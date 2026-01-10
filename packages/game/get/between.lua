---Returns a list of [bookmarks](lua://Bookmark) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return Bookmark[] bms All of the [bookmarks](lua://Bookmark) within the area.
function game.get.bookmarksBetweenOffsets(startOffset, endOffset)
    local bookmarksBetweenOffsets = {} ---@type Bookmark[]
    for _, bm in ipairs(map.Bookmarks) do
        local bmIsInRange = bm.StartTime >= startOffset and bm.StartTime < endOffset
        if bmIsInRange then table.insert(bookmarksBetweenOffsets, bm) end
    end
    return sort(bookmarksBetweenOffsets, sortAscendingStartTime)
end

---Returns a list of [timing points](lua://TimingPoint) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return TimingPoint[] tps All of the [timing points](lua://TimingPoint) within the area.
function game.get.linesBetweenOffsets(startOffset, endOffset)
    local linesBetweenoffsets = {} ---@type TimingPoint[]
    for _, line in ipairs(map.TimingPoints) do
        local lineIsInRange = line.StartTime >= startOffset and line.StartTime < endOffset
        if lineIsInRange then table.insert(linesBetweenoffsets, line) end
    end
    return sort(linesBetweenoffsets, sortAscendingStartTime)
end

---Returns a list of [hit objects](lua://HitObject) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return HitObject[] objs All of the [hit objects](lua://HitObject) within the area.
function game.get.notesBetweenOffsets(startOffset, endOffset)
    local notesBetweenOffsets = {} ---@type HitObject[]
    for _, note in ipairs(map.HitObjects) do
        local noteIsInRange = note.StartTime >= startOffset and note.StartTime <= endOffset
        if noteIsInRange then table.insert(notesBetweenOffsets, note) end
    end
    return sort(notesBetweenOffsets, sortAscendingStartTime)
end

---Returns a list of [scroll speed factors](lua://ScrollSpeedFactor) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@param dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollSpeedFactor[] ssfs All of the [scroll speed factors](lua://ScrollSpeedFactor) within the area.
function game.get.ssfsBetweenOffsets(startOffset, endOffset, includeEnd, dontSort)
    local ssfsBetweenOffsets = {} ---@type ScrollSpeedFactor[]
    local ssfs = map.ScrollSpeedFactors
    if ssfs == nil then
        ssfs = {}
    else
        for _, ssf in ipairs(map.ScrollSpeedFactors) do
            local ssfIsInRange = ssf.StartTime >= startOffset and ssf.StartTime < endOffset
            if (includeEnd and ssf.StartTime == endOffset) then ssfIsInRange = true end
            if ssfIsInRange then table.insert(ssfsBetweenOffsets, ssf) end
        end
    end
    if dontSort then return ssfsBetweenOffsets end
    return sort(ssfsBetweenOffsets, sortAscendingStartTime)
end

---Returns a list of [scroll velocities](lua://ScrollVelocity) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@param dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollVelocity[] svs All of the [scroll velocities](lua://ScrollVelocity) within the area.
function game.get.svsBetweenOffsets(startOffset, endOffset, includeEnd, dontSort)
    local svsBetweenOffsets = {} ---@type ScrollVelocity[]
    for _, sv in ipairs(map.ScrollVelocities) do
        local svIsInRange = sv.StartTime >= startOffset and sv.StartTime < endOffset
        if (includeEnd and sv.StartTime == endOffset) then svIsInRange = true end
        if svIsInRange then table.insert(svsBetweenOffsets, sv) end
    end
    if dontSort then return svsBetweenOffsets end
    return sort(svsBetweenOffsets, sortAscendingStartTime)
end
