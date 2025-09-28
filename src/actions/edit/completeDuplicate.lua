function storeDuplicateItems(menuVars)
    objects = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset)
    local tls = game.getLinesBetweenOffsets(startOffset, endOffset)
    local bms = game.getBookmarksBetweenOffsets(startOffset, endOffset)

    for _, note in pairs(notes) do
        table.insert(objects, { type = "ho", data = note })
    end
    for _, sv in pairs(svs) do
        table.insert(objects, { type = "sv", data = sv })
    end
    for _, ssf in pairs(ssfs) do
        table.insert(objects, { type = "ssf", data = ssf })
    end
    for _, tl in pairs(tls) do
        table.insert(objects, { type = "tl", data = tl })
    end
    for _, bm in pairs(bms) do
        table.insert(objects, { type = "bm", data = bm })
    end
    menuVars.objects = objects
end

function clearDuplicateItems(menuVars)
    menuVars.objects = {}
end
