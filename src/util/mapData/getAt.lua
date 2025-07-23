---Returns the SV multiplier in a given array of SVs.
---@param svs ScrollVelocity[]
---@param offset number
---@return number
function getHypotheticalSVMultiplierAt(svs, offset)
    if (#svs == 1) then return svs[1].Multiplier end
    local index = #svs
    while (index >= 1) do
        if (svs[index].StartTime > offset) then
            index = index - 1
        else
            return svs[index].Multiplier
        end
    end
    return 1
end

---Returns the SV time in a given array of SVs.
---@param svs ScrollVelocity[]
---@param offset number
---@return number
function getHypotheticalSVTimeAt(svs, offset)
    if (#svs == 1) then return svs[1].StartTime end
    local index = #svs
    while (index >= 1) do
        if (svs[index].StartTime > offset) then
            index = index - 1
        else
            return svs[index].StartTime
        end
    end
    return -69
end

function getSVStartTimeAt(offset)
    local sv = map.GetScrollVelocityAt(offset)
    if sv then return sv.StartTime end
    return -1
end

function getSVMultiplierAt(offset)
    local sv = map.GetScrollVelocityAt(offset)
    if sv then return sv.Multiplier end
    if (map.InitialScrollVelocity == 0) then return 1 end
    return map.InitialScrollVelocity or 1
end

function getSSFMultiplierAt(offset)
    local ssf = map.GetScrollSpeedFactorAt(offset)
    if ssf then return ssf.Multiplier end
    return 1
end

function getTimingPointAt(offset)
    local line = map.GetTimingPointAt(offset)
    if line then return line end
    return { StartTime = -69420, Bpm = 42.69 }
end
