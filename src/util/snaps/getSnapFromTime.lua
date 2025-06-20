local SPECIAL_SNAPS = { 1, 2, 3, 4, 6, 8, 12, 16 }

---Gets the snap color from a given time.
---@param time number # The time to reference.
---@return number
function getSnapFromTime(time)
    local previousBar = map.GetNearestSnapTimeFromTime(false, 1, time)
    local barTime = 60000 / getTimingPointAt(time).Bpm

    local distance = time - previousBar

    if (math.abs(distance) / barTime < 0.02) then return 1 end

    -- perform linear search to find nearest special snap, if the tolerance percentage is sufficient then return that snap, otherwise repeat until search fails, then return white if no matches found.

    local absoluteSnap = barTime / distance
    local foundCorrectSnap = false
    for i = 1, math.ceil(16 / absoluteSnap) do
        local currentSnap = absoluteSnap * i
        local guessIndex = 1
        while (SPECIAL_SNAPS[guessIndex] < currentSnap and guessIndex < #SPECIAL_SNAPS) do
            guessIndex = guessIndex + 1
        end
        if (currentSnap > 17) then break end

        guessedSnap = math.abs(SPECIAL_SNAPS[guessIndex] - currentSnap) <
            math.abs(SPECIAL_SNAPS[math.max(guessIndex - 1, 1)] - currentSnap) and
            SPECIAL_SNAPS[guessIndex] or SPECIAL_SNAPS[math.max(guessIndex - 1, 1)]

        if (math.abs(guessedSnap - currentSnap) / (currentSnap) < 0.02) then
            foundCorrectSnap = true
            break
        end
    end

    if (not foundCorrectSnap) then return 5 end

    return guessedSnap
end
