---Returns a list of [scroll speed factors](lua://ScrollSpeedFactor) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@param dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollSpeedFactor[] ssfs All of the [scroll speed factors](lua://ScrollSpeedFactor) within the area.
function game.getSSFsBetweenOffsets(startOffset, endOffset, includeEnd, dontSort)
    local ssfsBetweenOffsets = {} ---@type ScrollSpeedFactor[]
    local ssfs = map.ScrollSpeedFactors
    if (ssfs == nil) then
        ssfs = {}
    else
        for _, ssf in ipairs(map.ScrollSpeedFactors) do
            local ssfIsInRange = ssf.StartTime >= startOffset and ssf.StartTime < endOffset
            if (includeEnd and ssf.StartTime == endOffset) then ssfIsInRange = true end
            if ssfIsInRange then table.insert(ssfsBetweenOffsets, ssf) end
        end
    end
    if (dontSort) then return ssfsBetweenOffsets end
    return sort(ssfsBetweenOffsets, sortAscendingStartTime)
end
