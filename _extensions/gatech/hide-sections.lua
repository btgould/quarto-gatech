-- hide-sections.lua
--
-- Level-1 (`#`) section slides are dropped from the presentation while their
-- headings still structure the deck and appear in the table of contents
-- (`toc: true`). On by default (`hide-section-slides: true` in
-- _extension.yml); set `hide-section-slides: false` under the format to keep
-- the divider slides.
--
-- reveal.js's own `visibility="hidden"` can't be used here: Quarto strips
-- hidden slides before building the TOC, so the sections vanish from it too.
-- Instead each section slide gets a `.gatech-hidden-section` class and a small
-- script removes those slides once reveal.js is ready. Removing (rather than
-- skipping) them keeps the `c/t` slide counter honest. TOC links that pointed
-- at a removed section are retargeted to that section's first slide.
--
-- An individual section can opt out with `# Title {.gatech-show-section}`.

local enabled = false

local script = [[
<script>
(function () {
  function hideSections() {
    document.querySelectorAll('.reveal .slides section.level1.gatech-hidden-section').forEach(function (sec) {
      var next = sec.nextElementSibling;
      if (next && next.id) {
        document.querySelectorAll('a[href="#/' + sec.id + '"]').forEach(function (a) {
          a.setAttribute('href', '#/' + next.id);
        });
      }
      sec.remove();
    });
    Reveal.sync();
  }
  if (Reveal.isReady()) hideSections(); else Reveal.on('ready', hideSections);
})();
</script>
]]

return {
	{
		Meta = function(meta)
			enabled = meta["hide-section-slides"] == true
		end,
	},
	{
		Header = function(el)
			if not enabled or el.level ~= 1 or el.classes:includes("gatech-show-section") then
				return nil
			end
			el.classes:insert("gatech-hidden-section")
			return el
		end,
		Pandoc = function(doc)
			if enabled then
				quarto.doc.include_text("after-body", script)
			end
			return doc
		end,
	},
}
