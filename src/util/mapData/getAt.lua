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
