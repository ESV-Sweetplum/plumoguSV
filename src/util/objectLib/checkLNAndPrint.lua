---Returns true if the number of notes in the given [HitObject](lua://HitObject) list contains at least `requiredLNCount` long notes. If `requiredLNCount` isn't given, the default value 1 is used.
---@param hos HitObject[]
---@param requiredLNCount? integer
---@return boolean
function checkNotesForLNs(hos, requiredLNCount)
    requiredLNCount = requiredLNCount or 1
    local lnCount = 0
    for _, ho in pairs(hos) do
        if (ho.EndTime ~= 0) then lnCount = lnCount + 1 end
    end

    return lnCount >= requiredLNCount
end

---Prints a warning message if legacy LN rendering isn't enabled.
function printLegacyLNMessage()
    if (not checkNotesForLNs(game.uniqueNotesBetweenSelected()) or map.LegacyLNRendering) then return end
end
