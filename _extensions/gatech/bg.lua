local function copyResource(file)
	path = quarto.utils.resolvePath(file)
	quarto.doc.addFormatResource(path)
end

function Header(el)
	copyResource("assets/")

	if not el.attributes["background-image"] then
		if el.level == 1 then
			el.attributes["background-image"] = "assets/background_section_blank.jpg"
			el.attributes["background-size"] = "contain"
		elseif el.level == 2 then
			el.attributes["background-image"] = "assets/background_slide.png"
			el.attributes["background-size"] = "contain"
		end
	end

	return el
end
