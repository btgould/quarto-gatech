-- slide-refs.lua
-- Moves references to the bottom of slides where they are cited

if FORMAT:match 'revealjs' then
  function Pandoc(doc)
    local refs_div = nil
    local refs_by_id = {}
    local new_blocks = {}

    -- First pass: find and extract all references
    for i, block in ipairs(doc.blocks) do
      if block.t == 'Div' and block.identifier == 'refs' then
        refs_div = block
        -- Extract individual references
        for _, ref in ipairs(block.content) do
          if ref.t == 'Div' and ref.identifier:match('^ref%-') then
            refs_by_id[ref.identifier] = ref
          end
        end
      else
        table.insert(new_blocks, block)
      end
    end

    -- Second pass: add refs to slides that cite them
    local final_blocks = {}
    for _, block in ipairs(new_blocks) do
      table.insert(final_blocks, block)

      -- Check if this is a slide section
      if block.t == 'Div' and (block.classes:includes('section') or
         (block.attributes and block.attributes['data-type'] == 'slide')) then

        -- Find all citations in this slide
        local cited_refs = {}
        local function find_cites(el)
          if el.t == 'Cite' then
            for _, citation in ipairs(el.citations) do
              local ref_id = 'ref-' .. citation.id
              if refs_by_id[ref_id] and not cited_refs[ref_id] then
                cited_refs[ref_id] = refs_by_id[ref_id]
              end
            end
          end
          return el
        end

        pandoc.walk_block(block, {Cite = find_cites})

        -- If there are citations, add them to the slide
        local refs_list = {}
        for _, ref in pairs(cited_refs) do
          table.insert(refs_list, ref)
        end

        if #refs_list > 0 then
          local slide_refs = pandoc.Div(refs_list, {class = 'slide-references'})
          block.content:insert(slide_refs)
        end
      end
    end

    -- Add back the full references section at the end
    if refs_div then
      table.insert(final_blocks, refs_div)
    end

    doc.blocks = final_blocks
    return doc
  end
else
  -- For non-revealjs formats, return unchanged
  function Pandoc(doc)
    return doc
  end
end
