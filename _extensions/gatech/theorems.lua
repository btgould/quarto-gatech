local theorem_classes = {
	theorem = true, lemma = true, corollary = true, proposition = true,
	conjecture = true, definition = true, example = true, exercise = true,
	algorithm = true, remark = true, solution = true,
}

local function is_theorem_div(div)
	for _, c in ipairs(div.classes) do
		if theorem_classes[c] then return true end
	end
	return false
end

local function has_class(classes, name)
	for _, c in ipairs(classes) do
		if c == name then return true end
	end
	return false
end

local custom_numbers = {}

local function restructure(div)
	if not is_theorem_div(div) then return end
	if #div.content == 0 then return end

	local first = div.content[1]
	if first.t ~= "Para" or #first.content == 0 then return end

	local title_span = first.content[1]
	if title_span.t ~= "Span" or not has_class(title_span.classes, "theorem-title") then return end

	local unnumbered = has_class(div.classes, "unnumbered") or div.attributes.number == ""
	local custom_number = (not unnumbered) and div.attributes.number or nil

	if unnumbered or custom_number then
		local strong = title_span.content[1]
		if strong and strong.t == "Strong" then
			local text = pandoc.utils.stringify(strong.content)
			local typename = text:match("^(%a+)")
			local name = text:match("%((.-)%)%s*$")
			if typename then
				local parts = pandoc.List({ pandoc.Str(typename) })
				if not unnumbered and custom_number then
					parts:insert(pandoc.Str("\u{a0}"))
					parts:insert(pandoc.Str(custom_number))
				end
				if name then
					parts:insert(pandoc.Space())
					parts:insert(pandoc.Str("(" .. name .. ")"))
				end
				strong.content = parts
				if div.identifier ~= "" then
					custom_numbers[div.identifier] = unnumbered and "" or custom_number
				end
			end
		end
	end

	local title_bar = pandoc.Div(
		pandoc.Para(title_span.content),
		pandoc.Attr("", { "theorem-title-bar" })
	)

	local remaining = pandoc.List({})
	local start_idx = 2
	if first.content[2] and first.content[2].t == "Space" then start_idx = 3 end
	for k = start_idx, #first.content do
		remaining:insert(first.content[k])
	end

	local body_blocks = pandoc.List({})
	if #remaining > 0 then
		body_blocks:insert(pandoc.Para(remaining))
	end
	for k = 2, #div.content do
		body_blocks:insert(div.content[k])
	end

	local body = pandoc.Div(body_blocks, pandoc.Attr("", { "theorem-body" }))

	div.content = pandoc.List({ title_bar, body })
	div.classes:insert("gt-theorem")
	return div
end

local function rewrite_xref(link)
	if not has_class(link.classes, "quarto-xref") then return end
	local target = link.target:match("^#/?(.+)$")
	if not target then return end
	local custom = custom_numbers[target]
	if custom == nil then return end

	local text = pandoc.utils.stringify(link.content)
	local typename = text:match("^(%a+)")
	if not typename then return end

	local new_content
	if custom == "" then
		new_content = pandoc.List({ pandoc.Str(typename) })
	else
		new_content = pandoc.List({
			pandoc.Str(typename),
			pandoc.Str("\u{a0}"),
			pandoc.Str(custom),
		})
	end

	return pandoc.Link(new_content, link.target, link.title, link.attr)
end

function Pandoc(doc)
	doc = doc:walk({ Div = restructure })
	doc = doc:walk({ Link = rewrite_xref })
	return doc
end
