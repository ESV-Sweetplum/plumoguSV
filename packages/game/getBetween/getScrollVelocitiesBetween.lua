---Returns a list of [scroll velocities](lua://ScrollVelocity) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@paramk dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollVelocity[] svs All of the [scroll velocities](lua://ScrollVelocity) within the area.
function game.getSVsBetweenOffsets(startOffset, endOffset, includeEnd, dontSort)
    local svsBetweenOffsets = {} ---@type ScrollVelocity[]
    for _, sv in ipairs(map.ScrollVelocities) do
        local svIsInRange = sv.StartTime >= startOffset and sv.StartTime < endOffset
        if (includeEnd and sv.StartTime == endOffset) then svIsInRange = true end
        if svIsInRange then table.insert(svsBetweenOffsets, sv) end
    end
    if (dontSort) then return svsBetweenOffsets end
    return sort(svsBetweenOffsets, sortAscendingStartTime)
end
