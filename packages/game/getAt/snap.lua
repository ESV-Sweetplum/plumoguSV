local SPECIAL_SNAPS = { 1, 2, 3, 4, 6, 8, 12, 16 }

---Gets the snap color from a given time.
---@param time number The time to reference.
---@param dontPrintInaccuracy? boolean If set to true, will not print warning messages on unconfident guesses.
---@return SnapNumber
function game.getSnapAt(time, dontPrintInaccuracy)
    local previousBar = math.floor(map.GetNearestSnapTimeFromTime(false, 1, time + 6) or 0)
    local barLength = math.floor(map.GetNearestSnapTimeFromTime(true, 1, time) or 0) - previousBar

    local distanceAbovePrev = time - previousBar
    if (distanceAbovePrev <= 5 or distanceAbovePrev >= barLength - 5) then return 1 end

    local snap48 = barLength / 48
    local checkingTime = 0
    local index = -1

    for _ = 1, 48 do
        if (checkingTime > distanceAbovePrev) then break end
        checkingTime = checkingTime + snap48
        index = index + 1
    end

    if (math.abs(snap48 * (index + 1) - distanceAbovePrev) < math.abs(snap48 * index - distanceAbovePrev)) then
        index = index + 1
    end

    local v = 48
    local div = index
    local r = -1

    while (r ~= 0) do
        r = v % div
        v = div
        div = r
    end

    if (math.floor(48 / v) ~= 48 / v) then return 5 end
    if (48 / v > 16) then return 5 end

    return 48 / v
end
