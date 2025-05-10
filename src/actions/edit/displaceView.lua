-- Displaces the playfield view with SVs between selected notes
-- Parameters
--    menuVars : list of variables used for the current menu [Table]
function displaceViewSVs(menuVars)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = uniqueNoteOffsetsBetweenSelected()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local displaceAmount = menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local beforeDisplacement = nil
        local atDisplacement = displaceAmount
        local afterDisplacement = 0 ---@type number|nil
        if i ~= 1 then beforeDisplacement = -displaceAmount end
        if i == #offsets then
            atDisplacement = 0
            afterDisplacement = nil
        end
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
