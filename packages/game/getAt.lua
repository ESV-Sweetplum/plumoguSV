require("packages.table.searchClosest")

---Gets the most recent timing point, or a dummy timing point if none exists.
---@param offset number
---@return TimingPoint
function game.getTimingPointAt(offset)
    local line = map.getTimingPointAt(offset)
    if line then return line end
    return { StartTime = -69420, Bpm = 42.69, Signature = 4, Hidden = false }
end

---Gets the start time of the most recent note, or returns -1 if there is no note beforehand.
---@param offset number
---@param forward? boolean If true, will only search for notes above the offset. If false, will only search for notes below the offset.
---@return integer
function game.getNoteOffsetAt(offset, forward)
    local startTimes = cache.lists.hitObjectStartTimes
    if (not truthy(startTimes)) then return -1 end
    if (state.SongTime > startTimes[#startTimes]) then return startTimes[#startTimes] end
    if (state.SongTime < startTimes[1]) then return startTimes[1] end

    local startTime = table.searchClosest(startTimes, offset, tn(forward) + 1)
    return startTime
end

local SPECIAL_SNAPS = { 1, 2, 3, 4, 6, 8, 12, 16 }

---Gets the snap color from a given time.
---@param time number The time to reference.
---@param dontPrintInaccuracy? boolean If set to true, will not print warning messages on unconfident guesses.
---@return SnapNumber
function game.getSnapAt(time, dontPrintInaccuracy)
    local previousBar = math.floor(map.GetNearestSnapTimeFromTime(false, 1, time + 6) or 0)
    local barLength = 60000 / game.getTimingPointAt(state.SongTime).Bpm

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

---Gets the start time of the most recent SSF, or returns -1 if there is no SSF before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.getSSFStartTimeAt(offset, tgId)
    local ssf = map.GetScrollSpeedFactorAt(offset, tgId)
    if ssf then return ssf.StartTime end
    return -1
end

---Gets the multiplier of the most recent SSF, or returns 1 if there is no SSF before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.getSSFMultiplierAt(offset, tgId)
    local ssf = map.GetScrollSpeedFactorAt(offset, tgId)
    if ssf then return ssf.Multiplier end
    return 1
end

---Gets the start time of the most recent SV, or returns -1 if there is no SV before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.getSVStartTimeAt(offset, tgId)
    local sv = map.GetScrollVelocityAt(offset, tgId)
    if sv then return sv.StartTime end
    return -1
end

---Gets the multiplier of the most recent SV, or returns the initial scroll velocity or 1 if there is no SV before the given offset.
---@param offset number
---@param tgId? string
---@return number
function game.getSVMultiplierAt(offset, tgId)
    local sv = map.GetScrollVelocityAt(offset, tgId)
    if sv then return sv.Multiplier end

    local initSV = map.InitialScrollVelocity
    if (not truthy(initSV)) then return 1 end
    return initSV
end
