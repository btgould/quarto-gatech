local theorem_callouts = {
	thm = "Theorem",
	prp = "Proposition",
	lem = "Lemma",
	cor = "Corollary",
	cnj = "Conjecture",
	def = "Definition",
	exm = "Example",
	exr = "Exercise",
	alg = "Algorithm",
}

if type(_G.add_crossref_category) == "function"
	and type(_G.crossref) == "table"
	and type(_G.crossref.categories) == "table"
then
	for ref_type, name in pairs(theorem_callouts) do
		if _G.crossref.categories.by_ref_type[ref_type] == nil then
			_G.add_crossref_category({
				kind     = "Block",
				name     = name,
				prefix   = name,
				ref_type = ref_type,
			})
		end
	end
else
	error("theorems.lua: Quarto crossref API (add_crossref_category / crossref.categories) not accessible from filter sandbox; cannot register theorem-callout ref_types")
end

local function has_class(classes, name)
	for _, c in ipairs(classes) do
		if c == name then return true end
	end
	return false
end

-- pre-ast pass: route raw theorem-prefix divs into Quarto's callout pipeline.
function Div(div)
	if div.identifier == "" then return end
	local ref_type = div.identifier:match("^(%a+)%-")
	if not ref_type or theorem_callouts[ref_type] == nil then return end
	if has_class(div.classes, "theorem-callout") then return end

	div.classes:insert("callout-note")
	div.classes:insert("theorem-callout")

	if div.attributes.name then
		div.attributes.title = div.attributes.name
		div.attributes.name = nil
	end

	div.attributes.icon = "false"
	return div
end

-- post-render pass: replace Quarto's auto-number in the decorated title for
-- any callout that carries a `number="X"` attribute, and keep matching @-refs
-- in sync.
function Pandoc(doc)
	local custom_numbers = {}

	doc = doc:walk({
		Div = function(div)
			if not has_class(div.classes, "theorem-callout") then return end
			local custom = div.attributes.number
			if not custom or custom == "" then return end

			custom_numbers[div.identifier] = custom

			-- Inside the rendered callout wrapper, only the Strong nested in
			-- the .callout-title child carries the decorated title:
			--   [Str("Theorem"), Str(NBSP), Str(<auto-number>), Str(":"), Space, …name]
			-- Targeting just that Strong (instead of any Strong in the body)
			-- avoids clobbering bold runs in the theorem statement.
			return div:walk({
				Div = function(inner)
					if not has_class(inner.classes, "callout-title") then return end
					local para = inner.content[1]
					if not para or para.t ~= "Para" then
						error(string.format(
							"theorems.lua: expected .callout-title in #%s to start with a Para, got %s",
							div.identifier, para and para.t or "nil"
						))
					end
					local strong = para.content[1]
					if not strong or strong.t ~= "Strong" then
						error(string.format(
							"theorems.lua: expected .callout-title Para in #%s to start with a Strong, got %s",
							div.identifier, strong and strong.t or "nil"
						))
					end
					local third = strong.content[3]
					if not third or third.t ~= "Str" or not third.text:match("^%d") then
						local got = third and (third.t .. (third.text and ("(" .. third.text .. ")") or "")) or "nil"
						local stringified = pandoc.utils.stringify(strong.content)
						error(string.format(
							"theorems.lua: expected position 3 of decorated callout title for #%s to be a numeric Str; got %s. Full title: %q. The auto-number layout from Quarto's titlePrefix may have changed.",
							div.identifier, got, stringified
						))
					end
					strong.content[3] = pandoc.Str(custom)
					return inner
				end,
			})
		end,
	})

	doc = doc:walk({
		Link = function(link)
			if not has_class(link.classes, "quarto-xref") then return end
			local target = link.target:match("^#/?(.+)$")
			if not target then return end
			local custom = custom_numbers[target]
			if not custom then return end

			local text = pandoc.utils.stringify(link.content)
			local typename = text:match("^(%a+)")
			if not typename then return end

			return pandoc.Link(
				pandoc.List({
					pandoc.Str(typename),
					pandoc.Str("\u{a0}"),
					pandoc.Str(custom),
				}),
				link.target, link.title, link.attr
			)
		end,
	})

	return doc
end
