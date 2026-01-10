require("packages.table.searchClosest")

---Gets the most recent timing point, or a dummy timing point if none exists.
---@param offset number
---@return TimingPoint
function game.get.timingPointAt(offset)
    local line = map.getTimingPointAt(offset)
    if line then return line end
    return { StartTime = -69420, Bpm = 42.69, Signature = 4, Hidden = false }
end

local SPECIAL_SNAPS = { 1, 2, 3, 4, 6, 8, 12, 16 }

---Gets the snap color from a given time.
---@param time number The time to reference.
---@param dontPrintInaccuracy? boolean If set to true, will not print warning messages on unconfident guesses.
---@return SnapNumber
function game.get.snapAt(time, dontPrintInaccuracy)
    local previousBar = math.floor(map.GetNearestSnapTimeFromTime(false, 1, time + 6) or 0)
    local barLength = 60000 / game.get.timingPointAt(state.SongTime).Bpm

    local distanceAbovePrev = time - previousBar
    if (distanceAbovePrev <= 5 or distanceAbovePrev >= barLength - 5) then return 1 end

    local snap48 = barLength / 48
    local checkingTime = 0
    local index = -1

    for _ = 1, 48 do
        if checkingTime > distanceAbovePrev then break end
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

---Gets the start time of the most recent SSF, or returns -1 if there is no SSF before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.get.ssfStartTimeAt(offset, tgId)
    local ssf = map.GetScrollSpeedFactorAt(offset, tgId)
    if ssf then return ssf.StartTime end
    return -1
end

---Gets the multiplier of the most recent SSF, or returns 1 if there is no SSF before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.get.ssfMultiplierAt(offset, tgId)
    local ssf = map.GetScrollSpeedFactorAt(offset, tgId)
    if ssf then return ssf.Multiplier end
    return 1
end

---Gets the start time of the most recent SV, or returns -1 if there is no SV before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.get.svStartTimeAt(offset, tgId)
    local sv = map.GetScrollVelocityAt(offset, tgId)
    if sv then return sv.StartTime end
    return -1
end

---Gets the multiplier of the most recent SV, or returns the initial scroll velocity or 1 if there is no SV before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.get.svMultiplierAt(offset, tgId)
    local sv = map.GetScrollVelocityAt(offset, tgId)
    if sv then return sv.Multiplier end

    local initTgSv = state.SelectedScrollGroup.InitialScrollVelocity
    if initTgSv ~= nil then return initTgSv end
    local initSV = map.InitialScrollVelocity
    if initSV ~= nil then return initSV end
    return 1
end
