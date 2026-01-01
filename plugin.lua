cache = {
    boolean = {},
    windows = {},
    lists = {}
}
clock = {}; cache.clock = {}
clock.prevTime = 0
tempClockCount = 0
color = {
    vctr = {},
    int = {}
}
color.int.alphaMask = 16777216
color.int.redMask = 1
color.int.greenMask = 256
color.int.blueMask = 65536
color.int.whiteMask = color.int.redMask + color.int.greenMask + color.int.blueMask
game = {
    window = {}
}
kbm = {}
matrix = {}
---#### (NOTE: This function is impure and has no return value. This should be changed eventually.)
---Gets a list of variables.
---@param listName string An identifier to avoid state collisions.
---@param variables { [string]: any } The key-value table to get data for.
function cache.loadTable(listName, variables)
    for key, _ in pairs(variables) do
        if (state.GetValue(listName .. key) ~= nil) then
            variables[key] = state.GetValue(listName .. key)
        end
    end
end
---Saves a table in state, independently.
---@param listName string An identifier to avoid state collisions.
---@param variables { [string]: any } A key-value table to save.
function cache.saveTable(listName, variables)
    for key, value in pairs(variables) do
        state.SetValue(listName .. key, value)
    end
end
function clock.getTime()
    return (state.UnixTime - clock.prevTime) / 1000
end
---Returns true every `interval` ms.
---@param id string The unique identifier of the clock.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.listen(id, interval)
    local currentTime = state
        .UnixTime
    local prevTime = cache.clock[id]
    if (not prevTime) then
        cache.clock[id] = currentTime
        prevTime = currentTime
    end
    if (currentTime - prevTime > interval) then
        cache.clock[id] = currentTime
        return true
    end
    return false
end
---Alters opacity of a given color.
---@param col integer
---@param additiveOpacity integer
---@return number
---@overload fun(col: Vector4, additiveOpacity: number): Vector4
function color.alterOpacity(col, additiveOpacity)
    if (type(col) ~= "number") then
        return col + vector.New(0, 0, 0, additiveOpacity)
    end
    return col + math.floor(additiveOpacity) * 16777216
end
color.vctr.white = vector.New(1, 1, 1, 1)
color.vctr.black = vector.New(0, 0, 0, 1)
color.vctr.transparent = vector.New(0, 0, 0, 0)
color.int.white = color.int.whiteMask * 255 + color.int.alphaMask * 255
color.int.black = color.int.alphaMask * 255
color.int.transparent = 0
color.vctr.red = vector.New(1, 0, 0, 1)
color.vctr.light_red = vector.New(1, 0.5, 0.5, 1)
color.int.red = color.int.redMask * 255 + color.int.alphaMask * 255
color.vctr.orange = vector.New(1, 0.5, 0, 1)
color.vctr.light_orange = vector.New(1, 0.75, 0.5, 1)
color.int.orange = 4278222975
color.vctr.yellow = vector.New(1, 1, 0, 1)
color.vctr.light_yellow = vector.New(1, 1, 0.5, 1)
color.int.yellow = 4278255615
color.vctr.green = vector.New(0, 1, 0, 1)
color.vctr.light_green = vector.New(0.5, 1, 0.5, 1)
color.int.green = 4278255360
color.vctr.aqua = vector.New(0, 1, 1, 1)
color.vctr.light_aqua = vector.New(0.5, 1, 1, 1)
color.int.aqua = 4294967040
color.vctr.blue = vector.New(0, 0, 1, 1)
color.vctr.light_blue = vector.New(0.5, 0.5, 1, 1)
color.int.blue = 4294901760
color.vctr.purple = vector.New(1, 0, 1, 1)
color.vctr.light_purple = vector.New(1, 0.5, 1, 1)
color.int.purple = 4294901887
color.vctr.magenta = vector.New(1, 0, 0.5, 1)
color.vctr.light_magenta = vector.New(1, 0.5, 0.75, 1)
color.int.magenta = 4286546175
HEXADECIMAL = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" }
NONDUA = { "!", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f",
    "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}",
    "~" }
---Converts rgba to an unsigned integer (0-4294967295).
---@param r integer
---@param g integer
---@param b integer
---@param a integer
---@return integer
function color.rgbaToUint(r, g, b, a)
    local flr = math.floor
    return flr(a) * 16 ^ 6 + flr(b) * 16 ^ 4 + flr(g) * 16 ^ 2 + flr(r)
end
---Converts rgba (in vector form) to an unsigned integer (0-4294967295).
---@param col Vector4
---@return integer
function color.vrgbaToUint(col)
    local flr = math.floor
    return color.rgbaToUint(flr(col.x * 255), flr(col.y * 255), flr(col.z * 255), flr(col.w * 255))
end
---Converts an unsigned integer to a Vector4 of color values (0-1 for each element).
---@param n integer
---@return Vector4
function color.uintToRgba(n)
    local tbl = {}
    for i = 0, 3 do
        tbl[#tbl + 1] = math.floor(n / 256 ^ i) % 256
    end
    return table.vectorize4(tbl) / 255
end
---Converts a hexa string to an rgba Vector4 (0-1 for each element).
---@param hexa string
---@return Vector4
function color.hexaToRgba(hexa)
    local rgbaTable = {}
    for i = 1, 8, 2 do
        table.insert(rgbaTable,
            table.indexOf(HEXADECIMAL, hexa:charAt(i)) * 16 + table.indexOf(HEXADECIMAL, hexa:charAt(i + 1)) - 17)
    end
    return table.vectorize4(rgbaTable)
end
---Converts rgba to an ndua string (base 92).
---@param r integer
---@param g integer
---@param b integer
---@param a integer
---@return string
function color.rgbaToNdua(r, g, b, a)
    local uint = color.rgbaToUint(r, g, b, a)
    local str = ""
    for i = 0, 4 do
        str = str .. NONDUA[math.floor(uint / (92 ^ i)) % 92 + 1]
    end
    return str:reverse()
end
---Converts an ndua string (base 92) to an rgba Vector4 (0-1 for each element).
---@param ndua string
---@return Vector4
function color.nduaToRgba(ndua)
    local num = 0
    for i = 1, 5 do
        local idx = table.indexOf(NONDUA, ndua:charAt(i))
        if (idx == -1) then goto nextIndex end
        num = num + (idx - 1) * 92 ^ (5 - i)
        ::nextIndex::
    end
    return color.uintToRgba(num)
end
---Converts a color to a Quaver-compatible string.
---@param vctr Vector4
---@return string
function color.rgbaToStr(vctr)
    return table.concat({ vctr.x, vctr.y, vctr.z }, ",")
end
---Generates a random color.
---@param includeAlpha boolean If false, alpha will always be 1.
---@return Vector4
function generateColor(includeAlpha)
    local r = math.random(255)
    local g = math.random(255)
    local b = math.random(255)
    local a = math.random(255)
    return vector.New(r, g, b, includeAlpha and a or 255)
end
---Gets the most recent timing point, or a dummy timing point if none exists.
---@param offset number
---@return TimingPoint
function game.getTimingPointAt(offset)
    local line = map.getTimingPointAt(offset)
    if line then return line end
    return { StartTime = -69420, Bpm = 42.69, Signature = 4, Hidden = false }
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
    local initTgSv = state.SelectedScrollGroup.InitialScrollVelocity
    if initTgSv ~= nil then return initTgSv end
    local initSV = map.InitialScrollVelocity
    if initSV ~= nil then return initSV end
    return 1
end
---Returns a list of [bookmarks](lua://Bookmark) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return Bookmark[] bms All of the [bookmarks](lua://Bookmark) within the area.
function game.getBookmarksBetweenOffsets(startOffset, endOffset)
    local bookmarksBetweenOffsets = {} ---@type Bookmark[]
    for _, bm in ipairs(map.Bookmarks) do
        local bmIsInRange = bm.StartTime >= startOffset and bm.StartTime < endOffset
        if bmIsInRange then bookmarksBetweenOffsets[#bookmarksBetweenOffsets + 1] = bm end
    end
    return sort(bookmarksBetweenOffsets, sortAscendingStartTime)
end
---Returns a list of [timing points](lua://TimingPoint) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return TimingPoint[] tps All of the [timing points](lua://TimingPoint) within the area.
function game.getLinesBetweenOffsets(startOffset, endOffset)
    local linesBetweenoffsets = {} ---@type TimingPoint[]
    for _, line in ipairs(map.TimingPoints) do
        local lineIsInRange = line.StartTime >= startOffset and line.StartTime < endOffset
        if lineIsInRange then linesBetweenoffsets[#linesBetweenoffsets + 1] = line end
    end
    return sort(linesBetweenoffsets, sortAscendingStartTime)
end
---Returns a list of [hit objects](lua://HitObject) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return HitObject[] objs All of the [hit objects](lua://HitObject) within the area.
function game.getNotesBetweenOffsets(startOffset, endOffset)
    local notesBetweenOffsets = {} ---@type HitObject[]
    for _, note in ipairs(map.HitObjects) do
        local noteIsInRange = note.StartTime >= startOffset and note.StartTime <= endOffset
        if noteIsInRange then notesBetweenOffsets[#notesBetweenOffsets + 1] = note end
    end
    return sort(notesBetweenOffsets, sortAscendingStartTime)
end
---Returns a list of [scroll speed factors](lua://ScrollSpeedFactor) between two times, inclusive.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@param includeEnd? boolean Whether or not to include any SVs on the end time.
---@param dontSort? boolean Whether or not to resort the SVs by startTime. Should be disabled on temporal collisions.
---@return ScrollSpeedFactor[] ssfs All of the [scroll speed factors](lua://ScrollSpeedFactor) within the area.
function game.getSSFsBetweenOffsets(startOffset, endOffset, includeEnd, dontSort)
    local ssfsBetweenOffsets = {} ---@type ScrollSpeedFactor[]
    local ssfs = map.ScrollSpeedFactors
    if ssfs == nil then
        ssfs = {}
    else
        for _, ssf in ipairs(map.ScrollSpeedFactors) do
            local ssfIsInRange = ssf.StartTime >= startOffset and ssf.StartTime < endOffset
            if (includeEnd and ssf.StartTime == endOffset) then ssfIsInRange = true end
            if ssfIsInRange then ssfsBetweenOffsets[#ssfsBetweenOffsets + 1] = ssf end
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
function game.getSVsBetweenOffsets(startOffset, endOffset, includeEnd, dontSort)
    local svsBetweenOffsets = {} ---@type ScrollVelocity[]
    for _, sv in ipairs(map.ScrollVelocities) do
        local svIsInRange = sv.StartTime >= startOffset and sv.StartTime < endOffset
        if (includeEnd and sv.StartTime == endOffset) then svIsInRange = true end
        if svIsInRange then svsBetweenOffsets[#svsBetweenOffsets + 1] = sv end
    end
    if dontSort then return svsBetweenOffsets end
    return sort(svsBetweenOffsets, sortAscendingStartTime)
end
---Finds and returns a list of all unique offsets of notes between selected notes [Table]
---@param includeLN? boolean
---@return number[]
function game.uniqueNoteOffsetsBetweenSelected(includeLN)
    local selectedNoteOffsets = game.uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local offsets = game.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    if (#offsets < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return offsets
end
---Returns a list of unique offsets (in increasing order) of selected notes [Table]
---@return number[]
function game.uniqueSelectedNoteOffsets()
    local offsets = {}
    for _, ho in pairs(state.SelectedHitObjects) do
        offsets[#offsets + 1] = ho.StartTime
        if (ho.EndTime ~= 0 and globalVars.useEndTimeOffsets) then offsets[#offsets + 1] = ho.EndTime end
    end
    offsets = table.dedupe(offsets)
    offsets = sort(offsets, sortAscending)
    if (not truthy(offsets)) then return {} end
    return offsets
end
function game.getTimingGroupList()
    local baseList = table.keys(map.TimingGroups)
    local defaultIndex = table.indexOf(baseList, "$Default")
    table.remove(baseList, defaultIndex)
    local globalIndex = table.indexOf(baseList, "$Global")
    table.remove(baseList, globalIndex)
    table.insert(baseList, 1, "$Default")
    table.insert(baseList, 2, "$Global")
    if (globalVars.hideAutomatic) then table.filter(baseList, function(str) return not string.find(str, "automate_") end) end
    return baseList
end
---Finds and returns a list of all unique offsets of notes between a start and an end time [Table]
---@param startOffset number
---@param endOffset number
---@param includeLN? boolean
---@return number[]
function game.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    local noteOffsetsBetween = {}
    includeLN = includeLN or globalVars.useEndTimeOffsets
    for _, ho in ipairs(map.HitObjects) do
        if ho.StartTime >= startOffset and ho.StartTime <= endOffset then
            local skipNote = false
            if (state.SelectedScrollGroupId ~= ho.TimingGroup and globalVars.ignoreNotesOutsideTg) then skipNote = true end
            if (ho.StartTime == startOffset or ho.StartTime == endOffset) then skipNote = false end
            if skipNote then goto nextNote end
            noteOffsetsBetween[#noteOffsetsBetween + 1] = ho.StartTime
            if (ho.EndTime ~= 0 and ho.EndTime <= endOffset and includeLN) then
                table.insert(noteOffsetsBetween,
                    ho.EndTime)
            end
            ::nextNote::
        end
        if ho.EndTime >= startOffset and ho.EndTime <= endOffset and includeLN then
            noteOffsetsBetween[#noteOffsetsBetween + 1] = ho.EndTime
        end
    end
    noteOffsetsBetween = table.dedupe(noteOffsetsBetween)
    noteOffsetsBetween = sort(noteOffsetsBetween, sortAscending)
    return noteOffsetsBetween
end
game.getUniqueNoteOffsetsBetween = game.uniqueNoteOffsetsBetween
function game.window.getCenter()
    local windowDim = state.WindowSize
    return vector.New(state.WindowSize[1] / 2, state.WindowSize[2] / 2)
end
---Listens to the keyboard and returns specific values based on if keys are pressed.
---@return string[] prefixes An array of prefixes like "Ctrl" or "Shift".
---@return integer key The key enum of the pressed key.
function kbm.listenForAnyKeyPressed()
    local isCtrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local isShiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local isAltHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)
    local key = -1
    local prefixes = {}
    if isCtrlHeld then prefixes[#prefixes + 1] = "Ctrl" end
    if isShiftHeld then prefixes[#prefixes + 1] = "Shift" end
    if isAltHeld then prefixes[#prefixes + 1] = "Alt" end
    for i = 65, 90 do
        if (utils.IsKeyPressed(i)) then
            key = i
        end
    end
    return prefixes, key
end
---Gets the amount of distance the mouse moved THIS FRAME.
---@param button? ImGuiMouseButton
---@return Vector2 delta
function kbm.mouseDelta(button)
    local delta = imgui.GetMouseDragDelta(button or 0)
    imgui.ResetMouseDragDelta(button or 0)
    return delta
end
local ALPHABET_LIST = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S",
    "T", "U", "V", "W", "X", "Y", "Z" }
---Converts a key enum to a specific character.
---@param num integer
---@return string
function kbm.numToKey(num)
    return ALPHABET_LIST[math.clamp(num - 64, 1, #ALPHABET_LIST)]
end
---Returns true if the given key combo is pressed (e.g. "Ctrl+Shift+L")
---@param keyCombo string
---@return boolean
function kbm.pressedKeyCombo(keyCombo)
    keyCombo = keyCombo:upper()
    local comboList = {}
    for v in keyCombo:gmatch("%u+") do
        comboList[#comboList + 1] = v
    end
    local keyReq = comboList[#comboList]
    local ctrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local shiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local altHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)
    if (table.contains(comboList, "CTRL") ~= ctrlHeld) then
        return false
    end
    if (table.contains(comboList, "SHIFT") ~= shiftHeld) then
        return false
    end
    if (table.contains(comboList, "ALT") ~= altHeld) then
        return false
    end
    return utils.IsKeyPressed(keys[keyReq])
end
kbm.executedKeyCombo = kbm.pressedKeyCombo
---Evaluates a simplified one-dimensional cubic bezier expression with points (0, p2, p3, 1).
---@param p2 number The second point in the cubic bezier.
---@param p3 number The third point in the cubic bezier.
---@param t number The time in which to evaluate the cubic bezier.
---@return number cBez The result.
function math.cubicBezier(p2, p3, t)
    return 3 * t * (1 - t) ^ 2 * p2 + 3 * t * t * (1 - t) * p3 + t * t * t
end
---Evaluates a simplified one-dimensional quadratic bezier expression with points (0, p2, 1).
---@param p2 number The second point in the quadratic bezier.
---@param t number The time in which to evaluate the quadratic bezier.
---@return number qBez The result.
function math.quadraticBezier(p2, t)
    return 2 * t * (1 - t) * p2 + t * t
end
---Restricts a number to be within a chosen bound.
---@param number number
---@param lowerBound number
---@param upperBound number
---@return number
function math.clamp(number, lowerBound, upperBound)
    if number < lowerBound then return lowerBound end
    if number > upperBound then return upperBound end
    return number
end
function math.evaluatePolynomial(ceff, x)
    local sum = 0
    local degree = #ceff - 1
    for i, c in ipairs(ceff) do
        sum = sum + c * x ^ (degree - i + 1)
    end
    return sum
end
---Clamps a number between `lowerBound` and `upperBound` by repeatedly multiplying or dividing by the `multiplicativeFactor`.
---@param n number
---@param lowerBound number
---@param upperBound number
---@param multiplicativeFactor? number
---@return number
function math.expoClamp(n, lowerBound, upperBound, multiplicativeFactor)
    if upperBound <= lowerBound then return n end
    if (n <= upperBound and n >= lowerBound) then return n end
    local factor = multiplicativeFactor < 1 and 1 / multiplicativeFactor or multiplicativeFactor
    while (n < lowerBound) do
        n = n * factor
    end
    while (n > upperBound) do
        n = n / factor
    end
    return n
end
---Forces a number to have a quarterly decimal part.
---@param number number
---@return number
function math.quarter(number)
    return math.round(number * 4) * 0.25
end
---Returns the fractional portion of a number (e.g. in 4.4, returns 0.4).
---@param n number
---@return number
function math.frac(n)
    return n - math.floor(n)
end
---Evaluates a simplified one-dimensional hermite related (?) spline for SV purposes
---@param m1 number
---@param m2 number
---@param y2 number
---@param t number
---@return number
function math.hermite(m1, m2, y2, t)
    local a = m1 + m2 - 2 * y2
    local b = 3 * y2 - 2 * m1 - m2
    local c = m1
    return a * t * t * t + b * t * t + c * t
end
---Returns the weight of a number between `lowerBound` and `upperBound`.
---@param num number
---@param lowerBound number
---@param upperBound number
---@return number
function math.inverseLerp(num, lowerBound, upperBound)
    return (num - lowerBound) / (upperBound - lowerBound)
end
function matrix.findZeroRow(mtrx)
    for idx, row in pairs(mtrx) do
        local zeroRow = true
        for k1 = 1, #row do
            local num = row[k1]
            if num ~= 0 then
                zeroRow = false
                break
            end
        end
        if zeroRow then return idx end
    end
    return -1
end
function matrix.rowLinComb(mtrx, rowIdx1, rowIdx2, row2Factor)
    for k, v in pairs(mtrx[rowIdx1]) do
        mtrx[rowIdx1][k] = v + mtrx[rowIdx2][k] * row2Factor
    end
end
function matrix.scaleRow(mtrx, rowIdx, factor)
    for k, v in pairs(mtrx[rowIdx]) do
        mtrx[rowIdx][k] = v * factor
    end
end
---Given a square matrix A and equally-sized vector B, returns a vector x such that Ax=B.
---@param mtrx number[][]
---@param vctr number[]
function matrix.solve(mtrx, vctr)
    if (#vctr ~= #mtrx) then return -1 / 0 end
    local augMtrx = table.duplicate(mtrx)
    for i, n in pairs(vctr) do
        augMtrx[i][#augMtrx[i] + 1] = n
    end
    for i = 1, #mtrx do
        matrix.scaleRow(augMtrx, i, 1 / augMtrx[i][i])
        for j = i + 1, #mtrx do
            matrix.rowLinComb(augMtrx, j, i, -augMtrx[j][i]) -- Triangular Downward Sweep
            if (matrix.findZeroRow(augMtrx) ~= -1) then
                return augMtrx[matrix.findZeroRow(augMtrx)][#mtrx + 1] == 0 and 1 / 0 or 0
            end
        end
    end
    for i = #mtrx, 2, -1 do
        for j = i - 1, 1, -1 do
            matrix.rowLinComb(augMtrx, j, i, -augMtrx[j][i]) -- Triangular Upward Sweep
        end
    end
    return table.property(augMtrx, #mtrx + 1)
end
---Rounds a number to a given amount of decimal places.
---@param number number
---@param decimalPlaces? integer
---@return number
function math.round(number, decimalPlaces)
    if (not decimalPlaces) then decimalPlaces = 0 end
    local multiplier = 10 ^ decimalPlaces
    return math.floor(multiplier * number + 0.5) / multiplier
end
---Returns the sign of a number: `1` if the number is non-negative, `-1` if negative.
---@param number number
---@return 1|-1
function math.sign(number)
    if number >= 0 then return 1 end
    return -1
end
---Alias of [tonumber](lua://tonumber) for type coercion. Converts boolean values into their respective binary digits.
---@param x? string | number | boolean
---@return number
function math.toNumber(x)
    if (not x) then return 0 end
    if x == true then return 1 end
    local result = tonumber(x)
    if (not result or type(result) ~= "number") then return 0 end
    return result
end
tn = math.toNumber
---Wraps a number to an interval; that is, if the number is greater than the lower bound, continuously adds the difference until it reaches the upper bound, and vice versa.
---@param n number
---@param lowerBound number
---@param upperBound number
---@param discrete? boolean Whether or not to wrap discretely - that is, in a range of 1 to n, if given 0, will return n instead of n - 1. Check [OBOE or fencepost error](https://en.wikipedia.org/wiki/Off-by-one_error).
---@return number
function math.wrap(n, lowerBound, upperBound, discrete)
    if upperBound <= lowerBound then return n end
    if (n >= lowerBound and n <= upperBound) then return n end
    local additionFactor = math.toNumber(discrete)
    local diff = upperBound - lowerBound
    while (n < lowerBound) do
        n = n + diff + additionFactor
    end
    while (n > upperBound) do
        n = n - diff - additionFactor
    end
    return n
end
---Restricts a number to be within a closed ring.
---@param number number
---@param lowerBound number
---@param upperBound number
---@return number
function math.wrappedClamp(number, lowerBound, upperBound)
    if number < lowerBound then return upperBound end
    if number > upperBound then return lowerBound end
    return number
end
CONSONANTS = { "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Z" }
---Very rudimentary function that returns a string depending on whether or not it should be plural.
---@param str string The inital string, which should be a noun (e.g. `bookmark`)
---@param val number The value, or count, of the noun, which will determine if it should be plural.
---@param pos? integer Where the pluralization letter(s) should be inserted.
---@return string pluralizedStr A new string that is pluralized if `val ~= 1`.
function pluralize(str, val, pos)
    local strEnding = ""
    if pos then
        strEnding = str:sub(pos + 1, -1)
        str = str:sub(1, pos)
    end
    local finalStrTbl = { str, "s" }
    if val == 1 then return str .. (strEnding or "") end
    local lastLetter = str:sub(-1):upper()
    local secondToLastLetter = str:charAt(-2):upper()
    if (lastLetter == "Y" and table.contains(CONSONANTS, secondToLastLetter)) then
        finalStrTbl[1] = finalStrTbl[1]:sub(1, -2)
        finalStrTbl[2] = "ies"
    end
    if (str:sub(-3):lower() == "quy") then
        finalStrTbl[1] = finalStrTbl[1]:sub(1, -2)
        finalStrTbl[2] = "ies"
    end
    if (table.contains({ "J", "S", "X", "Z" }, lastLetter) or table.contains({ "SH", "CH" }, str:sub(-2))) then
        finalStrTbl[2] = "es"
    end
    return table.concat(finalStrTbl) .. (strEnding or "")
end
---Capitalizes the first letter of the given string. If `forceLowercase` is true, then all other letters will be forced into lowercase.
---@param str string
---@param forceLowercase? boolean
---@return string
function string.capitalize(str, forceLowercase)
    local secondPortion = str:sub(2)
    if forceLowercase then secondPortion = secondPortion:lower() end
    return str:charAt(1):upper() .. secondPortion
end
---Returns the `idx`th character in a string. Simply used for shorthand. Also supports negative indexes.
---@param str string The string to search.
---@param idx integer If positive, returns the `i`th character. If negative, returns the `i`th character from the end of the string (e.g. -1 returns the last character).
---@return string
function string.charAt(str, idx)
    return str:sub(idx, idx)
end
---Changes a string to fit a certain size, with a ... at the end.
---@param str string
---@param targetSize integer
---@return string dottedStr
function string.fixToSize(str, targetSize)
    local size = imgui.CalcTextSize(str).x
    if size <= targetSize then return str end
    while (str:len() > 3 and size > targetSize) do
        str = str:sub(1, -2)
        size = imgui.CalcTextSize(str .. "...").x
    end
    return str .. "..."
end
---Removes spaces and turns a string into lowerCamelCase. Also removes special characters.
---@param str string
---@return string
function string.identify(str)
    newStr = str:gsub("[%s%(%)#&]+", "")
    newStr = newStr:charAt(1):lower() .. newStr:sub(2)
    return newStr
end
---Lots of imgui functions have ## in them as identifiers. This will remove everything after the ##.
---@param str string
---@return string
function removeTrailingTag(str)
    local newStr = {}
    for i = 1, str:len() do
        if (str:charAt(i) == "#" and str:charAt(i + 1) == "#") then break end
        newStr[#newStr + 1] = str:charAt(i)
    end
    return table.concat(newStr)
end
---Removes vowels from a string.
---@param str string
---@return string
function string.removeVowels(str)
    local VOWELS = { "a", "e", "i", "o", "u", "y" }
    local newStr = ""
    for i = 1, str:len() do
        local char = str:charAt(i)
        if (not table.contains(VOWELS, char)) then
            newStr = newStr .. char
        end
    end
    return newStr
end
---Shortens a string to three consonants; the first, the second, and the last.
---@param str string
---@return string
function string.shorten(str)
    local consonants = str:removeVowels()
    if (consonants:len() < 3) then return consonants end
    return table.concat({ consonants:charAt(1), consonants:charAt(2), consonants:charAt(-1) })
end
---Splits a string into a table via the given separator.
---@param str string
---@param sep string
---@return string[]
function string.split(str, sep)
    local tbl = {}
    for s in str:gmatch(table.concat({"([^", sep, "]+)"})) do
        tbl[#tbl + 1] = s
    end
    return tbl
end
---Takes in two lists and converts them to a key-value table.
---@generic T
---@generic U
---@param keyArr T[]
---@param valArr U[]
---@return { [T]: U } tbl
function table.assign(keyArr, valArr)
    if (#valArr > #keyArr) then
        valArr = table.slice(valArr, 1, #keyArr)
    end
    local tbl = {}
    for i = 1, #keyArr do
        tbl[keyArr[i]] = valArr[i]
    end
    return tbl
end
---Returns the average value of an array.
---@param values number[] The list of numbers.
---@param includeLastValue? boolean Whether or not to include the last value in the table.
---@return number avg The arithmetic mean of the table.
function table.average(values, includeLastValue)
    if not truthy(values) then return 0 end
    local sum = 0
    for k2 = 1, #values do
        local value = values[k2]
        sum = sum + value
    end
    if not includeLastValue then
        sum = sum - values[#values]
        return sum / (#values - 1)
    end
    return sum / #values
end
---Concatenates arrays together.
---@param t1 any[] The first table.
---@param ... any[] The next tables.
---@return any[] tbl The resultant table.
function table.combine(t1, ...)
    local newTbl = table.duplicate(t1)
    for _, tbl in ipairs({ ... }) do
        for i = 1, #tbl do
            newTbl[#newTbl + 1] = tbl[i]
        end
    end
    return newTbl
end
---Creates a new array with a custom metatable, allowing for `:` syntactic sugar.
---@param ... any entries to put into the table.
---@return table tbl A table with the given entries.
function table.construct(...)
    local tbl = {}
    for _, v in ipairs({ ... }) do
        tbl[#tbl + 1] = v
    end
    setmetatable(tbl, { __index = table })
    return tbl
end
---Creates a new array with a custom metatable, allowing for `:` syntactic sugar. All elements will be the given item.
---@generic T: string | number | boolean | table
---@param item T The entry to use.
---@param num integer The number of entries to put into the table.
---@return T[] tbl A table with the given entries.
function table.constructRepeating(item, num)
    local tbl = table.construct()
    for _ = 1, num do
        tbl[#tbl + 1] = item
    end
    return tbl
end
---Returns a boolean value corresponding to whether or not an element exists within a table.
---@param tbl any[] The table to search in.
---@param item any The item to search for.
---@return boolean contains Whether or not the item given is within the table.
function table.contains(tbl, item)
    for k3 = 1, #tbl do
        local v = tbl[k3]
        if v == item then return true end
    end
    return false
end
table.includes = table.contains
---Removes duplicate values from a table.
---@param tbl table The original table.
---@return table tbl A new table with no duplicates.
function table.dedupe(tbl)
    local hash = {}
    local newTbl = {}
    for k4 = 1, #tbl do
        local value = tbl[k4]
        if (not hash[value]) then
            newTbl[#newTbl + 1] = value
            hash[value] = true
        end
    end
    return newTbl
end
---Returns a deep copy of a table.
---@generic T : table
---@param tbl T The original table.
---@return T tbl The new table.
function table.duplicate(tbl)
    if not tbl then return {} end
    local dupeTbl = {}
    if (tbl[1]) then
        for k5 = 1, #tbl do
            local value = tbl[k5]
            dupeTbl[#dupeTbl + 1] = type(value) == "table" and table.duplicate(value) or value
        end
    else
        for _, key in ipairs(table.keys(tbl)) do
            local value = tbl[key]
            dupeTbl[key] = type(value) == "table" and table.duplicate(value) or value
        end
    end
    return dupeTbl
end
---Filters a table via a given function. For each element in the table, it is passed into the function; if the function returns true, the value is kept, and if the function returns false, the value will not be kept in the new array. Not mutative.
---@generic T
---@param tbl T[]
---@param fn fun(element: T): boolean
function table.filter(tbl, fn)
    local newTbl = {}
end
---Returns a 1-indexed value corresponding to the location of an element within a table.
---@param tbl table The table to search in.
---@param item any The item to search for.
---@return integer idx The index of the item. If the item doesn't exist, returns -1 instead.
function table.indexOf(tbl, item)
    for i, v in pairs(tbl) do
        if v == item then return i end
    end
    return -1
end
---Returns a table of keys from a table.
---@param tbl { [string]: any } The table to search in.
---@return string[] keys A list of keys.
function table.keys(tbl)
    local resultsTbl = table.construct()
    for k, _ in pairs(tbl) do
        resultsTbl[#resultsTbl + 1] = k
    end
    return table.dedupe(resultsTbl)
end
---Transforms an array element-wise using a given function.
---@generic T: string | number | boolean
---@generic U
---@param tbl T[]
---@param fn fun(element: T, idx?: number): U
---@return U[]
function table.map(tbl, fn)
    local newTbl = {}
    for idx, v in ipairs(tbl) do
        table.insert(newTbl, fn(v, idx))
    end
    return newTbl
end
---Navigates a tree with dot notation and returns the corresponding value. For example, if you had a table { foo = { bar = 1}}, then this returns 1 if the given value is "foo.bar".
---@param tree { [string]: any }
---@param value string[]
---@return any
function table.nestedValue(tree, value)
    if (#value > 1) then
        return table.nestedValue(tree[value[1]], table.slice(value, 2))
    end
    return tree[value[1]]
end
---Normalizes a table of numbers to achieve a target average.
---@param values number[] The table to normalize.
---@param targetAverage number The desired average value.
---@param includeLastValue boolean Whether or not to include the last value in the average.
---@return number[]
function table.normalize(values, targetAverage, includeLastValue)
    local avgValue = table.average(values, includeLastValue)
    if avgValue == 0 then return table.constructRepeating(0, #values) end
    local newValues = {}
    for i = 1, #values do
        newValues[#newValues + 1] = (values[i] * targetAverage) / avgValue
    end
    return newValues
end
---Converts a string (generated from [table.stringify](lua://table.stringify)) into a table.
---@param str string
---@return any
function table.parse(str)
    if (str == "FALSE" or str == "TRUE") then return str == "TRUE" end
    if (str:charAt(1) == '"') then return str:sub(2, -2) end
    if (str:match("^[%d%.]+$")) then return math.toNumber(str) end
    if (not table.contains({ "{", "[" }, str:charAt(1))) then return str end
    local tableType = str:charAt(1) == "[" and "arr" or "dict"
    local tbl = {}
    local terms = {}
    local MAX_ITERATIONS = 10000
    for i = 1, MAX_ITERATIONS do
        local nestedTableFactor = tn(table.contains({ "[", "{" }, str:charAt(2)))
        local depth = nestedTableFactor
        local searchIdx = 2 + nestedTableFactor
        local inQuotes = false
        while (searchIdx < str:len()) do
            if (str:charAt(searchIdx) == '"') then
                inQuotes = not inQuotes
            end
            if (table.contains({ "]", "}" }, str:charAt(searchIdx)) and not inQuotes) then
                depth = depth - 1
            end
            if (table.contains({ "[", "{" }, str:charAt(searchIdx)) and not inQuotes) then
                depth = depth + 1
            end
            if ((str:charAt(searchIdx) == "," or nestedTableFactor == 1) and not inQuotes and depth == 0) then break end
            searchIdx = searchIdx + 1
        end
        table.insert(terms, str:sub(2, searchIdx + nestedTableFactor - 1))
        str = str:sub(searchIdx + nestedTableFactor)
        if (str:len() <= 1) then break end
    end
    if (tableType == "arr") then
        for k6 = 1, #terms do
            local v = terms[k6]
            tbl[#tbl + 1] = table.parse(v)
        end
    else
        for k7 = 1, #terms do
            local v = terms[k7]
            local idx = v:find("=")
            tbl[v:sub(1, idx - 1)] = table.parse(v:sub(idx + 1))
        end
    end
    return tbl
end
---In a nested table `tbl`, returns a table of property values with key `property`.
---@generic T
---@param tbl T[][] | { [string]: T[] } The table to search in.
---@param property string | integer The property name.
---@return T[] properties The resultant table.
function table.property(tbl, property)
    local resultsTbl = {}
    for _, v in pairs(tbl) do
        resultsTbl[#resultsTbl + 1] = v[property]
    end
    return resultsTbl
end
---Reduces an array element-wise using a given function.
---@generic T: string | number | boolean
---@generic V: string | number | boolean | string[] | number[] | boolean[] | { [string]: any }
---@param tbl T[]
---@param fn fun(accumulator: V, current: T): V
---@param initialValue V
---@return V
function table.reduce(tbl, fn, initialValue)
    local accumulator = initialValue
    for k8 = 1, #tbl do
        local v = tbl[k8]
        accumulator = fn(accumulator, v)
    end
    return accumulator
end
---Reverses the order of an array.
---@param tbl table The original table.
---@return table tbl The original table, reversed.
function table.reverse(tbl)
    local reverseTbl = {}
    for i = 1, #tbl do
        reverseTbl[#reverseTbl + 1] = tbl[#tbl + 1 - i]
    end
    return reverseTbl
end
---In an array of numbers, searches for the closest number to `item`.
---@param tbl number[] The array of numbers to search in.
---@param item number The number to search for.
---@param searchMode? 0|1|2 `0/nil`: Search before and after. `1`: Search only before. `2`: Search only after.
---@return number num, integer index The number that is the closest to the given item, and the index of that number in the given table.
function table.searchClosest(tbl, item, searchMode)
    local leftIdx = 1
    local rightIdx = #tbl
    while rightIdx - leftIdx > 1 do
        local middleIdx = math.floor((leftIdx + rightIdx) * 0.5)
        if (item >= tbl[middleIdx]) then
            leftIdx = middleIdx
        else
            rightIdx = middleIdx
        end
    end
    local leftDifference = item - tbl[leftIdx]
    local rightDifference = tbl[rightIdx] - item
    if ((leftDifference < rightDifference or searchMode == 1) and searchMode ~= 2) then
        return tbl[leftIdx], leftIdx
    else
        return tbl[rightIdx], rightIdx
    end
end
---Returns a copy of a table containing all values between indices `i` and `j` (inclusive). If `j` is not passed in, will slice to the end of the table.
---@generic T
---@param tbl T[]
---@param i integer
---@param j? integer
---@return T[]
function table.slice(tbl, i, j)
    return { table.unpack(tbl, i, j or #tbl) }
end
---Sorting function for sorting objects by their numerical value. Should be passed into [`table.sort`](lua://table.sort).
---@param a number
---@param b number
---@return boolean
function sortAscending(a, b) return a < b end
---Sorting function for sorting objects by their `startTime` property. Should be passed into [`table.sort`](lua://table.sort).
---@param a { StartTime: number }
---@param b { StartTime: number }
---@return boolean
function sortAscendingStartTime(a, b) return a.StartTime < b.StartTime end
---Sorting function for sorting objects by their `time` property. Should be passed into [`table.sort`](lua://table.sort).
---@param a { time: number }
---@param b { time: number }
---@return boolean
function sortAscendingTime(a, b) return a.time < b.time end
---Sorting function for sorting notes by their `startTime` property. Should be passed into [`table.sort`](lua://table.sort). If two items are identical, sorts by their lanes instead.
---@param a { StartTime: number, Lane: integer }
---@param b { StartTime: number, Lane: integer }
---@return boolean
function sortAscendingNoteLaneTime(a, b)
    if (math.abs(a.StartTime - b.StartTime) > 0.1) then return a.StartTime < b.StartTime end
    return a.Lane < b.Lane
end
---Sorts a table given a sorting function.
---@generic T
---@param tbl T[] The table to sort.
---@param compFn fun(a: T, b: T): boolean A comparison function. Given two elements `a` and `b`, how should they be sorted?
---@return T[] sortedTbl A sorted table.
function sort(tbl, compFn)
    newTbl = table.duplicate(tbl)
    table.sort(newTbl, compFn)
    return newTbl
end
---Converts a table (or any other primitive values) to a string.
---@param var any
---@return string
function table.stringify(var)
    if (type(var) == "boolean") then return var and "TRUE" or "FALSE" end
    if (type(var) == "string") then return '"' .. var .. '"' end
    if (type(var) == "number") then return var end
    if (type(var) ~= "table") then return "UNKNOWN" end
    if (var[1] ~= nil) then
        local str = "["
        for k9 = 1, #var do
            local v = var[k9]
            str = str .. table.stringify(v) .. ","
        end
        return str:sub(1, -2) .. "]"
    end
    if (not truthy(table.keys(var))) then return "[]" end
    local str = "{"
    for k, v in pairs(var) do
        str = str .. k .. table.concat({"=", table.stringify(v), ","})
    end
    return str:sub(1, -2) .. "}"
end
---When given a dictionary and table of keys, returns a new table with only the specified keys and values.
---@generic T table
---@param checkList T The base table, which has a list of keys to include in the new table.
---@param tbl T The base table in which to lint the data from.
---@param extrapolateData? boolean If this is set to true, will fill in missing keys in the new table with values frmo the old table.
---@param inferTypes? boolean If true, this will try to coerce types from `tbl` into the types of `checkList`.
---@return T outputTable
function table.validate(checkList, tbl, extrapolateData, inferTypes)
    local validKeys = table.keys(checkList)
    local tableKeys = table.keys(tbl)
    local outputTable = {}
    for k10 = 1, #validKeys do
        local key = validKeys[k10]
        if (table.contains(tableKeys, key)) then
            outputTable[key] = tbl[key]
        end
        if (not table.contains(tableKeys, key) and extrapolateData) then
            outputTable[key] = checkList[key]
        end
        if (inferTypes and outputTable[key]) then
            outputTable[key] = parseDefaultProperty(outputTable[key], checkList[key]) or outputTable[key]
        end
    end
    return outputTable
end
---Returns a table of values from a table.
---@param tbl { [string]: any } The table to search in.
---@return string[] values A list of values.
function table.values(tbl)
    local resultsTbl = table.construct()
    for k11 = 1, #tbl do
        local v = tbl[k11]
        resultsTbl[#resultsTbl + 1] = v
    end
    return resultsTbl
end
---@diagnostic disable: return-type-mismatch
---The above is made because we want the functions to be identity functions when passing in vectors instead of tables.
---Converts a table of length 4 into a [`Vector4`](lua://Vector4).
---@param tbl number[] | { x: number, y: number, z: number, w: number } The table to convert.
---@return Vector4 vctr The output vector.
function table.vectorize4(tbl)
    if (not tbl) then return vctr4(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2] and tbl[3] and tbl[4]) then return vector.New(tbl[1], tbl[2], tbl[3], tbl[4]) end
    return vector.New(tbl.x, tbl.y, tbl.z, tbl.w)
end
---Converts a table of length 3 into a [`Vector3`](lua://Vector3).
---@param tbl number[] | { x: number, y: number, z: number } The table to convert.
---@return Vector3 vctr The output vector.
function table.vectorize3(tbl)
    if (not tbl) then return vctr3(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2] and tbl[3]) then return vector.New(tbl[1], tbl[2], tbl[3]) end
    return vector.New(tbl.x, tbl.y, tbl.z)
end
---Converts a table of length 2 into a [`Vector2`](lua://Vector2).
---@param tbl number[] | { x: number, y: number } The table to convert.
---@return Vector2 vctr The output vector.
function table.vectorize2(tbl)
    if (not tbl) then return vctr2(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2]) then return vector.New(tbl[1], tbl[2]) end
    return vector.New(tbl.x, tbl.y)
end
---Returns `true` if given a string called "true", given a number greater than 0, given a table with an element, or is given `true`. Otherwise, returns `false`.
---@param param any The parameter to truthify.
---@param assumeTrue? boolean If the item is nil, will return true if this is true.
---@return boolean truthy The truthy value of the parameter.
function truthy(param, assumeTrue)
    local t = type(param)
    if t == "string" then
        return param:lower() == "true"
    end
    if t == "number" then
        return param > 0
    end
    if t == "table" or t == "userdata" then
        return #param > 0
    end
    if t == "boolean" then
        return param
    end
    return assumeTrue or false
end
---Creates a new [`Vector4`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector4 vctr The resultant vector of style `<n, n, n, n>`.
function vctr4(n)
    return vector.New(n, n, n, n)
end
---Creates a new [`Vector3`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector3 vctr The resultant vector of style `<n, n, n>`.
function vctr3(n)
    return vector.New(n, n, n)
end
---Creates a new [`Vector2`](lua://Vector2) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector2 vctr The resultant vector of style `<n, n>`.
function vctr2(n)
    return vector.New(n, n)
end
imgui_disable_vector_packing = true
DEFAULT_WIDGET_HEIGHT = 26
DEFAULT_WIDGET_WIDTH = 160
PADDING_WIDTH = 8
RADIO_BUTTON_SPACING = 7.5
SAMELINE_SPACING = 5
ACTION_BUTTON_SIZE = vector.New(253, 42)
PLOT_GRAPH_SIZE = vector.New(253, 100)
HALF_ACTION_BUTTON_SIZE = vector.New((253 - SAMELINE_SPACING) / 2, 42) -- dimensions of a button that does kinda important things
SECONDARY_BUTTON_SIZE = vector.New(48, 24)
TERTIARY_BUTTON_SIZE = vector.New(21.5, 24)
EXPORT_BUTTON_SIZE = vector.New(40, 24)
BEEG_BUTTON_SIZE = vector.New(253, 24)
MIN_RGB_CYCLE_TIME = 0.1
MAX_RGB_CYCLE_TIME = 300
MAX_CURSOR_TRAIL_POINTS = 100
MAX_SV_POINTS = 1000
MAX_ANIMATION_FRAMES = 999
MAX_IMPORT_CHARACTER_LIMIT = 999999
CHINCHILLA_TYPES = {
    "Exponential",
    "Polynomial",
    "Circular",
    "Sine Power",
    "Arc Sine Power",
    "Inverse Power",
    "Peter Stock"
}
COLOR_THEMES = {
    "Classic",
    "Strawberry",
    "Amethyst",
    "Tree",
    "Barbie",
    "Incognito",
    "Incognito + RGB",
    "Tobi's Glass",
    "Tobi's RGB Glass",
    "Glass",
    "Glass + RGB",
    "RGB Gamer Mode",
    "edom remag BGR",
    "otingocnI",
    "BGR + otingocnI",
    "CUSTOM"
}
COLOR_THEME_COLORS = {
    "255,255,255",
    "251,41,67",
    "153,102,204",
    "150,111,51",
    "227,5,173",
    "150,150,150",
    "255,0,0",
    "200,200,200",
    "0,255,0",
    "220,220,220",
    "0,0,255",
    "255,100,100",
    "100,255,100",
    "255,255,255",
    "100,100,255",
    "0,0,0",
}
DYNAMIC_BACKGROUND_TYPES = {
    "None",
    "Reactive Stars",
    "Reactive Singularity",
}
COMBO_SV_TYPE = {
    "Add",
    "Cross Multiply",
    "Remove",
    "Min",
    "Max",
    "SV Type 1 Only",
    "SV Type 2 Only"
}
CURSOR_TRAILS = {
    "None",
    "Snake",
    "Dust",
    "Sparkle"
}
DISPLACE_SCALE_SPOTS = {
    "Start",
    "End"
}
SPLIT_MODES = {
    "Column",
    "Time",
    "Individual"
}
EMOTICONS = {
    "( - _ - )",
    "( e . e )",
    "( * o * )",
    "( h . m )",
    "( ~ _ ~ )",
    "( - . - )",
    "( C | D )",
    "( w . w )",
    "( ^ w ^ )",
    "( > . < )",
    "( + x + )",
    "( o _ 0 )",
    "[ ^ . ^ ]",
    "( v . ^ )",
    "( ^ o v )",
    "( ^ o v )",
    "( ; A ; )",
    "[ . _ . ]",
    "[ ' = ' ]",
}
FINAL_SV_TYPES = {
    "Normal",
    "Custom",
    "Override"
}
FLICKER_TYPES = {
    "Normal",
    "Delayed"
}
NOTE_SKIN_TYPES = {
    "Bar",
    "Circle"
}
RANDOM_TYPES = {
    "Normal",
    "Uniform"
}
SCALE_TYPES = {
    "Average SV",
    "Absolute Distance",
    "Relative Ratio"
}
STANDARD_SVS_NO_COMBO = {
    "Linear",
    "Exponential",
    "Bezier",
    "Hermite",
    "Sinusoidal",
    "Circular",
    "Random",
    "Custom",
    "Chinchilla"
}
STILL_TYPES = {
    "No",
    "Start",
    "End",
    "Auto",
    "Otua"
}
STUTTER_CONTROLS = {
    "First SV",
    "Second SV"
}
STYLE_THEMES = {
    "Rounded",
    "Boxed",
    "Rounded + Border",
    "Boxed + Border"
}
SV_BEHAVIORS = {
    "Slow down",
    "Speed up"
}
TRAIL_SHAPES = {
    "Circles",
    "Triangles"
}
STILL_BEHAVIOR_TYPES = {
    "Entire Region",
    "Per Note Group",
}
DISTANCE_TYPES = {
    "Average SV + Shift",
    "Distance + Shift",
    "Start / End"
}
VIBRATO_TYPES = {
    "SV (msx)",
    "SSF (x)",
}
VIBRATO_QUALITIES = {
    "Low",
    "Medium",
    "High",
    "Ultra",
    "Omega"
}
VIBRATO_FRAME_RATES = { 60, 90, 150, 210, 270 }
VIBRATO_DETAILED_QUALITIES = {}
for i, v in pairs(VIBRATO_QUALITIES) do
    VIBRATO_DETAILED_QUALITIES[#VIBRATO_DETAILED_QUALITIES + 1] = v .. table.concat({"  (~", VIBRATO_FRAME_RATES[i], "fps)"})
end
VIBRATO_CURVATURES = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.2, 2.4, 2.6, 2.8, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5 }
DEFAULT_STYLE = {
    windowBg = vector.New(0.00, 0.00, 0.00, 1.00),
    popupBg = vector.New(0.08, 0.08, 0.08, 0.94),
    border = vector.New(0.00, 0.00, 0.00, 0.00),
    frameBg = vector.New(0.14, 0.24, 0.28, 1.00),
    frameBgHovered =
        vector.New(0.24, 0.34, 0.38, 1.00),
    frameBgActive =
        vector.New(0.29, 0.39, 0.43, 1.00),
    titleBg = vector.New(0.14, 0.24, 0.28, 1.00),
    titleBgActive =
        vector.New(0.51, 0.58, 0.75, 1.00),
    titleBgCollapsed =
        vector.New(0.51, 0.58, 0.75, 0.50),
    checkMark = vector.New(0.81, 0.88, 1.00, 1.00),
    sliderGrab =
        vector.New(0.56, 0.63, 0.75, 1.00),
    sliderGrabActive =
        vector.New(0.61, 0.68, 0.80, 1.00),
    button = vector.New(0.31, 0.38, 0.50, 1.00),
    buttonHovered =
        vector.New(0.41, 0.48, 0.60, 1.00),
    buttonActive =
        vector.New(0.51, 0.58, 0.70, 1.00),
    tab = vector.New(0.31, 0.38, 0.50, 1.00),
    tabHovered =
        vector.New(0.51, 0.58, 0.75, 1.00),
    tabActive =
        vector.New(0.51, 0.58, 0.75, 1.00),
    header = vector.New(0.81, 0.88, 1.00, 0.40),
    headerHovered =
        vector.New(0.81, 0.88, 1.00, 0.50),
    headerActive =
        vector.New(0.81, 0.88, 1.00, 0.54),
    separator = vector.New(0.81, 0.88, 1.00, 0.30),
    text = vector.New(1.00, 1.00, 1.00, 1.00),
    textSelectedBg =
        vector.New(0.81, 0.88, 1.00, 0.40),
    scrollbarGrab =
        vector.New(0.31, 0.38, 0.50, 1.00),
    scrollbarGrabHovered =
        vector.New(0.41, 0.48, 0.60, 1.00),
    scrollbarGrabActive =
        vector.New(0.51, 0.58, 0.70, 1.00),
    plotLines =
        vector.New(0.61, 0.61, 0.61, 1.00),
    plotLinesHovered =
        vector.New(1.00, 0.43, 0.35, 1.00),
    plotHistogram =
        vector.New(0.90, 0.70, 0.00, 1.00),
    plotHistogramHovered =
        vector.New(1.00, 0.60, 0.00, 1.00),
    loadupOpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00),
    loadupPulseTextColorLeft = vector.New(0.00, 0.50, 1.00, 1.00),
    loadupPulseTextColorRight = vector.New(0.00, 0.00, 1.00, 1.00),
    loadupBgTl = vector.New(0.00, 0.00, 0.00, 0.39),
    loadupBgTr = vector.New(0.31, 0.38, 0.50, 0.67),
    loadupBgBl = vector.New(0.31, 0.38, 0.50, 0.67),
    loadupBgBr = vector.New(0.62, 0.76, 1, 1.00),
}
DEFAULT_HOTKEY_LIST = { "T", "Shift+T", "S", "N", "R", "B", "M", "V", "G", "Ctrl+Alt+L", "Ctrl+Alt+E", "O" }
HOTKEY_LABELS = { "Execute Primary Action", "Execute Secondary Action", "Swap Primary Inputs",
    "Negate Primary Inputs", "Reset Secondary Input", "Go To Prev. Scroll Group", "Go To Next Scroll Group",
    "Execute Vibrato Separately", "Go To TG of Selected Note", "Toggle Note Lock Mode", "Toggle Use End Offsets",
    "Move Selection To TG" }
---@enum hotkeys
hotkeys_enum = {
    exec_primary = 1,
    exec_secondary = 2,
    swap_primary = 3,
    negate_primary = 4,
    reset_secondary = 5,
    go_to_prev_tg = 6,
    go_to_next_tg = 7,
    exec_vibrato = 8,
    go_to_note_tg = 9,
    toggle_note_lock = 10,
    toggle_end_offset = 11,
    move_selection_to_tg = 12,
}
function createSVGraphStats()
    local svGraphStats = {
        minScale = 0,
        maxScale = 0,
        distMinScale = 0,
        distMaxScale = 0
    }
    return svGraphStats
end
function createSVStats()
    local svStats = {
        minSV = 0,
        maxSV = 0,
        avgSV = 0
    }
    return svStats
end
function loadDefaultProperties(defaultProperties)
    if (not defaultProperties) then return end
    if (not defaultProperties.menu) then goto skipMenu end
    for label, tbl in pairs(defaultProperties.menu) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_MENU_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseDefaultProperty(settingValue, defaultTable[settingName])
            if defaultSetting == nil then
                goto nextSetting
            end
            DEFAULT_STARTING_MENU_VARS[label][settingName] = defaultSetting
            ::nextSetting::
        end
    end
    ::skipMenu::
    if (not defaultProperties.settings) then goto skipSettings end
    for label, tbl in pairs(defaultProperties.settings) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_SETTING_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseDefaultProperty(settingValue, defaultTable[settingName])
            if defaultSetting == nil then
                goto nextSetting
            end
            DEFAULT_STARTING_SETTING_VARS[label][settingName] = defaultSetting
            ::nextSetting::
        end
    end
    ::skipSettings::
    globalVars.defaultProperties = { settings = DEFAULT_STARTING_SETTING_VARS, menu = DEFAULT_STARTING_MENU_VARS }
end
function parseDefaultProperty(v, default)
    if (default == nil or type(default) == "table" or type(default) == "userdata") then
        return nil
    end
    if (type(default) == "number") then
        return tn(v)
    end
    if (type(default) == "boolean") then
        return truthy(v)
    end
    if (type(default) == "string") then
        return v
    end
    return v
end
globalVars = {
    advancedMode = false,
    colorThemeIndex = 1,
    comboizeSelect = false,
    cursorTrailGhost = false,
    cursorTrailIndex = 1,
    cursorTrailPoints = 10,
    cursorTrailShapeIndex = 1,
    cursorTrailSize = 5,
    customStyle = {},
    defaultProperties = { settings = {}, menu = {} },
    disableLoadup = false,
    dontPrintCreation = false,
    dontReplaceSV = false,
    drawCapybara = false,
    drawCapybara2 = false,
    drawCapybara312 = false,
    dynamicBackgroundIndex = 1,
    editToolIndex = 1,
    effectFPS = 90,
    equalizeLinear = true,
    hideAutomatic = false,
    hideSVInfo = false,
    hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST),
    ignoreNotesOutsideTg = false,
    maxDisplacementMultiplierExponent = 6,
    performanceMode = false,
    placeTypeIndex = 1,
    presets = {},
    printLegacyLNMessage = true,
    pulseCoefficient = 0,
    pulseColor = vector.New(0, 0, 0, 0),
    restrictSinusoidalPeriod = true,
    rgbPeriod = 2,
    scrollGroupIndex = 1,
    selectTypeIndex = 1,
    showMeasureDataWidget = false,
    showNoteDataWidget = false,
    showPresetMenu = false,
    showSVInfoVisualizer = true,
    showVibratoWidget = false,
    snakeSpringConstant = 1,
    stepSize = 5,
    styleThemeIndex = 1,
    upscroll = false,
    useCustomPulseColor = false,
    useEndTimeOffsets = false,
}
DEFAULT_GLOBAL_VARS = table.duplicate(globalVars)
function setGlobalVars(tempGlobalVars)
    globalVars.advancedMode = truthy(tempGlobalVars.advancedMode)
    globalVars.colorThemeIndex = tn(tempGlobalVars.colorThemeIndex)
    globalVars.comboizeSelect = truthy(tempGlobalVars.comboizeSelect)
    globalVars.cursorTrailGhost = truthy(tempGlobalVars.cursorTrailGhost)
    globalVars.cursorTrailIndex = tn(tempGlobalVars.cursorTrailIndex)
    globalVars.cursorTrailPoints = math.clamp(tn(tempGlobalVars.cursorTrailPoints), 0, 100)
    globalVars.cursorTrailShapeIndex = tn(tempGlobalVars.cursorTrailShapeIndex)
    globalVars.cursorTrailSize = tn(tempGlobalVars.cursorTrailSize)
    globalVars.customStyle = tempGlobalVars.customStyle or {}
    globalVars.disableLoadup = truthy(tempGlobalVars.disableLoadup)
    globalVars.dontPrintCreation = truthy(tempGlobalVars.dontPrintCreation)
    globalVars.dontReplaceSV = truthy(tempGlobalVars.dontReplaceSV)
    globalVars.drawCapybara = truthy(tempGlobalVars.drawCapybara)
    globalVars.drawCapybara2 = truthy(tempGlobalVars.drawCapybara2)
    globalVars.drawCapybara312 = truthy(tempGlobalVars.drawCapybara312)
    globalVars.dynamicBackgroundIndex = tn(tempGlobalVars.dynamicBackgroundIndex)
    globalVars.effectFPS = tn(tempGlobalVars.effectFPS)
    globalVars.equalizeLinear = truthy(tempGlobalVars.equalizeLinear, true)
    globalVars.hideAutomatic = truthy(tempGlobalVars.hideAutomatic)
    globalVars.hideSVInfo = truthy(tempGlobalVars.hideSVInfo)
    globalVars.hotkeyList = table.validate(DEFAULT_HOTKEY_LIST, table.duplicate(tempGlobalVars.hotkeyList), true)
    globalVars.ignoreNotes = truthy(tempGlobalVars.ignoreNotesOutsideTg)
    globalVars.maxDisplacementMultiplierExponent = tn(tempGlobalVars.maxDisplacementMultiplierExponent)
    globalVars.performanceMode = truthy(tempGlobalVars.performanceMode)
    globalVars.printLegacyLNMessage = truthy(tempGlobalVars.printLegacyLNMessage, true)
    globalVars.pulseCoefficient = tn(tempGlobalVars.pulseCoefficient)
    globalVars.pulseColor = table.vectorize4(tempGlobalVars.pulseColor)
    globalVars.restrictSinusoidalPeriod = truthy(tempGlobalVars.restrictSinusoidalPeriod, true)
    globalVars.rgbPeriod = tn(tempGlobalVars.rgbPeriod)
    globalVars.showMeasureDataWidget = truthy(tempGlobalVars.showMeasureDataWidget)
    globalVars.showNoteDataWidget = truthy(tempGlobalVars.showNoteDataWidget)
    globalVars.showSVInfoVisualizer = truthy(tempGlobalVars.showSVInfoVisualizer, true)
    globalVars.showVibratoWidget = truthy(tempGlobalVars.showVibratoWidget)
    globalVars.snakeSpringConstant = tn(tempGlobalVars.snakeSpringConstant)
    globalVars.stepSize = tn(tempGlobalVars.stepSize)
    globalVars.styleThemeIndex = tn(tempGlobalVars.styleThemeIndex)
    globalVars.upscroll = truthy(tempGlobalVars.upscroll)
    globalVars.useCustomPulseColor = truthy(tempGlobalVars.useCustomPulseColor)
    globalVars.useEndTimeOffsets = truthy(tempGlobalVars.useEndTimeOffsets)
    local forceVectorizeList = { "border", "loadupOpeningTextColor", "loadupPulseTextColorLeft",
        "loadupPulseTextColorRight", "loadupBgTl", "loadupBgTr", "loadupBgBl", "loadupBgBr" }
    for k12 = 1, #forceVectorizeList do
        local key = forceVectorizeList[k12]
        if (globalVars.customStyle[key]) then
            globalVars.customStyle[key] = table.vectorize4(globalVars.customStyle[key])
        end
    end
    globalVars.placeTypeIndex = state.GetValue("global.placeTypeIndex", globalVars.placeTypeIndex)
    globalVars.editToolIndex = state.GetValue("global.editToolIndex", globalVars.editToolIndex)
    globalVars.selectTypeIndex = state.GetValue("global.selectTypeIndex", globalVars.selectTypeIndex)
end
DEFAULT_STARTING_MENU_VARS = {
    placeStandard = {
        svTypeIndex = 1,
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svStats = createSVStats(),
        interlace = false,
        interlaceRatio = -0.5,
        overrideFinal = false
    },
    placeSpecial = { svTypeIndex = 1 },
    placeStill = {
        svTypeIndex = 1,
        noteSpacing = 1,
        stillTypeIndex = 1,
        stillDistance = 0,
        stillBehavior = 1,
        prePlaceDistances = {},
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svStats = createSVStats(),
        interlace = false,
        interlaceRatio = -0.5,
        overrideFinal = false
    },
    placeVibrato = {
        svTypeIndex = 1,
        vibratoMode = 1,
        vibratoQuality = 3,
        sides = 2
    },
    delete = {
        deleteTable = { true, true, true, true }
    },
    addTeleport = {
        distance = 10727,
        teleportBeforeHand = false
    },
    changeGroups = {
        designatedTimingGroup = "$Default",
        changeSVs = true,
        changeSSFs = true,
        clone = false,
    },
    completeDuplicate = {
        objects = {},
        svTbl = {},
        ssfTbl = {},
        msOffset = 0,
        dontCloneHos = false
    },
    convertSVSSF = {
        conversionDirection = true
    },
    copyPaste = {
        copyLines = false,
        copySVs = true,
        copySSFs = true,
        copyBMs = false,
        copied = {
            lines = { {} },
            SVs = { {} },
            SSFs = { {} },
            BMs = { {} },
        },
        tryAlign = true,
        alignWindow = 3,
        curSlot = 1,
    },
    directSV = {
        selectableIndex = 1,
        startTime = 0,
        multiplier = 0,
        pageNumber = 1
    },
    displaceNote = {
        distance = 200,
        distance1 = 0,
        distance2 = 200,
        linearlyChange = false
    },
    displaceView = {
        distance = 200
    },
    dynamicScale = {
        noteTimes = {},
        svTypeIndex = 1,
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svStats = createSVStats()
    },
    flicker = {
        flickerTypeIndex = 1,
        distance = -69420.727,
        distance1 = 0,
        distance2 = -69420.727,
        numFlickers = 1,
        linearlyChange = false,
        flickerPosition = 0.5
    },
    measure = {
        unrounded = false,
        nsvDistance = "",
        svDistance = "",
        avgSV = "",
        startDisplacement = "",
        endDisplacement = "",
        avgSVDisplaceless = "",
        roundedNSVDistance = 0,
        roundedSVDistance = 0,
        roundedAvgSV = 0,
        roundedStartDisplacement = 0,
        roundedEndDisplacement = 0,
        roundedAvgSVDisplaceless = 0
    },
    reverseScroll = {
        distance = 400
    },
    scaleBookmark = {
        searchTerm = "",
        filterTerm = ""
    },
    scaleDisplace = {
        scaleSpotIndex = 1,
        scaleTypeIndex = 1,
        avgSV = 0.6,
        distance = 100,
        ratio = 0.6,
    },
    scaleMultiply = {
        scaleTypeIndex = 1,
        avgSV = 0.6,
        distance = 100,
        ratio = 0.6
    },
    split = {
        modeIndex = 1,
        cloneSVs = false,
        cloneRadius = 1000
    },
    verticalShift = {
        verticalShift = 1
    },
    selectAlternating = {
        every = 1,
        offset = 0
    },
    selectBookmark = {
        searchTerm = "",
        filterTerm = "",
    },
    selectByTimingGroup = {
        designatedTimingGroup = "$Default",
    },
    selectChordSize = {
        select1 = true,
        select2 = false,
        select3 = false,
        select4 = false,
        select5 = false,
        select6 = false,
        select7 = false,
        select8 = false,
        select9 = false,
        select10 = false,
        laneSelector = 1
    },
    selectNoteType = {
        rice = true,
        ln = false,
        normal = true,
        mine = false
    },
    selectBySnap = {
        snap = 1
    }
}
---Gets the current menu's variables.
---@param menuType string The menu type.
---@return table
function getMenuVars(menuType, optionalLabel)
    optionalLabel = optionalLabel or ""
    menuKey = menuType:identify()
    local menuVars = table.duplicate(DEFAULT_STARTING_MENU_VARS[menuKey])
    local labelText = menuType .. optionalLabel .. "Menu"
    cache.loadTable(labelText, menuVars)
    return menuVars
end
function setPresets(presetList)
    globalVars.presets = {}
    for _, preset in pairs(presetList) do
        local presetIsValid, presetData = checkPresetValidity(preset)
        if (not presetIsValid) then goto nextPreset end
        table.insert(globalVars.presets,
            { name = preset.name, type = preset.type, menu = preset.menu, data = presetData })
        ::nextPreset::
    end
end
function checkPresetValidity(preset)
    if (not table.contains(CREATE_TYPES, preset.type)) then return false, nil end
    local validMenus = {}
    if (preset.type == "Standard" or preset.type == "Still") then
        validMenus = table.duplicate(STANDARD_SVS)
    end
    if (preset.type == "Special") then
        validMenus = table.duplicate(SPECIAL_SVS)
    end
    if (preset.type == "Vibrato") then
        validMenus = table.duplicate(VIBRATO_SVS)
    end
    if (not truthy(validMenus)) then return false, nil end
    if (not table.includes(validMenus, preset.menu)) then return false, nil end
    local realType = "place" .. preset.type
    return true, preset.data
end
DEFAULT_STARTING_SETTING_VARS = {
    linearVibratoSV = {
        startMsx = 100,
        endMsx = 0
    },
    polynomialVibratoSV = {
        startMsx = 0,
        endMsx = 100,
        controlPointCount = 3,
        controlPoints = { vector.New(0.25, 0.25), vector.New(0.5, 0), vector.New(0.75, 0.25) },
        plotPoints = {},
        plotCoefficients = {},
    },
    exponentialVibratoSV = {
        startMsx = 100,
        endMsx = 0,
        curvatureIndex = 5
    },
    sinusoidalVibratoSV = {
        startMsx = 100,
        endMsx = 0,
        verticalShift = 0,
        periods = 1,
        periodsShift = 0.25
    },
    sigmoidalVibratoSV = {
        startMsx = 100,
        endMsx = 0,
        curvatureIndex = 5
    },
    customVibratoSV = {
        code = [[return function (x)
    local maxHeight = 150
    heightFactor = maxHeight * math.exp((1 - math.sqrt(17)) * 0.5) / (31 - 7 * math.sqrt(17)) * 16
    primaryCoefficient = (x^2 - x^3) * math.exp(2 * x)
    sinusoidalCoefficient = math.sin(8 * math.pi * x)
    return heightFactor * primaryCoefficient * sinusoidalCoefficient
end]]
    },
    linearVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
    },
    exponentialVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
        curvatureIndex = 5
    },
    sinusoidalVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
        verticalShift = 0,
        periods = 1,
        periodsShift = 0.25,
        applyToHigher = false,
    },
    sigmoidalVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
        curvatureIndex = 5
    },
    customVibratoSSF = {
        code1 = "return function (x) return 0.69 end",
        code2 = "return function (x) return 1.420 end"
    },
    linear = {
        startSV = 1.5,
        endSV = 0.5,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1
    },
    exponential = {
        behaviorIndex = 1,
        intensity = 30,
        verticalShift = 0,
        distance = 100,
        startSV = 0.01,
        endSV = 1,
        avgSV = 1,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        distanceMode = 1
    },
    bezier = {
        p1 = vector.New(0.1, 0.9),
        p2 = vector.New(0.9, 0.1),
        verticalShift = 0,
        freeMode = false,
        manualMode = false,
        avgSV = 1,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1
    },
    hermite = {
        startSV = 0,
        endSV = 0,
        verticalShift = 0,
        avgSV = 1,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1
    },
    sinusoidal = {
        startSV = 2,
        endSV = 2,
        curveSharpness = 50,
        verticalShift = 1,
        periods = 1,
        periodsShift = 0.25,
        svsPerQuarterPeriod = 8,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1
    },
    circular = {
        behaviorIndex = 1,
        arcPercent = 50,
        avgSV = 1,
        verticalShift = 0,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        dontNormalize = false
    },
    random = {
        svMultipliers = {},
        randomTypeIndex = 1,
        randomScale = 2,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        dontNormalize = false,
        avgSV = 1,
        verticalShift = 0
    },
    custom = {
        svMultipliers = { 0 },
        selectedMultiplierIndex = 1,
        svPoints = 1,
        finalSVIndex = 2,
        customSV = 1
    },
    chinchilla = {
        behaviorIndex = 1,
        chinchillaTypeIndex = 1,
        chinchillaIntensity = 0.5,
        avgSV = 1,
        verticalShift = 0,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1
    },
    combo = {
        svType1Index = 1,
        svType2Index = 2,
        comboPhase = 0,
        comboTypeIndex = 1,
        comboMultiplier1 = 1,
        comboMultiplier2 = 1,
        finalSVIndex = 2,
        customSV = 1,
        dontNormalize = false,
        avgSV = 1,
        verticalShift = 0
    },
    code = {
        code = [[return function (x)
    local startPeriod = 4
    local endPeriod = -1
    local height = 1.5
    return height * math.sin(2 * math.pi * (startPeriod * x + (endPeriod - startPeriod) * 0.5 * x^2))
end]],
        svPoints = 64,
        finalSVIndex = 2,
        customSV = 1
    },
    stutter = {
        startSV = 1.5,
        endSV = 0.5,
        stutterDuration = 50,
        stutterDuration2 = 0,
        stuttersPerSection = 1,
        avgSV = 1,
        finalSVIndex = 2,
        customSV = 1,
        linearlyChange = false,
        controlLastSV = false,
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svMultipliers2 = {},
        svDistances2 = {},
        svGraph2Stats = createSVGraphStats()
    },
    teleportStutter = {
        svPercent = 50,
        svPercent2 = 0,
        distance = 50,
        mainSV = 0.5,
        mainSV2 = 0,
        useDistance = false,
        linearlyChange = false,
        avgSV = 1,
        finalSVIndex = 2,
        customSV = 1,
        stuttersPerSection = 1
    },
    framesSetup = {
        menuStep = 1,
        numFrames = 5,
        frameDistance = 2000,
        distance = 2000,
        reverseFrameOrder = false,
        noteSkinTypeIndex = 1,
        frameTimes = {},
        selectedTimeIndex = 1,
        currentFrame = 1
    },
    penis = {
        bWidth = 50,
        sWidth = 100,
        sCurvature = 100,
        bCurvature = 100
    },
    automate = {
        copiedSVs = {},
        deleteCopiedSVs = true,
        maintainMs = true,
        ms = 1000,
        scaleSVs = false,
        initialSV = 1,
        optimizeTGs = true,
    },
    animationPalette = {
        instructions = ""
    }
}
---Gets the current menu's setting variables.
---@param svType string The SV type - that is, the shape of the SV once plotted.
---@param label string A delineator to separate two categories with similar SV types (Standard/Still, etc).
---@return table
function getSettingVars(svType, label)
    menuKey = svType:identify()
    local settingVars = table.duplicate(DEFAULT_STARTING_SETTING_VARS[menuKey])
    local labelText = svType .. label .. "Settings"
    cache.loadTable(labelText, settingVars)
    return settingVars
end
function displaceNotesForAnimationFrames(settingVars)
    local frameDistance = settingVars.frameDistance
    local initialDistance = settingVars.distance
    local numFrames = settingVars.numFrames
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local selectedStartTime = game.uniqueSelectedNoteOffsets()[1]
    local firstFrameTimeTime = settingVars.frameTimes[1].time
    local lastFrameTimeTime = settingVars.frameTimes[#settingVars.frameTimes].time
    local firstOffset = math.min(selectedStartTime, firstFrameTimeTime)
    local lastOffset = math.max(selectedStartTime, lastFrameTimeTime)
    for i = 1, #settingVars.frameTimes do
        local frameTime = settingVars.frameTimes[i]
        local noteOffset = frameTime.time
        local frame = frameTime.frame
        local position = frameTime.position
        local startOffset = math.min(selectedStartTime, noteOffset)
        local endOffset = math.max(selectedStartTime, noteOffset)
        local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        local distanceBetweenOffsets = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
        local distanceToTargetNote = distanceBetweenOffsets
        if selectedStartTime < noteOffset then distanceToTargetNote = -distanceBetweenOffsets end
        local numFrameDistances = frame - 1
        if settingVars.reverseFrameOrder then numFrameDistances = numFrames - frame end
        local totalFrameDistances = frameDistance * numFrameDistances
        local distanceAfterTargetNote = initialDistance + totalFrameDistances + position
        local noteDisplaceAmount = distanceToTargetNote + distanceAfterTargetNote
        local beforeDisplacement = noteDisplaceAmount
        local atDisplacement = -noteDisplaceAmount
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, firstOffset, lastOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function automateCopySVs(settingVars)
    settingVars.copiedSVs = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    if (not truthy(svs)) then
        toggleablePrint("w!", "No SVs found within the copiable region.")
        return
    end
    local firstSVTime = svs[1].StartTime
    for k13 = 1, #svs do
        local sv = svs[k13]
        local copiedSV = {
            relativeOffset = sv.StartTime - firstSVTime,
            multiplier = sv.Multiplier
        }
        table.insert(settingVars.copiedSVs, copiedSV)
    end
    if (#settingVars.copiedSVs > 0) then
        toggleablePrint("s!",
            "Copied " .. #settingVars.copiedSVs .. pluralize(" SV.", #settingVars.copiedSVs, -2))
    end
    if (settingVars.deleteCopiedSVs) then actions.RemoveScrollVelocityBatch(svs) end
end
function clearAutomateSVs(settingVars)
    settingVars.copiedSVs = {}
end
function automateSVs(settingVars)
    local selected = state.SelectedHitObjects
    local actionList = {}
    local ids = utils.GenerateTimingGroupIds(#selected, "automate_")
    local neededIds = {}
    local timeSinceLastObject = 0
    local idIndex = 0
    for idx, ho in pairs(selected) do
        if (not settingVars.maintainMs and idx == 1) then goto nextSelected end
        do
            local thisTime = truthy(ho.EndTime) and ho.EndTime or ho.StartTime
            local prevTime = truthy(selected[math.max(1, idx - 1)].EndTime) and selected[math.max(1, idx - 1)].EndTime or
                selected[math.max(1, idx - 1)].StartTime
            timeSinceLastObject = timeSinceLastObject + thisTime - prevTime
            if (timeSinceLastObject - 10 > settingVars.ms and settingVars.maintainMs and settingVars.optimizeTGs) then
                idIndex = 1
                timeSinceLastObject = 0
            else
                idIndex = idIndex + 1
            end
            local idName = ids[idIndex]
            if (not neededIds[idName]) then
                neededIds[idName] = { hos = {}, svs = {} }
            end
            table.insert(neededIds[idName].hos, ho)
            local startTime = truthy(selected[1].EndTime) and selected[1].EndTime or selected[1].StartTime
            local secondaryTime = truthy(selected[2].EndTime) and selected[2].EndTime or selected[2].StartTime
            for _, sv in ipairs(settingVars.copiedSVs) do
                local currentTime = truthy(ho.EndTime) and ho.EndTime or ho.StartTime
                local maxRelativeOffset = settingVars.copiedSVs[#settingVars.copiedSVs].relativeOffset
                local progress = 1 - sv.relativeOffset / maxRelativeOffset
                local tempMultiplier = sv.multiplier
                if (settingVars.scaleSVs) then
                    local scalingFactor =
                        (currentTime - startTime) / (secondaryTime - startTime)
                    if (not settingVars.maintainMs) then scalingFactor = 1 / scalingFactor end
                    tempMultiplier = tempMultiplier * scalingFactor
                end
                if (settingVars.maintainMs) then
                    svTime = currentTime - progress * settingVars.ms
                else
                    svTime = currentTime - progress * (currentTime - startTime)
                end
                table.insert(neededIds[idName].svs, createSV(svTime, tempMultiplier))
            end
        end
        ::nextSelected::
    end
    for id, data in pairs(neededIds) do
        local r = math.random(255)
        local g = math.random(255)
        local b = math.random(255)
        local tg = createSG(data.svs, settingVars.initialSV or 1, table.concat({ r, g, b }, ","))
        local action = createEA(action_type.CreateTimingGroup, id, tg, data.hos)
        actionList[#actionList + 1] = action
    end
    actions.PerformBatch(actionList)
    toggleablePrint("w!", "Automated.")
end
function placePenisSV(settingVars)
    local startTime = state.SelectedHitObjects[1].StartTime
    local svs = {}
    for j = 0, 1 do
        for i = 0, 100 do
            local time = startTime + i * settingVars.bWidth * 0.01 + j * (settingVars.sWidth + settingVars.bWidth)
            local circVal = math.sqrt(1 - ((i * 0.02) - 1) ^ 2)
            local trueVal = settingVars.bCurvature * 0.01 * circVal + (1 - settingVars.bCurvature * 0.01)
            table.insert(svs, createSV(time, trueVal))
        end
    end
    for i = 0, 100 do
        local time = startTime + settingVars.bWidth + i * settingVars.sWidth * 0.01
        local circVal = math.sqrt(1 - ((i * 0.02) - 1) ^ 2)
        local trueVal = settingVars.sCurvature * 0.01 * circVal + (3.75 - settingVars.sCurvature * 0.01)
        table.insert(svs, createSV(time, trueVal))
    end
    removeAndAddSVs(game.getSVsBetweenOffsets(startTime, startTime + settingVars.sWidth + settingVars.bWidth * 2), svs)
end
function placeStutterSVs(settingVars)
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    local lastFirstStutter = settingVars.startSV
    local lastMultiplier = settingVars.svMultipliers[3]
    if settingVars.linearlyChange then
        lastFirstStutter = settingVars.endSV
        lastMultiplier = settingVars.svMultipliers2[3]
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local totalNumStutters = (#offsets - 1) * settingVars.stuttersPerSection
    local firstStutterSVs = generateLinearSet(settingVars.startSV, lastFirstStutter,
        totalNumStutters)
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    local stutterIndex = 1
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local stutterOffsets = generateLinearSet(startOffset, endOffset,
            settingVars.stuttersPerSection + 1)
        for j = 1, #stutterOffsets - 1 do
            local duration = settingVars.stutterDuration
            if settingVars.linearlyChange then
                local x = (j - 1) / (#stutterOffsets - 2)
                if (#stutterOffsets == 2) then
                    x = (i - 1) / (#offsets - 1)
                end
                duration = x * settingVars.stutterDuration2 + (1 - x) * settingVars.stutterDuration
            end
            local svMultipliers = generateStutterSet(firstStutterSVs[stutterIndex],
                duration,
                settingVars.avgSV,
                settingVars.controlLastSV)
            local stutterStart = stutterOffsets[j]
            local stutterEnd = stutterOffsets[j + 1]
            local timeInterval = stutterEnd - stutterStart
            local secondSVOffset = stutterStart + timeInterval * duration * 0.01
            addSVToList(svsToAdd, stutterStart, svMultipliers[1], true)
            addSVToList(svsToAdd, secondSVOffset, svMultipliers[2], true)
            stutterIndex = stutterIndex + 1
        end
    end
    addFinalSV(svsToAdd, lastOffset, lastMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function placeTeleportStutterSVs(settingVars)
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    local svPercent = settingVars.svPercent * 0.01
    local lastSVPercent = svPercent
    local lastMainSV = settingVars.mainSV
    if settingVars.linearlyChange then
        lastSVPercent = settingVars.svPercent2 * 0.01
        lastMainSV = settingVars.mainSV2
    end
    local offsets = game.uniqueNoteOffsetsBetweenSelected()
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local numTeleportSets = #offsets - 1
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    local svPercents = generateLinearSet(svPercent, lastSVPercent, numTeleportSets)
    local mainSVs = generateLinearSet(settingVars.mainSV, lastMainSV, numTeleportSets)
    removeAndAddSVs(svsToRemove, svsToAdd)
    for i = 1, numTeleportSets do
        local thisMainSV = mainSVs[i]
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local offsetInterval = endOffset - startOffset
        local startMultiplier = getUsableDisplacementMultiplier(startOffset)
        local startDuration = 1 / startMultiplier
        local endMultiplier = getUsableDisplacementMultiplier(endOffset)
        local endDuration = 1 / endMultiplier
        local startDistance = offsetInterval * svPercents[i]
        if settingVars.useDistance then startDistance = settingVars.distance end
        local expectedDistance = offsetInterval * settingVars.avgSV
        local traveledDistance = offsetInterval * thisMainSV
        local endDistance = expectedDistance - startDistance - traveledDistance
        local sv1 = thisMainSV + startDistance * startMultiplier
        local sv2 = thisMainSV
        local sv3 = thisMainSV + endDistance * endMultiplier
        for j = 0, settingVars.stuttersPerSection - 1 do
            local x = j / settingVars.stuttersPerSection
            local currentStart = (endOffset - startOffset) * j / settingVars.stuttersPerSection + startOffset
            local currentEnd = (endOffset - startOffset) * (j + 1) / settingVars.stuttersPerSection + startOffset
            addSVToList(svsToAdd, currentStart, sv1 / settingVars.stuttersPerSection, true)
            if sv2 ~= sv1 then
                addSVToList(svsToAdd, currentStart + startDuration, sv2,
                    true)
            end
            if sv3 ~= sv2 then addSVToList(svsToAdd, currentEnd - endDuration, sv3 / settingVars.stuttersPerSection, true) end
        end
    end
    local finalMultiplier = settingVars.avgSV
    if finalSVType ~= "Normal" then
        finalMultiplier = settingVars.customSV
    end
    addFinalSV(svsToAdd, lastOffset, finalMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function placeExponentialSpecialSVs(menuVars)
    if (menuVars.settingVars.distanceMode == 2) then
        placeSVs(menuVars, nil, nil, nil, menuVars.settingVars.distance)
    end
end
function placeSSFs(menuVars)
    local numMultipliers = #menuVars.svMultipliers
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    local ssfsToAdd = {}
    local ssfsToRemove = game.getSSFsBetweenOffsets(firstOffset, lastOffset)
    if globalVars.dontReplaceSV then
        ssfsToRemove = {}
    end
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local ssfOffsets = generateLinearSet(startOffset, endOffset, #menuVars.svDistances)
        for j = 1, #ssfOffsets - 1 do
            local offset = ssfOffsets[j]
            local multiplier = menuVars.svMultipliers[j]
            addSSFToList(ssfsToAdd, offset, multiplier, true)
        end
    end
    local lastMultiplier = menuVars.svMultipliers[numMultipliers]
    addFinalSSF(ssfsToAdd, lastOffset, lastMultiplier)
    addInitialSSF(ssfsToAdd, firstOffset - 1 / getUsableDisplacementMultiplier(firstOffset))
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
end
function placeSVs(menuVars, place, optionalStart, optionalEnd, optionalDistance, queuedSVs)
    local finalSVType = FINAL_SV_TYPES[menuVars.settingVars.finalSVIndex]
    local placingStillSVs = menuVars.noteSpacing ~= nil
    local numMultipliers = #menuVars.svMultipliers
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    if placingStillSVs then
        offsets = game.uniqueNoteOffsetsBetweenSelected()
        if (not truthy(offsets)) then return end
        if place == false then
            offsets = game.uniqueNoteOffsetsBetween(optionalStart, optionalEnd)
        end
    end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    if placingStillSVs then offsets = { firstOffset, lastOffset } end
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    if (not placingStillSVs) and globalVars.dontReplaceSV then
        svsToRemove = {}
    end
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local svOffsets = generateLinearSet(startOffset, endOffset, #menuVars.svDistances)
        for j = 1, #svOffsets - 1 do
            local offset = svOffsets[j]
            local multiplier = menuVars.svMultipliers[j]
            if optionalDistance ~= nil then
                multiplier = optionalDistance / (endOffset - startOffset) * math.abs(multiplier)
            end
            addSVToList(svsToAdd, offset, multiplier, true)
        end
    end
    local lastMultiplier = menuVars.svMultipliers[numMultipliers]
    if (place == nil or place == true) then
        if placingStillSVs then
            local tbl = getStillSVs(menuVars, firstOffset, lastOffset,
                sort(svsToAdd, sortAscendingStartTime), svsToAdd)
            svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
        end
        addFinalSV(svsToAdd, lastOffset, lastMultiplier, finalSVType == "Override")
        removeAndAddSVs(svsToRemove, svsToAdd)
        return
    end
    local tbl = getStillSVs(menuVars, firstOffset, lastOffset,
        sort(svsToAdd, sortAscendingStartTime), svsToAdd, queuedSVs)
    svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
function placeStillSVsParent(menuVars)
    printLegacyLNMessage()
    local svsToRemove = {}
    local svsToAdd = {}
    if (menuVars.stillBehavior == 1) then
        if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and menuVars.settingVars.distanceMode == 2) then
            placeSVs(menuVars, nil, nil, nil, menuVars.settingVars.distance)
        else
            placeSVs(menuVars)
        end
        return
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    for i = 1, (#offsets - 1) do
        if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and menuVars.settingVars.distanceMode == 2) then
            tbl = placeSVs(menuVars, false, offsets[i], offsets[i + 1], menuVars.settingVars.distance, svsToAdd)
        else
            tbl = placeSVs(menuVars, false, offsets[i], offsets[i + 1], nil, svsToAdd)
        end
        svsToRemove = table.combine(svsToRemove, tbl.svsToRemove)
        svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    end
    addFinalSV(svsToAdd, offsets[#offsets], menuVars.svMultipliers[#menuVars.svMultipliers], true)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function getStillSVs(menuVars, optionalStart, optionalEnd, svs, retroactiveSVRemovalTable, queuedSVs)
    local stillType = STILL_TYPES[menuVars.stillTypeIndex]
    local noteSpacing = menuVars.noteSpacing
    local stillDistance = menuVars.stillDistance
    local noteOffsets = game.uniqueNoteOffsetsBetween(optionalStart, optionalEnd, true)
    if (not noteOffsets) then return { svsToRemove = {}, svsToAdd = {} } end
    local firstOffset = noteOffsets[1]
    local lastOffset = noteOffsets[#noteOffsets]
    local svMultFn = truthy(queuedSVs) and function(t) return getHypotheticalSVMultiplierAt(queuedSVs, t) end or
        game.getSVMultiplierAt
    if stillType == "Auto" then
        local multiplier = getUsableDisplacementMultiplier(firstOffset)
        local duration = 1 / multiplier
        local timeBefore = firstOffset - duration
        multiplierBefore = svMultFn(timeBefore)
        stillDistance = multiplierBefore * duration
    elseif stillType == "Otua" then
        local multiplier = getUsableDisplacementMultiplier(lastOffset)
        local duration = 1 / multiplier
        local timeAt = lastOffset
        local multiplierAt = svMultFn(timeAt)
        stillDistance = -multiplierAt * duration
    end
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local svsBetweenOffsets = getHypotheticalSVsBetweenOffsets(svs, firstOffset, lastOffset)
    local svDisplacements = calculateDisplacementsFromSVs(svsBetweenOffsets, noteOffsets)
    local nsvDisplacements = calculateDisplacementsFromNotes(noteOffsets, noteSpacing)
    local finalDisplacements = calculateStillDisplacements(stillType, stillDistance,
        svDisplacements, nsvDisplacements)
    for i = 1, #noteOffsets do
        local noteOffset = noteOffsets[i]
        local beforeDisplacement = nil
        local atDisplacement = 0
        local afterDisplacement = nil
        if i ~= #noteOffsets then
            atDisplacement = -finalDisplacements[i]
            afterDisplacement = 0
        end
        if i ~= 1 then
            beforeDisplacement = finalDisplacements[i]
        end
        local baseSVs = table.duplicate(svs)
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement, true, baseSVs)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, firstOffset, lastOffset, retroactiveSVRemovalTable)
    while (svsToAdd[#svsToAdd].StartTime == optionalEnd) do
        table.remove(svsToAdd, #svsToAdd)
    end
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
function ssfVibrato(menuVars, func1, func2)
    printLegacyLNMessage()
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startTime = offsets[1]
    local endTime = offsets[#offsets]
    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality]
    local delta = 1000 / fps
    local time = startTime
    local ssfs = { createSSF(startTime - 1 / getUsableDisplacementMultiplier(startTime),
        game.getSSFMultiplierAt(time)) }
    while time < endTime do
        local x = math.inverseLerp(time, startTime, endTime)
        local y = math.inverseLerp(time + delta, startTime, endTime)
        table.insert(ssfs,
            createSSF(time, func2(x)
            ))
        table.insert(ssfs, createSSF(time + 1 / getUsableDisplacementMultiplier(time), func1(x)))
        table.insert(ssfs,
            createSSF(time + delta,
                func1(y)))
        table.insert(ssfs,
            createSSF(time + delta + 1 / getUsableDisplacementMultiplier(time), func2(y)))
        time = time + 2 * delta
    end
    addFinalSSF(ssfs, endTime, game.getSSFMultiplierAt(endTime))
    actions.PerformBatch({
        createEA(action_type.AddScrollSpeedFactorBatch, ssfs)
    })
    toggleablePrint("s!", table.concat({"Created ", #ssfs, pluralize(" SSF.", #ssfs, -2)}))
end
---comment
---@param menuVars any
---@param heightFn fun(t: number, idx?: integer): number
function svVibrato(menuVars, heightFn)
    printLegacyLNMessage()
    local offsets = game.uniqueNoteOffsetsBetweenSelected(true)
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {} ---@type ScrollVelocity[]
    local svsToRemove = {} ---@type ScrollVelocity[]
    local svTimeIsAdded = {}
    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality] + 0.69
    for i = 1, #offsets - 1 do
        local startVibro = offsets[i]
        local nextVibro = offsets[i + 1]
        local startPos = (startVibro - startOffset) / (endOffset - startOffset)
        local endPos = (nextVibro - startOffset) / (endOffset - startOffset)
        local posDifference = endPos - startPos
        local roundingFactor = math.max(menuVars.sides, 2)
        local teleportCount = math.floor((nextVibro - startVibro) / 1000 * fps / roundingFactor) * roundingFactor
        if teleportCount < 2 then
            print("e!", "Some notes are too close together to place vibrato. Check for notes that are 1ms apart.")
            return
        end
        if (menuVars.sides == 1) then
            for tp = 1, teleportCount do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(math.floor((tp - 1) / 2) * 2 / teleportCount * posDifference +
                    startPos, tp)
                if (tp % 2 == 1) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
        elseif (menuVars.sides == 2) then
            teleportCount = teleportCount + 1
            prepareDisplacingSVs(startVibro, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 0), 0)
            for tp = 1, teleportCount - 2, 2 do
                local x = tp / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local prevHeight = heightFn((tp - 1) / (teleportCount - 1) * posDifference +
                    startPos, tp)
                local newHeight = heightFn((tp + 1) / (teleportCount - 1) * posDifference +
                    startPos, tp + 1)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    prevHeight + newHeight, 0)
                x = (tp + 1) / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -newHeight * 2, 0)
            end
            prepareDisplacingSVs(nextVibro * (1 - 2 / teleportCount) + 2 * startVibro / teleportCount, svsToAdd,
                svTimeIsAdded, nil,
                heightFn(posDifference * (1 - 2 / (teleportCount - 1)) + startPos, teleportCount - 2) +
                heightFn(endPos, teleportCount - 1), 0)
            prepareDisplacingSVs(nextVibro * (1 - 1 / teleportCount) + startVibro / teleportCount, svsToAdd,
                svTimeIsAdded, nil,
                -heightFn(endPos, teleportCount), 0)
        else
            for tp = 1, teleportCount - 2, 3 do
                local x = (tp - 1) / teleportCount
                local offset = nextVibro * x + startVibro * (1 - x)
                local height = heightFn(startPos + (tp - 1) / teleportCount * posDifference, (tp - 1) / 3 + 1)
                local newHeight = heightFn(startPos + (tp + 2) / teleportCount * posDifference, (tp - 1) / 3 + 2)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = tp / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height + newHeight, 0)
                x = (tp + 1) / teleportCount
                offset = nextVibro * x + startVibro * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -newHeight, 0)
            end
        end
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function deleteItems(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local linesToRemove = game.getLinesBetweenOffsets(startOffset, endOffset)
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset)
    local ssfsToRemove = game.getSSFsBetweenOffsets(startOffset, endOffset)
    local bmsToRemove = game.getBookmarksBetweenOffsets(startOffset, endOffset)
    if (not menuVars.deleteTable[1]) then linesToRemove = {} end
    if (not menuVars.deleteTable[2]) then svsToRemove = {} end
    if (not menuVars.deleteTable[3]) then ssfsToRemove = {} end
    if (not menuVars.deleteTable[4]) then bmsToRemove = {} end
    if (truthy(linesToRemove) or truthy(svsToRemove) or truthy(ssfsToRemove) or truthy(bmsToRemove)) then
        actions.PerformBatch({
            createEA(
                action_type.RemoveTimingPointBatch, linesToRemove),
            createEA(
                action_type.RemoveScrollVelocityBatch, svsToRemove),
            createEA(
                action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
            createEA(
                action_type.RemoveBookmarkBatch, bmsToRemove) })
    end
    if (truthy(linesToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #linesToRemove, pluralize(" timing point.", #linesToRemove, -2)}))
    end
    if (truthy(svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(bmsToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #bmsToRemove, pluralize(" bookmark.", #bmsToRemove, -2)}))
    end
end
function addTeleportSVs(menuVars)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local displaceAmount = menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        if (menuVars.teleportBeforeHand) then
            noteOffset = noteOffset - 1 / getUsableDisplacementMultiplier(noteOffset)
        end
        local beforeDisplacement = nil
        local atDisplacement = displaceAmount
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function changeGroups(menuVars)
    if (state.SelectedScrollGroupId == menuVars.designatedTimingGroup) then
        print("w!",
            table.concat({ menuVars.clone and "Cloning" or "Moving",
                " from one timing group to the same timing group will do nothing." }))
        return
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset, true)
    local ssfsToRemove = game.getSSFsBetweenOffsets(startOffset, endOffset, true)
    local svsToAdd = {}
    local ssfsToAdd = {}
    local oldGroup = state.SelectedScrollGroupId
    for k14 = 1, #svsToRemove do
        local sv = svsToRemove[k14]
        table.insert(svsToAdd, createSV(sv.StartTime, sv.Multiplier))
    end
    for k15 = 1, #ssfsToRemove do
        local ssf = ssfsToRemove[k15]
        table.insert(ssfsToAdd, createSSF(ssf.StartTime, ssf.Multiplier))
    end
    local actionList = {}
    local willChangeSVs = menuVars.changeSVs and #svsToRemove ~= 0
    local willChangeSSFs = menuVars.changeSSFs and #ssfsToRemove ~= 0
    if willChangeSVs then
        if (not menuVars.clone) then
            table.insert(actionList, createEA(action_type.RemoveScrollVelocityBatch, svsToRemove))
        end
        state.SelectedScrollGroupId = menuVars
            .designatedTimingGroup
        table.insert(actionList, createEA(action_type.AddScrollVelocityBatch, svsToAdd))
    end
    if willChangeSSFs then
        if (not menuVars.clone) then
            table.insert(actionList, createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove))
        end
        state.SelectedScrollGroupId = menuVars.designatedTimingGroup
        table.insert(actionList, createEA(action_type.AddScrollSpeedFactorBatch, ssfsToAdd))
    end
    if (not truthy(actionList)) then
        state.SelectedScrollGroupId = oldGroup
        return
    end
    actions.PerformBatch(actionList)
    if willChangeSVs then
        toggleablePrint("s!",
            "Successfully moved " .. #svsToRemove ..
            pluralize(" SV", #svsToRemove) .. ' to "' .. menuVars.designatedTimingGroup .. '".')
    end
    if willChangeSSFs then
        toggleablePrint("s!",
            "Successfully moved " .. #ssfsToRemove ..
            pluralize(" SSF", #ssfsToRemove) .. ' to "' .. menuVars.designatedTimingGroup .. '".')
    end
end
function storeDuplicateItems(menuVars)
    objects = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    local tls = game.getLinesBetweenOffsets(startOffset, endOffset)
    local bms = game.getBookmarksBetweenOffsets(startOffset, endOffset)
    for _, note in pairs(notes) do
        table.insert(objects, { type = "ho", data = note })
    end
    for _, tl in pairs(tls) do
        table.insert(objects, { type = "tl", data = tl })
    end
    for _, bm in pairs(bms) do
        table.insert(objects, { type = "bm", data = bm })
    end
    local ogId = state.SelectedScrollGroupId
    local svTbl = {}
    local ssfTbl = {}
    for tgId, tg in pairs(map.TimingGroups) do
        svTbl[tgId] = {}
        ssfTbl[tgId] = {}
        state.SelectedScrollGroupId = tgId
        local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
        local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset)
        for _, sv in pairs(svs) do
            svTbl[tgId][#svTbl[tgId] + 1] = sv
        end
        for _, ssf in pairs(ssfs) do
            ssfTbl[tgId][#ssfTbl[tgId] + 1] = ssf
        end
    end
    state.SelectedScrollGroupId = ogId
    menuVars.objects = objects
    menuVars.svTbl = svTbl
    menuVars.ssfTbl = ssfTbl
    menuVars.msOffset = startOffset
end
function clearDuplicateItems(menuVars)
    menuVars.objects = {}
end
function placeDuplicateItems(menuVars)
    local placeTime = state.SelectedHitObjects[1].StartTime
    local hosToAdd = {}
    local tlsToAdd = {}
    local bmsToAdd = {}
    local svActions = {}
    local ssfActions = {}
    local moveActions = {}
    local objects = menuVars.objects
    local svTbl = menuVars.svTbl
    local ssfTbl = menuVars.ssfTbl
    local offset = placeTime - menuVars.msOffset
    for _, obj in ipairs(menuVars.objects) do
        local data = obj.data
        if (obj.type == "ho") then
            local ho = utils.CreateHitObject(data.StartTime + offset, data.Lane,
                data.EndTime == 0 and 0 or data.EndTime + offset, data.HitSound, data.EditorLayer)
            hosToAdd[#hosToAdd + 1] = ho
            table.insert(moveActions, createEA(action_type.MoveObjectsToTimingGroup, { ho }, data.TimingGroup))
        end
        if (obj.type == "tl") then
            table.insert(tlsToAdd, utils.CreateTimingPoint(data.StartTime + offset, data.Bpm, data.Signature, data
                .Hidden))
        end
        if (obj.type == "bm") then
            table.insert(bmsToAdd, utils.CreateBookmark(data.StartTime + offset, data.Note))
        end
    end
    for tgId, svList in pairs(svTbl) do
        local newSVList = {}
        for _, sv in pairs(svList) do
            table.insert(newSVList, createSV(sv.StartTime + offset, sv.Multiplier))
        end
        local tg = map.GetTimingGroup(tgId)
        table.insert(svActions, createEA(action_type.AddScrollVelocityBatch, newSVList, tg))
    end
    for tgId, ssfList in pairs(ssfTbl) do
        local newSSFList = {}
        for _, ssf in pairs(ssfList) do
            table.insert(newSSFList, createSSF(ssf.StartTime + offset, ssf.Multiplier))
        end
        local tg = map.GetTimingGroup(tgId)
        table.insert(ssfActions, createEA(action_type.AddScrollSpeedFactorBatch, newSSFList, tg))
    end
    actions.PerformBatch(table.combine({
        createEA(action_type.PlaceHitObjectBatch, hosToAdd),
        createEA(action_type.AddTimingPointBatch, tlsToAdd),
        createEA(action_type.AddBookmarkBatch, bmsToAdd),
    }, svActions, ssfActions))
    actions.PerformBatch(moveActions)
end
function convertSVSSF(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local objects = {}
    local editorActions = {}
    if (menuVars.conversionDirection) then
        local svs = game.getSVsBetweenOffsets(startOffset, endOffset, false)
        for k16 = 1, #svs do
            local sv = svs[k16]
            table.insert(objects, { StartTime = sv.StartTime, Multiplier = sv.Multiplier })
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svs))
    else
        local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset, false)
        for k17 = 1, #ssfs do
            local ssf = ssfs[k17]
            table.insert(objects, { StartTime = ssf.StartTime, Multiplier = ssf.Multiplier })
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollSpeedFactorBatch, ssfs))
    end
    local createTable = {}
    for k18 = 1, #objects do
        local obj = objects[k18]
        if (menuVars.conversionDirection) then
            table.insert(createTable, createSSF(obj.StartTime,
                obj.Multiplier))
        else
            table.insert(createTable, createSV(obj.StartTime, obj.Multiplier))
        end
    end
    if (menuVars.conversionDirection) then
        table.insert(editorActions, createEA(action_type.AddScrollSpeedFactorBatch, createTable))
    else
        table.insert(editorActions, createEA(action_type.AddScrollVelocityBatch, createTable))
    end
    actions.PerformBatch(editorActions)
    toggleablePrint("s!", "Successfully converted.")
end
function swapSVSSF(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset)
    local ssfsToRemove = game.getSSFsBetweenOffsets(startOffset, endOffset)
    local svsToAdd = {}
    local ssfsToAdd = {}
    for _, sv in pairs(svsToRemove) do
        table.insert(ssfsToAdd, createSSF(sv.StartTime, sv.Multiplier))
    end
    for _, ssf in pairs(ssfsToRemove) do
        table.insert(svsToAdd, createSV(ssf.StartTime, ssf.Multiplier))
    end
    actions.PerformBatch({
        createEA(action_type.RemoveScrollVelocityBatch, svsToRemove),
        createEA(action_type.AddScrollVelocityBatch, svsToAdd),
        createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        createEA(action_type.AddScrollSpeedFactorBatch, ssfsToAdd),
    })
    toggleablePrint("s!", "Successfully swapped.")
end
function copyItems(menuVars)
    clearCopiedItems(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local lines = game.getLinesBetweenOffsets(startOffset, endOffset)
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset)
    local bms = game.getBookmarksBetweenOffsets(startOffset, endOffset)
    if (not menuVars.copyLines) then goto lineSkip end
    for k19 = 1, #lines do
        local line = lines[k19]
        local copiedLine = {
            relativeOffset = line.StartTime - startOffset,
            bpm = line.Bpm,
            signature = line.Signature,
            hidden = line.Hidden,
        }
        table.insert(menuVars.copied.lines[menuVars.curSlot], copiedLine)
    end
    ::lineSkip::
    if (not menuVars.copySVs) then goto svSkip end
    for k20 = 1, #svs do
        local sv = svs[k20]
        local copiedSV = {
            relativeOffset = sv.StartTime - startOffset,
            multiplier = sv.Multiplier
        }
        table.insert(menuVars.copied.SVs[menuVars.curSlot], copiedSV)
    end
    ::svSkip::
    if (not menuVars.copySSFs) then goto ssfSkip end
    for k21 = 1, #ssfs do
        local ssf = ssfs[k21]
        local copiedSSF = {
            relativeOffset = ssf.StartTime - startOffset,
            multiplier = ssf.Multiplier
        }
        table.insert(menuVars.copied.SSFs[menuVars.curSlot], copiedSSF)
    end
    ::ssfSkip::
    if (not menuVars.copyBMs) then goto bmSkip end
    for k22 = 1, #bms do
        local bm = bms[k22]
        local copiedBM = {
            relativeOffset = bm.StartTime - startOffset,
            note = bm.Note
        }
        table.insert(menuVars.copied.BMs[menuVars.curSlot], copiedBM)
    end
    ::bmSkip::
    local printed = false
    if (#menuVars.copied.BMs[menuVars.curSlot] > 0) then
        printed = true
        toggleablePrint("s!",
            "Copied " ..
            #menuVars.copied.BMs[menuVars.curSlot] .. pluralize(" Bookmark.", #menuVars.copied.BMs[menuVars.curSlot], -2))
    end
    if (#menuVars.copied.SSFs[menuVars.curSlot] > 0) then
        printed = true
        toggleablePrint("s!",
            "Copied " ..
            #menuVars.copied.SSFs[menuVars.curSlot] .. pluralize(" SSF.", #menuVars.copied.SSFs[menuVars.curSlot], -2))
    end
    if (#menuVars.copied.SVs[menuVars.curSlot] > 0) then
        printed = true
        toggleablePrint("s!",
            "Copied " ..
            #menuVars.copied.SVs[menuVars.curSlot] .. pluralize(" SV.", #menuVars.copied.SVs[menuVars.curSlot], -2))
    end
    if (#menuVars.copied.lines[menuVars.curSlot] > 0) then
        printed = true
        toggleablePrint("s!",
            "Copied " ..
            #menuVars.copied.lines[menuVars.curSlot] .. pluralize(" Line.", #menuVars.copied.lines[menuVars.curSlot], -2))
    end
    if (not printed) then
        print("w!", "There were no items to copy.")
    end
end
function clearCopiedItems(menuVars)
    local newCopied = table.duplicate(menuVars.copied)
    newCopied.lines[menuVars.curSlot] = {}
    newCopied.SVs[menuVars.curSlot] = {}
    newCopied.SSFs[menuVars.curSlot] = {}
    newCopied.BMs[menuVars.curSlot] = {}
    menuVars.copied = newCopied
end
function pasteItems(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local lastCopiedLine = menuVars.copied.lines[menuVars.curSlot][#menuVars.copied.lines[menuVars.curSlot]]
    local lastCopiedSV = menuVars.copied.SVs[menuVars.curSlot][#menuVars.copied.SVs[menuVars.curSlot]]
    local lastCopiedSSF = menuVars.copied.SSFs[menuVars.curSlot][#menuVars.copied.SSFs[menuVars.curSlot]]
    local lastCopiedBM = menuVars.copied.BMs[menuVars.curSlot][#menuVars.copied.BMs[menuVars.curSlot]]
    local lastCopiedValue = lastCopiedSV
    if lastCopiedValue == nil then
        lastCopiedValue = lastCopiedSSF or lastCopiedLine or lastCopiedBM or { relativeOffset = 0 }
    end
    local endRemoveOffset = endOffset + lastCopiedValue.relativeOffset + 1 / 128
    local linesToRemove = menuVars.copyLines and game.getLinesBetweenOffsets(startOffset, endRemoveOffset) or {}
    local svsToRemove = menuVars.copySVs and game.getSVsBetweenOffsets(startOffset, endRemoveOffset) or {}
    local ssfsToRemove = menuVars.copySSFs and game.getSSFsBetweenOffsets(startOffset, endRemoveOffset) or {}
    local bmsToRemove = menuVars.copyBMs and game.getBookmarksBetweenOffsets(startOffset, endRemoveOffset) or {}
    if globalVars.dontReplaceSV then
        linesToRemove = {}
        svsToRemove = {}
        ssfsToRemove = {}
        bmsToRemove = {}
    end
    local linesToAdd = {}
    local svsToAdd = {}
    local ssfsToAdd = {}
    local bmsToAdd = {}
    local hitObjectTimes = table.dedupe(table.property(map.HitObjects, "StartTime"))
    for i = 1, #offsets do
        local pasteOffset = offsets[i]
        local nextOffset = offsets[math.clamp(i + 1, 1, #offsets)]
        local ignoranceTolerance = 0.01
        for _, line in ipairs(menuVars.copied.lines[menuVars.curSlot]) do
            local timeToPasteLine = pasteOffset + line.relativeOffset
            if (math.abs(timeToPasteLine - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto nextLine
            end
            table.insert(linesToAdd, utils.CreateTimingPoint(timeToPasteLine, line.bpm, line.signature, line.hidden))
            ::nextLine::
        end
        for _, sv in ipairs(menuVars.copied.SVs[menuVars.curSlot]) do
            local timeToPasteSV = pasteOffset + sv.relativeOffset
            if (math.abs(timeToPasteSV - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto nextSV
            end
            if menuVars.tryAlign then
                timeToPasteSV = tryAlignToHitObjects(timeToPasteSV, hitObjectTimes, menuVars.alignWindow)
            end
            table.insert(svsToAdd, createSV(timeToPasteSV, sv.multiplier))
            ::nextSV::
        end
        for _, ssf in ipairs(menuVars.copied.SSFs[menuVars.curSlot]) do
            local timeToPasteSSF = pasteOffset + ssf.relativeOffset
            if (math.abs(timeToPasteSSF - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto nextSSF
            end
            table.insert(ssfsToAdd, createSSF(timeToPasteSSF, ssf.multiplier))
            ::nextSSF::
        end
        for _, bm in ipairs(menuVars.copied.BMs[menuVars.curSlot]) do
            local timeToPasteBM = pasteOffset + bm.relativeOffset
            if (math.abs(timeToPasteBM - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto nextBM
            end
            table.insert(bmsToAdd, utils.CreateBookmark(timeToPasteBM, bm.note))
            ::nextBM::
        end
    end
    actions.PerformBatch({
        createEA(action_type.RemoveTimingPointBatch, linesToRemove),
        createEA(action_type.RemoveScrollVelocityBatch, svsToRemove),
        createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        createEA(action_type.RemoveBookmarkBatch, bmsToRemove),
        createEA(action_type.AddTimingPointBatch, linesToAdd),
        createEA(action_type.AddScrollVelocityBatch, svsToAdd),
        createEA(action_type.AddScrollSpeedFactorBatch, ssfsToAdd),
        createEA(action_type.AddBookmarkBatch, bmsToAdd),
    })
    if (truthy(linesToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #linesToRemove, pluralize(" timing point.", #linesToRemove, -2)}))
    end
    if (truthy(svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(bmsToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #bmsToRemove, pluralize(" bookmark.", #bmsToRemove, -2)}))
    end
    if (truthy(linesToAdd)) then
        toggleablePrint("s!", table.concat({"Created ", #linesToAdd, pluralize(" timing point.", #linesToAdd, -2)}))
    end
    if (truthy(svsToAdd)) then
        toggleablePrint("s!",
            "Created " .. #svsToAdd .. pluralize(" scroll velocity.", #svsToAdd, -2))
    end
    if (truthy(ssfsToAdd)) then
        toggleablePrint("s!",
            "Created " .. #ssfsToAdd .. pluralize(" scroll speed factor.", #ssfsToAdd, -2))
    end
    if (truthy(bmsToAdd)) then
        toggleablePrint("s!", table.concat({"Created ", #bmsToAdd, pluralize(" bookmark.", #bmsToAdd, -2)}))
    end
end
function tryAlignToHitObjects(time, hitObjectTimes, alignWindow)
    if not truthy(hitObjectTimes) then
        return time
    end
    local closestTime = table.searchClosest(hitObjectTimes, time)
    if math.abs(closestTime - time) > alignWindow then
        return time
    end
    time = math.frac(time) + closestTime - 1
    if math.abs(closestTime - (time + 1)) < math.abs(closestTime - time) then
        time = time + 1
    end
    return time
end
function displaceNoteSVsParent(menuVars)
    printLegacyLNMessage()
    if (not menuVars.linearlyChange) then
        displaceNoteSVs(menuVars)
        return
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local svsToRemove = {}
    local svsToAdd = {}
    for k23 = 1, #offsets do
        local offset = offsets[k23]
        local tbl = displaceNoteSVs(
            {
                distance = (offset - offsets[1]) / (offsets[#offsets] - offsets[1]) *
                    (menuVars.distance2 - menuVars.distance1) + menuVars.distance1
            },
            false, offset)
        svsToRemove = table.combine(svsToRemove, tbl.svsToRemove)
        svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function displaceNoteSVs(menuVars, place, optionalOffset)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return { svsToRemove = {}, svsToAdd = {} } end
    if place == false then offsets = { optionalOffset } end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local displaceAmount = menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local beforeDisplacement = displaceAmount
        local atDisplacement = -displaceAmount
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    if place ~= false then
        removeAndAddSVs(svsToRemove, svsToAdd)
        return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
    end
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
function displaceViewSVs(menuVars)
    printLegacyLNMessage()
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueNoteOffsetsBetweenSelected(true)
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local displaceAmount = menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local beforeDisplacement = nil
        local atDisplacement = displaceAmount
        local afterDisplacement = 0 ---@type number|nil
        if i ~= 1 then beforeDisplacement = -displaceAmount end
        if i == #offsets then
            atDisplacement = 0
            afterDisplacement = nil
        end
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function dynamicScaleSVs(menuVars)
    local offsets = menuVars.noteTimes
    local targetAvgSVs = menuVars.svMultipliers
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(offsets[1], offsets[#offsets])
    for i = 1, (#offsets - 1) do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local targetAvgSV = targetAvgSVs[i]
        local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
        local targetDistance = targetAvgSV * (endOffset - startOffset)
        local scalingFactor = targetDistance / currentDistance
        for k24 = 1, #svsBetweenOffsets do
            local sv = svsBetweenOffsets[k24]
            local newSVMultiplier = scalingFactor * sv.Multiplier
            addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
        end
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function flickerSVs(menuVars)
    printLegacyLNMessage()
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local numTeleports = 2 * menuVars.numFlickers
    local isDelayedFlicker = FLICKER_TYPES[menuVars.flickerTypeIndex] == "Delayed"
    for i = 1, (#offsets - 1) do
        local flickerStartOffset = offsets[i]
        local flickerEndOffset = offsets[i + 1]
        local teleportOffsets = generateLinearSet(flickerStartOffset, flickerEndOffset,
            numTeleports + 1)
        local flickerDuration = teleportOffsets[2] - teleportOffsets[1]
        for t, _ in pairs(teleportOffsets) do
            if (t % 2 == 1) then goto nextTeleport end
            pushFactor = (2 * menuVars.flickerPosition - 1) * flickerDuration
            teleportOffsets[t] = teleportOffsets[t] + pushFactor
            ::nextTeleport::
        end
        for j = 1, numTeleports do
            local offsetIndex = j
            if isDelayedFlicker then offsetIndex = offsetIndex + 1 end
            local teleportOffset = math.floor(teleportOffsets[offsetIndex])
            local isTeleportBack = j % 2 == 0
            if isDelayedFlicker then
                local beforeDisplacement = menuVars.distance
                local atDisplacement = 0
                if isTeleportBack then beforeDisplacement = -beforeDisplacement end
                prepareDisplacingSVs(teleportOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
                    atDisplacement, 0)
            else
                local atDisplacement = menuVars.distance
                local afterDisplacement = 0
                if isTeleportBack then atDisplacement = -atDisplacement end
                prepareDisplacingSVs(teleportOffset, svsToAdd, svTimeIsAdded, nil, atDisplacement,
                    afterDisplacement)
            end
        end
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
COLOR_MAP = {
    [1] = "Red",
    [2] = "Blue",
    [3] = "Purple",
    [4] = "Yellow",
    [5] = "White",
    [6] = "Pink",
    [8] =
    "Orange",
    [12] = "Cyan",
    [16] = "Green"
}
REVERSE_COLOR_MAP = {
    Red = 1,
    Blue = 2,
    Purple = 3,
    Yellow = 4,
    White = 5,
    Pink = 6,
    Orange = 8,
    Cyan = 12,
    Green = 16
}
function layerSnaps()
    local layerDict = {}
    local originalLayerNames = table.property(map.EditorLayers, "Name")
    local layerNames = table.duplicate(originalLayerNames)
    local notes = map.HitObjects
    for k25 = 1, #notes do
        local ho = notes[k25]
        local color = COLOR_MAP[game.getSnapAt(ho.StartTime)]
        if (ho.EditorLayer == 0) then
            layer = { Name = "Default", ColorRgb = "255,255,255", Hidden = false }
        else
            layer = map.EditorLayers[ho.EditorLayer]
        end
        local newLayerName = layer.Name .. "-plumoguSV-snap-" .. color
        if (table.contains(layerNames, newLayerName)) then
            if (table.contains(originalLayerNames, newLayerName)) then
                print("e!",
                    "Existing plumoguSV snap layers have been detected. Please remove them before trying to layer snaps again.")
                return
            end
            table.insert(layerDict[newLayerName].hos, ho)
        else
            layerDict[newLayerName] = { hos = { ho }, ColorRgb = layer.ColorRgb, Hidden = layer.Hidden }
            layerNames[#layerNames + 1] = newLayerName
        end
    end
    local createLayerQueue = {}
    local moveNoteQueue = {}
    for layerName, layerData in pairs(layerDict) do
        local layer = utils.CreateEditorLayer(layerName, layerData.Hidden, layerData.ColorRgb)
        table.insert(createLayerQueue,
            createEA(action_type.CreateLayer, layer))
        table.insert(moveNoteQueue, createEA(action_type.MoveToLayer, layer, layerData.hos))
    end
    actions.PerformBatch(createLayerQueue)
    actions.PerformBatch(moveNoteQueue)
end
function collapseSnaps()
    local normalTpsToAdd = {}
    local snapTpsToAdd = {}
    local tpsToRemove = {}
    local snapInterval = 0.69
    local baseBpm = 60000 / snapInterval
    local moveNoteActions = {}
    local removeLayerActions = {}
    for _, ho in ipairs(map.HitObjects) do
        for _, tp in ipairs(map.TimingPoints) do
            if ho.StartTime - snapInterval <= tp.StartTime and tp.StartTime <= ho.StartTime + snapInterval then
                tpsToRemove[#tpsToRemove + 1] = tp
            end
            if tp.StartTime > ho.StartTime + snapInterval then break end
        end
        if (ho.EditorLayer == 0) then
            hoLayer = { Name = "Default", ColorRgb = "255,255,255", Hidden = false }
        else
            hoLayer = map.EditorLayers[ho.EditorLayer]
        end
        if (not hoLayer.Name:find("plumoguSV")) then goto nextLayer end
        do
            local color = hoLayer.Name:match("-([a-zA-Z]+)$")
            local snap = REVERSE_COLOR_MAP[color]
            local mostRecentTP = game.getTimingPointAt(ho.StartTime)
            if snap == 1 then
                table.insert(snapTpsToAdd,
                    utils.CreateTimingPoint(ho.StartTime, mostRecentTP.Bpm, mostRecentTP.Signature, true))
            else
                table.insert(snapTpsToAdd,
                    utils.CreateTimingPoint(ho.StartTime - snapInterval,
                        baseBpm / snap, mostRecentTP.Signature, true))
                table.insert(normalTpsToAdd,
                    utils.CreateTimingPoint(ho.StartTime + snapInterval,
                        mostRecentTP.Bpm, mostRecentTP.Signature, true))
            end
            local originalLayerName = hoLayer.Name:match("^([^-]+)-")
            table.insert(moveNoteActions,
                createEA(action_type.MoveToLayer,
                    map.EditorLayers[table.indexOf(table.property(map.EditorLayers, "Name"), originalLayerName)], { ho }))
            table.insert(removeLayerActions,
                createEA(action_type.RemoveLayer, hoLayer))
        end
        ::nextLayer::
    end
    actions.PerformBatch(moveNoteActions)
    if (not truthy(#normalTpsToAdd + #snapTpsToAdd + #tpsToRemove)) then
        print("w!", "There were no generated layers you nonce")
        return
    end
    actions.PerformBatch({
        createEA(action_type.AddTimingPointBatch, normalTpsToAdd),
        createEA(action_type.AddTimingPointBatch, snapTpsToAdd),
        createEA(action_type.RemoveTimingPointBatch, tpsToRemove),
    })
end
function clearSnappedLayers()
    local removeLayerActions = {}
    for _, layer in ipairs(map.EditorLayers) do
        if layer.Name:find("plumoguSV") then
            table.insert(removeLayerActions, createEA(action_type.RemoveLayer, layer))
        end
    end
    if (not truthy(removeLayerActions)) then
        print("w!", "There were no generated layers you nonce")
        return
    end
    actions.PerformBatch(removeLayerActions)
end
function alignTimingLines()
    local tpsToRemove = {}
    local currentTP = state.CurrentTimingPoint
    local starttime = currentTP.StartTime
    local length = map.GetTimingPointLength(currentTP)
    local endtime = starttime + length
    local signature = tn(currentTP.Signature)
    local bpm = currentTP.Bpm
    local mspb = 60000 / bpm
    local msptl = mspb * signature
    local noteTimes = table.property(map.HitObjects, "StartTime")
    local times = {}
    local timingpoints = {}
    for time = starttime, endtime, msptl do
        local originalTime = math.floor(time)
        while (truthy(noteTimes) and (noteTimes[1] < originalTime - 5)) do
            table.remove(noteTimes, 1)
        end
        if (not truthy(noteTimes)) then
            times[#times + 1] = originalTime
        elseif (math.abs(noteTimes[1] - originalTime) <= 5) then
            times[#times + 1] = noteTimes[1]
        else
            times[#times + 1] = originalTime
        end
    end
    for k26 = 1, #times do
        local time = times[k26]
        if (game.getTimingPointAt(time).StartTime == time) then
            tpsToRemove[#tpsToRemove + 1] = game.getTimingPointAt(time)
        end
        table.insert(timingpoints, utils.CreateTimingPoint(time, bpm, signature))
    end
    actions.PerformBatch({
        createEA(action_type.AddTimingPointBatch, timingpoints),
        createEA(action_type.RemoveTimingPointBatch, tpsToRemove)
    })
    toggleablePrint("s!", table.concat({"Created ", #timingpoints, pluralize(" timing point.", #timingpoints, -2)}))
    if (truthy(tpsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #tpsToRemove .. pluralize(" timing point.", #tpsToRemove, -2))
    end
end
function fixFlippedLNEnds()
    local svsToRemove = {}
    local svsToAdd = {}
    local svTimeIsAdded = {}
    local lnEndTimeFixed = {}
    local fixedLNEndsCount = 0
    for _, ho in ipairs(map.HitObjects) do
        local lnEndTime = ho.EndTime
        local isLN = lnEndTime ~= 0
        local endHasNegativeSV = (game.getSVMultiplierAt(lnEndTime) <= 0)
        local hasntAlreadyBeenFixed = lnEndTimeFixed[lnEndTime] == nil
        if isLN and endHasNegativeSV and hasntAlreadyBeenFixed then
            lnEndTimeFixed[lnEndTime] = true
            local multiplier = getUsableDisplacementMultiplier(lnEndTime)
            local duration = 1 / multiplier
            local timeAt = lnEndTime
            local timeAfter = lnEndTime + duration
            local timeAfterAfter = lnEndTime + duration + duration
            svTimeIsAdded[timeAt] = true
            svTimeIsAdded[timeAfter] = true
            svTimeIsAdded[timeAfterAfter] = true
            local svMultiplierAt = game.getSVMultiplierAt(timeAt)
            local svMultiplierAfter = game.getSVMultiplierAt(timeAfter)
            local svMultiplierAfterAfter = game.getSVMultiplierAt(timeAfterAfter)
            local newMultiplierAt = 0.001
            local newMultiplierAfter = svMultiplierAt + svMultiplierAfter
            local newMultiplierAfterAfter = svMultiplierAfterAfter
            addSVToList(svsToAdd, timeAt, newMultiplierAt, true)
            addSVToList(svsToAdd, timeAfter, newMultiplierAfter, true)
            addSVToList(svsToAdd, timeAfterAfter, newMultiplierAfterAfter, true)
            fixedLNEndsCount = fixedLNEndsCount + 1
        end
    end
    local startOffset = map.HitObjects[1].StartTime
    local endOffset = map.HitObjects[#map.HitObjects].EndTime
    if endOffset == 0 then endOffset = map.HitObjects[#map.HitObjects].StartTime end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
    local type = truthy(fixedLNEndsCount) and "s!" or "w!"
    print(type, "Fixed " .. fixedLNEndsCount .. pluralize(" flipped LN end.", fixedLNEndsCount, -2))
end
function mergeSVs()
    local svTimeDict = {}
    local svsToRemove = {}
    for _, sv in ipairs(table.reverse(map.ScrollVelocities)) do
        if (svTimeDict[sv.StartTime]) then
            svsToRemove[#svsToRemove + 1] = sv
        else
            svTimeDict[sv.StartTime] = true
        end
    end
    if (truthy(svsToRemove)) then actions.RemoveScrollVelocityBatch(svsToRemove) end
    local type = truthy(svsToRemove) and "s!" or "w!"
    print(type, "Removed " .. #svsToRemove .. pluralize(" SV.", #svsToRemove, -2))
end
function mergeSSFs()
    local ssfTimeDict = {}
    local ssfsToRemove = {}
    for _, ssf in ipairs(table.reverse(map.ScrollSpeedFactors)) do
        if (ssfTimeDict[ssf.StartTime]) then
            ssfsToRemove[#ssfsToRemove + 1] = ssf
        else
            ssfTimeDict[ssf.StartTime] = true
        end
    end
    if (truthy(ssfsToRemove)) then actions.Perform(createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove)) end
    local type = truthy(ssfsToRemove) and "s!" or "w!"
    print(type, "Removed " .. #ssfsToRemove .. pluralize(" SSF.", #ssfsToRemove, -2))
end
function mergeNotes()
    local noteDict = {}
    local notesToRemove = {}
    for _, ho in ipairs(map.HitObjects) do
        if (not noteDict[ho.StartTime]) then
            noteDict[ho.StartTime] = { [ho.Lane] = true }
        else
            if (not noteDict[ho.StartTime][ho.Lane]) then
                noteDict[ho.StartTime][ho.Lane] = true
            else
                notesToRemove[#notesToRemove + 1] = ho
            end
        end
    end
    if (truthy(notesToRemove)) then actions.RemoveHitObjectBatch(notesToRemove) end
    local type = truthy(notesToRemove) and "s!" or "w!"
    print(type, "Removed " .. #notesToRemove .. pluralize(" note.", #notesToRemove, -2))
end
function removeUnnecessarySVs()
    local editorActions = {}
    local ogTG = state.SelectedScrollGroupId
    local svSum = 0
    for tgId, tg in pairs(map.TimingGroups) do
        local svsToRemove = {}
        state.SelectedScrollGroupId = tgId
        local prevMultiplier = state.SelectedScrollGroup.InitialScrollVelocity or map.InitialScrollVelocity or 1
        for _, sv in ipairs(map.ScrollVelocities) do
            local m = sv.Multiplier
            if m == prevMultiplier then svsToRemove[#svsToRemove + 1] = sv end
            prevMultiplier = m
        end
        table.insert(editorActions, createEA(action_type.RemoveScrollVelocityBatch, svsToRemove, tg))
        svSum = svSum + #svsToRemove
    end
    if (truthy(svSum)) then actions.PerformBatch(editorActions) end
    local type = truthy(svSum) and "s!" or "w!"
    print(type, "Removed " .. svSum .. pluralize(" SV.", svSum, -2))
    state.SelectedScrollGroupId = ogTG
end
function removeAllHitSounds()
    local hitsoundActions = {}
    local objs = {}
    for _, ho in ipairs(map.HitObjects) do
        local hs = tonumber(ho.HitSound)
        if hs > 1 then
            table.insert(hitsoundActions, createEA(action_type.RemoveHitsound, { ho }, hs))
            objs[#objs + 1] = ho.StartTime .. "|" .. ho.Lane
        end
    end
    local type = truthy(hitsoundActions) and "s!" or "w!"
    print(type,
        "Removed " ..
        #hitsoundActions .. pluralize(" hitsound.", #hitsoundActions, -2))
    print("w!", "Note that the Quaver hitsound system is funky and some hitsounds exist that aren't audible.")
    imgui.SetClipboardText(table.concat(objs, ","))
    actions.PerformBatch(hitsoundActions)
end
function measureSVs(menuVars)
    local roundingDecimalPlaces = 5
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    menuVars.roundedNSVDistance = endOffset - startOffset
    menuVars.nsvDistance = tostring(menuVars.roundedNSVDistance)
    local totalDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
    menuVars.roundedSVDistance = math.round(totalDistance, roundingDecimalPlaces)
    menuVars.svDistance = tostring(totalDistance)
    local avgSV = totalDistance / menuVars.roundedNSVDistance
    menuVars.roundedAvgSV = math.round(avgSV, roundingDecimalPlaces)
    menuVars.avgSV = tostring(avgSV)
    local durationStart = 1 / getUsableDisplacementMultiplier(startOffset)
    local timeAt = startOffset
    local timeAfter = startOffset + durationStart
    local multiplierAt = game.getSVMultiplierAt(timeAt)
    local multiplierAfter = game.getSVMultiplierAt(timeAfter)
    local startDisplacement = -(multiplierAt - multiplierAfter) * durationStart
    menuVars.roundedStartDisplacement = math.round(startDisplacement, roundingDecimalPlaces)
    menuVars.startDisplacement = tostring(startDisplacement)
    local durationEnd = 1 / getUsableDisplacementMultiplier(startOffset)
    local timeBefore = endOffset - durationEnd
    local timeBeforeBefore = timeBefore - durationEnd
    local multiplierBefore = game.getSVMultiplierAt(timeBefore)
    local multiplierBeforeBefore = game.getSVMultiplierAt(timeBeforeBefore)
    local endDisplacement = (multiplierBefore - multiplierBeforeBefore) * durationEnd
    menuVars.roundedEndDisplacement = math.round(endDisplacement, roundingDecimalPlaces)
    menuVars.endDisplacement = tostring(endDisplacement)
    local trueDistance = totalDistance - endDisplacement + startDisplacement
    local trueAvgSV = trueDistance / menuVars.roundedNSVDistance
    menuVars.roundedAvgSVDisplaceless = math.round(trueAvgSV, roundingDecimalPlaces)
    menuVars.avgSVDisplaceless = tostring(trueAvgSV)
end
function reverseScrollSVs(menuVars)
    printLegacyLNMessage()
    local offsets = game.uniqueNoteOffsetsBetweenSelected(true)
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {}
    local almostSVsToAdd = {}
    local extraOffset = 2 / getUsableDisplacementMultiplier(endOffset)
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset + extraOffset)
    local svTimeIsAdded = {}
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    local sectionDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
    local msxSeparatingDistance = -10000
    local teleportDistance = -sectionDistance + msxSeparatingDistance
    local noteDisplacement = -menuVars.distance
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local beforeDisplacement = nil
        local atDisplacement = 0
        local afterDisplacement = 0
        if i ~= 1 then
            beforeDisplacement = noteDisplacement
            atDisplacement = -noteDisplacement
        end
        if i == 1 or i == #offsets then
            atDisplacement = atDisplacement + teleportDistance
        end
        prepareDisplacingSVs(noteOffset, almostSVsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    for k27 = 1, #svsBetweenOffsets do
        local sv = svsBetweenOffsets[k27]
        if (not svTimeIsAdded[sv.StartTime]) then
            almostSVsToAdd[#almostSVsToAdd + 1] = sv
        end
    end
    for k28 = 1, #almostSVsToAdd do
        local sv = almostSVsToAdd[k28]
        local newSVMultiplier = -sv.Multiplier
        if sv.StartTime > endOffset then newSVMultiplier = sv.Multiplier end
        addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function scaleDisplaceSVs(menuVars)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local isStartDisplace = DISPLACE_SCALE_SPOTS[menuVars.scaleSpotIndex] == "Start"
    for i = 1, (#offsets - 1) do
        local note1Offset = offsets[i]
        local note2Offset = offsets[i + 1]
        local svsBetweenOffsets = game.getSVsBetweenOffsets(note1Offset, note2Offset)
        addStartSVIfMissing(svsBetweenOffsets, note1Offset)
        local scaleType = SCALE_TYPES[menuVars.scaleTypeIndex]
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, note1Offset,
            note2Offset)
        local scalingDistance
        if scaleType == "Average SV" then
            local targetDistance = menuVars.avgSV * (note2Offset - note1Offset)
            scalingDistance = targetDistance - currentDistance
            print(scalingDistance)
        elseif scaleType == "Absolute Distance" then
            scalingDistance = menuVars.distance - currentDistance
        elseif scaleType == "Relative Ratio" then
            scalingDistance = (menuVars.ratio - 1) * currentDistance
        end
        if isStartDisplace then
            prepareDisplacingSVs(note1Offset, svsToAdd, svTimeIsAdded, nil, scalingDistance,
                0)
        else
            prepareDisplacingSVs(note2Offset, svsToAdd, svTimeIsAdded, scalingDistance,
                0, nil)
        end
    end
    if isStartDisplace then addFinalSV(svsToAdd, endOffset, game.getSVMultiplierAt(endOffset)) end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function scaleMultiplySVs(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(offsets[1], offsets[#offsets])
    for i = 1, (#offsets - 1) do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        local scalingFactor = menuVars.ratio
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
        local scaleType = SCALE_TYPES[menuVars.scaleTypeIndex]
        if scaleType == "Average SV" then
            local currentAvgSV = currentDistance / (endOffset - startOffset)
            scalingFactor = menuVars.avgSV / currentAvgSV
        elseif scaleType == "Absolute Distance" then
            scalingFactor = menuVars.distance / currentDistance
        end
        for k29 = 1, #svsBetweenOffsets do
            local sv = svsBetweenOffsets[k29]
            local newSVMultiplier = scalingFactor * sv.Multiplier
            addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
        end
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function splitNotes(menuVars)
    local noteDict = {}
    local notes = state.SelectedHitObjects
    if (menuVars.modeIndex == 1) then
        for k30 = 1, #notes do
            local note = notes[k30]
            if (noteDict[note.Lane]) then
                table.insert(noteDict[note.Lane], note)
            else
                noteDict[note.Lane] = { note }
            end
        end
    elseif (menuVars.modeIndex == 2) then
        for k31 = 1, #notes do
            local note = notes[k31]
            if (noteDict[note.StartTime]) then
                table.insert(noteDict[note.StartTime], note)
            else
                noteDict[note.StartTime] = { note }
            end
        end
    else
        for k32 = 1, #notes do
            local note = notes[k32]
            noteDict[note.StartTime .. "_" .. note.Lane] = { note }
        end
    end
    local prefix = "col"
    if (menuVars.modeIndex == 2) then
        prefix = "time"
    elseif (menuVars.modeIndex == 3) then
        prefix = "solo"
    end
    local editorActions = {}
    local existingIds = table.keys(map.TimingGroups)
    for name, noteList in pairs(noteDict) do
        local id = table.concat({ "splitter_", prefix, "_", name })
        local startTimeTbl = table.unpack(table.property(noteList, "StartTime"))
        local minStartTime = math.min(startTimeTbl)
        local maxStartTime = math.max(startTimeTbl)
        local svs = menuVars.cloneSVs and
            game.getSVsBetweenOffsets(minStartTime - menuVars.cloneRadius, maxStartTime + menuVars.cloneRadius) or {}
        if (not table.includes(existingIds, id)) then
            local tg = createSG(svs, 1, color.rgbaToStr(generateColor(false)))
            local ea = createEA(action_type.CreateTimingGroup, id, tg, noteList)
            editorActions[#editorActions + 1] = ea
        else
            local ea = createEA(action_type.MoveObjectsToTimingGroup, noteList, id)
            local svEa = createEA(action_type.AddScrollVelocityBatch, svs, map.TimingGroups[id])
            editorActions[#editorActions + 1] = ea
            editorActions[#editorActions + 1] = svEa
        end
    end
    actions.PerformBatch(editorActions)
end
function swapNoteSVs()
    printLegacyLNMessage()
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    local oldSVDisplacements = calculateDisplacementsFromSVs(svsBetweenOffsets, offsets)
    for i = 1, #offsets do
        local noteOffset = offsets[i]
        local currentDisplacement = oldSVDisplacements[i]
        local nextDisplacement = oldSVDisplacements[i + 1] or oldSVDisplacements[1]
        local newDisplacement = nextDisplacement - currentDisplacement
        local beforeDisplacement = newDisplacement
        local atDisplacement = -newDisplacement
        local afterDisplacement = 0
        prepareDisplacingSVs(noteOffset, svsToAdd, svTimeIsAdded, beforeDisplacement,
            atDisplacement, afterDisplacement)
    end
    getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function verticalShiftSVs(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {}
    local svsToRemove = game.getSVsBetweenOffsets(startOffset, endOffset)
    local svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
    addStartSVIfMissing(svsBetweenOffsets, startOffset)
    for k33 = 1, #svsBetweenOffsets do
        local sv = svsBetweenOffsets[k33]
        local newSVMultiplier = sv.Multiplier + menuVars.verticalShift
        addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function changeNoteLockMode()
    local mode = state.GetValue("noteLockMode") or 0
    mode = (mode + 1) % 4
    if mode == 0 then
        print("s", "Notes have been unlocked.")
    end
    if mode == 1 then
        print("e",
            "Notes have been fully locked. To change the lock mode, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. ".")
    end
    if mode == 2 then
        print("w",
            "Notes can no longer be placed, only moved. To change the lock mode, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. ".")
    end
    if mode == 3 then
        print("w",
            "Notes can no longer be moved, only placed and deleted. To change the lock mode, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. ".")
    end
    state.SetValue("noteLockMode", mode)
end
function initializeNoteLockMode()
    state.SetValue("noteLockMode", 0)
    listen(function(action, type, fromLua)
        if fromLua then return end
        local actionIndex = tonumber(action.Type) ---@cast actionIndex EditorActionType
        local mode = state.GetValue("noteLockMode") or 0
        if mode == 1 then
            if actionIndex >= action_type.CreateLayer then return end
            actions.Undo()
        end
        if mode == 2 then
            local allowedActions = {
                action_type.PlaceHitObject,
                action_type.RemoveHitObject,
                action_type.PlaceHitObjectBatch,
                action_type.RemoveHitObjectBatch,
                action_type.AddHitsound,
                action_type.RemoveHitsound,
            }
            if (not table.contains(allowedActions, actionIndex)) then return end
            actions.Undo()
        end
        if mode == 3 then
            local allowedActions = {
                action_type.ResizeLongNote,
                action_type.FlipHitObjects,
                action_type.SwapLanes,
                action_type.MoveHitObjects,
            }
            if (not table.contains(allowedActions, actionIndex)) then return end
            actions.Undo()
        end
    end)
end
function changeTGIndex(diff)
    local groups = state.GetValue("tgList")
    local selectedTgDict = {}
    if (not truthy(state.SelectedHitObjects)) then
        globalVars.scrollGroupIndex = math.wrap(globalVars.scrollGroupIndex + diff, 1, #groups, true)
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
        return
    end
    for _, ho in pairs(state.SelectedHitObjects) do
        if (not selectedTgDict[ho.TimingGroup]) then
            selectedTgDict[ho.TimingGroup] = table.indexOf(groups, ho.TimingGroup)
        end
    end
    local idList = table.keys(selectedTgDict)
    if (not table.includes(idList, groups[globalVars.scrollGroupIndex])) then
        globalVars.scrollGroupIndex = selectedTgDict[idList[#idList]]
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
        return
    end
    if (#table.keys(selectedTgDict) == 1) then return end
    local idIndex = table.indexOf(idList, state.SelectedScrollGroupId)
    globalVars.scrollGroupIndex = selectedTgDict[idList[math.wrap(idIndex + diff, 1, #idList, true)]]
    state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
end
function goToPrevTg()
    changeTGIndex(-1)
end
function goToNextTg()
    changeTGIndex(1)
end
function jumpToTg()
    if (not truthy(state.SelectedHitObjects)) then return end
    local tgId = state.SelectedHitObjects[1].TimingGroup
    for _, ho in pairs(state.SelectedHitObjects) do
        if (ho.TimingGroup ~= tgId) then return end
    end
    state.SelectedScrollGroupId = tgId
end
function checkForGlobalHotkeys()
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_note_tg])) then jumpToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_note_lock])) then changeNoteLockMode() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.toggle_end_offset])) then toggleUseEndOffsets() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.move_selection_to_tg])) then moveSelectionToTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_prev_tg])) then goToPrevTg() end
    if (kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.go_to_next_tg])) then goToNextTg() end
end
function moveSelectionToTg()
    actions.MoveObjectsToTimingGroup(state.SelectedHitObjects, state.SelectedScrollGroupId)
end
function toggleUseEndOffsets()
    globalVars.useEndTimeOffsets = not globalVars.useEndTimeOffsets
    if (globalVars.useEndTimeOffsets) then
        print("s",
            "LN ends are now considered as their own offsets. To change this, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_end_offset] .. ".")
    else
        print("e",
            "LN ends are now no longer considered as their own offsets. To change this, press " ..
            globalVars.hotkeyList[hotkeys_enum.toggle_end_offset] .. ".")
    end
    write(globalVars)
end
function getMapStats()
    local currentTG = state.SelectedScrollGroupId
    local tgList = map.GetTimingGroupIds()
    local svSum = 0
    local ssfSum = 0
    for k34 = 1, #tgList do
        local tg = tgList[k34]
        state.SelectedScrollGroupId = tg
        svSum = svSum + #map.ScrollVelocities
        ssfSum = ssfSum + #map.ScrollSpeedFactors
    end
    print("s!",
        "That's an average of " ..
        math.round(svSum * 1000 / map.TrackLength, 2) ..
        table.concat({" SVs per second, or ", math.round(ssfSum * 1000 / map.TrackLength, 2), " SSFs per second."}))
    print("s!", table.concat({"This map also contains ", #map.TimingPoints, pluralize(" timing point.", #map.TimingPoints, -2)}))
    print("s!",
        "This map has " ..
        svSum .. table.concat({" SVs and ", ssfSum, " SSFs across "}) .. #tgList .. pluralize(" timing group.", #tgList, -2))
    print("w!",
        "Remember that the quality of map has no correlation with the object count! Try to be optimal in your object usage.")
    state.SelectedScrollGroupId = currentTG
end
function selectAlternating(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end
    local times = {}
    for k35 = 1, #notes do
        local ho = notes[k35]
        times[#times + 1] = ho.StartTime
    end
    times = table.dedupe(times)
    local allowedTimes = {}
    for i, time in pairs(times) do
        if ((i - menuVars.offset) % menuVars.every == 0) then
            allowedTimes[#allowedTimes + 1] = time
        end
    end
    local notesToSelect = {}
    local currentTime = allowedTimes[1]
    local index = 2
    for k36 = 1, #notes do
        local note = notes[k36]
        if (note.StartTime > currentTime and index <= #allowedTimes) then
            currentTime = allowedTimes[index]
            index = index + 1
        end
        if (note.StartTime == currentTime) then
            notesToSelect[#notesToSelect + 1] = note
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
function selectByChordSizes(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end
    notes = sort(notes, sortAscendingNoteLaneTime)
    local noteTimeTable = {}
    for k37 = 1, #notes do
        local note = notes[k37]
        noteTimeTable[#noteTimeTable + 1] = note.StartTime
    end
    noteTimeTable = table.dedupe(noteTimeTable)
    local sizeDict = {}
    for idx = 1, game.keyCount do
        sizeDict[#sizeDict + 1] = {}
    end
    for k38 = 1, #noteTimeTable do
        local time = noteTimeTable[k38]
        local size = 0
        local curLane = 0
        local totalNotes = {}
        for k39 = 1, #notes do
            local note = notes[k39]
            if (math.abs(note.StartTime - time) < 3) then
                size = size + 1
                curLane = curLane + 1
                totalNotes[#totalNotes + 1] = note
            end
        end
        sizeDict[size] = table.combine(sizeDict[size], totalNotes)
    end
    local notesToSelect = {}
    for idx = 1, game.keyCount do
        if (menuVars["select" .. idx]) then
            notesToSelect = table.combine(notesToSelect, sizeDict[idx])
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
---@diagnostic disable: undefined-field
function selectByNoteType(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local totalNotes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then totalNotes = state.SelectedHitObjects end
    local notesToSelect = {}
    for k40 = 1, #totalNotes do
        local note = totalNotes[k40]
        if hitobject_type then
            if (note.Type == hitobject_type.Normal and not menuVars.normal) then
                goto skipType
            end
            if (note.Type == hitobject_type.Mine and not menuVars.mine) then
                goto skipType
            end
            if (note.EndTime == 0 and menuVars.rice) then notesToSelect[#notesToSelect + 1] = note end
            if (note.EndTime ~= 0 and menuVars.ln) then notesToSelect[#notesToSelect + 1] = note end
            ::skipType::
        else
            if (note.EndTime == 0 and menuVars.rice) then notesToSelect[#notesToSelect + 1] = note end
            if (note.EndTime ~= 0 and menuVars.ln) then notesToSelect[#notesToSelect + 1] = note end
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
function selectBySnap(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end
    local notesToSelect = {}
    for _, note in pairs(notes) do
        local snap = game.getSnapAt(note.StartTime, true)
        if (snap == menuVars.snap) then notesToSelect[#notesToSelect + 1] = note end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
function selectByTimingGroup(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notesToSelect = {}
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end
    notes = sort(notes, sortAscendingNoteLaneTime)
    for _, note in pairs(notes) do
        if (note.TimingGroup == menuVars.designatedTimingGroup) then
            notesToSelect[#notesToSelect + 1] = note
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
function addGradient()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    local buttonColor = imgui.GetColorU32("Button")
    local bgColor = imgui.GetColorU32("WindowBg")
    local buttonFactor = 0.3
    local tlTr = color.vrgbaToUint(color.uintToRgba(buttonColor) * buttonFactor +
        color.uintToRgba(bgColor) * (1 - buttonFactor))
    ctx.AddRectFilledMultiColor(topLeft, topLeft + dim, bgColor, tlTr, buttonColor, tlTr)
end
local singularity_xList = {}
local singularity_yList = {}
local singularity_vxList = {}
local singularity_vyList = {}
local singularity_axList = {}
local singularity_ayList = {}
function renderReactiveSingularities()
    local imgui = imgui
    local math = math
    local state = state
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    local multiplier = game.getSVMultiplierAt(state.SongTime)
    local dimX = dim.x
    local dimY = dim.y
    local sqrt = math.sqrt
    local clamp = math.clamp
    local pulseStatus = state.GetValue("pulseValue") or 0
    local slowSpeedR = 89
    local slowSpeedG = 0
    local slowSpeedB = 255
    local fastSpeedR = 255
    local fastSpeedG = 165
    local fastSpeedB = 117
    local speed = clamp(math.abs(multiplier), 0, 4)
    if (dimX < 100 or clock.getTime() < 0.3) then return end
    createParticle(dimX, dimY, 150)
    updateParticles(dimX, dimY,
        state.DeltaTime * speed, multiplier)
    local lerp = function(w, l, h)
        return w * h + (1 - w) * l
    end
    for i = 1, #singularity_xList do
        local x = singularity_xList[i]
        local y = singularity_yList[i]
        local vx = singularity_vxList[i]
        local vy = singularity_vyList[i]
        local s = sqrt(vx ^ 2 + vy ^ 2)
        local clampedSpeed = clamp(s / 5, 0, 1)
        local r = lerp(clampedSpeed, slowSpeedR, fastSpeedR)
        local g = lerp(clampedSpeed, slowSpeedG, fastSpeedG)
        local b = lerp(clampedSpeed, slowSpeedB, fastSpeedB)
        local pos = vector.New(x + topLeft.x, y + topLeft.y)
        ctx.AddCircleFilled(pos, 2,
            color.rgbaToUint(r, g, b, 100 + pulseStatus * 155))
    end
    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295 - math.floor(pulseStatus * 120) * 16777216)
    ctx.AddCircle(dim / 2 + topLeft, 24 - pulseStatus * 8, 16777215 + math.floor(pulseStatus * 255) * 16777216)
end
function createParticle(dimX, dimY, n)
    if (#singularity_xList >= n) then return end
    singularity_xList[#singularity_xList + 1] = math.random() * dimX
    singularity_yList[#singularity_yList + 1] = math.random() * dimY
    singularity_vxList[#singularity_vxList + 1] = 0
    singularity_vyList[#singularity_vyList + 1] = 0
    singularity_axList[#singularity_axList + 1] = 0
    singularity_ayList[#singularity_ayList + 1] = 0
end
function updateParticles(dimX, dimY, dt, multiplier)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local spinDir = math.sign(multiplier)
    local movementSpeed = 0.1
    local bounceCoefficient = 0.8
    for i = 1, #singularity_xList do
        local x = singularity_xList[i]
        local y = singularity_yList[i]
        local vx = singularity_vxList[i]
        local vy = singularity_vyList[i]
        local ax = singularity_axList[i]
        local ay = singularity_ayList[i]
        local sgPosx = bit32.rshift(dimX, 1)
        local sgPosy = bit32.rshift(dimY, 1)
        local xDist = sgPosx - x
        local yDist = sgPosy - y
        local dist = sqrt(xDist ^ 2 + yDist ^ 2)
        if dist < 10 then dist = 10 end
        local gravityFactor = bit32.rshift(dist ^ 3, 9)
        local gx = xDist / gravityFactor
        local gy = yDist / gravityFactor
        local spinFactor = 10 * spinDir / sqrt(dist)
        singularity_axList[i] = gx + gy * spinFactor
        singularity_ayList[i] = gy - gx * spinFactor
        local movementDist = dt * movementSpeed
        singularity_vxList[i] = vx + ax * movementDist
        singularity_vyList[i] = vy + ay * movementDist
        singularity_xList[i] = x + vx * movementDist
        singularity_yList[i] = y + vy * movementDist
        if (x < 0 or x > dimX) then
            singularity_vxList[i] = -singularity_vxList[i] * bounceCoefficient
            singularity_xList[i] = clamp(singularity_xList[i], 1, dimX - 1)
        end
        if (y < 0 or y > dimY) then
            singularity_vyList[i] = -singularity_vyList[i] * bounceCoefficient
            singularity_yList[i] = clamp(singularity_yList[i], 1, dimY - 1)
        end
        local dragFactor = 1 - dt / 500
        singularity_vxList[i] = clamp(singularity_vxList[i] * dragFactor, -5, 5)
        singularity_vyList[i] = clamp(singularity_vyList[i] * dragFactor, -5, 5)
    end
end
local stars_xList = {}
local stars_yList = {}
local stars_vxList = {}
local stars_szList = {}
function renderReactiveStars()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    local dimX = dim.x
    local dimY = dim.y
    local clamp = math.clamp
    if (dimX < 100 or clock.getTime() < 0.3) then return end
    createStar(dimX, dimY, 100)
    updateStars(dimX, dimY, state.DeltaTime)
    for i = 1, #stars_xList do
        local x = stars_xList[i]
        local y = stars_yList[i]
        local sz = stars_szList[i]
        local progress = x / dimX
        local brightness = clamp(-8 * progress * (progress - 1), -1, 1)
        local pos = vector.New(x + topLeft.x, y + topLeft.y)
        if brightness < 0 then goto nextStar end
        ctx.AddCircleFilled(pos, sz, color.alterOpacity(color.int.white, 255 - math.floor(brightness * 255)))
        ::nextStar::
    end
end
function createStar(dimX, dimY, n)
    if (#stars_xList >= n) then return end
    stars_xList[#stars_xList + 1] = math.random() * dimX
    stars_yList[#stars_yList + 1] = math.random() * dimY
    stars_vxList[#stars_vxList + 1] = math.random() * 3 + 1
    stars_szList[#stars_szList + 1] = math.random(3) * 0.5
end
function updateStars(dimX, dimY, dt)
    local random = math.random
    local clamp = math.clamp
    local m = game.getSVMultiplierAt(state.SongTime)
    for i = 1, #stars_xList do
        local starWrapped = false
        local x = stars_xList[i]
        local y = stars_yList[i]
        local vx = stars_vxList[i]
        while (x > dimX + 10) do
            starWrapped = true
            x = x - dimX - 20
        end
        while (x < -10) do
            starWrapped = true
            x = x + dimX + 20
        end
        stars_xList[i] = x
        if starWrapped then
            stars_yList[i] = random() * dimY
            stars_vxList[i] = random() * 3 + 1
            stars_szList[i] = random(3) * 0.5
        else
            stars_xList[i] = x + vx * dt * 0.05 *
                clamp(2 * m, -50, 50)
        end
    end
end
function drawCapybaraParent()
    drawCapybara()
    drawCapybara2()
    drawCapybara312()
end
function drawCapybara()
    if not globalVars.drawCapybara then return end
    local o = imgui.GetForegroundDrawList()
    local sz = state.WindowSize
    local headWidth = 50
    local headRadius = 20
    local eyeWidth = 10
    local eyeRadius = 3
    local earRadius = 12
    local headCoords1 = relativePoint(sz, -100, -100)
    local headCoords2 = relativePoint(headCoords1, -headWidth, 0)
    local eyeCoords1 = relativePoint(headCoords1, -10, -10)
    local eyeCoords2 = relativePoint(eyeCoords1, -eyeWidth, 0)
    local earCoords = relativePoint(headCoords1, 12, -headRadius + 5)
    local stemCoords = relativePoint(headCoords1, 50, -headRadius + 5)
    local bodyColor = color.rgbaToUint(122, 70, 212, 255)
    local eyeColor = color.rgbaToUint(30, 20, 35, 255)
    local earColor = color.rgbaToUint(62, 10, 145, 255)
    local stemColor = color.rgbaToUint(0, 255, 0, 255)
    o.AddCircleFilled(earCoords, earRadius, earColor)
    drawHorizontalPillShape(o, headCoords1, headCoords2, headRadius, bodyColor, 12)
    drawHorizontalPillShape(o, eyeCoords1, eyeCoords2, eyeRadius, eyeColor, 12)
    o.AddRectFilled(table.vectorize2(sz), headCoords1, bodyColor)
    o.AddRectFilled(vector.New(stemCoords.x, stemCoords.y), vector.New(stemCoords.x + 10, stemCoords.y + 20),
        stemColor)
    o.AddRectFilled(vector.New(stemCoords.x - 10, stemCoords.y), vector.New(stemCoords.x + 20, stemCoords.y - 5),
        stemColor)
end
function drawCapybara2()
    if not globalVars.drawCapybara2 then return end
    local o = imgui.GetForegroundDrawList()
    local sz = state.WindowSize
    local topLeftCapyPoint = vector.New(0, sz[2] - 165)
    local p1 = relativePoint(topLeftCapyPoint, 0, 95)
    local p2 = relativePoint(topLeftCapyPoint, 0, 165)
    local p3 = relativePoint(topLeftCapyPoint, 58, 82)
    local p3b = relativePoint(topLeftCapyPoint, 108, 82)
    local p4 = relativePoint(topLeftCapyPoint, 58, 165)
    local p5 = relativePoint(topLeftCapyPoint, 66, 29)
    local p6 = relativePoint(topLeftCapyPoint, 105, 10)
    local p7 = relativePoint(topLeftCapyPoint, 122, 126)
    local p7b = relativePoint(topLeftCapyPoint, 133, 107)
    local p8 = relativePoint(topLeftCapyPoint, 138, 11)
    local p9 = relativePoint(topLeftCapyPoint, 145, 82)
    local p10 = relativePoint(topLeftCapyPoint, 167, 82)
    local p10b = relativePoint(topLeftCapyPoint, 172, 80)
    local p11 = relativePoint(topLeftCapyPoint, 172, 50)
    local p12 = relativePoint(topLeftCapyPoint, 179, 76)
    local p12b = relativePoint(topLeftCapyPoint, 176, 78)
    local p12c = relativePoint(topLeftCapyPoint, 176, 70)
    local p13 = relativePoint(topLeftCapyPoint, 185, 50)
    local p14 = relativePoint(topLeftCapyPoint, 113, 10)
    local p15 = relativePoint(topLeftCapyPoint, 116, 0)
    local p16 = relativePoint(topLeftCapyPoint, 125, 2)
    local p17 = relativePoint(topLeftCapyPoint, 129, 11)
    local p17b = relativePoint(topLeftCapyPoint, 125, 11)
    local p18 = relativePoint(topLeftCapyPoint, 91, 0)
    local p19 = relativePoint(topLeftCapyPoint, 97, 0)
    local p20 = relativePoint(topLeftCapyPoint, 102, 1)
    local p21 = relativePoint(topLeftCapyPoint, 107, 11)
    local p22 = relativePoint(topLeftCapyPoint, 107, 19)
    local p23 = relativePoint(topLeftCapyPoint, 103, 24)
    local p24 = relativePoint(topLeftCapyPoint, 94, 17)
    local p25 = relativePoint(topLeftCapyPoint, 88, 9)
    local p26 = relativePoint(topLeftCapyPoint, 123, 33)
    local p27 = relativePoint(topLeftCapyPoint, 132, 30)
    local p28 = relativePoint(topLeftCapyPoint, 138, 38)
    local p29 = relativePoint(topLeftCapyPoint, 128, 40)
    local p30 = relativePoint(topLeftCapyPoint, 102, 133)
    local p31 = relativePoint(topLeftCapyPoint, 105, 165)
    local p32 = relativePoint(topLeftCapyPoint, 113, 165)
    local p33 = relativePoint(topLeftCapyPoint, 102, 131)
    local p34 = relativePoint(topLeftCapyPoint, 82, 138)
    local p35 = relativePoint(topLeftCapyPoint, 85, 165)
    local p36 = relativePoint(topLeftCapyPoint, 93, 165)
    local p37 = relativePoint(topLeftCapyPoint, 50, 80)
    local p38 = relativePoint(topLeftCapyPoint, 80, 40)
    local p39 = relativePoint(topLeftCapyPoint, 115, 30)
    local p40 = relativePoint(topLeftCapyPoint, 40, 92)
    local p41 = relativePoint(topLeftCapyPoint, 80, 53)
    local p42 = relativePoint(topLeftCapyPoint, 107, 43)
    local p43 = relativePoint(topLeftCapyPoint, 40, 104)
    local p44 = relativePoint(topLeftCapyPoint, 70, 56)
    local p45 = relativePoint(topLeftCapyPoint, 100, 53)
    local p46 = relativePoint(topLeftCapyPoint, 45, 134)
    local p47 = relativePoint(topLeftCapyPoint, 50, 80)
    local p48 = relativePoint(topLeftCapyPoint, 70, 87)
    local p49 = relativePoint(topLeftCapyPoint, 54, 104)
    local p50 = relativePoint(topLeftCapyPoint, 50, 156)
    local p51 = relativePoint(topLeftCapyPoint, 79, 113)
    local p52 = relativePoint(topLeftCapyPoint, 55, 24)
    local p53 = relativePoint(topLeftCapyPoint, 85, 25)
    local p54 = relativePoint(topLeftCapyPoint, 91, 16)
    local p55 = relativePoint(topLeftCapyPoint, 45, 33)
    local p56 = relativePoint(topLeftCapyPoint, 75, 36)
    local p57 = relativePoint(topLeftCapyPoint, 81, 22)
    local p58 = relativePoint(topLeftCapyPoint, 45, 43)
    local p59 = relativePoint(topLeftCapyPoint, 73, 38)
    local p60 = relativePoint(topLeftCapyPoint, 61, 32)
    local p61 = relativePoint(topLeftCapyPoint, 33, 55)
    local p62 = relativePoint(topLeftCapyPoint, 73, 45)
    local p63 = relativePoint(topLeftCapyPoint, 55, 36)
    local p64 = relativePoint(topLeftCapyPoint, 32, 95)
    local p65 = relativePoint(topLeftCapyPoint, 53, 42)
    local p66 = relativePoint(topLeftCapyPoint, 15, 75)
    local p67 = relativePoint(topLeftCapyPoint, 0, 125)
    local p68 = relativePoint(topLeftCapyPoint, 53, 62)
    local p69 = relativePoint(topLeftCapyPoint, 0, 85)
    local p70 = relativePoint(topLeftCapyPoint, 0, 165)
    local p71 = relativePoint(topLeftCapyPoint, 29, 112)
    local p72 = relativePoint(topLeftCapyPoint, 0, 105)
    local p73 = relativePoint(topLeftCapyPoint, 73, 70)
    local p74 = relativePoint(topLeftCapyPoint, 80, 74)
    local p75 = relativePoint(topLeftCapyPoint, 92, 64)
    local p76 = relativePoint(topLeftCapyPoint, 60, 103)
    local p77 = relativePoint(topLeftCapyPoint, 67, 83)
    local p78 = relativePoint(topLeftCapyPoint, 89, 74)
    local p79 = relativePoint(topLeftCapyPoint, 53, 138)
    local p80 = relativePoint(topLeftCapyPoint, 48, 120)
    local p81 = relativePoint(topLeftCapyPoint, 73, 120)
    local p82 = relativePoint(topLeftCapyPoint, 46, 128)
    local p83 = relativePoint(topLeftCapyPoint, 48, 165)
    local p84 = relativePoint(topLeftCapyPoint, 74, 150)
    local p85 = relativePoint(topLeftCapyPoint, 61, 128)
    local p86 = relativePoint(topLeftCapyPoint, 83, 100)
    local p87 = relativePoint(topLeftCapyPoint, 90, 143)
    local p88 = relativePoint(topLeftCapyPoint, 73, 143)
    local p89 = relativePoint(topLeftCapyPoint, 120, 107)
    local p90 = relativePoint(topLeftCapyPoint, 116, 133)
    local p91 = relativePoint(topLeftCapyPoint, 106, 63)
    local p92 = relativePoint(topLeftCapyPoint, 126, 73)
    local p93 = relativePoint(topLeftCapyPoint, 127, 53)
    local p94 = relativePoint(topLeftCapyPoint, 91, 98)
    local p95 = relativePoint(topLeftCapyPoint, 101, 76)
    local p96 = relativePoint(topLeftCapyPoint, 114, 99)
    local p97 = relativePoint(topLeftCapyPoint, 126, 63)
    local p98 = relativePoint(topLeftCapyPoint, 156, 73)
    local p99 = relativePoint(topLeftCapyPoint, 127, 53)
    local color1 = color.rgbaToUint(250, 250, 225, 255)
    local color2 = color.rgbaToUint(240, 180, 140, 255)
    local color3 = color.rgbaToUint(195, 90, 120, 255)
    local color4 = color.rgbaToUint(115, 5, 65, 255)
    local color5 = color.rgbaToUint(100, 5, 45, 255)
    local color6 = color.rgbaToUint(200, 115, 135, 255)
    local color7 = color.rgbaToUint(175, 10, 70, 255)
    local color8 = color.rgbaToUint(200, 90, 110, 255)
    local color9 = color.rgbaToUint(125, 10, 75, 255)
    local color10 = color.rgbaToUint(220, 130, 125, 255)
    o.AddQuadFilled(p18, p19, p24, p25, color4)
    o.AddQuadFilled(p19, p20, p21, p22, color1)
    o.AddQuadFilled(p19, p22, p23, p24, color4)
    o.AddQuadFilled(p14, p15, p16, p17, color4)
    o.AddTriangleFilled(p17b, p16, p17, color1)
    o.AddQuadFilled(p1, p2, p4, p3, color3)
    o.AddQuadFilled(p1, p3, p6, p5, color3)
    o.AddQuadFilled(p3, p4, p7, p9, color2)
    o.AddQuadFilled(p3, p6, p11, p10, color2)
    o.AddQuadFilled(p6, p8, p13, p11, color1)
    o.AddQuadFilled(p13, p12, p10, p11, color6)
    o.AddTriangleFilled(p10b, p12b, p12c, color7)
    o.AddTriangleFilled(p9, p7b, p3b, color8)
    o.AddQuadFilled(p26, p27, p28, p29, color5)
    o.AddQuadFilled(p7, p30, p31, p32, color5)
    o.AddQuadFilled(p33, p34, p35, p36, color5)
    o.AddTriangleFilled(p37, p38, p39, color8)
    o.AddTriangleFilled(p40, p41, p42, color8)
    o.AddTriangleFilled(p43, p44, p45, color8)
    o.AddTriangleFilled(p46, p47, p48, color8)
    o.AddTriangleFilled(p49, p50, p51, color2)
    o.AddTriangleFilled(p52, p53, p54, color9)
    o.AddTriangleFilled(p55, p56, p57, color9)
    o.AddTriangleFilled(p58, p59, p60, color9)
    o.AddTriangleFilled(p61, p62, p63, color9)
    o.AddTriangleFilled(p64, p65, p66, color9)
    o.AddTriangleFilled(p67, p68, p69, color9)
    o.AddTriangleFilled(p70, p71, p72, color9)
    o.AddTriangleFilled(p73, p74, p75, color10)
    o.AddTriangleFilled(p76, p77, p78, color10)
    o.AddTriangleFilled(p79, p80, p81, color10)
    o.AddTriangleFilled(p82, p83, p84, color10)
    o.AddTriangleFilled(p85, p86, p87, color10)
    o.AddTriangleFilled(p88, p89, p90, color10)
    o.AddTriangleFilled(p91, p92, p93, color10)
    o.AddTriangleFilled(p94, p95, p96, color10)
    o.AddTriangleFilled(p97, p98, p99, color10)
end
function drawCapybara312()
    if not globalVars.drawCapybara312 then return end
    local o = imgui.GetForegroundDrawList()
    local rgbColors = getCurrentRGBColors(globalVars.rgbPeriod)
    local outlineColor = color.rgbaToUint(rgbColors.red, rgbColors.green, rgbColors.blue, 255)
    local p1 = vector.New(42, 32)
    local p2 = vector.New(100, 78)
    local p3 = vector.New(141, 32)
    local p4 = vector.New(83, 63)
    local p5 = vector.New(83, 78)
    local p6 = vector.New(70, 82)
    local p7 = vector.New(85, 88)
    local hairlineThickness = 1
    o.AddTriangleFilled(p1, p2, p3, outlineColor)
    o.AddTriangleFilled(p1, p4, p5, outlineColor)
    o.AddLine(p5, p6, outlineColor, hairlineThickness)
    o.AddLine(p6, p7, outlineColor, hairlineThickness)
    local p8 = vector.New(21, 109)
    local p9 = vector.New(0, 99)
    local p10 = vector.New(16, 121)
    local p11 = vector.New(5, 132)
    local p12 = vector.New(162, 109)
    local p13 = vector.New(183, 99)
    local p14 = vector.New(167, 121)
    local p15 = vector.New(178, 132)
    o.AddTriangleFilled(p1, p8, p9, outlineColor)
    o.AddTriangleFilled(p9, p10, p11, outlineColor)
    o.AddTriangleFilled(p3, p12, p13, outlineColor)
    o.AddTriangleFilled(p13, p14, p15, outlineColor)
    local p16 = vector.New(25, 139)
    local p17 = vector.New(32, 175)
    local p18 = vector.New(158, 139)
    local p19 = vector.New(151, 175)
    local p20 = vector.New(150, 215)
    o.AddTriangleFilled(p11, p16, p17, outlineColor)
    o.AddTriangleFilled(p15, p18, p19, outlineColor)
    o.AddTriangleFilled(p17, p19, p20, outlineColor)
    local p21 = vector.New(84, 148)
    local p22 = vector.New(88, 156)
    local p23 = vector.New(92, 153)
    local p24 = vector.New(96, 156)
    local p25 = vector.New(100, 148)
    local mouthLineThickness = 2
    o.AddLine(p21, p22, outlineColor, mouthLineThickness)
    o.AddLine(p22, p23, outlineColor, mouthLineThickness)
    o.AddLine(p23, p24, outlineColor, mouthLineThickness)
    o.AddLine(p24, p25, outlineColor, mouthLineThickness)
    local p26 = vector.New(61, 126)
    local p27 = vector.New(122, 126)
    local eyeRadius = 9
    local numSements = 16
    o.AddCircleFilled(p26, eyeRadius, outlineColor, numSements)
    o.AddCircleFilled(p27, eyeRadius, outlineColor, numSements)
end
function drawHorizontalPillShape(o, point1, point2, radius, color, circleSegments)
    o.AddCircleFilled(point1, radius, color, circleSegments)
    o.AddCircleFilled(point2, radius, color, circleSegments)
    local rectangleStartCoords = relativePoint(point1, 0, radius)
    local rectangleEndCoords = relativePoint(point2, 0, -radius)
    o.AddRectFilled(rectangleStartCoords, rectangleEndCoords, color)
end
function logoThread()
    curTime = state.UnixTime or 0
    if (math.abs(curTime - (prevTime or 0) - state.DeltaTime) > 60000) then
        state.SetValue("logoStartTime", clock.getTime())
        if (state.GetValue("logoStartTime") < 2.5) then
            state.SetValue("logoStartTime", state.GetValue("logoStartTime") + 0.75)
        end
    end
    prevTime = state.UnixTime
    local currentTime = clock.getTime() - state.GetValue("logoStartTime")
    local logoLength = 3
    if ((state.GetValue("logoStartTime") < 3 or loaded) and not globalVars.disableLoadup) then
        if (currentTime >= 0 and currentTime <= logoLength) then
            drawLogo(currentTime, logoLength, imgui.GetForegroundDrawList(), table.vectorize2(state.WindowSize), 4,
                loadup.OpeningTextColor or DEFAULT_STYLE.loadupOpeningTextColor, 4,
                { loadup.PulseTextColorLeft or DEFAULT_STYLE.loadupPulseTextColorLeft, loadup.PulseTextColorRight or
                DEFAULT_STYLE.loadupPulseTextColorRight })
        end
    else
        state.SetValue("logoStartTime", clock.getTime() - 5)
    end
    loaded = true
end
---Draws logo, where dim = scale * (267, 48).
---@param currentTime number
---@param logoLength number
---@param ctx ImDrawListPtr
---@param windowSize Vector2
---@param scale number
---@param textCol Vector4
---@param thickness integer
---@param pulseCol [Vector4, Vector4]
function drawLogo(currentTime, logoLength, ctx, windowSize, scale, textCol, thickness, pulseCol)
    if currentTime < 0 then return end
    if currentTime > logoLength then return end
    local location = windowSize / 2
    local timeProgress = (currentTime % logoLength / logoLength)
    local curvature1 = 0.4
    local curvature2 = 0.25
    local progress = math.clamp(timeProgress, 0, 1) * 2
    if progress <= 1 then
        progress = (1 - (1 - progress) ^ (1 / curvature1))
    else
        progress = (progress - 1) ^ (1 / curvature2) + 1
    end
    progress = progress * 0.5
    local bgStrength = 4 * (progress - progress * progress)
    local alphaStrengthFactor = vector.New(1, 1, 1, bgStrength)
    local colTl = color.vrgbaToUint((loadup.BgTl or DEFAULT_STYLE.loadupBgTl) * alphaStrengthFactor)
    local colTr = color.vrgbaToUint((loadup.BgTr or DEFAULT_STYLE.loadupBgTr) * alphaStrengthFactor)
    local colBl = color.vrgbaToUint((loadup.BgBl or DEFAULT_STYLE.loadupBgBl) * alphaStrengthFactor)
    local colBr = color.vrgbaToUint((loadup.BgBr or DEFAULT_STYLE.loadupBgBr) * alphaStrengthFactor)
    local textStrength = math.min(1, progress * 2, (1 - progress) * 2)
    local textCol = textCol - (1 - textStrength) * color.vctr.black
    ctx.AddRectFilledMultiColor(vctr2(0), windowSize, colTl, colTr, colBr, colBl)
    local t0, t1
    local trueProgress = progress * 2
    if trueProgress < 1 then
        t0 = 10 * (trueProgress - 1)
        t1 = (1 - trueProgress / 2) * t0 + trueProgress
    else
        trueProgress = trueProgress - 1
        t0 = trueProgress * 20
        t1 = 1 - trueProgress + t0
    end
    local center = vector.New(267, 48) * scale / 2
    location = location - center
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(0, 58.66)), scale * (vector.New(0, 58.66)),
        scale * (vector.New(0, 21.16)),
        scale * (vector.New(0, 21.16)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(0, 21.16)), scale * (vector.New(0, 21.16)),
        scale * (vector.New(4.05, 21.16)), scale * (vector.New(4.05, 21.16)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.05, 21.16)),
        scale * (vector.New(4.05, 21.16)),
        scale * (vector.New(4.05, 25.5)), scale * (vector.New(4.05, 25.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.05, 25.5)),
        scale * (vector.New(4.05, 25.5)),
        scale * (vector.New(4.55, 25.5)), scale * (vector.New(4.55, 25.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.55, 25.5)),
        scale * (vector.New(4.86, 25.03)),
        scale * (vector.New(5.28, 24.42)),
        scale * (vector.New(5.83, 23.68)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(5.83, 23.68)),
        scale * (vector.New(6.38, 22.94)),
        scale * (vector.New(7.18, 22.28)),
        scale * (vector.New(8.21, 21.69)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(8.21, 21.69)),
        scale * (vector.New(9.25, 21.10)),
        scale * (vector.New(10.66, 20.81)),
        scale * (vector.New(12.43, 20.81)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(12.43, 20.81)),
        scale * (vector.New(14.72, 20.81)),
        scale * (vector.New(16.75, 21.38)),
        scale * (vector.New(18.5, 22.53)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(18.5, 22.53)),
        scale * (vector.New(20.25, 23.68)),
        scale * (vector.New(21.62, 25.30)),
        scale * (vector.New(22.6, 27.41)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(22.6, 27.41)),
        scale * (vector.New(23.59, 29.52)),
        scale * (vector.New(24.08, 32.01)), scale * (vector.New(24.08, 34.87)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(24.08, 34.87)),
        scale * (vector.New(24.08, 37.76)),
        scale * (vector.New(23.59, 40.26)),
        scale * (vector.New(22.6, 42.37)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(22.6, 42.37)),
        scale * (vector.New(21.62, 44.48)),
        scale * (vector.New(20.26, 46.12)),
        scale * (vector.New(18.52, 47.27)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(18.52, 47.27)),
        scale * (vector.New(16.78, 48.43)),
        scale * (vector.New(14.77, 49.01)), scale * (vector.New(12.5, 49.01)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(12.5, 49.01)),
        scale * (vector.New(10.75, 49.01)),
        scale * (vector.New(9.34, 48.72)),
        scale * (vector.New(8.29, 48.13)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(8.29, 48.13)),
        scale * (vector.New(7.245, 47.54)),
        scale * (vector.New(6.43, 46.87)),
        scale * (vector.New(5.86, 46.12)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(5.86, 46.12)),
        scale * (vector.New(5.29, 45.37)),
        scale * (vector.New(4.86, 44.74)),
        scale * (vector.New(4.55, 44.25)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.55, 44.25)),
        scale * (vector.New(4.55, 44.25)),
        scale * (vector.New(4.19, 44.25)), scale * (vector.New(4.19, 44.25)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.19, 44.25)),
        scale * (vector.New(4.19, 44.25)),
        scale * (vector.New(4.19, 58.66)), scale * (vector.New(4.19, 58.66)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.19, 58.66)),
        scale * (vector.New(4.19, 58.66)),
        scale * (vector.New(0, 58.66)),
        scale * (vector.New(0, 58.66)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(4.12, 34.8)),
        scale * (vector.New(4.12, 36.86)),
        scale * (vector.New(4.42, 38.67)),
        scale * (vector.New(5.02, 40.24)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(5.02, 40.24)),
        scale * (vector.New(5.63, 41.81)),
        scale * (vector.New(6.51, 43.04)),
        scale * (vector.New(7.67, 43.92)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(7.67, 43.92)),
        scale * (vector.New(8.83, 44.8)),
        scale * (vector.New(10.25, 45.24)),
        scale * (vector.New(11.93, 45.24)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(11.93, 45.24)),
        scale * (vector.New(13.68, 45.24)),
        scale * (vector.New(15.15, 44.78)),
        scale * (vector.New(16.33, 43.85)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(16.33, 43.85)),
        scale * (vector.New(17.50, 42.92)),
        scale * (vector.New(18.39, 41.66)), scale * (vector.New(18.99, 40.08)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(18.99, 40.08)),
        scale * (vector.New(19.59, 38.5)),
        scale * (vector.New(19.89, 36.74)),
        scale * (vector.New(19.89, 34.8)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(19.89, 34.8)),
        scale * (vector.New(19.89, 32.88)),
        scale * (vector.New(19.6, 31.15)), scale * (vector.New(19.01, 29.61)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(19.01, 29.61)),
        scale * (vector.New(18.42, 28.06)),
        scale * (vector.New(17.54, 26.84)), scale * (vector.New(16.36, 25.93)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(16.36, 25.93)),
        scale * (vector.New(15.19, 25.02)),
        scale * (vector.New(13.71, 24.57)), scale * (vector.New(11.93, 24.57)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(11.93, 24.57)),
        scale * (vector.New(10.23, 24.57)),
        scale * (vector.New(8.8, 25)),
        scale * (vector.New(7.63, 25.86)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(7.63, 25.86)),
        scale * (vector.New(6.47, 26.72)),
        scale * (vector.New(5.6, 27.92)),
        scale * (vector.New(5.01, 29.45)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(5.01, 29.45)),
        scale * (vector.New(4.42, 30.98)),
        scale * (vector.New(4.12, 32.77)), scale * (vector.New(4.12, 34.8)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(34.66, 12.07)),
        scale * (vector.New(34.66, 12.07)),
        scale * (vector.New(34.66, 48.44)),
        scale * (vector.New(34.66, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(34.66, 48.44)),
        scale * (vector.New(34.66, 48.44)),
        scale * (vector.New(30.47, 48.44)),
        scale * (vector.New(30.47, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(30.47, 48.44)),
        scale * (vector.New(30.47, 48.44)),
        scale * (vector.New(30.47, 12.07)),
        scale * (vector.New(30.47, 12.07)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(30.47, 12.07)),
        scale * (vector.New(30.47, 12.07)),
        scale * (vector.New(34.66, 12.07)),
        scale * (vector.New(34.66, 12.07)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(59.52, 37.29)),
        scale * (vector.New(59.52, 37.29)),
        scale * (vector.New(59.52, 21.16)),
        scale * (vector.New(59.52, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(59.52, 21.16)),
        scale * (vector.New(59.52, 21.16)),
        scale * (vector.New(63.71, 21.16)),
        scale * (vector.New(63.71, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(63.71, 21.16)),
        scale * (vector.New(63.71, 21.16)),
        scale * (vector.New(63.71, 48.44)),
        scale * (vector.New(63.71, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(63.71, 48.44)),
        scale * (vector.New(63.71, 48.44)),
        scale * (vector.New(59.52, 48.44)),
        scale * (vector.New(59.52, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(59.52, 48.44)),
        scale * (vector.New(59.52, 48.44)),
        scale * (vector.New(59.52, 43.82)),
        scale * (vector.New(59.52, 43.82)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(59.52, 43.82)),
        scale * (vector.New(59.52, 43.82)),
        scale * (vector.New(59.23, 43.82)),
        scale * (vector.New(59.23, 43.82)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(59.23, 43.82)),
        scale * (vector.New(58.59, 45.21)),
        scale * (vector.New(57.6, 46.38)),
        scale * (vector.New(56.25, 47.35)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(56.25, 47.35)),
        scale * (vector.New(54.90, 48.31)),
        scale * (vector.New(53.26, 48.79)),
        scale * (vector.New(51.14, 48.79)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(51.14, 48.79)),
        scale * (vector.New(49.43, 48.79)),
        scale * (vector.New(47.92, 48.42)),
        scale * (vector.New(46.59, 47.67)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(46.59, 47.67)),
        scale * (vector.New(45.26, 46.92)),
        scale * (vector.New(44.22, 45.78)),
        scale * (vector.New(43.47, 44.26)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(43.47, 44.26)),
        scale * (vector.New(42.71, 42.73)),
        scale * (vector.New(42.33, 40.81)), scale * (vector.New(42.33, 38.49)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(42.33, 38.49)),
        scale * (vector.New(42.33, 38.49)),
        scale * (vector.New(42.33, 21.16)),
        scale * (vector.New(42.33, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(42.33, 21.16)),
        scale * (vector.New(42.33, 21.16)),
        scale * (vector.New(46.52, 21.16)),
        scale * (vector.New(46.52, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(46.52, 21.16)),
        scale * (vector.New(46.52, 21.16)),
        scale * (vector.New(46.52, 38.21)),
        scale * (vector.New(46.52, 38.21)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(46.52, 38.21)),
        scale * (vector.New(46.52, 40.2)),
        scale * (vector.New(47.08, 41.78)), scale * (vector.New(48.2, 42.97)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(48.2, 42.97)),
        scale * (vector.New(49.32, 44.15)),
        scale * (vector.New(50.75, 44.74)),
        scale * (vector.New(52.49, 44.74)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(52.49, 44.74)),
        scale * (vector.New(53.53, 44.74)),
        scale * (vector.New(54.59, 44.48)),
        scale * (vector.New(55.67, 43.95)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(55.67, 43.95)),
        scale * (vector.New(56.76, 43.42)),
        scale * (vector.New(57.67, 42.6)),
        scale * (vector.New(58.41, 41.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(58.41, 41.5)),
        scale * (vector.New(59.15, 40.39)),
        scale * (vector.New(59.52, 38.99)), scale * (vector.New(59.52, 37.29)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(71.38, 48.44)),
        scale * (vector.New(71.38, 48.44)),
        scale * (vector.New(71.38, 21.16)),
        scale * (vector.New(71.38, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(71.38, 21.16)),
        scale * (vector.New(71.38, 21.16)),
        scale * (vector.New(75.43, 21.16)),
        scale * (vector.New(75.43, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(75.43, 21.16)),
        scale * (vector.New(75.43, 21.16)),
        scale * (vector.New(75.43, 25.43)),
        scale * (vector.New(75.43, 25.43)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(75.43, 25.43)),
        scale * (vector.New(75.43, 25.43)),
        scale * (vector.New(75.78, 25.43)),
        scale * (vector.New(75.78, 25.43)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(75.78, 25.43)),
        scale * (vector.New(76.35, 23.97)),
        scale * (vector.New(77.26, 22.84)),
        scale * (vector.New(78.53, 22.03)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(78.53, 22.03)),
        scale * (vector.New(79.8, 21.22)),
        scale * (vector.New(81.32, 20.81)), scale * (vector.New(83.1, 20.81)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(83.1, 20.81)),
        scale * (vector.New(84.9, 20.81)),
        scale * (vector.New(86.4, 21.22)),
        scale * (vector.New(87.6, 22.03)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(87.6, 22.03)),
        scale * (vector.New(88.8, 22.84)),
        scale * (vector.New(89.74, 23.97)), scale * (vector.New(90.41, 25.43)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(90.41, 25.43)),
        scale * (vector.New(90.41, 25.43)),
        scale * (vector.New(90.7, 25.43)),
        scale * (vector.New(90.7, 25.43)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(90.7, 25.43)),
        scale * (vector.New(91.39, 24.02)),
        scale * (vector.New(92.44, 22.89)), scale * (vector.New(93.84, 22.06)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(93.84, 22.06)),
        scale * (vector.New(95.23, 21.23)),
        scale * (vector.New(96.91, 20.81)),
        scale * (vector.New(98.86, 20.81)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(98.86, 20.81)),
        scale * (vector.New(101.3, 20.81)),
        scale * (vector.New(103.3, 21.57)),
        scale * (vector.New(104.85, 23.09)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(104.85, 23.09)),
        scale * (vector.New(106.4, 24.61)),
        scale * (vector.New(107.17, 26.97)),
        scale * (vector.New(107.17, 30.18)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(107.17, 30.18)),
        scale * (vector.New(107.17, 30.18)),
        scale * (vector.New(107.17, 48.44)),
        scale * (vector.New(107.17, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(107.17, 48.44)),
        scale * (vector.New(107.17, 48.44)),
        scale * (vector.New(102.98, 48.44)),
        scale * (vector.New(102.98, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(102.98, 48.44)),
        scale * (vector.New(102.98, 48.44)),
        scale * (vector.New(102.98, 30.18)),
        scale * (vector.New(102.98, 30.18)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(102.98, 30.18)),
        scale * (vector.New(102.98, 28.17)),
        scale * (vector.New(102.43, 26.74)), scale * (vector.New(101.33, 25.87)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(101.33, 25.87)),
        scale * (vector.New(100.23, 25.00)),
        scale * (vector.New(98.93, 24.57)), scale * (vector.New(97.44, 24.57)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(97.44, 24.57)),
        scale * (vector.New(95.53, 24.57)),
        scale * (vector.New(94.04, 25.15)), scale * (vector.New(92.99, 26.31)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(92.99, 26.31)),
        scale * (vector.New(91.94, 27.46)),
        scale * (vector.New(91.41, 28.92)), scale * (vector.New(91.41, 30.68)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(91.41, 30.68)),
        scale * (vector.New(91.41, 30.68)),
        scale * (vector.New(91.41, 48.44)),
        scale * (vector.New(91.41, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(91.41, 48.44)),
        scale * (vector.New(91.41, 48.44)),
        scale * (vector.New(87.14, 48.44)),
        scale * (vector.New(87.14, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(87.14, 48.44)),
        scale * (vector.New(87.14, 48.44)),
        scale * (vector.New(87.14, 29.76)),
        scale * (vector.New(87.14, 29.76)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(87.14, 29.76)),
        scale * (vector.New(87.14, 28.21)),
        scale * (vector.New(86.64, 26.95)), scale * (vector.New(85.64, 26)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(85.64, 26)),
        scale * (vector.New(84.63, 25.05)),
        scale * (vector.New(83.34, 24.57)), scale * (vector.New(81.75, 24.57)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(81.75, 24.57)),
        scale * (vector.New(80.66, 24.57)),
        scale * (vector.New(79.64, 24.86)),
        scale * (vector.New(78.7, 25.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(78.7, 25.44)),
        scale * (vector.New(77.76, 26.02)),
        scale * (vector.New(77.00, 26.82)),
        scale * (vector.New(76.43, 27.85)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(76.43, 27.85)),
        scale * (vector.New(75.86, 28.88)),
        scale * (vector.New(75.57, 30.06)), scale * (vector.New(75.57, 31.39)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(75.57, 31.39)),
        scale * (vector.New(75.57, 31.39)),
        scale * (vector.New(75.57, 48.44)),
        scale * (vector.New(75.57, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(75.57, 48.44)),
        scale * (vector.New(75.57, 48.44)),
        scale * (vector.New(71.38, 48.44)),
        scale * (vector.New(71.38, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(125.92, 49.01)),
        scale * (vector.New(123.46, 49.01)),
        scale * (vector.New(121.30, 48.42)),
        scale * (vector.New(119.45, 47.25)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(119.45, 47.25)),
        scale * (vector.New(117.6, 46.08)),
        scale * (vector.New(116.15, 44.44)),
        scale * (vector.New(115.12, 42.33)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(115.12, 42.33)),
        scale * (vector.New(114.09, 40.22)),
        scale * (vector.New(113.57, 37.76)), scale * (vector.New(113.57, 34.94)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(113.57, 34.94)),
        scale * (vector.New(113.57, 32.1)),
        scale * (vector.New(114.09, 29.62)),
        scale * (vector.New(115.12, 27.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(115.12, 27.5)),
        scale * (vector.New(116.15, 25.39)),
        scale * (vector.New(117.6, 23.74)),
        scale * (vector.New(119.45, 22.57)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(119.45, 22.57)),
        scale * (vector.New(121.30, 21.4)),
        scale * (vector.New(123.46, 20.81)), scale * (vector.New(125.92, 20.81)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(125.92, 20.81)),
        scale * (vector.New(128.39, 20.81)),
        scale * (vector.New(130.55, 21.4)),
        scale * (vector.New(132.4, 22.57)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(132.4, 22.57)),
        scale * (vector.New(134.25, 23.74)),
        scale * (vector.New(135.69, 25.39)),
        scale * (vector.New(136.73, 27.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(136.73, 27.5)),
        scale * (vector.New(137.76, 29.62)),
        scale * (vector.New(138.28, 32.1)), scale * (vector.New(138.28, 34.94)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(138.28, 34.94)),
        scale * (vector.New(138.28, 37.76)),
        scale * (vector.New(137.76, 40.22)),
        scale * (vector.New(136.73, 42.33)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(136.73, 42.33)),
        scale * (vector.New(135.69, 44.44)),
        scale * (vector.New(134.25, 46.08)),
        scale * (vector.New(132.4, 47.25)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(132.4, 47.25)),
        scale * (vector.New(130.55, 48.42)),
        scale * (vector.New(128.39, 49.01)),
        scale * (vector.New(125.92, 49.01)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(125.92, 45.24)),
        scale * (vector.New(127.79, 45.24)),
        scale * (vector.New(129.33, 44.76)), scale * (vector.New(130.54, 43.8)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(130.54, 43.8)),
        scale * (vector.New(131.75, 42.85)),
        scale * (vector.New(132.64, 41.59)), scale * (vector.New(133.22, 40.02)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(133.22, 40.02)),
        scale * (vector.New(133.8, 38.46)),
        scale * (vector.New(134.09, 36.77)), scale * (vector.New(134.09, 34.94)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(134.09, 34.94)),
        scale * (vector.New(134.09, 33.12)),
        scale * (vector.New(133.8, 31.42)),
        scale * (vector.New(133.22, 29.85)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(133.22, 29.85)),
        scale * (vector.New(132.64, 28.28)),
        scale * (vector.New(131.75, 27.00)),
        scale * (vector.New(130.54, 26.03)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(130.54, 26.03)),
        scale * (vector.New(129.33, 25.06)),
        scale * (vector.New(127.79, 24.57)), scale * (vector.New(125.92, 24.57)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(125.92, 24.57)),
        scale * (vector.New(124.05, 24.57)),
        scale * (vector.New(122.52, 25.06)),
        scale * (vector.New(121.31, 26.03)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(121.31, 26.03)),
        scale * (vector.New(120.10, 27.00)),
        scale * (vector.New(119.21, 28.28)),
        scale * (vector.New(118.63, 29.85)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(118.63, 29.85)),
        scale * (vector.New(118.05, 31.42)),
        scale * (vector.New(117.76, 33.12)), scale * (vector.New(117.76, 34.94)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(117.76, 34.94)),
        scale * (vector.New(117.76, 36.77)),
        scale * (vector.New(118.05, 38.46)),
        scale * (vector.New(118.63, 40.02)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(118.63, 40.02)),
        scale * (vector.New(119.21, 41.59)),
        scale * (vector.New(120.10, 42.85)),
        scale * (vector.New(121.31, 43.8)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(121.31, 43.8)),
        scale * (vector.New(122.52, 44.76)),
        scale * (vector.New(124.05, 45.24)), scale * (vector.New(125.92, 45.24)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(155.68, 59.23)),
        scale * (vector.New(153.66, 59.23)),
        scale * (vector.New(151.92, 58.97)),
        scale * (vector.New(150.46, 58.46)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(150.46, 58.46)),
        scale * (vector.New(149.01, 57.95)),
        scale * (vector.New(147.8, 57.276)),
        scale * (vector.New(146.83, 56.44)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(146.83, 56.44)),
        scale * (vector.New(145.86, 55.6)),
        scale * (vector.New(145.1, 54.71)),
        scale * (vector.New(144.53, 53.76)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(144.53, 53.76)),
        scale * (vector.New(144.53, 53.76)),
        scale * (vector.New(147.87, 51.42)),
        scale * (vector.New(147.87, 51.42)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(147.87, 51.42)),
        scale * (vector.New(148.25, 51.92)),
        scale * (vector.New(148.73, 52.49)),
        scale * (vector.New(149.31, 53.13)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(149.31, 53.13)),
        scale * (vector.New(149.89, 53.78)),
        scale * (vector.New(150.69, 54.34)),
        scale * (vector.New(151.7, 54.82)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(151.7, 54.82)),
        scale * (vector.New(152.71, 55.3)),
        scale * (vector.New(154.03, 55.54)),
        scale * (vector.New(155.68, 55.54)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(155.68, 55.54)),
        scale * (vector.New(157.88, 55.54)),
        scale * (vector.New(159.7, 55.01)),
        scale * (vector.New(161.13, 53.94)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(161.13, 53.94)),
        scale * (vector.New(162.56, 52.87)),
        scale * (vector.New(163.28, 51.20)),
        scale * (vector.New(163.28, 48.93)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(163.28, 48.93)),
        scale * (vector.New(163.28, 48.93)),
        scale * (vector.New(163.28, 43.39)),
        scale * (vector.New(163.28, 43.39)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(163.28, 43.39)),
        scale * (vector.New(163.28, 43.39)),
        scale * (vector.New(162.93, 43.39)),
        scale * (vector.New(162.93, 43.39)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(162.93, 43.39)),
        scale * (vector.New(162.62, 43.89)),
        scale * (vector.New(162.18, 44.50)), scale * (vector.New(161.62, 45.23)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(161.62, 45.23)),
        scale * (vector.New(161.06, 45.96)),
        scale * (vector.New(160.26, 46.60)),
        scale * (vector.New(159.21, 47.17)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(159.21, 47.17)),
        scale * (vector.New(158.16, 47.73)),
        scale * (vector.New(156.74, 48.01)),
        scale * (vector.New(154.97, 48.01)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(154.97, 48.01)),
        scale * (vector.New(152.77, 48.01)),
        scale * (vector.New(150.8, 47.49)),
        scale * (vector.New(149.05, 46.45)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(149.05, 46.45)),
        scale * (vector.New(147.30, 45.41)),
        scale * (vector.New(145.92, 43.89)),
        scale * (vector.New(144.91, 41.9)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(144.91, 41.9)),
        scale * (vector.New(143.9, 39.91)),
        scale * (vector.New(143.39, 37.5)), scale * (vector.New(143.39, 34.66)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(143.39, 34.66)),
        scale * (vector.New(143.39, 31.87)),
        scale * (vector.New(143.88, 29.43)), scale * (vector.New(144.87, 27.35)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(144.87, 27.35)),
        scale * (vector.New(145.85, 25.28)),
        scale * (vector.New(147.22, 23.67)),
        scale * (vector.New(148.97, 22.52)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(148.97, 22.52)),
        scale * (vector.New(150.72, 21.38)),
        scale * (vector.New(152.75, 20.81)),
        scale * (vector.New(155.04, 20.81)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(155.04, 20.81)),
        scale * (vector.New(156.82, 20.81)),
        scale * (vector.New(158.23, 21.10)),
        scale * (vector.New(159.28, 21.69)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(159.28, 21.69)),
        scale * (vector.New(160.33, 22.28)),
        scale * (vector.New(161.13, 22.94)), scale * (vector.New(161.69, 23.68)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(161.69, 23.68)),
        scale * (vector.New(162.26, 24.42)),
        scale * (vector.New(162.69, 25.03)),
        scale * (vector.New(163, 25.5)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(163, 25.5)),
        scale * (vector.New(163, 25.5)),
        scale * (vector.New(163.42, 25.5)), scale * (vector.New(163.42, 25.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(163.42, 25.5)),
        scale * (vector.New(163.42, 25.5)),
        scale * (vector.New(163.42, 21.16)),
        scale * (vector.New(163.42, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(163.42, 21.16)),
        scale * (vector.New(163.42, 21.16)),
        scale * (vector.New(167.47, 21.16)),
        scale * (vector.New(167.47, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(167.47, 21.16)),
        scale * (vector.New(167.47, 21.16)),
        scale * (vector.New(167.47, 49.22)),
        scale * (vector.New(167.47, 49.22)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(167.47, 49.22)),
        scale * (vector.New(167.47, 51.56)),
        scale * (vector.New(166.94, 53.47)), scale * (vector.New(165.88, 54.94)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(165.88, 54.94)),
        scale * (vector.New(164.82, 56.42)),
        scale * (vector.New(163.4, 57.50)),
        scale * (vector.New(161.62, 58.19)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(161.62, 58.19)),
        scale * (vector.New(159.84, 58.886)),
        scale * (vector.New(157.86, 59.23)),
        scale * (vector.New(155.68, 59.23)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(155.54, 44.25)),
        scale * (vector.New(157.22, 44.25)),
        scale * (vector.New(158.64, 43.86)),
        scale * (vector.New(159.8, 43.09)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(159.8, 43.09)),
        scale * (vector.New(160.96, 42.32)),
        scale * (vector.New(161.84, 41.22)),
        scale * (vector.New(162.45, 39.77)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(162.45, 39.77)),
        scale * (vector.New(163.05, 38.33)),
        scale * (vector.New(163.35, 36.60)), scale * (vector.New(163.35, 34.59)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(163.35, 34.59)),
        scale * (vector.New(163.35, 32.62)),
        scale * (vector.New(163.05, 30.89)), scale * (vector.New(162.46, 29.39)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(162.46, 29.39)),
        scale * (vector.New(161.87, 27.88)),
        scale * (vector.New(161, 26.70)), scale * (vector.New(159.84, 25.85)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(159.84, 25.85)),
        scale * (vector.New(158.68, 25)),
        scale * (vector.New(157.25, 24.57)), scale * (vector.New(155.54, 24.57)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(155.54, 24.57)),
        scale * (vector.New(153.77, 24.57)),
        scale * (vector.New(152.29, 25.02)),
        scale * (vector.New(151.11, 25.92)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(151.11, 25.92)),
        scale * (vector.New(149.93, 26.82)),
        scale * (vector.New(149.05, 28.03)),
        scale * (vector.New(148.46, 29.55)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(148.46, 29.55)),
        scale * (vector.New(147.88, 31.06)),
        scale * (vector.New(147.59, 32.74)), scale * (vector.New(147.59, 34.59)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(147.59, 34.59)),
        scale * (vector.New(147.59, 36.48)),
        scale * (vector.New(147.89, 38.15)),
        scale * (vector.New(148.48, 39.6)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(148.48, 39.6)),
        scale * (vector.New(149.08, 41.05)),
        scale * (vector.New(149.97, 42.19)), scale * (vector.New(151.15, 43.01)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(151.15, 43.01)),
        scale * (vector.New(152.32, 43.84)),
        scale * (vector.New(153.79, 44.25)), scale * (vector.New(155.54, 44.25)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(192.33, 37.29)),
        scale * (vector.New(192.33, 37.29)),
        scale * (vector.New(192.33, 21.16)),
        scale * (vector.New(192.33, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(192.33, 21.16)),
        scale * (vector.New(192.33, 21.16)),
        scale * (vector.New(196.52, 21.16)),
        scale * (vector.New(196.52, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(196.52, 21.16)),
        scale * (vector.New(196.52, 21.16)),
        scale * (vector.New(196.52, 48.44)),
        scale * (vector.New(196.52, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(196.52, 48.44)),
        scale * (vector.New(196.52, 48.44)),
        scale * (vector.New(192.33, 48.44)),
        scale * (vector.New(192.33, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(192.33, 48.44)),
        scale * (vector.New(192.33, 48.44)),
        scale * (vector.New(192.33, 43.82)),
        scale * (vector.New(192.33, 43.82)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(192.33, 43.82)),
        scale * (vector.New(192.33, 43.82)),
        scale * (vector.New(192.05, 43.82)),
        scale * (vector.New(192.05, 43.82)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(192.05, 43.82)),
        scale * (vector.New(191.41, 45.21)),
        scale * (vector.New(190.41, 46.38)),
        scale * (vector.New(189.06, 47.35)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(189.06, 47.35)),
        scale * (vector.New(187.71, 48.31)),
        scale * (vector.New(186.01, 48.79)), scale * (vector.New(183.95, 48.79)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(183.95, 48.79)),
        scale * (vector.New(182.24, 48.79)),
        scale * (vector.New(180.73, 48.42)),
        scale * (vector.New(179.4, 47.67)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(179.4, 47.67)),
        scale * (vector.New(178.07, 46.92)),
        scale * (vector.New(177.03, 45.78)),
        scale * (vector.New(176.28, 44.26)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(176.28, 44.26)),
        scale * (vector.New(175.52, 42.73)),
        scale * (vector.New(175.14, 40.81)), scale * (vector.New(175.14, 38.49)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(175.14, 38.49)),
        scale * (vector.New(175.14, 38.49)),
        scale * (vector.New(175.14, 21.16)),
        scale * (vector.New(175.14, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(175.14, 21.16)),
        scale * (vector.New(175.14, 21.16)),
        scale * (vector.New(179.33, 21.16)),
        scale * (vector.New(179.33, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(179.33, 21.16)),
        scale * (vector.New(179.33, 21.16)),
        scale * (vector.New(179.33, 38.21)),
        scale * (vector.New(179.33, 38.21)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(179.33, 38.21)),
        scale * (vector.New(179.33, 40.2)),
        scale * (vector.New(179.89, 41.78)), scale * (vector.New(181.01, 42.97)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(181.01, 42.97)),
        scale * (vector.New(182.13, 44.15)),
        scale * (vector.New(183.56, 44.74)),
        scale * (vector.New(185.3, 44.74)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(185.3, 44.74)),
        scale * (vector.New(186.34, 44.74)),
        scale * (vector.New(187.40, 44.48)),
        scale * (vector.New(188.49, 43.95)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(188.49, 43.95)),
        scale * (vector.New(189.57, 43.42)),
        scale * (vector.New(190.48, 42.6)),
        scale * (vector.New(191.22, 41.5)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(191.22, 41.5)),
        scale * (vector.New(191.96, 40.39)),
        scale * (vector.New(192.33, 38.99)), scale * (vector.New(192.33, 37.29)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(224.64, 21.16)),
        scale * (vector.New(224.43, 19.37)),
        scale * (vector.New(223.57, 17.97)), scale * (vector.New(222.05, 16.97)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(222.05, 16.97)),
        scale * (vector.New(220.54, 15.98)),
        scale * (vector.New(218.68, 15.48)), scale * (vector.New(216.48, 15.48)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(216.48, 15.48)),
        scale * (vector.New(214.87, 15.48)),
        scale * (vector.New(213.46, 15.74)), scale * (vector.New(212.26, 16.26)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(212.26, 16.26)),
        scale * (vector.New(211.06, 16.79)),
        scale * (vector.New(210.12, 17.50)),
        scale * (vector.New(209.45, 18.41)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(209.45, 18.41)),
        scale * (vector.New(208.78, 19.32)),
        scale * (vector.New(208.45, 20.36)), scale * (vector.New(208.45, 21.52)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(208.45, 21.52)),
        scale * (vector.New(208.45, 22.49)),
        scale * (vector.New(208.68, 23.32)),
        scale * (vector.New(209.15, 24.01)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(209.15, 24.01)),
        scale * (vector.New(209.62, 24.70)),
        scale * (vector.New(210.22, 25.28)),
        scale * (vector.New(210.96, 25.74)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(210.96, 25.74)),
        scale * (vector.New(211.69, 26.19)),
        scale * (vector.New(212.46, 26.57)),
        scale * (vector.New(213.26, 26.86)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(213.26, 26.86)),
        scale * (vector.New(214.07, 27.15)),
        scale * (vector.New(214.81, 27.38)),
        scale * (vector.New(215.48, 27.56)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(215.48, 27.56)),
        scale * (vector.New(215.48, 27.56)),
        scale * (vector.New(219.18, 28.55)),
        scale * (vector.New(219.18, 28.55)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(219.18, 28.55)),
        scale * (vector.New(220.13, 28.8)),
        scale * (vector.New(221.18, 29.14)), scale * (vector.New(222.35, 29.58)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(222.35, 29.58)),
        scale * (vector.New(223.51, 30.02)),
        scale * (vector.New(224.63, 30.62)),
        scale * (vector.New(225.7, 31.37)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(225.7, 31.37)),
        scale * (vector.New(226.77, 32.12)),
        scale * (vector.New(227.66, 33.08)), scale * (vector.New(228.36, 34.25)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(228.36, 34.25)),
        scale * (vector.New(229.05, 35.42)),
        scale * (vector.New(229.4, 36.86)), scale * (vector.New(229.4, 38.57)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(229.4, 38.57)),
        scale * (vector.New(229.4, 40.53)),
        scale * (vector.New(228.89, 42.30)),
        scale * (vector.New(227.87, 43.89)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(227.87, 43.89)),
        scale * (vector.New(226.84, 45.48)),
        scale * (vector.New(225.35, 46.74)),
        scale * (vector.New(223.39, 47.67)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(223.39, 47.67)),
        scale * (vector.New(221.43, 48.61)),
        scale * (vector.New(219.058, 49.08)), scale * (vector.New(216.26, 49.08)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(216.26, 49.08)),
        scale * (vector.New(213.66, 49.08)),
        scale * (vector.New(211.41, 48.66)), scale * (vector.New(209.51, 47.82)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(209.51, 47.82)),
        scale * (vector.New(207.61, 46.98)),
        scale * (vector.New(206.12, 45.81)),
        scale * (vector.New(205.03, 44.3)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(205.03, 44.3)),
        scale * (vector.New(203.95, 42.8)),
        scale * (vector.New(203.34, 41.05)),
        scale * (vector.New(203.2, 39.06)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(203.2, 39.06)),
        scale * (vector.New(203.2, 39.06)),
        scale * (vector.New(207.74, 39.06)),
        scale * (vector.New(207.74, 39.06)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(207.74, 39.06)),
        scale * (vector.New(207.86, 40.43)),
        scale * (vector.New(208.33, 41.57)),
        scale * (vector.New(209.14, 42.46)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(209.14, 42.46)),
        scale * (vector.New(209.95, 43.355)),
        scale * (vector.New(210.97, 44.02)),
        scale * (vector.New(212.22, 44.45)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(212.22, 44.45)),
        scale * (vector.New(213.47, 44.88)),
        scale * (vector.New(214.82, 45.1)), scale * (vector.New(216.26, 45.1)), textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(216.26, 45.1)),
        scale * (vector.New(217.95, 45.1)),
        scale * (vector.New(219.46, 44.82)),
        scale * (vector.New(220.79, 44.27)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(220.79, 44.27)),
        scale * (vector.New(222.13, 43.72)),
        scale * (vector.New(223.19, 42.96)), scale * (vector.New(223.97, 41.97)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(223.97, 41.97)),
        scale * (vector.New(224.75, 40.98)),
        scale * (vector.New(225.14, 39.82)),
        scale * (vector.New(225.14, 38.49)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(225.14, 38.49)),
        scale * (vector.New(225.14, 37.28)),
        scale * (vector.New(224.808, 36.30)),
        scale * (vector.New(224.13, 35.55)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(224.13, 35.55)),
        scale * (vector.New(223.46, 34.79)),
        scale * (vector.New(222.57, 34.17)), scale * (vector.New(221.47, 33.7)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(221.47, 33.7)),
        scale * (vector.New(220.37, 33.23)),
        scale * (vector.New(219.18, 32.81)),
        scale * (vector.New(217.9, 32.46)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(217.9, 32.46)),
        scale * (vector.New(217.9, 32.46)),
        scale * (vector.New(213.42, 31.18)),
        scale * (vector.New(213.42, 31.18)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(213.42, 31.18)),
        scale * (vector.New(210.58, 30.36)),
        scale * (vector.New(208.33, 29.19)),
        scale * (vector.New(206.68, 27.68)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(206.68, 27.68)),
        scale * (vector.New(205.02, 26.17)),
        scale * (vector.New(204.19, 24.18)), scale * (vector.New(204.19, 21.73)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(204.19, 21.73)),
        scale * (vector.New(204.19, 19.7)),
        scale * (vector.New(204.74, 17.92)),
        scale * (vector.New(205.85, 16.4)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(205.85, 16.4)),
        scale * (vector.New(206.96, 14.88)),
        scale * (vector.New(208.45, 13.7)),
        scale * (vector.New(210.32, 12.85)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(210.32, 12.85)),
        scale * (vector.New(212.2, 12.00)),
        scale * (vector.New(214.3, 11.58)), scale * (vector.New(216.62, 11.58)),
        textCol,
        thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(216.62, 11.58)),
        scale * (vector.New(218.96, 11.58)),
        scale * (vector.New(221.04, 12)),
        scale * (vector.New(222.87, 12.83)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(222.87, 12.83)),
        scale * (vector.New(224.69, 13.66)),
        scale * (vector.New(226.14, 14.80)),
        scale * (vector.New(227.21, 16.25)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(227.21, 16.25)),
        scale * (vector.New(228.28, 17.69)),
        scale * (vector.New(228.85, 19.33)),
        scale * (vector.New(228.91, 21.16)),
        textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(228.91, 21.16)),
        scale * (vector.New(228.91, 21.16)),
        scale * (vector.New(224.64, 21.16)),
        scale * (vector.New(224.64, 21.16)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(238.14, 12.07)),
        scale * (vector.New(238.14, 12.07)),
        scale * (vector.New(248.93, 42.68)),
        scale * (vector.New(248.93, 42.68)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(248.93, 42.68)),
        scale * (vector.New(248.93, 42.68)),
        scale * (vector.New(249.36, 42.68)),
        scale * (vector.New(249.36, 42.68)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(249.36, 42.68)),
        scale * (vector.New(249.36, 42.68)),
        scale * (vector.New(260.16, 12.07)),
        scale * (vector.New(260.16, 12.07)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(260.16, 12.07)),
        scale * (vector.New(260.16, 12.07)),
        scale * (vector.New(264.77, 12.07)),
        scale * (vector.New(264.77, 12.07)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(264.77, 12.07)),
        scale * (vector.New(264.77, 12.07)),
        scale * (vector.New(251.42, 48.44)),
        scale * (vector.New(251.42, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(251.42, 48.44)),
        scale * (vector.New(251.42, 48.44)),
        scale * (vector.New(246.88, 48.44)),
        scale * (vector.New(246.88, 48.44)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(246.88, 48.44)),
        scale * (vector.New(246.88, 48.44)),
        scale * (vector.New(233.52, 12.07)),
        scale * (vector.New(233.52, 12.07)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
    partialBezierCubic(ctx, t0, t1, location, scale * (vector.New(233.52, 12.07)),
        scale * (vector.New(233.52, 12.07)),
        scale * (vector.New(238.14, 12.07)),
        scale * (vector.New(238.14, 12.07)), textCol, thickness, pulseCol, scale * 264.77, timeProgress)
end
---Simplified version of de Casteljau's algorithm from [Stack Overflow](https://stackoverflow.com/questions/878862/drawing-part-of-a-bézier-curve-by-reusing-a-basic-bézier-curve-function).
---@param ctx ImDrawListPtr
---@param t0 number
---@param t1 number
---@param location Vector2
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@param p4 Vector2
---@param col Vector4
---@param thickness number
---@param pulseCol [Vector4, Vector4]
---@param timeProgress number
function partialBezierCubic(ctx, t0, t1, location, p1, p2, p3, p4, col, thickness, pulseCol, maxValue, timeProgress)
    local u0 = 1.0 - t0
    local u1 = 1.0 - t1
    local avgX = (p1.x + p4.x) / 2
    local xProgress = avgX / maxValue
    local xCol = (1 - xProgress) * pulseCol[1] + pulseCol[2] * xProgress
    local pulseStrength = 2 ^ (-50 * (timeProgress - 1 / 3 - xProgress / 3) ^ 2)
    local bezierCol = xCol * pulseStrength + col * (1 - pulseStrength)
    local qa = p1 * u0 * u0 + p2 * 2 * t0 * u0 + p3 * t0 * t0
    local qb = p1 * u1 * u1 + p2 * 2 * t1 * u1 + p3 * t1 * t1
    local qc = p2 * u0 * u0 + p2 * 2 * t0 * u0 + p4 * t0 * t0
    local qd = p2 * u1 * u1 + p2 * 2 * t1 * u1 + p4 * t1 * t1
    local np1 = qa * u0 + qc * t0
    local np2 = qa * u1 + qc * t1
    local np3 = qb * u0 + qd * t0
    local np4 = qb * u1 + qd * t1
    ctx.AddBezierCubic(location + np1, location + np2, location + np3, location + np4, color.vrgbaToUint(bezierCol),
        thickness)
end
function drawCursorTrail()
    local cursorTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if cursorTrail == "None" then return end
    local o = imgui.GetForegroundDrawList()
    local m = imgui.GetMousePos()
    local t = clock.getTime()
    local sz = state.WindowSize
    if cursorTrail ~= "Snake" then state.SetValue("boolean.snakeTrailInitialized", false) end
    if cursorTrail ~= "Dust" then state.SetValue("boolean.dustParticlesInitialized", false) end
    if cursorTrail ~= "Sparkle" then state.SetValue("boolean.sparkleParticlesInitialized", false) end
    if cursorTrail == "Snake" then drawSnakeTrail(o, m, t) end
    if cursorTrail == "Dust" then drawDustTrail(o, m, t, sz) end
    if cursorTrail == "Sparkle" then drawSparkleTrail(o, m, t, sz) end
end
function drawSnakeTrail(o, m, t)
    local trailPoints = globalVars.cursorTrailPoints
    local snakeTrailPoints = {}
    initializeSnakeTrailPoints(snakeTrailPoints, m, MAX_CURSOR_TRAIL_POINTS)
    cache.loadTable("snakeTrailPoints", snakeTrailPoints)
    local needTrailUpdate = clock.listen("snakeTrail", 1000 / globalVars.effectFPS)
    updateSnakeTrailPoints(snakeTrailPoints, needTrailUpdate, m, trailPoints,
        globalVars.snakeSpringConstant)
    cache.saveTable("snakeTrailPoints", snakeTrailPoints)
    local trailShape = TRAIL_SHAPES[globalVars.cursorTrailShapeIndex]
    renderSnakeTrailPoints(o, m, snakeTrailPoints, trailPoints, globalVars.cursorTrailSize,
        globalVars.cursorTrailGhost, trailShape)
end
function initializeSnakeTrailPoints(snakeTrailPoints, m, trailPoints)
    if (state.GetValue("boolean.snakeTrailInitialized")) then
        for i = 1, trailPoints do
            snakeTrailPoints[i] = {}
        end
        return
    end
    for i = 1, trailPoints do
        snakeTrailPoints[i] = m
    end
    state.SetValue("boolean.snakeTrailInitialized", true)
    cache.saveTable("snakeTrailPoints", snakeTrailPoints)
end
function updateSnakeTrailPoints(snakeTrailPoints, needTrailUpdate, m, trailPoints,
                                snakeSpringConstant)
    if not needTrailUpdate then return end
    for i = trailPoints, 1, -1 do
        local currentTrailPoint = snakeTrailPoints[i]
        if i == 1 then
            snakeTrailPoints[i] = m
        else
            local lastTrailPoint = snakeTrailPoints[i - 1]
            local change = lastTrailPoint - currentTrailPoint
            snakeTrailPoints[i] = currentTrailPoint + snakeSpringConstant * change
        end
    end
end
function renderSnakeTrailPoints(o, m, snakeTrailPoints, trailPoints, cursorTrailSize,
                                cursorTrailGhost, trailShape)
    for i = 1, trailPoints do
        local point = snakeTrailPoints[i]
        local alpha = 255
        if not cursorTrailGhost then
            alpha = math.floor(255 * (trailPoints - i) / (trailPoints - 1))
        end
        local color = color.int.whiteMask * 255 + math.floor(alpha) * color.int.alphaMask
        if trailShape == "Circles" then
            o.AddCircleFilled(point, cursorTrailSize, color)
        elseif trailShape == "Triangles" then
            drawTriangleTrailPoint(o, m, point, cursorTrailSize, color)
        end
    end
end
function drawTriangleTrailPoint(o, m, point, cursorTrailSize, color)
    local dx = m.x - point.x
    local dy = m.y - point.y
    if dx == 0 and dy == 0 then return end
    local angle = math.pi * 0.5
    if dx ~= 0 then angle = math.atan(dy / dx) end
    if dx < 0 then angle = angle + math.pi end
    if dx == 0 and dy < 0 then angle = angle + math.pi end
    drawEquilateralTriangle(o, point, cursorTrailSize, angle, color)
end
function drawDustTrail(o, m, t, sz)
    local dustSize = math.floor(sz[2] / 120)
    local dustDuration = 0.4
    local numDustParticles = 20
    local dustParticles = {}
    initializeDustParticles(sz, t, dustParticles, numDustParticles, dustDuration)
    cache.loadTable("dustParticles", dustParticles)
    updateDustParticles(t, m, dustParticles, dustDuration, dustSize)
    cache.saveTable("dustParticles", dustParticles)
    renderDustParticles(globalVars.rgbPeriod, o, t, dustParticles, dustDuration, dustSize)
end
function initializeDustParticles(_, t, dustParticles, numDustParticles, dustDuration)
    if state.GetValue("boolean.dustParticlesInitialized") then
        for i = 1, numDustParticles do
            dustParticles[i] = {}
        end
        return
    end
    for i = 1, numDustParticles do
        local endTime = t + (i / numDustParticles) * dustDuration
        local showParticle = false
        dustParticles[i] = generateParticle(0, 0, 0, 0, endTime, showParticle)
    end
    state.SetValue("boolean.dustParticlesInitialized", true)
    cache.saveTable("dustParticles", dustParticles)
end
function updateDustParticles(t, m, dustParticles, dustDuration, dustSize)
    local yRange = 8 * dustSize * (math.random() - 0.5)
    local xRange = 8 * dustSize * (math.random() - 0.5)
    for i = 1, #dustParticles do
        local dustParticle = dustParticles[i]
        local timeLeft = dustParticle.endTime - t
        if timeLeft < 0 then
            local endTime = t + dustDuration
            local showParticle = checkIfMouseMoved(imgui.GetMousePos())
            dustParticles[i] = generateParticle(m.x, m.y, xRange, yRange, endTime, showParticle)
        end
    end
end
function renderDustParticles(rgbPeriod, o, t, dustParticles, dustDuration, dustSize)
    local currentRGBColors = getCurrentRGBColors(rgbPeriod)
    for i = 1, #dustParticles do
        local dustParticle = dustParticles[i]
        if dustParticle.showParticle then
            local time = 1 - ((dustParticle.endTime - t) / dustDuration)
            local dustX = dustParticle.x + dustParticle.xRange * time
            local dy = dustParticle.yRange * math.quadraticBezier(0, time)
            local dustY = dustParticle.y + dy
            local dustCoords = vector.New(dustX, dustY)
            local alpha = math.round(255 * (1 - time), 0)
            local dustColor = color.rgbaToUint(currentRGBColors.red, currentRGBColors.green, currentRGBColors.blue, alpha)
            o.AddCircleFilled(dustCoords, dustSize, dustColor)
        end
    end
end
function drawSparkleTrail(o, m, t, sz)
    local sparkleSize = 10
    local sparkleDuration = 0.3
    local numSparkleParticles = 10
    local sparkleParticles = {}
    initializeSparkleParticles(sz, t, sparkleParticles, numSparkleParticles, sparkleDuration)
    cache.loadTable("sparkleParticles", sparkleParticles)
    updateSparkleParticles(t, m, sparkleParticles, sparkleDuration, sparkleSize)
    cache.saveTable("sparkleParticles", sparkleParticles)
    renderSparkleParticles(o, t, sparkleParticles, sparkleDuration, sparkleSize)
end
function initializeSparkleParticles(_, t, sparkleParticles, numSparkleParticles, sparkleDuration)
    if state.GetValue("boolean.sparkleParticlesInitialized") then
        for i = 1, numSparkleParticles do
            sparkleParticles[i] = {}
        end
        return
    end
    for i = 1, numSparkleParticles do
        local endTime = t + (i / numSparkleParticles) * sparkleDuration
        local showParticle = false
        sparkleParticles[i] = generateParticle(0, 0, 0, 0, endTime, showParticle)
    end
    state.SetValue("boolean.sparkleParticlesInitialized", true)
    cache.saveTable("sparkleParticles", sparkleParticles)
end
function updateSparkleParticles(t, m, sparkleParticles, sparkleDuration, sparkleSize)
    for i = 1, #sparkleParticles do
        local sparkleParticle = sparkleParticles[i]
        local timeLeft = sparkleParticle.endTime - t
        if timeLeft < 0 then
            local endTime = t + sparkleDuration
            local showParticle = checkIfMouseMoved(imgui.GetMousePos())
            local randomX = m.x + sparkleSize * 3 * (math.random() - 0.5)
            local randomY = m.y + sparkleSize * 3 * (math.random() - 0.5)
            local yRange = 6 * sparkleSize
            sparkleParticles[i] = generateParticle(randomX, randomY, 0, yRange, endTime,
                showParticle)
        end
    end
end
function renderSparkleParticles(o, t, sparkleParticles, sparkleDuration, sparkleSize)
    for i = 1, #sparkleParticles do
        local sparkleParticle = sparkleParticles[i]
        if sparkleParticle.showParticle then
            local time = 1 - ((sparkleParticle.endTime - t) / sparkleDuration)
            local sparkleX = sparkleParticle.x + sparkleParticle.xRange * time
            local dy = -sparkleParticle.yRange * math.quadraticBezier(0, time)
            local sparkleY = sparkleParticle.y + dy
            local sparkleCoords = vector.New(sparkleX, sparkleY)
            local actualSize = sparkleSize * (1 - math.quadraticBezier(0, time))
            local sparkleColor = color.rgbaToUint(255, 255, 100, 30)
            drawGlare(o, sparkleCoords, actualSize, color.int.white, sparkleColor)
        end
    end
end
function generateParticle(x, y, xRange, yRange, endTime, showParticle)
    local particle = {
        x = x,
        y = y,
        xRange = xRange,
        yRange = yRange,
        endTime = endTime,
        showParticle = showParticle
    }
    return particle
end
function checkIfMouseMoved(currentMousePosition)
    oldMousePosition = state.GetValue("oldMousePosition", vctr2(0))
    local mousePositionChanged = currentMousePosition ~= oldMousePosition
    state.SetValue("oldMousePosition", currentMousePosition)
    return mousePositionChanged
end
function drawEquilateralTriangle(o, centerPoint, size, angle, color)
    local angle2 = 2 * math.pi / 3 + angle
    local angle3 = 4 * math.pi / 3 + angle
    local x1 = centerPoint.x + size * math.cos(angle)
    local y1 = centerPoint.y + size * math.sin(angle)
    local x2 = centerPoint.x + size * math.cos(angle2)
    local y2 = centerPoint.y + size * math.sin(angle2)
    local x3 = centerPoint.x + size * math.cos(angle3)
    local y3 = centerPoint.y + size * math.sin(angle3)
    local p1 = vector.New(x1, y1)
    local p2 = vector.New(x2, y2)
    local p3 = vector.New(x3, y3)
    o.AddTriangleFilled(p1, p2, p3, color)
end
function drawGlare(o, coords, size, glareColor, auraColor)
    local outerRadius = size
    local innerRadius = outerRadius / 7
    local innerPoints = {}
    local outerPoints = {}
    for i = 1, 4 do
        local angle = math.pi * ((2 * i + 1) / 4)
        local innerX = innerRadius * math.cos(angle)
        local innerY = innerRadius * math.sin(angle)
        local outerX = outerRadius * innerX
        local outerY = outerRadius * innerY
        innerPoints[i] = { innerX + coords.x, innerY + coords.y }
        outerPoints[i] = { outerX + coords.x, outerY + coords.y }
    end
    o.AddQuadFilled(innerPoints[1], outerPoints[2], innerPoints[3], outerPoints[4], glareColor)
    o.AddQuadFilled(outerPoints[1], innerPoints[2], outerPoints[3], innerPoints[4], glareColor)
    local circlePoints = 20
    local circleSize1 = size / 1.2
    local circleSize2 = size / 3
    o.AddCircleFilled(coords, circleSize1, auraColor, circlePoints)
    o.AddCircleFilled(coords, circleSize2, auraColor, circlePoints)
end
function pulseController()
    local pulseVars = {
        previousBar = 0,
        pulseStatus = 0,
        pulsedThisFrame = false
    }
    cache.loadTable("pulseController", pulseVars)
    local timeOffset = 50
    local timeSinceLastBar = ((state.SongTime + timeOffset) - game.getTimingPointAt(state.SongTime).StartTime) %
        ((60000 / game.getTimingPointAt(state.SongTime).Bpm))
    pulseVars.pulsedThisFrame = false
    if ((timeSinceLastBar < pulseVars.previousBar)) then
        pulseVars.pulseStatus = 1
        pulseVars.pulsedThisFrame = true
    else
        pulseVars.pulseStatus = (pulseVars.pulseStatus - state.DeltaTime / (60000 / game.getTimingPointAt(state.SongTime).Bpm) * 1.2)
    end
    pulseVars.previousBar = timeSinceLastBar
    local futureTime = state.SongTime + state.DeltaTime * 2 + timeOffset
    if ((futureTime - game.getTimingPointAt(futureTime).StartTime) < 0) then
        pulseVars.pulseStatus = 0
    end
    outputPulseStatus = math.max(pulseVars.pulseStatus, 0) * (globalVars.pulseCoefficient or 0)
    local borderColor = state.GetValue("borderColor") or vctr4(1)
    local negatedBorderColor = vctr4(1) - borderColor
    local pulseColor = globalVars.useCustomPulseColor and globalVars.pulseColor or negatedBorderColor
    imgui.PushStyleColor(imgui_col.Border, pulseColor * outputPulseStatus + borderColor * (1 - outputPulseStatus))
    cache.saveTable("pulseController", pulseVars)
    state.SetValue("pulseValue", math.max(pulseVars.pulseStatus, 0))
    state.SetValue("pulsedThisFrame", pulseVars.pulsedThisFrame)
end
---@class PhysicsObject
---@field pos Vector2
---@field v Vector2
---@field a Vector2
---@class Particle: PhysicsObject
---@field col Vector4
---@field size integer
function renderBackground()
    local idx = globalVars.dynamicBackgroundIndex
    if (DYNAMIC_BACKGROUND_TYPES[idx] == "Reactive Stars") then
        renderReactiveStars()
    end
    if (DYNAMIC_BACKGROUND_TYPES[idx] == "Reactive Singularity") then
        renderReactiveSingularities()
    end
end
function setPluginAppearance()
    local colorTheme = COLOR_THEMES[globalVars.colorThemeIndex]
    local styleTheme = STYLE_THEMES[globalVars.styleThemeIndex]
    setPluginAppearanceStyles(styleTheme)
    setPluginAppearanceColors(colorTheme)
end
function setPluginAppearanceStyles(styleTheme)
    local cornerRoundnessValue = (styleTheme == "Boxed" or
        styleTheme == "Boxed + Border") and 0 or 5
    local borderSize = tn(styleTheme == "Rounded + Border" or
        styleTheme == "Boxed + Border")
    imgui.PushStyleVar(imgui_style_var.FrameBorderSize, borderSize)
    imgui.PushStyleVar(imgui_style_var.WindowPadding, vector.New(PADDING_WIDTH, 8))
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushStyleVar(imgui_style_var.ItemSpacing, vector.New(DEFAULT_WIDGET_HEIGHT * 0.5 - 1, 4))
    imgui.PushStyleVar(imgui_style_var.ItemInnerSpacing, vector.New(SAMELINE_SPACING, 6))
    imgui.PushStyleVar(imgui_style_var.WindowRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.ChildRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.FrameRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.GrabRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.ScrollbarRounding, cornerRoundnessValue)
    imgui.PushStyleVar(imgui_style_var.TabRounding, cornerRoundnessValue)
end
function setPluginAppearanceColors(colorTheme, hideBorder)
    local borderColor = vctr4(1)
    if colorTheme == "Classic" or not colorTheme then borderColor = setClassicColors() end
    if colorTheme == "Strawberry" then borderColor = setStrawberryColors() end
    if colorTheme == "Amethyst" then borderColor = setAmethystColors() end
    if colorTheme == "Tree" then borderColor = setTreeColors() end
    if colorTheme == "Barbie" then borderColor = setBarbieColors() end
    if colorTheme == "Incognito" then borderColor = setIncognitoColors() end
    if colorTheme == "Incognito + RGB" then borderColor = setIncognitoRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "Tobi's Glass" then borderColor = setTobiGlassColors() end
    if colorTheme == "Tobi's RGB Glass" then borderColor = setTobiRGBGlassColors(globalVars.rgbPeriod) end
    if colorTheme == "Glass" then borderColor = setGlassColors() end
    if colorTheme == "Glass + RGB" then borderColor = setGlassRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "RGB Gamer Mode" then borderColor = setRGBGamerColors(globalVars.rgbPeriod) end
    if colorTheme == "edom remag BGR" then borderColor = setInvertedRGBGamerColors(globalVars.rgbPeriod) end
    if colorTheme == "otingocnI" then borderColor = setInvertedIncognitoColors() end
    if colorTheme == "BGR + otingocnI" then borderColor = setInvertedIncognitoRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "CUSTOM" then borderColor = setCustomColors() end
    if hideBorder then return end
    state.SetValue("borderColor", borderColor)
end
function setClassicColors()
    local borderColor = vector.New(0.81, 0.88, 1.00, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.00, 0.00, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.14, 0.24, 0.28, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.24, 0.34, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.29, 0.39, 0.43, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.41, 0.48, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.51, 0.58, 0.75, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(0.81, 0.88, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.56, 0.63, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(0.61, 0.68, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(0.81, 0.88, 1.00, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(0.81, 0.88, 1.00, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(0.81, 0.88, 1.00, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))
    loadup.OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.PulseTextColorLeft = vector.New(0.00, 0.50, 1.00, 1.00)
    loadup.PulseTextColorRight = vector.New(0.00, 0.00, 1.00, 1.00)
    loadup.BgTl = vector.New(0.00, 0.00, 0.00, 0.39)
    loadup.BgTr = vector.New(0.31, 0.38, 0.50, 0.67)
    loadup.BgBl = vector.New(0.31, 0.38, 0.50, 0.67)
    loadup.BgBr = vector.New(0.62, 0.76, 1, 1.00)
    return borderColor
end
function setStrawberryColors()
    local borderColor = vector.New(1.00, 0.81, 0.88, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.00, 0.00, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.28, 0.14, 0.24, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.38, 0.24, 0.34, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.43, 0.29, 0.39, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.65, 0.41, 0.48, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.75, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.75, 0.51, 0.58, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(1.00, 0.81, 0.88, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.75, 0.56, 0.63, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(0.80, 0.61, 0.68, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.50, 0.31, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.60, 0.41, 0.48, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.70, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.50, 0.31, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.75, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.75, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(1.00, 0.81, 0.88, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(1.00, 0.81, 0.88, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(1.00, 0.81, 0.88, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(1.00, 0.81, 0.88, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(1.00, 0.81, 0.88, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.50, 0.31, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.60, 0.41, 0.48, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.70, 0.51, 0.58, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))
    loadup.OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.PulseTextColorLeft = vector.New(1.00, 0.00, 0, 1.00)
    loadup.PulseTextColorRight = vector.New(1.00, 0.50, 0.50, 1.00)
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = vector.New(0.50, 0.31, 0.38, 1.00)
    loadup.BgBl = vector.New(0.50, 0.31, 0.38, 1.00)
    loadup.BgBr = vector.New(1, 0.62, 0.76, 1.00)
    return borderColor
end
function setAmethystColors()
    local borderColor = vector.New(0.90, 0.00, 0.81, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.16, 0.00, 0.20, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.40, 0.20, 0.40, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.50, 0.30, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.55, 0.35, 0.55, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.31, 0.11, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.41, 0.21, 0.45, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.41, 0.21, 0.45, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.95, 0.75, 0.95, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.60, 0.40, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.80, 0.60, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.50, 0.30, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(1.00, 0.80, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(1.00, 0.80, 1.00, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(1.00, 0.80, 1.00, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(1.00, 0.80, 1.00, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(1.00, 0.80, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.60, 0.40, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.70, 0.50, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.80, 0.60, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.70, 0.30, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(1.00, 0.80, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.70, 0.30, 1.00))
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = vector.New(0.50, 0.00, 0.75, 1.00)
    loadup.PulseTextColorRight = vector.New(1.00, 0.00, 0.60, 1.00)
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = vector.New(0.50, 0.30, 0.50, 1.00)
    loadup.BgBl = vector.New(0.50, 0.30, 0.50, 1.00)
    loadup.BgBr = vector.New(1.00, 0.60, 1.00, 1.00)
    return borderColor
end
function setTreeColors()
    local borderColor = vector.New(0.81, 0.90, 0.00, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, vector.New(0.20, 0.16, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, vector.New(0.40, 0.40, 0.20, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered, vector.New(0.50, 0.50, 0.30, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive, vector.New(0.55, 0.55, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, vector.New(0.35, 0.31, 0.11, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive, vector.New(0.45, 0.41, 0.21, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, vector.New(0.45, 0.41, 0.21, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, vector.New(0.95, 0.95, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Button, vector.New(0.60, 0.60, 0.40, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive, vector.New(0.80, 0.80, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, vector.New(0.50, 0.50, 0.30, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.Header, vector.New(1.00, 1.00, 0.80, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered, vector.New(1.00, 1.00, 0.80, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive, vector.New(1.00, 1.00, 0.80, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, vector.New(1.00, 1.00, 0.80, 0.30))
    imgui.PushStyleColor(imgui_col.Text, vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg, vector.New(1.00, 1.00, 0.80, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, vector.New(0.60, 0.60, 0.40, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, vector.New(0.70, 0.70, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, vector.New(0.80, 0.80, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(0.30, 1.00, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(1.00, 1.00, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(0.30, 1.00, 0.70, 1.00))
    loadup.OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.PulseTextColorLeft = vector.New(0.50, 0.50, 0.00, 1.00)
    loadup.PulseTextColorRight = vector.New(1.00, 1.00, 0.00, 1.00)
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = vector.New(0.50, 0.50, 0.30, 1.00)
    loadup.BgBl = vector.New(0.50, 0.50, 0.30, 1.00)
    loadup.BgBr = vector.New(1.00, 1.00, 0.60, 0.70)
    return borderColor
end
function setBarbieColors()
    local pink = vector.New(0.79, 0.31, 0.55, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local blue = vector.New(0.29, 0.48, 0.63, 1.00)
    local pinkTint = vector.New(1.00, 0.86, 0.86, 0.40)
    imgui.PushStyleColor(imgui_col.WindowBg, pink)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, blue)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, pinkTint)
    imgui.PushStyleColor(imgui_col.TitleBg, blue)
    imgui.PushStyleColor(imgui_col.TitleBgActive, blue)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, pink)
    imgui.PushStyleColor(imgui_col.CheckMark, blue)
    imgui.PushStyleColor(imgui_col.SliderGrab, blue)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Button, blue)
    imgui.PushStyleColor(imgui_col.ButtonHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Tab, blue)
    imgui.PushStyleColor(imgui_col.TabHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.TabActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Header, blue)
    imgui.PushStyleColor(imgui_col.HeaderHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, pinkTint)
    imgui.PushStyleColor(imgui_col.Separator, pinkTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, pinkTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, pinkTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, white)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, white)
    imgui.PushStyleColor(imgui_col.PlotLines, pinkTint)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, white)
    imgui.PushStyleColor(imgui_col.PlotHistogram, pinkTint)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, white)
    loadup.OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.PulseTextColorLeft = pink
    loadup.PulseTextColorRight = blue
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = blue
    loadup.BgBl = blue
    loadup.BgBr = pink
    return pinkTint
end
function setIncognitoColors()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.20, 0.20, 0.20, 1.00)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local red = vector.New(1.00, 0.00, 0.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, whiteTint)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, black)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, white)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Separator, whiteTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, white)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, white)
    imgui.PushStyleColor(imgui_col.PlotLines, white)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, red)
    imgui.PushStyleColor(imgui_col.PlotHistogram, white)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, red)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.PulseTextColorRight = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = grey
    loadup.BgBl = grey
    loadup.BgBr = white
    return whiteTint
end
function setIncognitoRGBColors(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.20, 0.20, 0.20, 1.00)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.40)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, black)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Separator, rgbColor)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, white)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, white)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotHistogram, white)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, rgbColor)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = rgbColor
    loadup.PulseTextColorRight = rgbColor
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = grey
    loadup.BgBl = grey
    loadup.BgBr = white
    return rgbColor
end
function setTobiGlassColors()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.70)
    local transparentWhite = vector.New(0.30, 0.30, 0.30, 0.50)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local buttonColor = vector.New(0.14, 0.24, 0.28, 0.80)
    local frameColor = vector.New(0.24, 0.34, 0.38, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, buttonColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, whiteTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparentBlack)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, frameColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, buttonColor)
    imgui.PushStyleColor(imgui_col.Button, buttonColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Tab, transparentBlack)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Header, transparentBlack)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Separator, whiteTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotLines, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotHistogram, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, transparentWhite)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = buttonColor / 2 + color.vctr.white / 2
    loadup.PulseTextColorRight = buttonColor / 2 + color.vctr.white / 2
    loadup.BgTl = transparentBlack
    loadup.BgTr = buttonColor / 2 + color.vctr.black / 2
    loadup.BgBl = buttonColor / 2 + color.vctr.black / 2
    loadup.BgBr = buttonColor / 2 + color.vctr.white / 2
    return frameColor
end
function setTobiRGBGlassColors(rgbPeriod)
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.85)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local colorTint = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.3)
    imgui.PushStyleColor(imgui_col.WindowBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, colorTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, colorTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparentBlack)
    imgui.PushStyleColor(imgui_col.CheckMark, rgbColor)
    imgui.PushStyleColor(imgui_col.SliderGrab, colorTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Button, transparentBlack)
    imgui.PushStyleColor(imgui_col.ButtonHovered, colorTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, colorTint)
    imgui.PushStyleColor(imgui_col.Tab, transparentBlack)
    imgui.PushStyleColor(imgui_col.TabHovered, colorTint)
    imgui.PushStyleColor(imgui_col.TabActive, colorTint)
    imgui.PushStyleColor(imgui_col.Header, transparentBlack)
    imgui.PushStyleColor(imgui_col.HeaderHovered, colorTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, colorTint)
    imgui.PushStyleColor(imgui_col.Separator, colorTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, colorTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, colorTint)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = rgbColor
    loadup.PulseTextColorRight = rgbColor
    loadup.BgTl = transparentBlack
    loadup.BgTr = color.vctr.white / 4 + 3 * color.vctr.black / 4
    loadup.BgBl = color.vctr.white / 4 + 3 * color.vctr.black / 4
    loadup.BgBr = color.vctr.white / 2 + color.vctr.black / 2
    return rgbColor
end
function setGlassColors()
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local transparentWhite = vector.New(1.00, 1.00, 1.00, 0.70)
    local whiteTint = vector.New(1.00, 1.00, 1.00, 0.30)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, whiteTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparentBlack)
    imgui.PushStyleColor(imgui_col.CheckMark, transparentWhite)
    imgui.PushStyleColor(imgui_col.SliderGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, transparentWhite)
    imgui.PushStyleColor(imgui_col.Button, transparentBlack)
    imgui.PushStyleColor(imgui_col.ButtonHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Tab, transparentBlack)
    imgui.PushStyleColor(imgui_col.TabHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.TabActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Header, transparentBlack)
    imgui.PushStyleColor(imgui_col.HeaderHovered, whiteTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, whiteTint)
    imgui.PushStyleColor(imgui_col.Separator, whiteTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, whiteTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotLines, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, transparentWhite)
    imgui.PushStyleColor(imgui_col.PlotHistogram, whiteTint)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, transparentWhite)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = transparentBlack / 2 + color.vctr.white / 2
    loadup.PulseTextColorRight = color.vctr.white
    loadup.BgTl = transparentBlack
    loadup.BgTr = transparentBlack / 2 + color.vctr.black / 2
    loadup.BgBl = transparentBlack / 2 + color.vctr.black / 2
    loadup.BgBr = transparentBlack / 2 + color.vctr.white / 2
    return transparentWhite
end
function setGlassRGBColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local colorTint = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.3)
    local transparentBlack = vector.New(0.00, 0.00, 0.00, 0.25)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, colorTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, colorTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparentBlack)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparentBlack)
    imgui.PushStyleColor(imgui_col.CheckMark, rgbColor)
    imgui.PushStyleColor(imgui_col.SliderGrab, colorTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Button, transparentBlack)
    imgui.PushStyleColor(imgui_col.ButtonHovered, colorTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, colorTint)
    imgui.PushStyleColor(imgui_col.Tab, transparentBlack)
    imgui.PushStyleColor(imgui_col.TabHovered, colorTint)
    imgui.PushStyleColor(imgui_col.TabActive, colorTint)
    imgui.PushStyleColor(imgui_col.Header, transparentBlack)
    imgui.PushStyleColor(imgui_col.HeaderHovered, colorTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, colorTint)
    imgui.PushStyleColor(imgui_col.Separator, colorTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, colorTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, colorTint)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = rgbColor
    loadup.PulseTextColorRight = rgbColor
    loadup.BgTl = transparentBlack
    loadup.BgTr = color.vctr.white / 4 + 3 * color.vctr.black / 4
    loadup.BgBl = color.vctr.white / 4 + 3 * color.vctr.black / 4
    loadup.BgBr = color.vctr.white / 2 + color.vctr.black / 2
    return rgbColor
end
function setRGBGamerColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local inactiveColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.5)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearWhite = vector.New(1.00, 1.00, 1.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.FrameBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, inactiveColor)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, rgbColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, white)
    imgui.PushStyleColor(imgui_col.Button, inactiveColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.ButtonActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Tab, inactiveColor)
    imgui.PushStyleColor(imgui_col.TabHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.TabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Header, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderHovered, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Separator, inactiveColor)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, clearWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, inactiveColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))
    loadup.OpeningTextColor = vector.New(1.00, 1.00, 1.00, 1.00)
    loadup.PulseTextColorLeft = inactiveColor
    loadup.PulseTextColorRight = rgbColor
    loadup.BgTl = black
    loadup.BgTr = inactiveColor / 2 + vctr4(0)
    loadup.BgBl = inactiveColor / 2 + vctr4(0)
    loadup.BgBr = rgbColor / 2 + vctr4(0)
    return inactiveColor
end
function setInvertedRGBGamerColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local inactiveColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.5)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearBlack = vector.New(0.00, 0.00, 0.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.FrameBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, inactiveColor)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, rgbColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, black)
    imgui.PushStyleColor(imgui_col.Button, inactiveColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.ButtonActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Tab, inactiveColor)
    imgui.PushStyleColor(imgui_col.TabHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.TabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Header, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderHovered, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Separator, inactiveColor)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, clearBlack)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, inactiveColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.39, 0.39, 0.39, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(0.00, 0.57, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.10, 0.30, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(0.00, 0.40, 1.00, 1.00))
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = inactiveColor
    loadup.PulseTextColorRight = rgbColor
    loadup.BgTl = black
    loadup.BgTr = inactiveColor / 2 + vctr4(1) / 2
    loadup.BgBl = inactiveColor / 2 + vctr4(1) / 2
    loadup.BgBr = rgbColor / 2 + vctr4(1) / 2
    return inactiveColor
end
function setInvertedIncognitoColors()
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.80, 0.80, 0.80, 1.00)
    local blackTint = vector.New(0.00, 0.00, 0.00, 0.40)
    local notRed = vector.New(0.00, 1.00, 1.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, blackTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, blackTint)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, white)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, blackTint)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, blackTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, blackTint)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, blackTint)
    imgui.PushStyleColor(imgui_col.TabActive, blackTint)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, blackTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, blackTint)
    imgui.PushStyleColor(imgui_col.Separator, blackTint)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, blackTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, blackTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, black)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, black)
    imgui.PushStyleColor(imgui_col.PlotLines, black)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, notRed)
    imgui.PushStyleColor(imgui_col.PlotHistogram, black)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, notRed)
    loadup.OpeningTextColor = white
    loadup.PulseTextColorLeft = black
    loadup.PulseTextColorRight = black
    loadup.BgTl = white / 2 + vctr4(0)
    loadup.BgTr = grey
    loadup.BgBl = grey
    loadup.BgBr = black
    return blackTint
end
function setInvertedIncognitoRGBColors(rgbPeriod)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local grey = vector.New(0.80, 0.80, 0.80, 1.00)
    local blackTint = vector.New(0.00, 0.00, 0.00, 0.40)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local rgbColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, grey)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, blackTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, rgbColor)
    imgui.PushStyleColor(imgui_col.TitleBg, grey)
    imgui.PushStyleColor(imgui_col.TitleBgActive, grey)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, white)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Button, grey)
    imgui.PushStyleColor(imgui_col.ButtonHovered, blackTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Tab, grey)
    imgui.PushStyleColor(imgui_col.TabHovered, blackTint)
    imgui.PushStyleColor(imgui_col.TabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Header, grey)
    imgui.PushStyleColor(imgui_col.HeaderHovered, blackTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, rgbColor)
    imgui.PushStyleColor(imgui_col.Separator, rgbColor)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, rgbColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, blackTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, black)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotLines, black)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, rgbColor)
    imgui.PushStyleColor(imgui_col.PlotHistogram, black)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, rgbColor)
    loadup.OpeningTextColor = vector.New(0.00, 0.00, 0.00, 1.00)
    loadup.PulseTextColorLeft = rgbColor
    loadup.PulseTextColorRight = rgbColor
    loadup.BgTl = vector.New(0.00, 0, 0.00, 0.39)
    loadup.BgTr = grey
    loadup.BgBl = grey
    loadup.BgBr = white
    return rgbColor
end
function setCustomColors()
    if (globalVars.customStyle == nil) then
        return setClassicColors()
    end
    local borderColor = globalVars.customStyle.border or vector.New(0.81, 0.88, 1.00, 0.30)
    imgui.PushStyleColor(imgui_col.WindowBg, globalVars.customStyle.windowBg or vector.New(0.00, 0.00, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PopupBg, globalVars.customStyle.popupBg or vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, globalVars.customStyle.frameBg or vector.New(0.14, 0.24, 0.28, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgHovered,
        globalVars.customStyle.frameBgHovered or vector.New(0.24, 0.34, 0.38, 1.00))
    imgui.PushStyleColor(imgui_col.FrameBgActive,
        globalVars.customStyle.frameBgActive or vector.New(0.29, 0.39, 0.43, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBg, globalVars.customStyle.titleBg or vector.New(0.41, 0.48, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgActive,
        globalVars.customStyle.titleBgActive or vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed,
        globalVars.customStyle.titleBgCollapsed or vector.New(0.51, 0.58, 0.75, 0.50))
    imgui.PushStyleColor(imgui_col.CheckMark, globalVars.customStyle.checkMark or vector.New(0.81, 0.88, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrab, globalVars.customStyle.sliderGrab or vector.New(0.56, 0.63, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.SliderGrabActive,
        globalVars.customStyle.sliderGrabActive or vector.New(0.61, 0.68, 0.80, 1.00))
    imgui.PushStyleColor(imgui_col.Button, globalVars.customStyle.button or vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonHovered,
        globalVars.customStyle.buttonHovered or vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ButtonActive,
        globalVars.customStyle.buttonActive or vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.Tab, globalVars.customStyle.tab or vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.TabHovered, globalVars.customStyle.tabHovered or vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.TabActive, globalVars.customStyle.tabActive or vector.New(0.51, 0.58, 0.75, 1.00))
    imgui.PushStyleColor(imgui_col.Header, globalVars.customStyle.header or vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.HeaderHovered,
        globalVars.customStyle.headerHovered or vector.New(0.81, 0.88, 1.00, 0.50))
    imgui.PushStyleColor(imgui_col.HeaderActive,
        globalVars.customStyle.headerActive or vector.New(0.81, 0.88, 1.00, 0.54))
    imgui.PushStyleColor(imgui_col.Separator, globalVars.customStyle.separator or vector.New(0.81, 0.88, 1.00, 0.30))
    imgui.PushStyleColor(imgui_col.Text, globalVars.customStyle.text or vector.New(1.00, 1.00, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.TextSelectedBg,
        globalVars.customStyle.textSelectedBg or vector.New(0.81, 0.88, 1.00, 0.40))
    imgui.PushStyleColor(imgui_col.ScrollbarGrab,
        globalVars.customStyle.scrollbarGrab or vector.New(0.31, 0.38, 0.50, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered,
        globalVars.customStyle.scrollbarGrabHovered or vector.New(0.41, 0.48, 0.60, 1.00))
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive,
        globalVars.customStyle.scrollbarGrabActive or vector.New(0.51, 0.58, 0.70, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLines, globalVars.customStyle.plotLines or vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered,
        globalVars.customStyle.plotLinesHovered or vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram,
        globalVars.customStyle.plotHistogram or vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered,
        globalVars.customStyle.plotHistogramHovered or vector.New(1.00, 0.60, 0.00, 1.00))
    loadup.OpeningTextColor = globalVars.customStyle.loadupOpeningTextColor
    loadup.PulseTextColorLeft = globalVars.customStyle.loadupPulseTextColorLeft
    loadup.PulseTextColorRight = globalVars.customStyle.loadupPulseTextColorRight
    loadup.BgTl = globalVars.customStyle.loadupBgTl
    loadup.BgTr = globalVars.customStyle.loadupBgTr
    loadup.BgBl = globalVars.customStyle.loadupBgBl
    loadup.BgBr = globalVars.customStyle.loadupBgBr
    return borderColor
end
function getCurrentRGBColors(rgbPeriod)
    local currentTime = clock.getTime()
    local percentIntoRGBCycle = (currentTime % rgbPeriod) / rgbPeriod
    local stagesElapsed = 6 * percentIntoRGBCycle
    local currentStageNumber = math.floor(stagesElapsed)
    local percentIntoStage = math.clamp(stagesElapsed - currentStageNumber, 0, 1)
    local red = 0
    local green = 0
    local blue = 0
    if currentStageNumber == 0 then
        green = 1 - percentIntoStage
        blue = 1
    elseif currentStageNumber == 1 then
        blue = 1
        red = percentIntoStage
    elseif currentStageNumber == 2 then
        blue = 1 - percentIntoStage
        red = 1
    elseif currentStageNumber == 3 then
        green = percentIntoStage
        red = 1
    elseif currentStageNumber == 4 then
        green = 1
        red = 1 - percentIntoStage
    else
        blue = percentIntoStage
        green = 1
    end
    return { red = red, green = green, blue = blue }
end
---Similar to [`imgui.PushStyleColor`](lua://imgui.PushStyleColor), but pushes a changing color instead.
---@param color1 Vector4 The first color.
---@param color2 Vector4 The second color.
---@param property ImGuiCol The property to change.
---@param oscillationPeriod? integer The amount of time to switch from color 1 -> 2 -> 1, in milliseconds.
function PushGradientStyle(color1, color2, property, oscillationPeriod)
    local x = math.sin(6.28318531 * state.UnixTime / (oscillationPeriod or 1000)) / 2 + 0.5
    local currentColor = color1 * x + color2 * (1 - x)
    imgui.PushStyleColor(property, currentColor)
end
INSTRUCTION_COLOR = vector.New(1, 0.5, 0.5, 1)
GUIDELINE_COLOR = vector.New(0.5, 0.5, 1, 1)
---Creates an imgui button.
---@param text string The text that the button should have.
---@param size Vector2 The size of the button.
---@param fn fun(menuVars?: table): nil The function that the button should run upon being clicked.
---@param menuVars? table A set of variables to be passed into the function.
function FunctionButton(text, size, fn, menuVars)
    if not imgui.Button(text, size) then return end
    if menuVars then
        fn(menuVars)
        return
    end
    fn()
end
function PresetButton()
    local buttonText = ": )"
    if globalVars.showPresetMenu then buttonText = "X" end
    local buttonPressed = imgui.Button(buttonText, EXPORT_BUTTON_SIZE)
    HoverToolTip("View presets and export/import them.")
    KeepSameLine()
    if not buttonPressed then return end
    globalVars.showPresetMenu = not globalVars.showPresetMenu
end
function GradientButton(label, color1, color2, oscillationPeriod)
    PushGradientStyle(color1, color2, imgui_col.Text, oscillationPeriod)
    local btn = imgui.Button(label)
    imgui.PopStyleColor()
    return btn
end
---Creates a checkbox that directly saves to globalVars and the universal `.yaml` file.
---@param varsTable { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicCheckbox(varsTable, parameterName, label, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.Checkbox(label, oldValue)
    if tooltipText then HelpMarker(tooltipText) end
    return oldValue ~= varsTable[parameterName]
end
---Creates a checkbox that directly saves to globalVars and the universal `.yaml` file.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
function GlobalCheckbox(parameterName, label, tooltipText)
    local oldValue = globalVars[parameterName] ---@cast oldValue boolean
    _, globalVars[parameterName] = imgui.Checkbox(label, oldValue)
    if tooltipText then HoverToolTip(tooltipText) end
    if (oldValue ~= globalVars[parameterName]) then
        write(globalVars)
    end
end
---Creates an input designed specifically for code.
---@param varsTable { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of the table that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean active Whether or not the code input is currently in edit mode.
function CodeInput(varsTable, parameterName, label, tooltipText)
    local oldCode = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.InputTextMultiline(label, oldCode, 16384,
        vector.New(240, 120))
    if tooltipText then HoverToolTip(tooltipText) end
    return imgui.IsItemActive()
end
---Creates a color input.
---@param customStyle { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the input has changed this frame.
function ColorInput(customStyle, parameterName, label, tooltipText)
    AddSeparator()
    local oldCode = customStyle[parameterName]
    _, customStyle[parameterName] = imgui.ColorPicker4(label, customStyle[parameterName] or DEFAULT_STYLE[parameterName])
    if tooltipText then HoverToolTip(tooltipText) end
    return oldCode ~= customStyle[parameterName]
end
---Creates a combo element.
---@param label string The label for the combo.
---@param list string[] The list of elements the combo should use.
---@param listIndex integer The currently selected combo index.
---@param colorList? string[] An optional list containing an array of colors to use for each item.
---@param hiddenGroups? string[] An optional list, where if any items in list show up here, they will not be shown on the dropdown.
---@param tooltipList? string[] An optional list, showing tooltips that should appear when an element is hovered over.
---@return number newListIndex The new combo index.
function Combo(label, list, listIndex, colorList, hiddenGroups, tooltipList)
    local newListIndex = math.clamp(listIndex, 1, #list)
    local currentComboItem = list[listIndex]
    local comboFlag = imgui_combo_flags.HeightLarge
    local rgb = {}
    hiddenGroups = hiddenGroups or {}
    if (colorList and truthy(colorList)) then
        colorList[newListIndex]:gsub("(%d+)", function(c)
            rgb[#rgb + 1] = c
        end)
        local alpha = math.floor(imgui.GetColorU32(imgui_col.Text) / 16777216) / 255 or 1
        imgui.PushStyleColor(imgui_col.Text,
            vector.New(rgb[1] / 255, rgb[2] / 255, rgb[3] / 255, alpha))
    end
    if not imgui.BeginCombo(label, currentComboItem, comboFlag) then
        if (colorList and truthy(colorList)) then imgui.PopStyleColor() end
        return newListIndex
    end
    if (colorList and truthy(colorList)) then imgui.PopStyleColor() end
    for i = 1, #list do
        rgb = {}
        if (colorList and truthy(colorList)) then
            colorList[i]:gsub("(%d+)", function(c)
                rgb[#rgb + 1] = c
            end)
            imgui.PushStyleColor(imgui_col.Text, vector.New(rgb[1] / 255, rgb[2] / 255, rgb[3] / 255, 1))
        end
        local listItem = list[i]
        if (table.contains(hiddenGroups, listItem)) then goto skipRender end
        if imgui.Selectable(listItem) then
            newListIndex = i
        end
        if (tooltipList and truthy(tooltipList)) then
            HoverToolTip(tooltipList[i])
        end
        ::skipRender::
        if (colorList and truthy(colorList)) then imgui.PopStyleColor() end
    end
    imgui.EndCombo()
    return newListIndex
end
function ComputableInputFloat(label, var, decimalPlaces, suffix)
    local previousValue = var
    local fmt = table.concat({"%.", decimalPlaces, "f"})
    if suffix then fmt = fmt .. suffix end
    _, var = imgui.InputText(label,
        string.format(fmt,
            tn(tostring(var):match("%d*[%-]?%d+[%.]?%d+") or tostring(var):match("%d*[%-]?%d+")) or 0),
        4096,
        imgui_input_text_flags.AutoSelectAll)
    if (imgui.IsItemDeactivatedAfterEdit()) then
        local desiredComp = tostring(var):gsub(" ", "")
        var = expr(desiredComp)
    end
    return tn(tostring(var):match("%d*[%-]?%d+[%.]?%d+") or tostring(var):match("%d*[%-]?%d+")),
        previousValue ~= var
end
function NegatableComputableInputFloat(label, var, decimalPlaces, suffix)
    local oldValue = var
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("Neg.", SECONDARY_BUTTON_SIZE)
    HoverToolTip("Negate SV value")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local newValue = ComputableInputFloat(label, var, decimalPlaces, suffix)
    imgui.PopItemWidth()
    if ((negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.negate_primary])) and newValue ~= 0) then
        newValue = -newValue
    end
    imgui.PopStyleVar(2)
    return newValue, oldValue ~= newValue
end
function SwappableNegatableInputFloat2(varsTable, lowerName, higherName, label, suffix, digits, widthFactor)
    digits = digits or 2
    suffix = suffix or "x"
    widthFactor = widthFactor or 0.7
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local swapButtonPressed = imgui.Button("S##" .. lowerName, TERTIARY_BUTTON_SIZE)
    HoverToolTip("Swap start/end values")
    local oldValues = vector.New(varsTable[lowerName], varsTable[higherName])
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N##" .. higherName, TERTIARY_BUTTON_SIZE)
    HoverToolTip("Negate start/end values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * widthFactor - SAMELINE_SPACING)
    local _, newValues = imgui.InputFloat2(label, oldValues, table.concat({"%.", digits, "f"}) .. suffix)
    imgui.PopItemWidth()
    varsTable[lowerName] = newValues.x
    varsTable[higherName] = newValues.y
    if (swapButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.swap_primary])) then
        varsTable[lowerName] = oldValues.y
        varsTable[higherName] = oldValues.x
    end
    if (negateButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.negate_primary])) then
        varsTable[lowerName] = -oldValues.x
        varsTable[higherName] = -oldValues.y
    end
    imgui.PopStyleVar(3)
    return swapButtonPressed or negateButtonPressed or
        kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.swap_primary]) or
        kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.negate_primary]) or
        oldValues ~= newValues
end
---@class GraphPoint
---@field pos Vector2 A Vector2 of two elements between 0-1.
---@field col integer Unsigned integer of the color.
---@field size number Radius of the point.
---Creates a graph and returns the context to run functions on.
---@param label string The hidden label of the graph.
---@param size Vector2 The size of the graph.
---@param points GraphPoint[] A list of points that can be dragged around.
---@param preferForeground? boolean Set this to true if you want to use `GetForegroundDrawList` instead of `GetWindowDrawList`.
---@param gridSize? integer To what degree you'd like the points to snap to.
---@param yScale? Vector2 If included, will create labels corresponding to this scale.
---@return ImDrawListPtr
---@return boolean changed
function renderGraph(label, size, points, preferForeground, gridSize, yScale)
    local gray = color.int.whiteMask * 100 + color.int.alphaMask * 255
    local tableLabel = "graph_points_" .. label
    local initDragList = {}
    local initPointList = {}
    for i = 1, #points do
        initDragList[#initDragList + 1] = false
        initPointList[#initPointList + 1] = points[i].pos
    end
    local dragList = state.GetValue(tableLabel, initDragList)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if preferForeground then ctx = imgui.GetForegroundDrawList() end
    for i, point in ipairs(points) do
        imgui.SetCursorPos(point.pos - vctr2(point.size))
        imgui.InvisibleButton(tableLabel .. i, vctr2(point.size * 2))
        if (imgui.IsMouseDown("Left") and imgui.IsItemActive()) then
            dragList[i] = true
        end
        if (imgui.IsMouseDragging("Left") and dragList[i]) then
            point.pos = point.pos + kbm.mouseDelta()
        end
        local pointCol = point.col
        local alphaDifference = 150 * 16 ^ 6
        if (not dragList[i]) then pointCol = pointCol - alphaDifference end
        ctx.AddCircleFilled(topLeft + point.pos, point.size, pointCol)
    end
    gridSize = gridSize or 1
    if (not imgui.IsMouseDown("Left")) then
        for i = 1, #points do
            dragList[i] = false
            local roundedX = math.round(points[i].pos.x / gridSize) * gridSize
            local roundedY = math.round(points[i].pos.y / gridSize) * gridSize
            points[i].pos = vector.New(roundedX, roundedY)
        end
    end
    if gridSize ~= 1 then
        for i = 0, size.x, gridSize do
            local lineCol = gray
            if (truthy(i % 4)) then
                lineCol = color.rgbaToUint(40, 40, 40, 255)
            end
            ctx.AddLine(vector.New(topLeft.x + i, topLeft.y), vector.New(topLeft.x + i, topLeft.y + dim.y), lineCol, 1)
        end
        for i = 0, size.y, gridSize do
            local lineCol = gray
            if (truthy(i % 4)) then
                lineCol = color.rgbaToUint(40, 40, 40, 255)
            end
            if (yScale and not truthy(i % 4)) then
                local number = (yScale.y - yScale.x) * (size.y - i) / size.y + yScale.x
                local textSize = imgui.CalcTextSize(tostring(number))
                ctx.AddText(
                    vector.New(topLeft.x + 6, math.clamp(topLeft.y + i - 7, topLeft.y + 5, topLeft.y + dim.y - 16)),
                    color.int.white,
                    tostring(number))
                ctx.AddLine(vector.New(topLeft.x + textSize.x + 10, topLeft.y + i),
                    vector.New(topLeft.x + dim.x, topLeft.y + i), lineCol,
                    1)
            else
                ctx.AddLine(vector.New(topLeft.x, topLeft.y + i), vector.New(topLeft.x + dim.x, topLeft.y + i), lineCol,
                    1)
            end
        end
    end
    local pointChanged = false
    for i = 1, #points do
        if (points[i].pos ~= initPointList[i]) then
            pointChanged = true
            break
        end
    end
    state.SetValue(tableLabel, dragList)
    return ctx, pointChanged
end
---Creates an `imgui.inputInt` element.
---@param varsTable { [string]: any } The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param bounds? [number, number] A tuple representing the minimum and maximum bounds this input should have.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicInputInt(varsTable, parameterName, label, bounds, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.InputInt(label, oldValue, 1, 1)
    if tooltipText then HelpMarker(tooltipText) end
    if (bounds and bounds[1] and bounds[2]) then
        varsTable[parameterName] = math.clamp(varsTable[parameterName], bounds[1], bounds[2])
    end
    return oldValue ~= varsTable[parameterName]
end
---Creates a set of radio buttons.
---@generic T
---@param label string The label for all radio buttons.
---@param value T The current value of the input.
---@param options string[] The list of options that the input should have. Each option has its own radio button.
---@param optionValues T[] What each option should set the value, in code.
---@param tooltipText? string An optional tooltip to be shown on hover.
---@return T idx The value of the currently selected radio button.
function RadioButtons(label, value, options, optionValues, tooltipText)
    imgui.AlignTextToFramePadding()
    imgui.Text(label)
    if tooltipText then HoverToolTip(tooltipText) end
    for idx, option in pairs(options) do
        imgui.SameLine(0, RADIO_BUTTON_SPACING)
        if imgui.RadioButton(option, value == optionValues[idx]) then
            value = optionValues[idx]
        end
        if tooltipText then HoverToolTip(tooltipText) end
    end
    return value
end
---Creates a big button that runs a function when clicked. If the number of notes selected is less than `minimumNotes`, returns a textual placeholder instead.
---@param buttonText string The text that should be rendered on the button.
---@param minimumNotes integer The minimum number of notes that are required to select berfore the button appears.
---@param actionfunc fun(...): nil The function to run on button press.
---@param menuVars? { [string]: any } Optional menu variable parameter.
---@param hideNoteReq? boolean Whether or not to hide the textual placeholder if the selected note requirement isn't met.
---@param disableKeyInput? boolean Whether or not to disallow keyboard inputs as a substitution to pressing the button.
---@param optionalKeyOverride? string (Assumes `disableKeyInput` is false) Optional string to change the activation keybind.
function simpleActionMenu(buttonText, minimumNotes, actionfunc, menuVars, hideNoteReq, disableKeyInput,
                          optionalKeyOverride)
    if (not hideNoteReq) then AddSeparator() end
    local enoughSelectedNotes = checkEnoughSelectedNotes(minimumNotes)
    local infoText = table.concat({ "Select ", minimumNotes, " or more ", pluralize("note", minimumNotes) })
    if (not enoughSelectedNotes) then
        if (not hideNoteReq) then imgui.Text(infoText) end
        return
    end
    FunctionButton(buttonText, ACTION_BUTTON_SIZE, actionfunc, menuVars)
    if disableKeyInput then return end
    local keyCombo = optionalKeyOverride or globalVars.hotkeyList[1 + tn(hideNoteReq)]
    local tooltip = HoverToolTip("Press \'" .. keyCombo ..
        "\' on your keyboard to do the same thing as this button")
    executeFunctionIfTrue(kbm.pressedKeyCombo(keyCombo), actionfunc, menuVars)
end
---Runs a function with the given parameters if the given `condition` is true.
---@param condition boolean The condition that is used.
---@param fn fun(...): nil The function to run if the condition is true.
---@param menuVars? { [string]: any } Optional menu variable parameter.
function executeFunctionIfTrue(condition, fn, menuVars)
    if not condition then return end
    if menuVars then
        fn(menuVars)
        return
    end
    fn()
end
function KeepSameLine()
    imgui.SameLine(0, SAMELINE_SPACING)
end
function AddPadding()
    imgui.Dummy(vector.New(0, 0))
end
function AddSeparator()
    AddPadding()
    imgui.Separator()
    AddPadding()
end
function HoverToolTip(text)
    if not imgui.IsItemHovered() then return end
    imgui.BeginTooltip()
    imgui.PushTextWrapPos(imgui.GetFontSize() * 20)
    imgui.Text(text)
    imgui.PopTextWrapPos()
    imgui.EndTooltip()
end
function HelpMarker(text)
    KeepSameLine()
    imgui.TextDisabled("(?)")
    HoverToolTip(text)
end
function gpsim(label, szFactor, distanceFn, colTbl, simulationDuration, forcedOverride, windowScale)
    if (not forcedOverride) then
        imgui.Dummy(vector.New(0, 10))
        imgui.SetCursorPosX((380 - 270 * szFactor.x) / 2)
    end
    imgui.BeginChild(label, vector.New(270, 150) * szFactor, imgui_child_flags.Border)
    local heightFactor = szFactor.y
    local simulationTime = state.UnixTime % simulationDuration
    local progress = simulationTime / simulationDuration
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    local red = color.rgbaToUint(225, 0, 0, 255)
    local blue = color.rgbaToUint(75, 75, 255, 255)
    local yellow = color.rgbaToUint(200, 200, 0, 255)
    local colorTable = {
        [4] = { red, yellow, blue, yellow }
    }
    for i = 1, #colTbl do
        for _, col in ipairs(colTbl[i]) do
            local height = 50 * (#colTbl * distanceFn(math.wrap(progress + 0.25, 0, 1), i) + #colTbl - i)
            if height > 150 then
                height = height - 50 * #colTbl
            end
            local notePos = vector.New((col - 1) * 60 + 20, height) * szFactor
            local noteSize = vector.New(50, 20) * szFactor
            local uintColor = color.rgbaToUint(255, 0, 0, 255)
            ctx.AddRectFilledMultiColor(topLeft + notePos, topLeft + notePos + noteSize, colorTable[#colTbl][i],
                colorTable[#colTbl][i],
                colorTable[#colTbl][i], colorTable[#colTbl][i])
        end
    end
    imgui.EndChild()
    if (not forcedOverride) then
        imgui.Dummy(vector.New(0, 10))
    end
end
---Returns `true` if enough notes are selected.
---@param minimumNotes 0|1|2
---@return boolean
function checkEnoughSelectedNotes(minimumNotes)
    if minimumNotes == 0 then return true end
    local selectedNotes = state.SelectedHitObjects
    local numSelectedNotes = #selectedNotes
    if numSelectedNotes == 0 then return false end
    if minimumNotes == 1 then return true end
    if numSelectedNotes > game.keyCount then return true end
    if (globalVars.useEndTimeOffsets and minimumNotes == 2 and selectedNotes[1].EndTime ~= 0) then return true end
    return selectedNotes[1].StartTime ~= selectedNotes[numSelectedNotes].StartTime
end
function showSettingsMenu(currentSVType, settingVars, skipFinalSV, svPointsForce, optionalLabel)
    if currentSVType == "Linear" then
        return linearSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Exponential" then
        return exponentialSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Bezier" then
        return bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce, optionalLabel)
    elseif currentSVType == "Hermite" then
        return hermiteSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Sinusoidal" then
        return sinusoidalSettingsMenu(settingVars, skipFinalSV)
    elseif currentSVType == "Circular" then
        return circularSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Random" then
        return randomSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Custom" then
        return customSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Chinchilla" then
        return chinchillaSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Combo" then
        return comboSettingsMenu(settingVars)
    elseif currentSVType == "Code" then
        return codeSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    end
end
function coordsRelativeToWindow(x, y)
    return vector.New(x, y) + imgui.GetWindowPos()
end
function relativePoint(point, xChange, yChange)
    return point + vector.New(xChange, yChange)
end
CREATE_TYPES = {
    "Standard",
    "Special",
    "Still",
    "Vibrato",
}
function createSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    local changedTool = chooseCreateTool()
    local placeType = CREATE_TYPES[globalVars.placeTypeIndex]
    if changedTool then state.SetValue("global.placeTypeIndex", globalVars.placeTypeIndex) end
    if placeType == "Standard" then placeStandardSVMenu() end
    if placeType == "Special" then placeSpecialSVMenu() end
    if placeType == "Still" then placeStillSVMenu() end
    if placeType == "Vibrato" then placeVibratoSVMenu(false) end
end
function chooseCreateTool()
    local tooltipList = {
        "Place standard shapes.",
        "Non-standard effects.",
        "Still shapes keep notes normal distance/spacing apart.",
        "Make notes vibrate or appear to duplicate."
    }
    imgui.AlignTextToFramePadding()
    imgui.Text("  Type:  ")
    KeepSameLine()
    local oldPlaceTypeIndex = globalVars.placeTypeIndex
    globalVars.placeTypeIndex = Combo("##placeType", CREATE_TYPES, oldPlaceTypeIndex, nil, nil, tooltipList)
    HoverToolTip(tooltipList[globalVars.placeTypeIndex])
    return oldPlaceTypeIndex ~= globalVars.placeTypeIndex
end
function renderPresetMenu(menuLabel, menuVars, settingVars)
    local newPresetName = state.GetValue("newPresetName", "")
    imgui.AlignTextToFramePadding()
    imgui.Text("New Preset Name:")
    KeepSameLine()
    imgui.PushItemWidth(90)
    _, newPresetName = imgui.InputText("##PresetName", newPresetName, 4096)
    imgui.PopItemWidth()
    imgui.SameLine()
    if (imgui.Button("Save") and newPresetName:len() > 0) then
        preset = {}
        preset.name = newPresetName
        newPresetName = ""
        preset.data = table.stringify({ menuVars = menuVars, settingVars = settingVars })
        preset.type = menuLabel
        if (menuLabel == "Standard" or menuLabel == "Still") then
            preset.menu = STANDARD_SVS[menuVars.svTypeIndex]
        end
        if (menuLabel == "Special") then
            preset.menu = SPECIAL_SVS[menuVars.svTypeIndex]
        end
        if (menuLabel == "Vibrato") then
            preset.menu = VIBRATO_SVS[menuVars.svTypeIndex]
        end
        table.insert(globalVars.presets, preset)
        write(globalVars)
    end
    state.SetValue("newPresetName", newPresetName)
    AddSeparator()
    local importCustomPreset = state.GetValue("importCustomPreset", "")
    imgui.AlignTextToFramePadding()
    imgui.Text("Import Preset:")
    KeepSameLine()
    imgui.PushItemWidth(103)
    _, importCustomPreset = imgui.InputText("##CustomPreset", importCustomPreset, MAX_IMPORT_CHARACTER_LIMIT)
    state.SetValue("importCustomPreset", importCustomPreset)
    imgui.PopItemWidth()
    imgui.SameLine()
    if (imgui.Button("Import##CustomPreset")) then
        local parsedTable = table.parse(importCustomPreset)
        if (table.includes(table.property(globalVars.presets, "name"), parsedTable.name)) then
            print("e!",
                "A preset with this name already exists. Please remove it or change the name in the import string.")
        else
            table.insert(globalVars.presets, parsedTable)
            importCustomPreset = ""
            write(globalVars)
        end
    end
    AddSeparator()
    imgui.Columns(3)
    imgui.Text("Name")
    imgui.NextColumn()
    imgui.Text("Menu")
    imgui.NextColumn()
    imgui.Text("Actions")
    imgui.NextColumn()
    imgui.Separator()
    for idx, preset in pairs(globalVars.presets) do
        imgui.AlignTextToFramePadding()
        imgui.Text(preset.name)
        imgui.NextColumn()
        imgui.AlignTextToFramePadding()
        imgui.Text(table.concat({ preset.type:shorten(), " > ", removeTrailingTag(preset.menu):sub(1, 3) }))
        imgui.NextColumn()
        if (imgui.Button("Select##Preset" .. idx)) then
            local data = table.parse(preset.data)
            globalVars.placeTypeIndex = table.indexOf(CREATE_TYPES, preset.type)
            cache.saveTable(preset.menu .. preset.type .. "Settings", data.settingVars)
            cache.saveTable(table.concat({"place", preset.type, "Menu"}), data.menuVars)
            globalVars.showPresetMenu = false
        end
        if (imgui.IsItemClicked("Right")) then
            imgui.SetClipboardText(table.stringify(preset))
            print("i!", "Exported preset to your clipboard.")
        end
        HoverToolTip("Left-click to select this preset. Right-click to copy this preset to your clipboard.")
        KeepSameLine()
        if (imgui.Button("X##Preset" .. idx)) then
            table.remove(globalVars.presets, idx)
            write(globalVars)
        end
    end
    imgui.SetColumnWidth(0, 90)
    imgui.SetColumnWidth(1, 73)
    imgui.SetColumnWidth(2, 95)
    imgui.Columns(1)
end
function animationFramesSetupMenu(settingVars)
    chooseMenuStep(settingVars)
    if settingVars.menuStep == 1 then
        KeepSameLine()
        imgui.Text("Choose Frame Settings")
        AddSeparator()
        BasicInputInt(settingVars, "numFrames", "Total # Frames", { 1, MAX_ANIMATION_FRAMES })
        chooseFrameSpacing(settingVars)
        chooseDistance(settingVars)
        HelpMarker("Initial separating distance from selected note to the first frame")
        BasicCheckbox(settingVars, "reverseFrameOrder", "Reverse frame order when placing SVs")
        AddSeparator()
        chooseNoteSkinType(settingVars)
    elseif settingVars.menuStep == 2 then
        KeepSameLine()
        imgui.Text("Adjust Notes/Frames")
        AddSeparator()
        imgui.Columns(2, "Notes and Frames", false)
        addFrameTimes(settingVars)
        displayFrameTimes(settingVars)
        removeSelectedFrameTimeButton(settingVars)
        AddPadding()
        chooseFrameTimeData(settingVars)
        imgui.NextColumn()
        chooseCurrentFrame(settingVars)
        drawCurrentFrame(settingVars)
        imgui.Columns(1)
        local invisibleButtonSize = vector.New(2 * (ACTION_BUTTON_SIZE.x + 1.5 * SAMELINE_SPACING), 1)
        imgui.InvisibleButton("sv isnt a real skill", invisibleButtonSize)
    else
        KeepSameLine()
        imgui.Text("Place SVs")
        AddSeparator()
        if not truthy(settingVars.frameTimes) then
            imgui.Text("No notes added in Step 2, so can't place SVs yet")
            return
        end
        HelpMarker("This tool displaces notes into frames after the (first) selected note")
        HelpMarker("Works with pre-existing SVs or no SVs in the map")
        HelpMarker("This is technically an edit SV tool, but it replaces the old animate function")
        HelpMarker("Make sure to prepare an empty area for the frames after the note you select")
        HelpMarker("Note: frame positions and viewing them will break if SV distances change")
        simpleActionMenu("Setup frames after selected note", 1, displaceNotesForAnimationFrames, settingVars)
    end
end
function removeSelectedFrameTimeButton(settingVars)
    if not truthy(settingVars.frameTimes) then return end
    if not imgui.Button("Removed currently selected time", BEEG_BUTTON_SIZE) then return end
    table.remove(settingVars.frameTimes, settingVars.selectedTimeIndex)
    local maxIndex = math.max(1, #settingVars.frameTimes)
    settingVars.selectedTimeIndex = math.clamp(settingVars.selectedTimeIndex, 1, maxIndex)
end
function addFrameTimes(settingVars)
    if not imgui.Button("Add selected notes to use for frames", ACTION_BUTTON_SIZE) then return end
    local hasAlreadyAddedLaneTime = {}
    for _ = 1, game.keyCount do
        hasAlreadyAddedLaneTime[#hasAlreadyAddedLaneTime + 1] = {}
    end
    local frameTimeToIndex = {}
    local totalTimes = #settingVars.frameTimes
    for i = 1, totalTimes do
        local frameTime = settingVars.frameTimes[i] ---@cast frameTime { time: number, lanes: number[] }
        local time = frameTime.time
        local lanes = frameTime.lanes
        frameTimeToIndex[time] = i
        for j = 1, #lanes do
            local lane = lanes[j]
            hasAlreadyAddedLaneTime[lane][time] = true
        end
    end
    for _, ho in pairs(state.SelectedHitObjects) do
        local lane = ho.Lane
        local time = ho.StartTime
        if (not hasAlreadyAddedLaneTime[lane][time]) then
            hasAlreadyAddedLaneTime[lane][time] = true
            if frameTimeToIndex[time] then
                local index = frameTimeToIndex[time]
                local frameTime = settingVars.frameTimes[index] ---@cast frameTime { time: number, lanes: number[] }
                table.insert(frameTime.lanes, lane)
                frameTime.lanes = sort(frameTime.lanes, sortAscending)
            else
                local defaultFrame = settingVars.currentFrame
                local defaultPosition = 0
                local newFrameTime = createFrameTime(time, { lane }, defaultFrame, defaultPosition)
                table.insert(settingVars.frameTimes, newFrameTime)
                frameTimeToIndex[time] = #settingVars.frameTimes
            end
        end
    end
    settingVars.frameTimes = sort(settingVars.frameTimes, sortAscendingTime)
end
function displayFrameTimes(settingVars)
    if not truthy(settingVars.frameTimes) then
        imgui.Text("Add notes to fill the selection box below")
    else
        imgui.Text("time | lanes | frame # | position")
    end
    HelpMarker("Make sure to select ALL lanes from a chord with multiple notes, not just one lane")
    AddPadding()
    local frameTimeSelectionArea = vector.New(ACTION_BUTTON_SIZE.x, 120)
    imgui.BeginChild("Frame Times", frameTimeSelectionArea, 1)
    for i = 1, #settingVars.frameTimes do
        local frameTimeData = {}
        local frameTime = settingVars.frameTimes[i]
        frameTimeData[1] = frameTime.time
        frameTimeData[2] = frameTime.lanes .. ", "
        frameTimeData[3] = frameTime.frame
        frameTimeData[4] = frameTime.position
        local selectableText = frameTimeData .. " | "
        if imgui.Selectable(selectableText, settingVars.selectedTimeIndex == i) then
            settingVars.selectedTimeIndex = i
        end
    end
    imgui.EndChild()
end
function drawCurrentFrame(settingVars)
    local mapKeyCount = game.keyCount
    local noteWidth = 200 / mapKeyCount
    local noteSpacing = 5
    local barNoteHeight = math.round(2 * noteWidth / 5, 0)
    local noteColor = color.rgbaToUint(117, 117, 117, 255)
    local noteSkinType = NOTE_SKIN_TYPES[settingVars.noteSkinTypeIndex]
    local drawlist = imgui.GetWindowDrawList()
    local childHeight = 250
    imgui.BeginChild("Current Frame", vector.New(255, childHeight), 1)
    for _, frameTime in pairs(settingVars.frameTimes) do
        if not frameTime.frame == settingVars.currentFrame then goto continue end
        for _, lane in pairs(frameTime.lanes) do
            if noteSkinType == "Bar" then
                local x1 = 2 * noteSpacing + (noteWidth + noteSpacing) * (lane - 1)
                local y1 = (childHeight - 2 * noteSpacing) - (frameTime.position / 2)
                local x2 = x1 + noteWidth
                local y2 = y1 - barNoteHeight
                if globalVars.upscroll then
                    y1 = childHeight - y1
                    y2 = y1 + barNoteHeight
                end
                local p1 = coordsRelativeToWindow(x1, y1)
                local p2 = coordsRelativeToWindow(x2, y2)
                drawlist.AddRectFilled(p1, p2, noteColor)
            elseif noteSkinType == "Circle" then
                local circleRadius = noteWidth / 2
                local leftBlankSpace = 2 * noteSpacing + circleRadius
                local yBlankSpace = 2 * noteSpacing + circleRadius + frameTime.position / 2
                local x1 = leftBlankSpace + (noteWidth + noteSpacing) * (lane - 1)
                local y1 = childHeight - yBlankSpace
                if globalVars.upscroll then
                    y1 = childHeight - y1
                end
                local p1 = coordsRelativeToWindow(x1, y1)
                drawlist.AddCircleFilled(p1, circleRadius, noteColor, 20)
            end
        end
        ::continue::
    end
    imgui.EndChild()
end
function addSelectedNoteTimesToList(menuVars)
    for _, ho in pairs(state.SelectedHitObjects) do
        table.insert(menuVars.noteTimes, ho.StartTime)
    end
    menuVars.noteTimes = table.dedupe(menuVars.noteTimes)
    menuVars.noteTimes = sort(menuVars.noteTimes, sortAscending)
end
function automateSVMenu(settingVars)
    local copiedSVCount = #settingVars.copiedSVs
    if copiedSVCount == 0 then
        BasicCheckbox(settingVars, "deleteCopiedSVs", "Delete Copied SVs?",
            "If true, will automatically delete the SVs that are copied.")
        simpleActionMenu("Copy SVs between selected notes", 2, automateCopySVs, settingVars)
        return
    end
    FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearAutomateSVs, settingVars)
    AddSeparator()
    automateSVSettingsMenu(settingVars)
    simpleActionMenu("Automate SVs for selected notes", 2, automateSVs, settingVars)
end
function automateSVSettingsMenu(settingVars)
    settingVars.initialSV = NegatableComputableInputFloat("Initial SV", settingVars.initialSV, 2, "x")
    _, settingVars.scaleSVs = imgui.Checkbox("Scale SVs?", settingVars.scaleSVs)
    KeepSameLine()
    _, settingVars.optimizeTGs = imgui.Checkbox("Optimize TGs?", settingVars.optimizeTGs)
    _, settingVars.maintainMs = imgui.Checkbox("Static Time?", settingVars.maintainMs)
    if (settingVars.maintainMs) then
        KeepSameLine()
        imgui.PushItemWidth(71)
        settingVars.ms = ComputableInputFloat("Time", settingVars.ms, 2, "ms")
        imgui.PopItemWidth()
    end
end
SPECIAL_SVS = {
    "Stutter",
    "Teleport Stutter",
    "Frames Setup",
    "Automate",
    "Penis",
}
function placeSpecialSVMenu()
    PresetButton()
    local menuVars = getMenuVars("placeSpecial")
    chooseSpecialSVType(menuVars)
    AddSeparator()
    local currentSVType = SPECIAL_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, "Special")
    if globalVars.showPresetMenu then
        renderPresetMenu("Special", menuVars, settingVars)
        return
    end
    if currentSVType == "Stutter" then stutterMenu(settingVars) end
    if currentSVType == "Teleport Stutter" then teleportStutterMenu(settingVars) end
    if currentSVType == "Frames Setup" then
        animationFramesSetupMenu(settingVars)
    end
    if currentSVType == "Automate" then automateSVMenu(settingVars) end
    if currentSVType == "Penis" then penisMenu(settingVars) end
    cache.saveTable(currentSVType .. "SpecialSettings", settingVars)
    cache.saveTable("placeSpecialMenu", menuVars)
end
function penisMenu(settingVars)
    penisSettingsMenu(settingVars)
    simpleActionMenu("Place SVs", 1, placePenisSV, settingVars)
end
function penisSettingsMenu(settingVars)
    _, settingVars.bWidth = imgui.InputInt("Ball Width", math.floor(settingVars.bWidth))
    _, settingVars.sWidth = imgui.InputInt("Shaft Width", math.floor(settingVars.sWidth))
    _, settingVars.sCurvature = imgui.SliderInt("S Curvature", settingVars.sCurvature, 1, 100,
        settingVars.sCurvature .. "%%")
    _, settingVars.bCurvature = imgui.SliderInt("B Curvature", settingVars.bCurvature, 1, 100,
        settingVars.bCurvature .. "%%")
end
function stutterMenu(settingVars)
    local settingsChanged = not truthy(settingVars.svMultipliers)
    settingsChanged = stutterSettingsMenu(settingVars) or settingsChanged
    if settingsChanged then updateStutterMenuSVs(settingVars) end
    displayStutterSVWindows(settingVars)
    simpleActionMenu("Place SVs between selected notes", 2, placeStutterSVs, settingVars)
end
function stutterSettingsMenu(settingVars)
    local settingsChanged = false
    settingsChanged = chooseControlSecondSV(settingVars) or settingsChanged
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    if (not settingVars.linearlyChange) then
        settingsChanged = chooseStutterDuration(settingVars) or settingsChanged
    else
        settingsChanged = SwappableNegatableInputFloat2(settingVars, "stutterDuration", "stutterDuration2",
            "S/E % Duration",
            "%%", 0)
        settingVars.stutterDuration = math.clamp(settingVars.stutterDuration, 1, 99)
        settingVars.stutterDuration2 = math.clamp(settingVars.stutterDuration2, 1, 99)
    end
    settingsChanged = BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time") or settingsChanged
    HoverToolTip(
        "Affects the stutter within two offsets; does not affect the stutter over the duration of several notes.")
    AddSeparator()
    settingsChanged = BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 }) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, false) or settingsChanged
    return settingsChanged
end
function teleportStutterMenu(settingVars)
    teleportStutterSettingsMenu(settingVars)
    simpleActionMenu("Place SVs between selected notes", 2, placeTeleportStutterSVs, settingVars)
end
function teleportStutterSettingsMenu(settingVars)
    if settingVars.useDistance then
        chooseDistance(settingVars)
        HelpMarker("Start SV teleport distance")
    else
        chooseStartSVPercent(settingVars)
    end
    chooseMainSV(settingVars)
    BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 })
    chooseAverageSV(settingVars)
    chooseFinalSV(settingVars, false)
    BasicCheckbox(settingVars, "useDistance", "Use distance for start SV")
    BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time")
end
STANDARD_SVS = {
    "Linear",
    "Exponential",
    "Bezier",
    "Hermite",
    "Sinusoidal",
    "Circular",
    "Random",
    "Custom",
    "Chinchilla",
    "Combo",
    "Code"
}
function placeStandardSVMenu()
    PresetButton()
    local menuVars = getMenuVars("placeStandard")
    local needSVUpdate = not truthy(menuVars.svMultipliers)
    needSVUpdate = chooseStandardSVType(menuVars, false) or needSVUpdate
    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, "Standard")
    if globalVars.showPresetMenu then
        renderPresetMenu("Standard", menuVars, settingVars)
        return
    end
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil, "Standard") or needSVUpdate
    AddSeparator()
    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end
    startNextWindowNotCollapsed("SV Info")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)
    menuVars.settingVars = settingVars
    if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and settingVars.distanceMode == 2) then
        simpleActionMenu("Place SVs between selected notes##Exponential", 2, placeExponentialSpecialSVs, menuVars)
    else
        simpleActionMenu("Place SVs between selected notes", 2, placeSVs, menuVars)
    end
    simpleActionMenu("Place SSFs between selected notes", 2, placeSSFs, menuVars, true)
    cache.saveTable(currentSVType .. "StandardSettings", settingVars)
    cache.saveTable("placeStandardMenu", menuVars)
end
function placeStillSVMenu()
    PresetButton()
    local menuVars = getMenuVars("placeStill")
    local needSVUpdate = not truthy(menuVars.svMultipliers)
    needSVUpdate = chooseStandardSVType(menuVars, false) or needSVUpdate
    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, "Still")
    if globalVars.showPresetMenu then
        renderPresetMenu("Still", menuVars, settingVars)
        return
    end
    imgui.Text("Still Settings:")
    menuVars.noteSpacing = ComputableInputFloat("Note Spacing", menuVars.noteSpacing, 2, "x")
    menuVars.stillBehavior = Combo("Still Behavior", STILL_BEHAVIOR_TYPES, menuVars.stillBehavior, nil, nil,
        { "Apply the Still across the entire selected region.", "Apply the Stills across the selected note groups." })
    chooseStillType(menuVars)
    AddSeparator()
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil, "Still") or needSVUpdate
    AddSeparator()
    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end
    startNextWindowNotCollapsed("SV Info")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)
    menuVars.settingVars = settingVars
    simpleActionMenu("Place SVs between selected notes", 2, placeStillSVsParent, menuVars)
    cache.saveTable(currentSVType .. "StillSettings", settingVars)
    cache.saveTable("placeStillMenu", menuVars)
end
function customVibratoMenu(menuVars, settingVars, separateWindow)
    local typingCode = false
    if (menuVars.vibratoMode == 1) then
        typingCode = CodeInput(settingVars, "code", "##code",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        local func = eval(settingVars.code)
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, typingCode, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        typingCode = CodeInput(settingVars, "code1", "##code1",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        typingCode = CodeInput(settingVars, "code2", "##code2",
                "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.") or
            typingCode
        local func1 = eval(settingVars.code1)
        local func2 = eval(settingVars.code2)
        simpleActionMenu("Vibrate", 2, function(v)
            ssfVibrato(v, func1, func2)
        end, menuVars, false, typingCode, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    end
end
function exponentialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func = function(t)
            t = math.clamp(t, 0, 1)
            if curvature < 10 then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.endMsx * t +
                settingVars.startMsx * (1 - t)
        end
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func1 = function(t)
            t = math.clamp(t, 0, 1)
            if curvature < 10 then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            t = math.clamp(t, 0, 1)
            if curvature < 10 then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    end
end
function linearVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)
        local func = function(t)
            return settingVars.endMsx * t + settingVars.startMsx * (1 - t)
        end
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        local func1 = function(t)
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    end
end
VIBRATO_SVS = {
    "Linear##Vibrato",
    "Polynomial##Vibrato",
    "Exponential##Vibrato",
    "Sinusoidal##Vibrato",
    "Sigmoidal##Vibrato",
    "Custom##Vibrato"
}
function placeVibratoSVMenu(separateWindow)
    PresetButton()
    local menuVars = getMenuVars("placeVibrato", tostring(separateWindow))
    chooseVibratoSVType(menuVars)
    AddSeparator()
    imgui.Text("Vibrato Settings:")
    menuVars.vibratoMode = Combo("Vibrato Mode", VIBRATO_TYPES, menuVars.vibratoMode)
    chooseVibratoQuality(menuVars)
    if (menuVars.vibratoMode ~= 2) then
        chooseVibratoSides(menuVars)
    end
    local modeText = menuVars.vibratoMode == 1 and "SV" or "SSF"
    local currentSVType = VIBRATO_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType .. modeText,
        "Vibrato" .. tostring(separateWindow))
    if globalVars.showPresetMenu then
        renderPresetMenu("Vibrato", menuVars, settingVars)
        return
    end
    AddSeparator()
    if currentSVType == "Linear##Vibrato" then linearVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Polynomial##Vibrato" then polynomialVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Exponential##Vibrato" then exponentialVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Sinusoidal##Vibrato" then sinusoidalVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Sigmoidal##Vibrato" then sigmoidalVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Custom##Vibrato" then customVibratoMenu(menuVars, settingVars, separateWindow) end
    cache.saveTable(table.concat({ currentSVType, modeText, "Vibrato", tostring(separateWindow), "Settings" }),
        settingVars)
    cache.saveTable(table.concat({"placeVibrato", tostring(separateWindow), "Menu"}), menuVars)
end
function polynomialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Bounds##Vibrato", " msx", 0, 0.875)
        BasicInputInt(settingVars, "controlPointCount", "Control Points", { 1, 10 })
        AddSeparator()
        local size = 220
        PolynomialEditor(size, settingVars, separateWindow)
        local func = function(t)
            return (settingVars.startMsx - settingVars.endMsx) *
                (1 - math.clamp(math.evaluatePolynomial(settingVars.plotCoefficients, t * size) / size, 0, 1)) +
                settingVars.endMsx
        end
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        imgui.TextColored(color.vctr.red, "This mode is not supported.")
    end
end
function PolynomialEditor(size, settingVars, separateWindow)
    local pointList = {}
    local RESOLUTION = 44
    local changedControlCount = false
    while (settingVars.controlPointCount > #settingVars.controlPoints) do
        local points = table.duplicate(settingVars.controlPoints)
        table.insert(points, vector.New(math.random(), math.random()))
        settingVars.controlPoints = table.duplicate(points)
        changedControlCount = true
    end
    while (settingVars.controlPointCount < #settingVars.controlPoints) do
        table.remove(settingVars.controlPoints, #settingVars.controlPoints)
        changedControlCount = true
    end
    for _, point in pairs(settingVars.controlPoints) do
        table.insert(pointList,
            { pos = table.vectorize2(point) * vctr2(size), col = color.int.white, size = 5 })
    end
    imgui.SetCursorPosX(26)
    imgui.BeginChild("Polynomial Vibrato Interactive Window" .. tostring(separateWindow), vctr2(size), 67, 31)
    local ctx, changedPoints = renderGraph("Polynomial Vibrato Menu" .. tostring(separateWindow), vctr2(size),
        pointList, false, 11,
        vector.New(settingVars.startMsx, settingVars.endMsx))
    changedPoints = not truthy(settingVars.plotPoints) or changedPoints
    for i = 1, settingVars.controlPointCount do
        settingVars.controlPoints[i] = vector.Clamp(pointList[i].pos, vctr2(0), vctr2(size)) / vctr2(size)
    end
    if (changedPoints or changedControlCount) then
        plotPoints = {}
        local mtrx = {}
        local vctr = {}
        local pointCount = settingVars.controlPointCount
        for i, point in pairs(settingVars.controlPoints) do
            table.insert(mtrx, 1, {})
            for j = 1, pointCount do
                mtrx[1][#mtrx[1] + 1] = (point.x * size) ^ (pointCount - j)
            end
            table.insert(vctr, 1, size - point.y * size)
        end
        local sorted = false
        while (not sorted) do
            sorted = true
            for i = 1, #mtrx - 1 do
                if (mtrx[i][2] < mtrx[i + 1][2]) then
                    local tempRow = table.duplicate(mtrx[i])
                    mtrx[i] = table.duplicate(mtrx[i + 1])
                    mtrx[i + 1] = tempRow
                    local tempValue = vctr[i]
                    vctr[i] = vctr[i + 1]
                    vctr[i + 1] = tempValue
                    sorted = false
                end
            end
        end
        local coefficients = matrix.solve(mtrx, vctr) ---@cast coefficients number[]
        for i = 0, RESOLUTION do
            local x = i / RESOLUTION * size
            local y = size - math.clamp(math.evaluatePolynomial(coefficients, x), 0, size)
            table.insert(plotPoints, vector.New(x, y))
        end
        settingVars.plotPoints = table.duplicate(plotPoints)
        settingVars.plotCoefficients = table.duplicate(coefficients)
    end
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    for i = 1, #settingVars.plotPoints - 1 do
        local opacityFactor = 0.7 - math.sin(20 * i / #settingVars.plotPoints - clock.getTime() * 5) / 2
        ctx.AddLine(topLeft + settingVars.plotPoints[i],
            vector.Clamp(topLeft + settingVars.plotPoints[i + 1], topLeft, topLeft + dim - vctr2(1)),
            imgui.GetColorU32("PlotLines", opacityFactor), 3)
    end
    imgui.EndChild()
end
function sigmoidalVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 7 / 8)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func = function(t)
            t = math.clamp(t, 0, 1) * 2
            if curvature >= 1 then
                if t <= 1 then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if t <= 1 then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.startMsx + t * (settingVars.endMsx - settingVars.startMsx)
        end
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func1 = function(t)
            t = math.clamp(t, 0, 1) * 2
            if curvature >= 1 then
                if t <= 1 then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if t <= 1 then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            t = math.clamp(t, 0, 1) * 2
            if curvature >= 1 then
                if t <= 1 then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if t <= 1 then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    end
end
function sinusoidalVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)
        chooseMsxVerticalShift(settingVars, 0)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        local func = function(t)
            return math.sin(2 * math.pi * (settingVars.periods * t + settingVars.periodsShift)) * (settingVars.startMsx +
                t * (settingVars.endMsx - settingVars.startMsx)) + settingVars.verticalShift
        end
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseConstantShift(settingVars)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        _, settingVars.applyToHigher = imgui.Checkbox("Apply Vibrato to Higher SSF?", settingVars.applyToHigher)
        local func1 = function(t)
            return math.sin(2 * math.pi * (settingVars.periods * t + settingVars.periodsShift)) *
                (settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)) +
                settingVars.verticalShift
        end
        local func2 = function(t)
            if (settingVars.applyToHigher) then
                return math.sin(2 * math.pi * (settingVars.periods * t + settingVars.periodsShift)) *
                    (settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)) +
                    settingVars.verticalShift
            end
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[hotkeys_enum.exec_vibrato] or nil)
    end
end
function deleteTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    local menuVars = getMenuVars("delete")
    _, menuVars.deleteTable[1] = imgui.Checkbox("Delete Lines", menuVars.deleteTable[1])
    KeepSameLine()
    _, menuVars.deleteTable[2] = imgui.Checkbox("Delete SVs", menuVars.deleteTable[2])
    _, menuVars.deleteTable[3] = imgui.Checkbox("Delete SSFs", menuVars.deleteTable[3])
    imgui.SameLine(0, SAMELINE_SPACING + 3.5)
    _, menuVars.deleteTable[4] = imgui.Checkbox("Delete Bookmarks", menuVars.deleteTable[4])
    cache.saveTable("deleteMenu", menuVars)
    for i = 1, 4 do
        if (menuVars.deleteTable[i]) then
            simpleActionMenu("Delete items between selected notes", 2, deleteItems, menuVars)
            return
        end
    end
end
function addTeleportMenu()
    local menuVars = getMenuVars("addTeleport")
    addTeleportSettingsMenu(menuVars)
    cache.saveTable("addTeleportMenu", menuVars)
    simpleActionMenu("Add teleport SVs at selected notes", 1, addTeleportSVs, menuVars)
end
function addTeleportSettingsMenu(menuVars)
    chooseDistance(menuVars)
    BasicCheckbox(menuVars, "teleportBeforeHand", "Add teleport before note")
end
function changeGroupsMenu()
    local menuVars = getMenuVars("changeGroups")
    local action = changeGroupsSettingsMenu(menuVars)
    cache.saveTable("changeGroupsMenu", menuVars)
    simpleActionMenu(table.concat({ action, " items to ", menuVars.designatedTimingGroup }), 2, changeGroups, menuVars)
end
function changeGroupsSettingsMenu(menuVars)
    local action = menuVars.clone and "Clone" or "Move"
    imgui.AlignTextToFramePadding()
    menuVars.designatedTimingGroup = chooseTimingGroup(table.concat({ "  ", action, " to: " }),
        menuVars.designatedTimingGroup)
    _, menuVars.changeSVs = imgui.Checkbox("Change SVs?", menuVars.changeSVs)
    KeepSameLine()
    _, menuVars.changeSSFs = imgui.Checkbox("Change SSFs?", menuVars.changeSSFs)
    menuVars.clone = RadioButtons("Mode: ", menuVars.clone, { "Clone", "Move" }, { true, false })
    return action
end
function completeDuplicateMenu()
    local menuVars = getMenuVars("completeDuplicate")
    completeDuplicateSettingsMenu(menuVars)
    local copiedItemCount = #menuVars.objects
    if copiedItemCount == 0 then
        simpleActionMenu("Copy items between selected notes", 2, storeDuplicateItems, menuVars)
        cache.saveTable("completeDuplicateMenu", menuVars)
        return
    else
        FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearDuplicateItems, menuVars)
    end
    simpleActionMenu("Paste items at selected notes", 1, placeDuplicateItems, menuVars)
    cache.saveTable("completeDuplicateMenu", menuVars)
end
function completeDuplicateSettingsMenu(menuVars)
    BasicCheckbox(menuVars, "dontCloneHos", "Don't Clone Notes",
        "If true, will not copy notes during the complete duplicate process.")
end
function convertSVSSFMenu()
    local menuVars = getMenuVars("convertSVSSF")
    convertSVSSFSettingsMenu(menuVars)
    cache.saveTable("convertSVSSFMenu", menuVars)
    simpleActionMenu(menuVars.conversionDirection and "Convert SVs -> SSFs" or "Convert SSFs -> SVs", 2, convertSVSSF,
        menuVars, false, false)
    simpleActionMenu("Swap SVs <-> SSFs", 2, swapSVSSF,
        nil, true, true)
end
function convertSVSSFSettingsMenu(menuVars)
    chooseConvertSVSSFDirection(menuVars)
end
function copyNPasteMenu()
    local menuVars = getMenuVars("copyPaste")
    local copiedItemCount = copyNPasteSettingsMenu(menuVars, true)
    cache.saveTable("copyPasteMenu", menuVars)
    if not truthy(copiedItemCount) then return end
    simpleActionMenu("Paste items at selected notes", 1, pasteItems, menuVars)
end
function copyNPasteSettingsMenu(menuVars, actionable)
    _, menuVars.copyLines = imgui.Checkbox("Copy Lines", menuVars.copyLines)
    KeepSameLine()
    _, menuVars.copySVs = imgui.Checkbox("Copy SVs", menuVars.copySVs)
    _, menuVars.copySSFs = imgui.Checkbox("Copy SSFs", menuVars.copySSFs)
    imgui.SameLine(0, SAMELINE_SPACING + 3.5)
    _, menuVars.copyBMs = imgui.Checkbox("Copy Bookmarks", menuVars.copyBMs)
    AddSeparator()
    if actionable then BasicInputInt(menuVars, "curSlot", "Current slot", { 1, 999 }) end
    if (actionable and #menuVars.copied.lines < menuVars.curSlot) then
        local newCopied = table.duplicate(menuVars.copied)
        while #newCopied.lines < menuVars.curSlot do
            table.insert(newCopied.lines, {})
            table.insert(newCopied.SVs, {})
            table.insert(newCopied.SSFs, {})
            table.insert(newCopied.BMs, {})
        end
        menuVars.copied = newCopied
    end
    if actionable then AddSeparator() end
    local copiedItemCount = #menuVars.copied.lines[menuVars.curSlot] + #menuVars.copied.SVs[menuVars.curSlot] +
        #menuVars.copied.SSFs[menuVars.curSlot] + #menuVars.copied.BMs[menuVars.curSlot]
    if actionable then
        if not truthy(copiedItemCount) then
            simpleActionMenu("Copy items between selected notes", 2, copyItems, menuVars)
        else
            FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearCopiedItems, menuVars)
        end
    end
    if (not truthy(copiedItemCount) and actionable) then return copiedItemCount end
    if actionable then AddSeparator() end
    _, menuVars.tryAlign = imgui.Checkbox("Try to fix misalignments", menuVars.tryAlign)
    imgui.PushItemWidth(100)
    _, menuVars.alignWindow = imgui.SliderInt("Alignment window (ms)", menuVars.alignWindow, 1, 10)
    menuVars.alignWindow = math.clamp(menuVars.alignWindow, 1, 10)
    imgui.PopItemWidth()
    return copiedItemCount
end
function updateDirectEdit()
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets) and not truthy(state.GetValue("lists.directSVList"))) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    if (not truthy(offsets)) then
        state.SetValue("lists.directSVList", {})
        return
    end
    state.SetValue("lists.directSVList", game.getSVsBetweenOffsets(firstOffset - 50, lastOffset + 50))
end
function directSVMenu()
    local menuVars = getMenuVars("directSV")
    if (clock.listen("directSV", 300)) then
        updateDirectEdit()
    end
    local svs = state.GetValue("lists.directSVList") or {}
    if (not truthy(svs)) then
        menuVars.selectableIndex = 1
        if (not truthy(state.SelectedHitObjects)) then
            imgui.TextWrapped("Select a note to view local SVs.")
        else
            imgui
                .TextWrapped("There are no SVs in this area.")
        end
        return
    end
    if (menuVars.selectableIndex > #svs) then menuVars.selectableIndex = #svs end
    _, menuVars.startTime = imgui.InputFloat("Start Time", svs[menuVars.selectableIndex].StartTime)
    if (imgui.IsItemDeactivatedAfterEdit()) then
        actions.PerformBatch({ createEA(action_type.RemoveScrollVelocity, svs[menuVars.selectableIndex]),
            createEA(action_type.AddScrollVelocity, createSV(menuVars.startTime or 0, menuVars.multiplier)) })
    end
    _, menuVars.multiplier = imgui.InputFloat("Multiplier", svs[menuVars.selectableIndex].Multiplier)
    if (imgui.IsItemDeactivatedAfterEdit()) then
        actions.PerformBatch({ createEA(action_type.RemoveScrollVelocity, svs[menuVars.selectableIndex]),
            createEA(action_type.AddScrollVelocity, createSV(menuVars.startTime, menuVars.multiplier or 1)) })
    end
    imgui.Separator()
    if (imgui.ArrowButton("##DirectSVLeft", imgui_dir.Left)) then
        menuVars.pageNumber = math.clamp(menuVars.pageNumber - 1, 1, math.ceil(#svs * 0.1))
    end
    KeepSameLine()
    imgui.Text("Page ")
    KeepSameLine()
    imgui.SetNextItemWidth(100)
    _, menuVars.pageNumber = imgui.InputInt("##PageNum", math.clamp(menuVars.pageNumber, 1, math.ceil(#svs * 0.1)), 0)
    KeepSameLine()
    imgui.Text(" of " .. math.ceil(#svs * 0.1))
    KeepSameLine()
    if (imgui.ArrowButton("##DirectSVRight", imgui_dir.Right)) then
        menuVars.pageNumber = math.clamp(menuVars.pageNumber + 1, 1, math.ceil(#svs * 0.1))
    end
    imgui.Separator()
    imgui.Text("Start Time")
    KeepSameLine()
    imgui.SetCursorPosX(150)
    imgui.Text("Multiplier")
    imgui.Separator()
    local startingPoint = 10 * menuVars.pageNumber - 10
    imgui.BeginTable("Test", 2)
    for idx, v in pairs(table.slice(svs, startingPoint + 1, startingPoint + 10)) do
        imgui.PushID(idx)
        imgui.TableNextRow()
        imgui.TableSetColumnIndex(0)
        imgui.Selectable(tostring(math.round(v.StartTime, 2)), menuVars.selectableIndex == idx,
            imgui_selectable_flags.SpanAllColumns)
        if (imgui.IsItemClicked()) then
            menuVars.selectableIndex = idx + startingPoint
        end
        imgui.TableSetColumnIndex(1)
        imgui.SetCursorPosX(150)
        imgui.Text(tostring(math.round(v.Multiplier, 2)));
        imgui.PopID()
    end
    imgui.EndTable()
    cache.saveTable("directSVMenu", menuVars)
end
function displaceNoteMenu()
    local menuVars = getMenuVars("displaceNote")
    displaceNoteSettingsMenu(menuVars)
    cache.saveTable("displaceNoteMenu", menuVars)
    simpleActionMenu("Displace selected notes", 1, displaceNoteSVsParent, menuVars)
end
function displaceNoteSettingsMenu(menuVars)
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
end
function displaceViewMenu()
    local menuVars = getMenuVars("displaceView")
    displaceViewSettingsMenu(menuVars)
    cache.saveTable("displaceViewMenu", menuVars)
    simpleActionMenu("Displace view between selected notes", 2, displaceViewSVs, menuVars)
end
function displaceViewSettingsMenu(menuVars)
    chooseDistance(menuVars)
end
function dynamicScaleMenu()
    local menuVars = getMenuVars("dynamicScale")
    local numNoteTimes = #menuVars.noteTimes
    imgui.Text(#menuVars.noteTimes .. " note times assigned to scale SVs between")
    addNoteTimesToDynamicScaleButton(menuVars)
    if numNoteTimes == 0 then
        cache.saveTable("dynamicScaleMenu", menuVars)
        return
    else
        clearNoteTimesButton(menuVars)
    end
    AddSeparator()
    if #menuVars.noteTimes < 3 then
        imgui.Text("Not enough note times assigned")
        imgui.Text("Assign 3 or more note times instead")
        cache.saveTable("dynamicScaleMenu", menuVars)
        return
    end
    local numSVPoints = numNoteTimes - 1
    local needSVUpdate = not truthy(menuVars.svMultipliers) or (#menuVars.svMultipliers ~= numSVPoints)
    imgui.AlignTextToFramePadding()
    imgui.Text("Shape:")
    KeepSameLine()
    needSVUpdate = chooseStandardSVType(menuVars, true) or needSVUpdate
    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    if currentSVType == "Sinusoidal" then
        imgui.Text("Import sinusoidal values using 'Custom' instead")
        cache.saveTable("dynamicScaleMenu", menuVars)
        return
    end
    local settingVars = getSettingVars(currentSVType, "DynamicScale")
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, true, numSVPoints, "DynamicScale") or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, true) end
    startNextWindowNotCollapsed("SV Info")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, true)
    local labelText = currentSVType .. "DynamicScale"
    cache.saveTable(currentSVType .. "DynamicScaleSettings", settingVars)
    cache.saveTable("dynamicScaleMenu", menuVars)
    simpleActionMenu("Scale spacing between assigned notes", 0, dynamicScaleSVs, menuVars)
end
function clearNoteTimesButton(menuVars)
    if not imgui.Button("Clear all assigned note times", BEEG_BUTTON_SIZE) then return end
    menuVars.noteTimes = {}
end
function addNoteTimesToDynamicScaleButton(menuVars)
    local buttonText = "Assign selected note times"
    FunctionButton(buttonText, ACTION_BUTTON_SIZE, addSelectedNoteTimesToList, menuVars)
end
function flickerMenu()
    local menuVars = getMenuVars("flicker")
    flickerSettingsMenu(menuVars)
    cache.saveTable("flickerMenu", menuVars)
    simpleActionMenu("Add flicker SVs between selected notes", 2, flickerSVs, menuVars)
end
function flickerSettingsMenu(menuVars)
    menuVars.flickerTypeIndex = Combo("Flicker Type", FLICKER_TYPES, menuVars.flickerTypeIndex)
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
    BasicInputInt(menuVars, "numFlickers", "Flickers", { 1, 9999 })
    if (globalVars.advancedMode) then chooseFlickerPosition(menuVars) end
end
function layerSnapMenu()
    simpleActionMenu("Layer snaps throughout map", 0, layerSnaps, nil, true, true)
    AddSeparator()
    simpleActionMenu("Collapse snap layers", 0, collapseSnaps, nil, true, true)
    simpleActionMenu("Clear unused snap layers", 0, clearSnappedLayers, nil, true, true)
end
function lintMapMenu()
    simpleActionMenu("Align timing lines in this region", 0, alignTimingLines, nil, true, true)
    HoverToolTip(
        "Sometimes, due to rounding errors with BPMs, timing lines don't show up where 1/1 snapped notes should be. This will fix that within the entire timing line region you are currently in.")
    AddSeparator()
    simpleActionMenu("Fix flipped LN ends", 0, fixFlippedLNEnds, nil, true, true)
    HoverToolTip(
        "If there is a negative SV at an LN end, the LN end will be flipped. This is noticable especially for arrow skins and is jarring. This tool will fix that.")
    simpleActionMenu("Merge duplicate SVs", 0, mergeSVs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) removes SVs that are on the same time as others. Note that Quaver always renders the second SV in the internal SV list, and this tool will only ever remove the first duplicate SV, so nothing in the map should change. If something does change, please message @kvrosakura on Discord with the map.")
    simpleActionMenu("Merge duplicate SSFs", 0, mergeSSFs, nil, true, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) removes SSFs that are on the same time as others. Note that Quaver always renders the second SSF in the internal SSF list, and this tool will only ever remove the first duplicate SSF, so nothing in the map should change. If something does change, please message @kvrosakura on Discord with the map.")
    simpleActionMenu("Remove unnecessary SVs", 0, removeUnnecessarySVs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) If two consecutive SVs have the same multiplier, removes the second SV.")
    simpleActionMenu("Remove duplicate notes", 0, mergeNotes, nil, true, true)
    HoverToolTip("Removes stacked notes.")
    simpleActionMenu("Remove all hitsounds", 0, removeAllHitSounds, nil, true, true)
    HoverToolTip("Self-explanatory.")
end
EDIT_SV_TOOLS = {
    "Add Teleport",
    "Change Groups",
    "Complete Duplicate",
    "Convert SV <-> SSF",
    "Copy & Paste",
    "Direct SV",
    "Displace Note",
    "Displace View",
    "Dynamic Scale",
    "Flicker",
    "Layer Snaps",
    "Lint Map",
    "Measure",
    "Reverse Scroll",
    "Scale (Displace)",
    "Scale (Multiply)",
    "Split",
    "Swap Notes",
    "Vertical Shift"
}
function editSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    local changedTool = chooseEditTool()
    if changedTool then state.SetValue("global.editToolIndex", globalVars.editToolIndex) end
    AddSeparator()
    local toolName = EDIT_SV_TOOLS[globalVars.editToolIndex]
    if toolName == "Add Teleport" then addTeleportMenu() end
    if toolName == "Change Groups" then changeGroupsMenu() end
    if toolName == "Complete Duplicate" then completeDuplicateMenu() end
    if toolName == "Convert SV <-> SSF" then convertSVSSFMenu() end
    if toolName == "Copy & Paste" then copyNPasteMenu() end
    if toolName == "Direct SV" then directSVMenu() end
    if toolName == "Displace Note" then displaceNoteMenu() end
    if toolName == "Displace View" then displaceViewMenu() end
    if toolName == "Dynamic Scale" then dynamicScaleMenu() end
    if toolName == "Flicker" then flickerMenu() end
    if toolName == "Layer Snaps" then layerSnapMenu() end
    if toolName == "Lint Map" then lintMapMenu() end
    if toolName == "Measure" then measureMenu() end
    if toolName == "Reverse Scroll" then reverseScrollMenu() end
    if toolName == "Scale (Displace)" then scaleDisplaceMenu() end
    if toolName == "Scale (Multiply)" then scaleMultiplyMenu() end
    if toolName == "Split" then splitMenu() end
    if toolName == "Swap Notes" then swapNotesMenu() end
    if toolName == "Vertical Shift" then verticalShiftMenu() end
end
function chooseEditTool()
    local tooltipList = {
        "Add a large teleport SV to move far away.",
        "Moves SVs and SSFs to a designated timing group.",
        "Convert multipliers between SV/SSF.",
        "Completely copy a section of your map and put it somewhere else.",
        "Copy SVs and SSFs and paste them somewhere else.",
        "Directly update SVs within your selection.",
        "Move where notes are hit on the screen.",
        "Temporarily displace the playfield view.",
        "Dynamically scale SVs across notes.",
        "Flash notes on and off the screen.",
        "Transfer snap colors into layers, to be loaded later.",
        "Polish your map with these set of tools.",
        "Get stats about SVs in a section.",
        "Reverse the scroll direction using SVs.",
        "Scale SV values by adding teleport SVs.",
        "Scale SV values by multiplying.",
        "Split notes into different timing groups for finer control.",
        "Swap positions of notes using SVs.",
        "Adds a constant value to SVs in a range.",
    }
    imgui.AlignTextToFramePadding()
    imgui.Text("  Current Tool:")
    KeepSameLine()
    local oldEditToolIndex = globalVars.editToolIndex
    globalVars.editToolIndex = Combo("##edittool", EDIT_SV_TOOLS, oldEditToolIndex, nil, nil, tooltipList)
    HoverToolTip(tooltipList[globalVars.editToolIndex])
    return oldEditToolIndex ~= globalVars.editToolIndex
end
function measureMenu()
    local menuVars = getMenuVars("measure")
    menuVars.unrounded = RadioButtons("View values:", menuVars.unrounded, { "Rounded", "Unrounded" }, { false, true })
    AddSeparator()
    if menuVars.unrounded then
        displayMeasuredStatsUnrounded(menuVars)
    else
        displayMeasuredStatsRounded(menuVars)
    end
    AddPadding()
    imgui.TextDisabled("*** Measuring disclaimer ***")
    HoverToolTip("Measured values might not be 100%% accurate & may not work on older maps")
    simpleActionMenu("Measure SVs between selected notes", 2, measureSVs, menuVars)
    cache.saveTable("measureMenu", menuVars)
end
function displayMeasuredStatsRounded(menuVars)
    imgui.Columns(2, "Measured SV Stats", false)
    imgui.Text("NSV distance:")
    imgui.Text("SV distance:")
    imgui.Text("Average SV:")
    imgui.Text("Start displacement:")
    imgui.Text("End displacement:")
    imgui.Text("True average SV:")
    imgui.NextColumn()
    imgui.Text(menuVars.roundedNSVDistance .. " msx")
    HelpMarker("The normal distance between the start and the end, ignoring SVs")
    imgui.Text(menuVars.roundedSVDistance .. " msx")
    HelpMarker("The actual distance between the start and the end, calculated with SVs")
    imgui.Text(menuVars.roundedAvgSV .. "x")
    imgui.Text(menuVars.roundedStartDisplacement .. " msx")
    HelpMarker("Calculated using plumoguSV displacement metrics, so might not always work")
    imgui.Text(menuVars.roundedEndDisplacement .. " msx")
    HelpMarker("Calculated using plumoguSV displacement metrics, so might not always work")
    imgui.Text(menuVars.roundedAvgSVDisplaceless .. "x")
    HelpMarker("Average SV calculated ignoring the start and end displacement")
    imgui.Columns(1)
end
function displayMeasuredStatsUnrounded(menuVars)
    CopiableBox("NSV distance", "##nsvDistance", menuVars.nsvDistance)
    CopiableBox("SV distance", "##svDistance", menuVars.svDistance)
    CopiableBox("Average SV", "##avgSV", menuVars.avgSV)
    CopiableBox("Start displacement", "##startDisplacement", menuVars.startDisplacement)
    CopiableBox("End displacement", "##endDisplacement", menuVars.endDisplacement)
    CopiableBox("True average SV", "##avgSVDisplaceless", menuVars.avgSVDisplaceless)
end
function CopiableBox(text, label, content)
    imgui.TextWrapped(text)
    imgui.PushItemWidth(imgui.GetContentRegionAvailWidth())
    imgui.InputText(label, content, #content, imgui_input_text_flags.AutoSelectAll)
    imgui.PopItemWidth()
    AddPadding()
end
function reverseScrollMenu()
    local menuVars = getMenuVars("reverseScroll")
    reverseScrollSettingsMenu(menuVars)
    cache.saveTable("reverseScrollMenu", menuVars)
    simpleActionMenu("Reverse scroll between selected notes", 2, reverseScrollSVs, menuVars)
end
function reverseScrollSettingsMenu(menuVars)
    chooseDistance(menuVars)
    HelpMarker("Height at which reverse scroll notes are hit")
end
function scaleDisplaceMenu()
    local menuVars = getMenuVars("scaleDisplace")
    scaleDisplaceSettingsMenu(menuVars)
    cache.saveTable("scaleDisplaceMenu", menuVars)
    simpleActionMenu("Scale SVs between selected notes##displace", 2, scaleDisplaceSVs, menuVars)
end
function scaleMultiplyMenu()
    local menuVars = getMenuVars("scaleMultiply")
    scaleMultiplySettingsMenu(menuVars)
    cache.saveTable("scaleMultiplyMenu", menuVars)
    simpleActionMenu("Scale SVs between selected notes##multiply", 2, scaleMultiplySVs, menuVars)
end
function scaleDisplaceSettingsMenu(menuVars)
    menuVars.scaleSpotIndex = Combo("Displace Spot", DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
    scaleMultiplySettingsMenu(menuVars)
end
function scaleMultiplySettingsMenu(menuVars)
    chooseScaleType(menuVars)
end
function splitMenu()
    local menuVars = getMenuVars("split")
    splitSettingsMenu(menuVars)
    cache.saveTable("splitMenu", menuVars)
    simpleActionMenu("Split selected notes into TGs", 1, splitNotes, menuVars, false)
end
function splitSettingsMenu(menuVars)
    menuVars.modeIndex = Combo("Split Mode", SPLIT_MODES, menuVars.modeIndex, nil, nil, {
        "Split notes via column; either with individual TGs or a certain transformation of such columns.",
        "Split notes via time; each time has its own TG.",
        "Split all notes into their own TG regardless of any properties they have."
    })
    BasicCheckbox(menuVars, "cloneSVs", "Clone SVs?",
        "If enabled, each note will clone the SVs around it in the current timing group.")
    if (menuVars.cloneSVs) then
        BasicInputInt(menuVars, "cloneRadius", "Clone Radius", { 0, 69420 },
            "SVs that are further than THIS amount of ms away will be ignored.")
    end
end
function swapNotesMenu()
    imgui.TextWrapped("Doesn't swap note temporal positions; instead, swaps their spatial positions with two displaces.")
    simpleActionMenu("Swap selected notes using SVs", 2, swapNoteSVs, nil)
end
function verticalShiftMenu()
    local menuVars = getMenuVars("verticalShift")
    verticalShiftSettingsMenu(menuVars)
    cache.saveTable("verticalShiftMenu", menuVars)
    simpleActionMenu("Vertically shift SVs between selected notes", 2, verticalShiftSVs, menuVars)
end
function verticalShiftSettingsMenu(menuVars)
    chooseConstantShift(menuVars, 0)
end
function infoTab()
    imgui.SeparatorText("Welcome to plumoguSV!")
    imgui.TextWrapped("This plugin is your one-stop shop for all of \nyour SV needs. Using it is quick and easy:")
    AddPadding()
    imgui.BulletText("Choose an SV tool in the Create tab.")
    imgui.BulletText("Adjust the tool's settings to your liking.")
    imgui.BulletText("Select notes to use the tool at.")
    imgui.BulletText(table.concat({"Press the '", globalVars.hotkeyList[hotkeys_enum.exec_primary], "' hotkey."}))
    AddPadding()
    imgui.SeparatorText("Special thanks to:")
    AddPadding()
    imgui.BulletText("kloi34, for being the original dev.")
    imgui.BulletText("kusa, for some handy widgets.")
    imgui.BulletText("7xbi + nethen for some useful PRs.")
    imgui.BulletText("Emik + William for plugin help.")
    imgui.BulletText("ESV members for constant support.")
    imgui.Dummy(vctr2(10))
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 153) / 2)
    imgui.Text("If you enjoy using this plugin,")
    imgui.SetCursorPosX((imgui.GetWindowWidth() - 172) / 2)
    imgui.Text("consider supporting me on")
    imgui.SameLine(0, 3)
    imgui.TextLinkOpenURL("ko-fi!", "https://ko-fi.com/plummyyummy")
    imgui.Dummy(vctr2(10))
    if (imgui.Button("Edit Settings", HALF_ACTION_BUTTON_SIZE)) then
        state.SetValue("windows.showSettingsWindow", not state.GetValue("windows.showSettingsWindow"))
        local coordinatesToCenter = game.window.getCenter() - vector.New(216.5, 200)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
    HoverToolTip("Edit various functions of the plugin, such as the appearance or internal calculations.")
    KeepSameLine()
    if (imgui.Button("See Patch Notes", HALF_ACTION_BUTTON_SIZE)) then
        state.SetValue("windows.showPatchNotesWindow", not state.GetValue("windows.showPatchNotesWindow"))
        local coordinatesToCenter = game.window.getCenter() - vector.New(300, 250)
        imgui.SetWindowPos("plumoguSV Patch Notes", coordinatesToCenter)
    end
    HoverToolTip("Keep up with the progress of plumoguSV, and see what the newest updates have in store for you.")
    if (imgui.Button("Get Map Stats", HALF_ACTION_BUTTON_SIZE)) then
        getMapStats()
    end
    HoverToolTip("A quick and easy way to view SV/SSF counts and some other minute pieces of data.")
    KeepSameLine()
    if (imgui.Button("View Tutorials", HALF_ACTION_BUTTON_SIZE)) then
        state.SetValue("windows.showTutorialWindow", not state.GetValue("windows.showTutorialWindow"))
        local coordinatesToCenter = game.window.getCenter() - vector.New(300, 250)
        imgui.SetWindowPos("plumoguSV Tutorial Menu", coordinatesToCenter)
    end
    HoverToolTip("New to SV? View interactive tutorials that will help you navigate the plugin for your first time.")
end
---@diagnostic disable: redefined-local
function showPatchNotesWindow()
    startNextWindowNotCollapsed("plumoguSV Patch Notes")
    _, patchNotesOpened = imgui.Begin("plumoguSV Patch Notes", true, imgui_window_flags.NoResize)
    imgui.SetWindowSize("plumoguSV Patch Notes", vector.New(500, 400))
    imgui.PushStyleColor(imgui_col.Separator, color.int.white - color.int.alphaMask * 200)
    local minHeight = imgui.GetWindowPos().y
    local maxHeight = minHeight + 400
    if (not patchNotesOpened) then
        state.SetValue("windows.showPatchNotesWindow", false)
    end
    imgui.BeginChild("v2.0.1Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip201 end
    if (topLeft.y - minHeight < -50) then goto skip201 end
    drawV201(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 137 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 137 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip201::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fixed individual combo settings being able to be saved.")
    imgui.BulletText("Fixed loadup text color not being properly used in the custom theme.")
    imgui.BulletText("Changed the barbie theme to be less obnoxious.")
    imgui.BulletText("Fixed themes not exporting loadup parameters correctly.")
    imgui.BulletText("Changed some backend features to prevent bugs in the future.")
    imgui.BulletText('Moved some settings to the new "Advanced" section.')
    imgui.BulletText('Fixed performance mode not delaying HitObject refresh.')
    imgui.BulletText('Fixed stutter linear interpolation crashing the plugin.')
    imgui.BulletText('Now successfully hot-reloads menu data.')
    imgui.BulletText('Fixed Select > Alternating offset bug.')
    imgui.BulletText('Fixed loadup animation playing after delay even when it was disabled.')
    imgui.SeparatorText("New Features")
    imgui.BulletText('Now allows you to change the default displacement exponential multiplier.')
    imgui.BulletText('Added a setting which unrestricts sinusoidal period.')
    imgui.BulletText('Added mines to the Select > Note Type feature (canary only).')
    imgui.BulletText('Added a small gradient in the background to enhance appearance.')
    AddPadding()
    imgui.BeginChild("v2.0.0Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip200 end
    if (topLeft.y - minHeight < -50) then goto skip200 end
    drawV200(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 144 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 144 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip200::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fixed not being able to properly store some cursor trail parameters.")
    imgui.BulletText("Fixed start/end expo using incorrect algorithm.")
    imgui.BulletText("Fixed all bugs relating to automate.")
    imgui.BulletText("Removed v1.1.2 temporary bug fix.")
    imgui.BulletText("Fix direct SV pagination not working correctly.")
    imgui.BulletText("Fixed flicker percentage not accurately converting to map.")
    imgui.BulletText("Fixed align timing lines not being deterministic.")
    imgui.BulletText("Fixed suffix of computableInputFloat.")
    imgui.BulletText("Fixed inconsistency of negative/positive SV generation.")
    imgui.BulletText("Fixed getRemovableSVs to use tolerance.")
    imgui.BulletText("Fixed the builder not properly nesting files.")
    imgui.BulletText("Fixed stills placing duplicate SVs.")
    imgui.BulletText("Fixed internal documentation being incorrect and generally poor.")
    imgui.BulletText("Fixed several overlapping SV issues.")
    imgui.BulletText("Fixed hypothetical SVs using some weird BS.")
    imgui.BulletText("Removed splitscroll in favor of using TGs.")
    imgui.BulletText("Fixed TG selector being unable to properly select some TGs.")
    imgui.BulletText("Fixed TG selector not always being fully in-sync with the game.")
    imgui.BulletText("Fixed automate altering SV post-effect.")
    imgui.BulletText("Fixed 2-side vibrato inaccuracy.")
    imgui.BulletText("Fixed build script to use correct regex.")
    imgui.BulletText("Fixed cursor trail being broken.")
    imgui.BulletText("Fixed hotkey settings window having overlapping text.")
    imgui.BulletText("Fixed global vars being unable to default to true.")
    imgui.BulletText("Moved workspace settings to .luarc file.")
    imgui.BulletText("Cached variables are properly reloaded during hot-reload.")
    imgui.BulletText("Fixed bug where hot-reloading would crash the game.")
    imgui.BulletText("Fixed starting fresh plugin with no config.yaml breaking style.")
    imgui.BulletText("Fixed bug where string ending of pluralized content\ncarried over between function calls.")
    imgui.BulletText("Fixed vibrato placing duplicate SVs.")
    imgui.BulletText("Fixed still per note group finally.")
    imgui.BulletText("Now properly instantiates pulse color.")
    imgui.BulletText("Fixed relative ratio not saving.")
    imgui.BulletText("Fixed Still per note group displacements, and enabled auto/otua on the \naforementioned feature.")
    imgui.BulletText("Fixed Select Bookmark crashing the game.")
    imgui.BulletText("Fixed Select Bookmark text going off the screen.")
    imgui.BulletText(
        "Fixed measure msx widget not rendering in real time, and not\nproperly recalculating distances when switching TGs.")
    imgui.BulletText("Fixed bug where saving a false setting wouldn't save it at all.")
    imgui.BulletText(
        "Fixed bug with certain functions where LN ends would not be\nconsidered if their start wasn't within the selection.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added tooltips to various functions to explain their functionality.")
    imgui.BulletText("New border pulse feature that pulses along with the beat.")
    imgui.BulletText("Added a new hotkey to select the TG of note(s).")
    imgui.BulletText("New menu: Edit > Convert SV <-> SSF; Self-explanatory.")
    imgui.BulletText(
        "Added vibrato to plumoguSV, with less error than AFFINE. Includes linear,\npolynomial, exponential, sinusoidal, and sigmoidal shapes. Includes presets for FPS.")
    imgui.BulletText("Include code-based SV/SSF fast place.")
    imgui.BulletText("New settings menu with many more customizable features.")
    imgui.BulletText("Allow defaults to be edited.")
    imgui.BulletText("Include some new automate parameters for further customization.")
    imgui.BulletText("Edit > Layer Snaps feature: Save your snap colors before using AFFINE to\nbring them back easily.")
    imgui.BulletText("Edit > Split feature: Split notes into different TGs with the\nsurrounding SVs in one click.")
    imgui.BulletText("Added linear equalizer to allow you to create 0x SV on linear much easier.")
    imgui.BulletText("Added custom theme input, along with exporting/importing.")
    imgui.BulletText("Added 3 custom reactive backgrounds. More will be added\nwhen the kofi products are paid for.")
    imgui.BulletText("Added copy paste slots; now you can copy paste more than one thing at once.")
    imgui.BulletText("Allow border pulse to be custom.")
    imgui.BulletText(
        "Note lock feature: you don't need to worry about accidentally placing,\nmoving, or deleting notes during SV generation.")
    imgui.BulletText("Now allows certain inputs to be computed automatically on the backend.")
    imgui.BulletText("A new performance mode to speed up the FPS by 2-3x.")
    imgui.BulletText("You can now merge SSFs to eliminate duped ones.")
    imgui.BulletText("Added new option to allow combo-select.")
    imgui.BulletText("New toggleable SV Info visualizer for the more inexperienced mappers.")
    imgui.BulletText("Reworked bezier menu to be much more intuitive.")
    imgui.BulletText("Added loadup animation because why not.")
    imgui.BulletText("Added patch notes page.")
    imgui.BulletText("Added map stats button to quickly grab SV and SSF count.")
    imgui.BulletText("Added pagination to bookmarks.")
    imgui.BulletText("Now allowed Direct SV to view SVs around a particular note.")
    imgui.BulletText("Moved many linting features to Edit > Lint Map.")
    imgui.BulletText("Added new feature to remove duplicated notes.")
    imgui.BulletText(
        "Added new feature to remove hitsounds, for mappers who don't use\nthem but accidentally click on the menu.")
    imgui.BulletText("Added a very rudimentary preset system, so you can send menu data to others.")
    imgui.BulletText("Added a button to directly swap SVs and SSFs.")
    imgui.BulletText("Added a startup animation.")
    imgui.BulletText("Added hotkeys to switch between TGs.")
    imgui.BulletText("Added hotkey to move all selected notes to the selected TG.")
    AddPadding()
    imgui.BeginChild("v1.1.2Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip112 end
    if (topLeft.y - minHeight < -50) then goto skip112 end
    drawV112(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 127 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 127 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip112::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fixed stills placing duplicate SVs that changed order when called.")
    imgui.BulletText("Fixed stills removing non-existent SVs.")
    imgui.BulletText("Fixed copy/paste priority problems.")
    imgui.BulletText("Fixed plugin TG selector overriding editor TG selector.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Now stores settings so you don't have to edit the plugin file to save them.")
    imgui.BulletText("Added step size to the exponential intensity bar.")
    imgui.BulletText("Distance fields now allow mathematical expressions\nthat are automatically evaluated.")
    imgui.BulletText("Created a new advanced mode, which disabling causes less clutter.")
    imgui.BulletText("Created Edit > Direct SV, an easier way to edit SVs directly within your selection.")
    imgui.BulletText("Added colors to the TG selector to easily distinguish groups.")
    AddPadding()
    imgui.BeginChild("v1.1.1Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    drawV111(ctx, topLeft + vector.New(238, 17), 1, color.int.white, 1)
    if (topLeft.y - maxHeight > 0) then goto skip111 end
    if (topLeft.y - minHeight < -50) then goto skip111 end
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 111 / 2 - 15, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 111 / 2 + 15, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip111::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fixed more bugs involving stills.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added a new hotkey to quickly place SSFs.")
    imgui.BulletText("Added a new TG selector.")
    AddPadding()
    imgui.BeginChild("v1.1.0Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip110 end
    if (topLeft.y - minHeight < -50) then goto skip110 end
    drawV110(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 129 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 129 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip110::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fixed issues where stills would incorrectly displace notes.")
    imgui.BulletText("Fixed swap/negate buttons not working properly.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added Select by Chord Size.")
    imgui.BulletText("Now allows displace note/flicker to be linearly interpolated.")
    imgui.BulletText("Stills now only require one undo instead of two.")
    imgui.BulletText("New Still mode: still per note group, which drastically speeds up still production.")
    imgui.BulletText("Two new exponential modes: start/end and distance-based algorithms.")
    imgui.BulletText("Added hotkeys to quickly swap, negate, and reset certain parameters.")
    imgui.BulletText("Added notifications to all features.")
    imgui.BulletText("Copy and paste now supports bookmarks and timing lines.")
    imgui.BulletText("New setting was added to allow you to ignore notes outside the current TG.")
    AddPadding()
    imgui.BeginChild("v1.0.1Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip101 end
    if (topLeft.y - minHeight < -50) then goto skip101 end
    drawV101(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 125 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 125 / 2 + 12.5, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip101::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fixed game occasionally crashing when using the Select tab.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added Select Bookmark feature (from BookmarkLeaper).")
    imgui.BulletText("Added Edit > Align Timing Lines feature (from SmartAlign).")
    imgui.BulletText("Added notifications for more features when executed.")
    imgui.BulletText("Added tooltips for Select features and swap/negate buttons.")
    imgui.BulletText("Changed the Delete menu to allow deleting SVs or SSFs.")
    AddPadding()
    imgui.BeginChild("v1.0.0Bezier", vector.New(486, 48), 2, 3)
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    if (topLeft.y - maxHeight > 0) then goto skip100 end
    if (topLeft.y - minHeight < -50) then goto skip100 end
    drawV100(ctx, topLeft + vector.New(243, 17), 1, color.int.white, 1)
    ctx.AddRect(topLeft + vector.New(0, 25), topLeft + vector.New(243 - 137 / 2 - 10, 28), color.int.white)
    ctx.AddRect(topLeft + vector.New(243 + 137 / 2 + 10, 25), topLeft + vector.New(486, 28), color.int.white)
    ::skip100::
    imgui.EndChild()
    imgui.SeparatorText("Bug Fixes / Minor Changes")
    imgui.BulletText("Fix LN Ends feature now flips LN ends, even if the corresponding ending SV is 0.")
    imgui.BulletText("Allowed Still to treat LN ends as displacement markers.")
    imgui.SeparatorText("New Features")
    imgui.BulletText("Added the SSF equivalent to all Standard SV shapes.")
    imgui.BulletText(
        "Added the Select tab, which allows users to quickly select desired notes based on\na variety of conditions. Currently, there is the Alternate option and the Snap option.")
    imgui.PopStyleColor()
    imgui.End()
end
---Draws v201 on screen, with dimensions = scale * [132,37].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV201(ctx, location, scale, col, thickness)
    location = location - vector.New(66, 18.5) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44),
        location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24),
        location + scale * vector.New(41.9, 32.1), location + scale * vector.New(41.9, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1), location + scale * vector.New(43.31333333333333, 30.56),
        location + scale * vector.New(44.473333333333336, 29.22), location + scale * vector.New(45.38, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.29333333333333, 26.939999999999998),
        location + scale * vector.New(46.97333333333333, 25.86333333333333), location + scale * vector.New(47.42, 24.85),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85),
        location + scale * vector.New(47.85999999999999, 23.836666666666666),
        location + scale * vector.New(48.07999999999999, 22.77333333333333), location + scale * vector.New(48.08, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66),
        location + scale * vector.New(48.07999999999999, 20.38),
        location + scale * vector.New(47.77666666666666, 19.273333333333333), location + scale * vector.New(47.17, 18.34),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34),
        location + scale * vector.New(46.556666666666665, 17.406666666666666),
        location + scale * vector.New(45.72333333333333, 16.686666666666667), location + scale * vector.New(44.67, 16.18),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18),
        location + scale * vector.New(43.61666666666667, 15.666666666666666),
        location + scale * vector.New(42.43333333333333, 15.41), location + scale * vector.New(41.12, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.72666666666667, 15.41), location + scale * vector.New(38.51, 15.696666666666665),
        location + scale * vector.New(37.47, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27),
        location + scale * vector.New(36.43666666666667, 16.84333333333333),
        location + scale * vector.New(35.64, 17.646666666666665), location + scale * vector.New(35.08, 18.68), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68),
        location + scale * vector.New(34.51333333333333, 19.706666666666663),
        location + scale * vector.New(34.23, 20.913333333333334), location + scale * vector.New(34.23, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3), location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.039999999999996, 20.173333333333332),
        location + scale * vector.New(30.53333333333333, 18.30333333333333), location + scale * vector.New(31.52, 16.69),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69),
        location + scale * vector.New(32.5, 15.083333333333332),
        location + scale * vector.New(33.839999999999996, 13.829999999999998),
        location + scale * vector.New(35.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.14666666666667, 11.58), location + scale * vector.New(41.26, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58),
        location + scale * vector.New(43.39333333333333, 11.58), location + scale * vector.New(45.28333333333333, 12.03),
        location + scale * vector.New(46.93, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93),
        location + scale * vector.New(48.57666666666666, 13.829999999999998),
        location + scale * vector.New(49.86666666666666, 15.043333333333333), location + scale * vector.New(50.8, 16.57),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.8, 16.57),
        location + scale * vector.New(51.73333333333333, 18.096666666666664),
        location + scale * vector.New(52.199999999999996, 19.793333333333333), location + scale * vector.New(52.2, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.199999999999996, 23),
        location + scale * vector.New(51.959999999999994, 24.306666666666665),
        location + scale * vector.New(51.48, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(50.99999999999999, 26.85333333333333),
        location + scale * vector.New(50.17333333333333, 28.266666666666666), location + scale * vector.New(49, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82),
        location + scale * vector.New(47.81999999999999, 31.379999999999995),
        location + scale * vector.New(46.19, 33.276666666666664), location + scale * vector.New(44.11, 35.51), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72),
        location + scale * vector.New(62.406666666666666, 48.72),
        location + scale * vector.New(61.656666666666666, 48.406666666666666),
        location + scale * vector.New(61.03, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78),
        location + scale * vector.New(60.403333333333336, 47.153333333333336),
        location + scale * vector.New(60.09, 46.403333333333336), location + scale * vector.New(60.09, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.403333333333336, 43.89666666666667), location + scale * vector.New(61.03, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.656666666666666, 42.64333333333333),
        location + scale * vector.New(62.406666666666666, 42.33), location + scale * vector.New(63.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91333333333333, 42.64333333333333), location + scale * vector.New(65.54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27),
        location + scale * vector.New(66.16666666666667, 43.89666666666667), location + scale * vector.New(66.48, 44.65),
        location + scale * vector.New(66.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33333333333334, 46.63999999999999), location + scale * vector.New(66.04, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12),
        location + scale * vector.New(65.75333333333333, 47.60666666666666),
        location + scale * vector.New(65.36999999999999, 47.99666666666666), location + scale * vector.New(64.89, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29),
        location + scale * vector.New(64.41, 48.57666666666666), location + scale * vector.New(63.873333333333335, 48.72),
        location + scale * vector.New(63.28, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 48.93),
        location + scale * vector.New(83.11999999999999, 48.92999999999999),
        location + scale * vector.New(80.83999999999999, 48.199999999999996), location + scale * vector.New(78.96, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.96, 46.74),
        location + scale * vector.New(77.08, 45.279999999999994), location + scale * vector.New(75.64, 43.15666666666666),
        location + scale * vector.New(74.64, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.64, 40.37),
        location + scale * vector.New(73.64666666666666, 37.58333333333333),
        location + scale * vector.New(73.15, 34.21333333333333), location + scale * vector.New(73.15, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.15, 30.26),
        location + scale * vector.New(73.15, 26.326666666666664),
        location + scale * vector.New(73.65, 22.966666666666665), location + scale * vector.New(74.65, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.65, 20.18),
        location + scale * vector.New(75.65, 17.39333333333333),
        location + scale * vector.New(77.09666666666666, 15.263333333333332), location + scale * vector.New(78.99, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.99, 13.79),
        location + scale * vector.New(80.87666666666667, 12.316666666666666),
        location + scale * vector.New(83.14666666666666, 11.58), location + scale * vector.New(85.8, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 11.58),
        location + scale * vector.New(88.44666666666666, 11.58),
        location + scale * vector.New(90.71333333333332, 12.316666666666666), location + scale * vector.New(92.6, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.6, 13.79),
        location + scale * vector.New(94.49333333333333, 15.263333333333332),
        location + scale * vector.New(95.94, 17.39333333333333), location + scale * vector.New(96.94, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.94, 20.18),
        location + scale * vector.New(97.94, 22.966666666666665),
        location + scale * vector.New(98.44, 26.326666666666664), location + scale * vector.New(98.44, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.44, 30.26),
        location + scale * vector.New(98.44, 34.21333333333333),
        location + scale * vector.New(97.94333333333333, 37.58333333333333), location + scale * vector.New(96.95, 40.37),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.95, 40.37),
        location + scale * vector.New(95.94999999999999, 43.15666666666666),
        location + scale * vector.New(94.50999999999999, 45.279999999999994), location + scale * vector.New(92.63, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.63, 46.74),
        location + scale * vector.New(90.75, 48.199999999999996),
        location + scale * vector.New(88.47333333333333, 48.92999999999999), location + scale * vector.New(85.8, 48.93),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 45.03),
        location + scale * vector.New(88.44666666666666, 45.03), location + scale * vector.New(90.50333333333333, 43.75),
        location + scale * vector.New(91.97, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.97, 41.19),
        location + scale * vector.New(93.44333333333333, 38.63666666666666),
        location + scale * vector.New(94.18, 34.99333333333333), location + scale * vector.New(94.18, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.18, 30.26),
        location + scale * vector.New(94.18, 27.106666666666666),
        location + scale * vector.New(93.84333333333333, 24.423333333333332), location + scale * vector.New(93.17, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.17, 22.21),
        location + scale * vector.New(92.50333333333333, 19.996666666666666),
        location + scale * vector.New(91.54666666666667, 18.31), location + scale * vector.New(90.3, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.3, 17.15),
        location + scale * vector.New(89.04666666666667, 15.989999999999998),
        location + scale * vector.New(87.54666666666667, 15.41), location + scale * vector.New(85.8, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 15.41),
        location + scale * vector.New(83.16666666666666, 15.41),
        location + scale * vector.New(81.10999999999999, 16.703333333333333), location + scale * vector.New(79.63, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.63, 19.29),
        location + scale * vector.New(78.14999999999999, 21.876666666666665),
        location + scale * vector.New(77.41, 25.53333333333333), location + scale * vector.New(77.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(77.41, 30.26),
        location + scale * vector.New(77.41, 33.406666666666666), location + scale * vector.New(77.74333333333333, 36.08),
        location + scale * vector.New(78.41, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.41, 38.28), location + scale * vector.New(79.07, 40.48),
        location + scale * vector.New(80.02666666666667, 42.156666666666666), location + scale * vector.New(81.28, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.28, 43.31),
        location + scale * vector.New(82.52666666666667, 44.45666666666666),
        location + scale * vector.New(84.03333333333333, 45.03), location + scale * vector.New(85.8, 45.03), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 48.72),
        location + scale * vector.New(107.43666666666667, 48.72),
        location + scale * vector.New(106.68333333333332, 48.406666666666666),
        location + scale * vector.New(106.05, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 47.78),
        location + scale * vector.New(105.42333333333332, 47.153333333333336),
        location + scale * vector.New(105.10999999999999, 46.403333333333336),
        location + scale * vector.New(105.11, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.11, 45.53),
        location + scale * vector.New(105.10999999999999, 44.65),
        location + scale * vector.New(105.42333333333332, 43.89666666666667),
        location + scale * vector.New(106.05, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 43.27),
        location + scale * vector.New(106.68333333333332, 42.64333333333333),
        location + scale * vector.New(107.43666666666667, 42.33), location + scale * vector.New(108.31, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 42.33),
        location + scale * vector.New(109.18333333333334, 42.33),
        location + scale * vector.New(109.93333333333334, 42.64333333333333),
        location + scale * vector.New(110.56, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.56, 43.27),
        location + scale * vector.New(111.19333333333333, 43.89666666666667),
        location + scale * vector.New(111.51, 44.65), location + scale * vector.New(111.51, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.51, 45.53), location + scale * vector.New(111.51, 46.11),
        location + scale * vector.New(111.36333333333333, 46.63999999999999),
        location + scale * vector.New(111.07, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.07, 47.12),
        location + scale * vector.New(110.78333333333332, 47.60666666666666),
        location + scale * vector.New(110.39999999999999, 47.99666666666666),
        location + scale * vector.New(109.92, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.92, 48.29),
        location + scale * vector.New(109.44, 48.57666666666666),
        location + scale * vector.New(108.90333333333334, 48.72), location + scale * vector.New(108.31, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.75, 12.07), location + scale * vector.New(131.75, 12.07),
        location + scale * vector.New(131.75, 48.44), location + scale * vector.New(131.75, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.75, 48.44), location + scale * vector.New(131.75, 48.44),
        location + scale * vector.New(127.34, 48.44), location + scale * vector.New(127.34, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.34, 48.44), location + scale * vector.New(127.34, 48.44),
        location + scale * vector.New(127.34, 16.69), location + scale * vector.New(127.34, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.34, 16.69), location + scale * vector.New(127.34, 16.69),
        location + scale * vector.New(127.13, 16.69), location + scale * vector.New(127.13, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.13, 16.69), location + scale * vector.New(127.13, 16.69),
        location + scale * vector.New(118.25, 22.59), location + scale * vector.New(118.25, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.25, 22.59), location + scale * vector.New(118.25, 22.59),
        location + scale * vector.New(118.25, 18.11), location + scale * vector.New(118.25, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.25, 18.11), location + scale * vector.New(118.25, 18.11),
        location + scale * vector.New(127.34, 12.07), location + scale * vector.New(127.34, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(127.34, 12.07), location + scale * vector.New(127.34, 12.07),
        location + scale * vector.New(131.75, 12.07), location + scale * vector.New(131.75, 12.07), col, thickness)
end
---Draws v200 on screen, with dimensions = scale * [144,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV200(ctx, location, scale, col, thickness)
    location = location - vector.New(72, 24) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44),
        location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.9, 45.24), location + scale * vector.New(29.9, 45.24),
        location + scale * vector.New(41.9, 32.1), location + scale * vector.New(41.9, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.9, 32.1), location + scale * vector.New(43.31333333333333, 30.56),
        location + scale * vector.New(44.473333333333336, 29.22), location + scale * vector.New(45.38, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(45.38, 28.08),
        location + scale * vector.New(46.29333333333333, 26.939999999999998),
        location + scale * vector.New(46.97333333333333, 25.86333333333333), location + scale * vector.New(47.42, 24.85),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.42, 24.85),
        location + scale * vector.New(47.85999999999999, 23.836666666666666),
        location + scale * vector.New(48.07999999999999, 22.77333333333333), location + scale * vector.New(48.08, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(48.08, 21.66),
        location + scale * vector.New(48.07999999999999, 20.38),
        location + scale * vector.New(47.77666666666666, 19.273333333333333), location + scale * vector.New(47.17, 18.34),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(47.17, 18.34),
        location + scale * vector.New(46.556666666666665, 17.406666666666666),
        location + scale * vector.New(45.72333333333333, 16.686666666666667), location + scale * vector.New(44.67, 16.18),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.67, 16.18),
        location + scale * vector.New(43.61666666666667, 15.666666666666666),
        location + scale * vector.New(42.43333333333333, 15.41), location + scale * vector.New(41.12, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.12, 15.41),
        location + scale * vector.New(39.72666666666667, 15.41), location + scale * vector.New(38.51, 15.696666666666665),
        location + scale * vector.New(37.47, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(37.47, 16.27),
        location + scale * vector.New(36.43666666666667, 16.84333333333333),
        location + scale * vector.New(35.64, 17.646666666666665), location + scale * vector.New(35.08, 18.68), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.08, 18.68),
        location + scale * vector.New(34.51333333333333, 19.706666666666663),
        location + scale * vector.New(34.23, 20.913333333333334), location + scale * vector.New(34.23, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(34.23, 22.3), location + scale * vector.New(34.23, 22.3),
        location + scale * vector.New(30.04, 22.3), location + scale * vector.New(30.04, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(30.04, 22.3),
        location + scale * vector.New(30.039999999999996, 20.173333333333332),
        location + scale * vector.New(30.53333333333333, 18.30333333333333), location + scale * vector.New(31.52, 16.69),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(31.52, 16.69),
        location + scale * vector.New(32.5, 15.083333333333332),
        location + scale * vector.New(33.839999999999996, 13.829999999999998),
        location + scale * vector.New(35.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.54, 12.93), location + scale * vector.New(37.24, 12.03),
        location + scale * vector.New(39.14666666666667, 11.58), location + scale * vector.New(41.26, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(41.26, 11.58),
        location + scale * vector.New(43.39333333333333, 11.58), location + scale * vector.New(45.28333333333333, 12.03),
        location + scale * vector.New(46.93, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(46.93, 12.93),
        location + scale * vector.New(48.57666666666666, 13.829999999999998),
        location + scale * vector.New(49.86666666666666, 15.043333333333333), location + scale * vector.New(50.8, 16.57),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(50.8, 16.57),
        location + scale * vector.New(51.73333333333333, 18.096666666666664),
        location + scale * vector.New(52.199999999999996, 19.793333333333333), location + scale * vector.New(52.2, 21.66),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.2, 21.66), location + scale * vector.New(52.199999999999996, 23),
        location + scale * vector.New(51.959999999999994, 24.306666666666665),
        location + scale * vector.New(51.48, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(51.48, 25.58),
        location + scale * vector.New(50.99999999999999, 26.85333333333333),
        location + scale * vector.New(50.17333333333333, 28.266666666666666), location + scale * vector.New(49, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(49, 29.82),
        location + scale * vector.New(47.81999999999999, 31.379999999999995),
        location + scale * vector.New(46.19, 33.276666666666664), location + scale * vector.New(44.11, 35.51), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(44.11, 35.51), location + scale * vector.New(44.11, 35.51),
        location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.25), location + scale * vector.New(35.94, 44.25),
        location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(35.94, 44.53), location + scale * vector.New(35.94, 44.53),
        location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 44.53), location + scale * vector.New(52.84, 44.53),
        location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(52.84, 48.44), location + scale * vector.New(52.84, 48.44),
        location + scale * vector.New(29.9, 48.44), location + scale * vector.New(29.9, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 48.72),
        location + scale * vector.New(62.406666666666666, 48.72),
        location + scale * vector.New(61.656666666666666, 48.406666666666666),
        location + scale * vector.New(61.03, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 47.78),
        location + scale * vector.New(60.403333333333336, 47.153333333333336),
        location + scale * vector.New(60.09, 46.403333333333336), location + scale * vector.New(60.09, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(60.09, 45.53), location + scale * vector.New(60.09, 44.65),
        location + scale * vector.New(60.403333333333336, 43.89666666666667), location + scale * vector.New(61.03, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(61.03, 43.27),
        location + scale * vector.New(61.656666666666666, 42.64333333333333),
        location + scale * vector.New(62.406666666666666, 42.33), location + scale * vector.New(63.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(63.28, 42.33), location + scale * vector.New(64.16, 42.33),
        location + scale * vector.New(64.91333333333333, 42.64333333333333), location + scale * vector.New(65.54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(65.54, 43.27),
        location + scale * vector.New(66.16666666666667, 43.89666666666667), location + scale * vector.New(66.48, 44.65),
        location + scale * vector.New(66.48, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.48, 45.53), location + scale * vector.New(66.48, 46.11),
        location + scale * vector.New(66.33333333333334, 46.63999999999999), location + scale * vector.New(66.04, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.04, 47.12),
        location + scale * vector.New(65.75333333333333, 47.60666666666666),
        location + scale * vector.New(65.36999999999999, 47.99666666666666), location + scale * vector.New(64.89, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(64.89, 48.29),
        location + scale * vector.New(64.41, 48.57666666666666), location + scale * vector.New(63.873333333333335, 48.72),
        location + scale * vector.New(63.28, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 48.93),
        location + scale * vector.New(83.11999999999999, 48.92999999999999),
        location + scale * vector.New(80.83999999999999, 48.199999999999996), location + scale * vector.New(78.96, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.96, 46.74),
        location + scale * vector.New(77.08, 45.279999999999994), location + scale * vector.New(75.64, 43.15666666666666),
        location + scale * vector.New(74.64, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.64, 40.37),
        location + scale * vector.New(73.64666666666666, 37.58333333333333),
        location + scale * vector.New(73.15, 34.21333333333333), location + scale * vector.New(73.15, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(73.15, 30.26),
        location + scale * vector.New(73.15, 26.326666666666664),
        location + scale * vector.New(73.65, 22.966666666666665), location + scale * vector.New(74.65, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.65, 20.18),
        location + scale * vector.New(75.65, 17.39333333333333),
        location + scale * vector.New(77.09666666666666, 15.263333333333332), location + scale * vector.New(78.99, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.99, 13.79),
        location + scale * vector.New(80.87666666666667, 12.316666666666666),
        location + scale * vector.New(83.14666666666666, 11.58), location + scale * vector.New(85.8, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 11.58),
        location + scale * vector.New(88.44666666666666, 11.58),
        location + scale * vector.New(90.71333333333332, 12.316666666666666), location + scale * vector.New(92.6, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.6, 13.79),
        location + scale * vector.New(94.49333333333333, 15.263333333333332),
        location + scale * vector.New(95.94, 17.39333333333333), location + scale * vector.New(96.94, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.94, 20.18),
        location + scale * vector.New(97.94, 22.966666666666665),
        location + scale * vector.New(98.44, 26.326666666666664), location + scale * vector.New(98.44, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.44, 30.26),
        location + scale * vector.New(98.44, 34.21333333333333),
        location + scale * vector.New(97.94333333333333, 37.58333333333333), location + scale * vector.New(96.95, 40.37),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.95, 40.37),
        location + scale * vector.New(95.94999999999999, 43.15666666666666),
        location + scale * vector.New(94.50999999999999, 45.279999999999994), location + scale * vector.New(92.63, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(92.63, 46.74),
        location + scale * vector.New(90.75, 48.199999999999996),
        location + scale * vector.New(88.47333333333333, 48.92999999999999), location + scale * vector.New(85.8, 48.93),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 45.03),
        location + scale * vector.New(88.44666666666666, 45.03), location + scale * vector.New(90.50333333333333, 43.75),
        location + scale * vector.New(91.97, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.97, 41.19),
        location + scale * vector.New(93.44333333333333, 38.63666666666666),
        location + scale * vector.New(94.18, 34.99333333333333), location + scale * vector.New(94.18, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.18, 30.26),
        location + scale * vector.New(94.18, 27.106666666666666),
        location + scale * vector.New(93.84333333333333, 24.423333333333332), location + scale * vector.New(93.17, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.17, 22.21),
        location + scale * vector.New(92.50333333333333, 19.996666666666666),
        location + scale * vector.New(91.54666666666667, 18.31), location + scale * vector.New(90.3, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.3, 17.15),
        location + scale * vector.New(89.04666666666667, 15.989999999999998),
        location + scale * vector.New(87.54666666666667, 15.41), location + scale * vector.New(85.8, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.8, 15.41),
        location + scale * vector.New(83.16666666666666, 15.41),
        location + scale * vector.New(81.10999999999999, 16.703333333333333), location + scale * vector.New(79.63, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.63, 19.29),
        location + scale * vector.New(78.14999999999999, 21.876666666666665),
        location + scale * vector.New(77.41, 25.53333333333333), location + scale * vector.New(77.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(77.41, 30.26),
        location + scale * vector.New(77.41, 33.406666666666666), location + scale * vector.New(77.74333333333333, 36.08),
        location + scale * vector.New(78.41, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.41, 38.28), location + scale * vector.New(79.07, 40.48),
        location + scale * vector.New(80.02666666666667, 42.156666666666666), location + scale * vector.New(81.28, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(81.28, 43.31),
        location + scale * vector.New(82.52666666666667, 44.45666666666666),
        location + scale * vector.New(84.03333333333333, 45.03), location + scale * vector.New(85.8, 45.03), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 48.72),
        location + scale * vector.New(107.43666666666667, 48.72),
        location + scale * vector.New(106.68333333333332, 48.406666666666666),
        location + scale * vector.New(106.05, 47.78), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 47.78),
        location + scale * vector.New(105.42333333333332, 47.153333333333336),
        location + scale * vector.New(105.10999999999999, 46.403333333333336),
        location + scale * vector.New(105.11, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.11, 45.53),
        location + scale * vector.New(105.10999999999999, 44.65),
        location + scale * vector.New(105.42333333333332, 43.89666666666667),
        location + scale * vector.New(106.05, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(106.05, 43.27),
        location + scale * vector.New(106.68333333333332, 42.64333333333333),
        location + scale * vector.New(107.43666666666667, 42.33), location + scale * vector.New(108.31, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.31, 42.33),
        location + scale * vector.New(109.18333333333334, 42.33),
        location + scale * vector.New(109.93333333333334, 42.64333333333333),
        location + scale * vector.New(110.56, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(110.56, 43.27),
        location + scale * vector.New(111.19333333333333, 43.89666666666667),
        location + scale * vector.New(111.51, 44.65), location + scale * vector.New(111.51, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.51, 45.53), location + scale * vector.New(111.51, 46.11),
        location + scale * vector.New(111.36333333333333, 46.63999999999999),
        location + scale * vector.New(111.07, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.07, 47.12),
        location + scale * vector.New(110.78333333333332, 47.60666666666666),
        location + scale * vector.New(110.39999999999999, 47.99666666666666),
        location + scale * vector.New(109.92, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.92, 48.29),
        location + scale * vector.New(109.44, 48.57666666666666),
        location + scale * vector.New(108.90333333333334, 48.72), location + scale * vector.New(108.31, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 48.93),
        location + scale * vector.New(128.14666666666665, 48.92999999999999),
        location + scale * vector.New(125.86999999999999, 48.199999999999996),
        location + scale * vector.New(123.99, 46.74), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.99, 46.74),
        location + scale * vector.New(122.10333333333332, 45.279999999999994),
        location + scale * vector.New(120.66333333333333, 43.15666666666666),
        location + scale * vector.New(119.67, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.67, 40.37),
        location + scale * vector.New(118.67666666666666, 37.58333333333333),
        location + scale * vector.New(118.17999999999999, 34.21333333333333),
        location + scale * vector.New(118.18, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.18, 30.26),
        location + scale * vector.New(118.17999999999999, 26.326666666666664),
        location + scale * vector.New(118.67999999999999, 22.966666666666665),
        location + scale * vector.New(119.68, 20.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.68, 20.18),
        location + scale * vector.New(120.67999999999999, 17.39333333333333),
        location + scale * vector.New(122.12333333333333, 15.263333333333332),
        location + scale * vector.New(124.01, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.01, 13.79),
        location + scale * vector.New(125.90333333333334, 12.316666666666666),
        location + scale * vector.New(128.17333333333332, 11.58), location + scale * vector.New(130.82, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 11.58),
        location + scale * vector.New(133.47333333333333, 11.58),
        location + scale * vector.New(135.74333333333334, 12.316666666666666),
        location + scale * vector.New(137.63, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.63, 13.79),
        location + scale * vector.New(139.5233333333333, 15.263333333333332),
        location + scale * vector.New(140.97, 17.39333333333333), location + scale * vector.New(141.97, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.97, 20.18),
        location + scale * vector.New(142.97, 22.966666666666665),
        location + scale * vector.New(143.47, 26.326666666666664), location + scale * vector.New(143.47, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(143.47, 30.26),
        location + scale * vector.New(143.47, 34.21333333333333),
        location + scale * vector.New(142.97, 37.58333333333333), location + scale * vector.New(141.97, 40.37), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(141.97, 40.37),
        location + scale * vector.New(140.97666666666666, 43.15666666666666),
        location + scale * vector.New(139.54, 45.279999999999994), location + scale * vector.New(137.66, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137.66, 46.74),
        location + scale * vector.New(135.78, 48.199999999999996),
        location + scale * vector.New(133.5, 48.92999999999999), location + scale * vector.New(130.82, 48.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 45.03),
        location + scale * vector.New(133.47333333333333, 45.03),
        location + scale * vector.New(135.53333333333333, 43.75), location + scale * vector.New(137, 41.19), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(137, 41.19),
        location + scale * vector.New(138.46666666666664, 38.63666666666666),
        location + scale * vector.New(139.2, 34.99333333333333), location + scale * vector.New(139.2, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(139.2, 30.26),
        location + scale * vector.New(139.2, 27.106666666666666),
        location + scale * vector.New(138.86666666666665, 24.423333333333332),
        location + scale * vector.New(138.2, 22.21), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(138.2, 22.21),
        location + scale * vector.New(137.5333333333333, 19.996666666666666),
        location + scale * vector.New(136.57333333333332, 18.31), location + scale * vector.New(135.32, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(135.32, 17.15),
        location + scale * vector.New(134.07333333333332, 15.989999999999998),
        location + scale * vector.New(132.57333333333332, 15.41), location + scale * vector.New(130.82, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.82, 15.41),
        location + scale * vector.New(128.19333333333333, 15.41),
        location + scale * vector.New(126.13999999999999, 16.703333333333333),
        location + scale * vector.New(124.66, 19.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.66, 19.29),
        location + scale * vector.New(123.17999999999999, 21.876666666666665),
        location + scale * vector.New(122.44, 25.53333333333333), location + scale * vector.New(122.44, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.44, 30.26),
        location + scale * vector.New(122.44, 33.406666666666666),
        location + scale * vector.New(122.77333333333333, 36.08), location + scale * vector.New(123.44, 38.28), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.44, 38.28), location + scale * vector.New(124.1, 40.48),
        location + scale * vector.New(125.05666666666667, 42.156666666666666),
        location + scale * vector.New(126.31, 43.31), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.31, 43.31),
        location + scale * vector.New(127.55666666666667, 44.45666666666666),
        location + scale * vector.New(129.06, 45.03), location + scale * vector.New(130.82, 45.03), col, thickness)
end
---Draws v112 on screen, with dimensions = scale * [127,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV112(ctx, location, scale, col, thickness)
    location = location - vector.New(63.5, 24) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07),
        location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44),
        location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44),
        location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69),
        location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69),
        location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59),
        location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11),
        location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07),
        location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 48.72),
        location + scale * vector.New(92.37666666666667, 48.72),
        location + scale * vector.New(91.62666666666667, 48.406666666666666), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.37333333333333, 47.153333333333336),
        location + scale * vector.New(90.06, 46.403333333333336), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.37333333333333, 43.89666666666667), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.62666666666667, 42.64333333333333),
        location + scale * vector.New(92.37666666666667, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.88333333333333, 42.64333333333333), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.13666666666666, 43.89666666666667),
        location + scale * vector.New(96.44999999999999, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.44999999999999, 46.11),
        location + scale * vector.New(96.30333333333333, 46.63999999999999), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.72333333333333, 47.60666666666666),
        location + scale * vector.New(95.34, 47.99666666666666), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.57666666666666), location + scale * vector.New(93.84333333333333, 48.72),
        location + scale * vector.New(93.25, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.91, 48.44), location + scale * vector.New(103.91, 48.44),
        location + scale * vector.New(103.91, 45.24), location + scale * vector.New(103.91, 45.24), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.91, 45.24), location + scale * vector.New(103.91, 45.24),
        location + scale * vector.New(115.91, 32.1), location + scale * vector.New(115.91, 32.1), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.91, 32.1),
        location + scale * vector.New(117.31666666666666, 30.56),
        location + scale * vector.New(118.47666666666666, 29.22), location + scale * vector.New(119.39, 28.08), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.39, 28.08),
        location + scale * vector.New(120.30333333333333, 26.939999999999998),
        location + scale * vector.New(120.97999999999999, 25.86333333333333),
        location + scale * vector.New(121.42, 24.85), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.42, 24.85),
        location + scale * vector.New(121.86666666666666, 23.836666666666666),
        location + scale * vector.New(122.09, 22.77333333333333), location + scale * vector.New(122.09, 21.66), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.09, 21.66), location + scale * vector.New(122.09, 20.38),
        location + scale * vector.New(121.78333333333333, 19.273333333333333),
        location + scale * vector.New(121.17, 18.34), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.17, 18.34),
        location + scale * vector.New(120.56333333333333, 17.406666666666666),
        location + scale * vector.New(119.73333333333333, 16.686666666666667),
        location + scale * vector.New(118.68, 16.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.68, 16.18),
        location + scale * vector.New(117.62666666666667, 15.666666666666666),
        location + scale * vector.New(116.44333333333333, 15.41), location + scale * vector.New(115.13, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.13, 15.41),
        location + scale * vector.New(113.72999999999999, 15.41),
        location + scale * vector.New(112.51333333333332, 15.696666666666665),
        location + scale * vector.New(111.48, 16.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.48, 16.27),
        location + scale * vector.New(110.44666666666666, 16.84333333333333),
        location + scale * vector.New(109.64666666666666, 17.646666666666665),
        location + scale * vector.New(109.08, 18.68), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.08, 18.68),
        location + scale * vector.New(108.52, 19.706666666666663),
        location + scale * vector.New(108.24, 20.913333333333334), location + scale * vector.New(108.24, 22.3), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.24, 22.3), location + scale * vector.New(108.24, 22.3),
        location + scale * vector.New(104.05, 22.3), location + scale * vector.New(104.05, 22.3), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.05, 22.3),
        location + scale * vector.New(104.04999999999998, 20.173333333333332),
        location + scale * vector.New(104.53999999999999, 18.30333333333333),
        location + scale * vector.New(105.52, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(105.52, 16.69),
        location + scale * vector.New(106.50666666666666, 15.083333333333332),
        location + scale * vector.New(107.84666666666666, 13.829999999999998),
        location + scale * vector.New(109.54, 12.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.54, 12.93), location + scale * vector.New(111.24, 12.03),
        location + scale * vector.New(113.14999999999999, 11.58), location + scale * vector.New(115.27, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.27, 11.58),
        location + scale * vector.New(117.40333333333332, 11.58),
        location + scale * vector.New(119.28999999999999, 12.03), location + scale * vector.New(120.93, 12.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.93, 12.93),
        location + scale * vector.New(122.57666666666667, 13.829999999999998),
        location + scale * vector.New(123.86666666666666, 15.043333333333333),
        location + scale * vector.New(124.8, 16.57), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.8, 16.57),
        location + scale * vector.New(125.73999999999998, 18.096666666666664),
        location + scale * vector.New(126.20999999999998, 19.793333333333333),
        location + scale * vector.New(126.21, 21.66), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.21, 21.66),
        location + scale * vector.New(126.20999999999998, 23),
        location + scale * vector.New(125.96999999999998, 24.306666666666665),
        location + scale * vector.New(125.49, 25.58), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(125.49, 25.58),
        location + scale * vector.New(125.00999999999999, 26.85333333333333),
        location + scale * vector.New(124.17999999999999, 28.266666666666666), location + scale * vector.New(123, 29.82),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123, 29.82),
        location + scale * vector.New(121.82666666666665, 31.379999999999995),
        location + scale * vector.New(120.19666666666666, 33.276666666666664),
        location + scale * vector.New(118.11, 35.51), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(118.11, 35.51), location + scale * vector.New(118.11, 35.51),
        location + scale * vector.New(109.94, 44.25), location + scale * vector.New(109.94, 44.25), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.94, 44.25), location + scale * vector.New(109.94, 44.25),
        location + scale * vector.New(109.94, 44.53), location + scale * vector.New(109.94, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.94, 44.53), location + scale * vector.New(109.94, 44.53),
        location + scale * vector.New(126.85, 44.53), location + scale * vector.New(126.85, 44.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.85, 44.53), location + scale * vector.New(126.85, 44.53),
        location + scale * vector.New(126.85, 48.44), location + scale * vector.New(126.85, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.85, 48.44), location + scale * vector.New(126.85, 48.44),
        location + scale * vector.New(103.91, 48.44), location + scale * vector.New(103.91, 48.44), col, thickness)
end
---Draws v111 on screen, with dimensions = scale * [111,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV111(ctx, location, scale, col, thickness)
    location = location - vector.New(55.5, 24) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07),
        location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44),
        location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44),
        location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69),
        location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69),
        location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59),
        location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11),
        location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07),
        location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 48.72),
        location + scale * vector.New(92.37666666666667, 48.72),
        location + scale * vector.New(91.62666666666667, 48.406666666666666), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.37333333333333, 47.153333333333336),
        location + scale * vector.New(90.06, 46.403333333333336), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.37333333333333, 43.89666666666667), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.62666666666667, 42.64333333333333),
        location + scale * vector.New(92.37666666666667, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.88333333333333, 42.64333333333333), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.13666666666666, 43.89666666666667),
        location + scale * vector.New(96.44999999999999, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.44999999999999, 46.11),
        location + scale * vector.New(96.30333333333333, 46.63999999999999), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.72333333333333, 47.60666666666666),
        location + scale * vector.New(95.34, 47.99666666666666), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.57666666666666), location + scale * vector.New(93.84333333333333, 48.72),
        location + scale * vector.New(93.25, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.69, 12.07), location + scale * vector.New(116.69, 12.07),
        location + scale * vector.New(116.69, 48.44), location + scale * vector.New(116.69, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.69, 48.44), location + scale * vector.New(116.69, 48.44),
        location + scale * vector.New(112.29, 48.44), location + scale * vector.New(112.29, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.29, 48.44), location + scale * vector.New(112.29, 48.44),
        location + scale * vector.New(112.29, 16.69), location + scale * vector.New(112.29, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.29, 16.69), location + scale * vector.New(112.29, 16.69),
        location + scale * vector.New(112.07, 16.69), location + scale * vector.New(112.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.07, 16.69), location + scale * vector.New(112.07, 16.69),
        location + scale * vector.New(103.2, 22.59), location + scale * vector.New(103.2, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.2, 22.59), location + scale * vector.New(103.2, 22.59),
        location + scale * vector.New(103.2, 18.11), location + scale * vector.New(103.2, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.2, 18.11), location + scale * vector.New(103.2, 18.11),
        location + scale * vector.New(112.29, 12.07), location + scale * vector.New(112.29, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.29, 12.07), location + scale * vector.New(112.29, 12.07),
        location + scale * vector.New(116.69, 12.07), location + scale * vector.New(116.69, 12.07), col, thickness)
end
---Draws v110 on screen, with dimensions = scale * [129,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV110(ctx, location, scale, col, thickness)
    location = location - vector.New(64.5, 24) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07),
        location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(79.69, 48.44), location + scale * vector.New(79.69, 48.44),
        location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 48.44), location + scale * vector.New(75.28, 48.44),
        location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 16.69), location + scale * vector.New(75.28, 16.69),
        location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.07, 16.69), location + scale * vector.New(75.07, 16.69),
        location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 22.59), location + scale * vector.New(66.19, 22.59),
        location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.19, 18.11), location + scale * vector.New(66.19, 18.11),
        location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(75.28, 12.07), location + scale * vector.New(75.28, 12.07),
        location + scale * vector.New(79.69, 12.07), location + scale * vector.New(79.69, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 48.72),
        location + scale * vector.New(92.37666666666667, 48.72),
        location + scale * vector.New(91.62666666666667, 48.406666666666666), location + scale * vector.New(91, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 47.78),
        location + scale * vector.New(90.37333333333333, 47.153333333333336),
        location + scale * vector.New(90.06, 46.403333333333336), location + scale * vector.New(90.06, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(90.06, 45.53), location + scale * vector.New(90.06, 44.65),
        location + scale * vector.New(90.37333333333333, 43.89666666666667), location + scale * vector.New(91, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91, 43.27),
        location + scale * vector.New(91.62666666666667, 42.64333333333333),
        location + scale * vector.New(92.37666666666667, 42.33), location + scale * vector.New(93.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(93.25, 42.33), location + scale * vector.New(94.13, 42.33),
        location + scale * vector.New(94.88333333333333, 42.64333333333333), location + scale * vector.New(95.51, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(95.51, 43.27),
        location + scale * vector.New(96.13666666666666, 43.89666666666667),
        location + scale * vector.New(96.44999999999999, 44.65), location + scale * vector.New(96.45, 45.53), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.45, 45.53),
        location + scale * vector.New(96.44999999999999, 46.11),
        location + scale * vector.New(96.30333333333333, 46.63999999999999), location + scale * vector.New(96.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(96.01, 47.12),
        location + scale * vector.New(95.72333333333333, 47.60666666666666),
        location + scale * vector.New(95.34, 47.99666666666666), location + scale * vector.New(94.86, 48.29), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(94.86, 48.29),
        location + scale * vector.New(94.38, 48.57666666666666), location + scale * vector.New(93.84333333333333, 48.72),
        location + scale * vector.New(93.25, 48.72), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 48.93),
        location + scale * vector.New(113.09, 48.92999999999999),
        location + scale * vector.New(110.81, 48.199999999999996), location + scale * vector.New(108.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.93, 46.74),
        location + scale * vector.New(107.05, 45.279999999999994),
        location + scale * vector.New(105.61333333333333, 43.15666666666666),
        location + scale * vector.New(104.62, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.62, 40.37),
        location + scale * vector.New(103.62666666666667, 37.58333333333333),
        location + scale * vector.New(103.13, 34.21333333333333), location + scale * vector.New(103.13, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.13, 30.26),
        location + scale * vector.New(103.13, 26.326666666666664),
        location + scale * vector.New(103.63, 22.966666666666665), location + scale * vector.New(104.63, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.63, 20.18),
        location + scale * vector.New(105.63, 17.39333333333333),
        location + scale * vector.New(107.07333333333332, 15.263333333333332),
        location + scale * vector.New(108.96, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.96, 13.79),
        location + scale * vector.New(110.84666666666666, 12.316666666666666),
        location + scale * vector.New(113.11666666666667, 11.58), location + scale * vector.New(115.77, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 11.58),
        location + scale * vector.New(118.41666666666666, 11.58),
        location + scale * vector.New(120.68666666666665, 12.316666666666666),
        location + scale * vector.New(122.58, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.58, 13.79),
        location + scale * vector.New(124.46666666666665, 15.263333333333332),
        location + scale * vector.New(125.90999999999998, 17.39333333333333),
        location + scale * vector.New(126.91, 20.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.91, 20.18),
        location + scale * vector.New(127.90999999999998, 22.966666666666665),
        location + scale * vector.New(128.40999999999997, 26.326666666666664),
        location + scale * vector.New(128.41, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.41, 30.26),
        location + scale * vector.New(128.40999999999997, 34.21333333333333),
        location + scale * vector.New(127.91333333333333, 37.58333333333333),
        location + scale * vector.New(126.92, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(126.92, 40.37),
        location + scale * vector.New(125.92666666666668, 43.15666666666666),
        location + scale * vector.New(124.48666666666666, 45.279999999999994),
        location + scale * vector.New(122.6, 46.74), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(122.6, 46.74),
        location + scale * vector.New(120.71999999999998, 48.199999999999996),
        location + scale * vector.New(118.44333333333333, 48.92999999999999),
        location + scale * vector.New(115.77, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 45.03),
        location + scale * vector.New(118.41666666666666, 45.03),
        location + scale * vector.New(120.47666666666666, 43.75), location + scale * vector.New(121.95, 41.19), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(121.95, 41.19),
        location + scale * vector.New(123.41666666666666, 38.63666666666666),
        location + scale * vector.New(124.15, 34.99333333333333), location + scale * vector.New(124.15, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.15, 30.26),
        location + scale * vector.New(124.15, 27.106666666666666),
        location + scale * vector.New(123.81333333333333, 24.423333333333332),
        location + scale * vector.New(123.14, 22.21), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.14, 22.21),
        location + scale * vector.New(122.47333333333333, 19.996666666666666),
        location + scale * vector.New(121.51666666666665, 18.31), location + scale * vector.New(120.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.27, 17.15),
        location + scale * vector.New(119.01666666666665, 15.989999999999998),
        location + scale * vector.New(117.51666666666665, 15.41), location + scale * vector.New(115.77, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.77, 15.41),
        location + scale * vector.New(113.14333333333332, 15.41),
        location + scale * vector.New(111.08999999999999, 16.703333333333333),
        location + scale * vector.New(109.61, 19.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(109.61, 19.29),
        location + scale * vector.New(108.13, 21.876666666666665),
        location + scale * vector.New(107.39, 25.53333333333333), location + scale * vector.New(107.39, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(107.39, 30.26),
        location + scale * vector.New(107.39, 33.406666666666666), location + scale * vector.New(107.72, 36.08),
        location + scale * vector.New(108.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(108.38, 38.28),
        location + scale * vector.New(109.04666666666665, 40.48),
        location + scale * vector.New(110.00333333333332, 42.156666666666666),
        location + scale * vector.New(111.25, 43.31), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.25, 43.31),
        location + scale * vector.New(112.49666666666666, 44.45666666666666),
        location + scale * vector.New(114.00333333333333, 45.03), location + scale * vector.New(115.77, 45.03), col,
        thickness)
end
---Draws v101 on screen, with dimensions = scale * [125,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV101(ctx, location, scale, col, thickness)
    location = location - vector.New(62.5, 24) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 48.93),
        location + scale * vector.New(76.08666666666666, 48.92999999999999),
        location + scale * vector.New(73.81, 48.199999999999996), location + scale * vector.New(71.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.93, 46.74),
        location + scale * vector.New(70.05, 45.279999999999994), location + scale * vector.New(68.61, 43.15666666666666),
        location + scale * vector.New(67.61, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.61, 40.37),
        location + scale * vector.New(66.61666666666666, 37.58333333333333),
        location + scale * vector.New(66.12, 34.21333333333333), location + scale * vector.New(66.12, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.12, 30.26),
        location + scale * vector.New(66.12, 26.326666666666664),
        location + scale * vector.New(66.62, 22.966666666666665), location + scale * vector.New(67.62, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.62, 20.18),
        location + scale * vector.New(68.62, 17.39333333333333),
        location + scale * vector.New(70.06333333333333, 15.263333333333332), location + scale * vector.New(71.95, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.95, 13.79),
        location + scale * vector.New(73.84333333333333, 12.316666666666666),
        location + scale * vector.New(76.11333333333333, 11.58), location + scale * vector.New(78.76, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 11.58),
        location + scale * vector.New(81.41333333333333, 11.58),
        location + scale * vector.New(83.68333333333332, 12.316666666666666), location + scale * vector.New(85.57, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.57, 13.79),
        location + scale * vector.New(87.46333333333332, 15.263333333333332),
        location + scale * vector.New(88.91, 17.39333333333333), location + scale * vector.New(89.91, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 20.18),
        location + scale * vector.New(90.91, 22.966666666666665),
        location + scale * vector.New(91.41, 26.326666666666664), location + scale * vector.New(91.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.41, 30.26),
        location + scale * vector.New(91.41, 34.21333333333333), location + scale * vector.New(90.91, 37.58333333333333),
        location + scale * vector.New(89.91, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 40.37),
        location + scale * vector.New(88.91666666666666, 43.15666666666666),
        location + scale * vector.New(87.47999999999999, 45.279999999999994), location + scale * vector.New(85.6, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.6, 46.74),
        location + scale * vector.New(83.72, 48.199999999999996), location + scale * vector.New(81.44, 48.92999999999999),
        location + scale * vector.New(78.76, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 45.03),
        location + scale * vector.New(81.41333333333333, 45.03), location + scale * vector.New(83.47333333333333, 43.75),
        location + scale * vector.New(84.94, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(84.94, 41.19),
        location + scale * vector.New(86.40666666666667, 38.63666666666666),
        location + scale * vector.New(87.14, 34.99333333333333), location + scale * vector.New(87.14, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(87.14, 30.26),
        location + scale * vector.New(87.14, 27.106666666666666),
        location + scale * vector.New(86.80666666666667, 24.423333333333332), location + scale * vector.New(86.14, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.14, 22.21),
        location + scale * vector.New(85.47333333333333, 19.996666666666666),
        location + scale * vector.New(84.51666666666667, 18.31), location + scale * vector.New(83.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(83.27, 17.15),
        location + scale * vector.New(82.01666666666667, 15.989999999999998),
        location + scale * vector.New(80.51333333333334, 15.41), location + scale * vector.New(78.76, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 15.41),
        location + scale * vector.New(76.13333333333333, 15.41),
        location + scale * vector.New(74.07999999999998, 16.703333333333333), location + scale * vector.New(72.6, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(72.6, 19.29),
        location + scale * vector.New(71.11999999999999, 21.876666666666665),
        location + scale * vector.New(70.38, 25.53333333333333), location + scale * vector.New(70.38, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(70.38, 30.26),
        location + scale * vector.New(70.38, 33.406666666666666), location + scale * vector.New(70.71333333333332, 36.08),
        location + scale * vector.New(71.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.38, 38.28),
        location + scale * vector.New(72.03999999999999, 40.48),
        location + scale * vector.New(72.99666666666667, 42.156666666666666), location + scale * vector.New(74.25, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.25, 43.31),
        location + scale * vector.New(75.49666666666667, 44.45666666666666), location + scale * vector.New(77, 45.03),
        location + scale * vector.New(78.76, 45.03), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 48.72),
        location + scale * vector.New(100.39999999999998, 48.72),
        location + scale * vector.New(99.64666666666665, 48.406666666666666), location + scale * vector.New(99.02, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 47.78),
        location + scale * vector.New(98.39333333333332, 47.153333333333336),
        location + scale * vector.New(98.07999999999998, 46.403333333333336), location + scale * vector.New(98.08, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.08, 45.53),
        location + scale * vector.New(98.07999999999998, 44.65),
        location + scale * vector.New(98.39333333333332, 43.89666666666667), location + scale * vector.New(99.02, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 43.27),
        location + scale * vector.New(99.64666666666665, 42.64333333333333),
        location + scale * vector.New(100.39999999999998, 42.33), location + scale * vector.New(101.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 42.33),
        location + scale * vector.New(102.15333333333334, 42.33),
        location + scale * vector.New(102.90333333333334, 42.64333333333333),
        location + scale * vector.New(103.53, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.53, 43.27),
        location + scale * vector.New(104.15666666666667, 43.89666666666667),
        location + scale * vector.New(104.47, 44.65), location + scale * vector.New(104.47, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.47, 45.53), location + scale * vector.New(104.47, 46.11),
        location + scale * vector.New(104.32666666666665, 46.63999999999999),
        location + scale * vector.New(104.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.04, 47.12),
        location + scale * vector.New(103.74666666666667, 47.60666666666666),
        location + scale * vector.New(103.36333333333333, 47.99666666666666),
        location + scale * vector.New(102.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.89, 48.29),
        location + scale * vector.New(102.41, 48.57666666666666),
        location + scale * vector.New(101.87333333333333, 48.72), location + scale * vector.New(101.28, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.72, 12.07), location + scale * vector.New(124.72, 12.07),
        location + scale * vector.New(124.72, 48.44), location + scale * vector.New(124.72, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(124.72, 48.44), location + scale * vector.New(124.72, 48.44),
        location + scale * vector.New(120.31, 48.44), location + scale * vector.New(120.31, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.31, 48.44), location + scale * vector.New(120.31, 48.44),
        location + scale * vector.New(120.31, 16.69), location + scale * vector.New(120.31, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.31, 16.69), location + scale * vector.New(120.31, 16.69),
        location + scale * vector.New(120.1, 16.69), location + scale * vector.New(120.1, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.1, 16.69), location + scale * vector.New(120.1, 16.69),
        location + scale * vector.New(111.22, 22.59), location + scale * vector.New(111.22, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.22, 22.59), location + scale * vector.New(111.22, 22.59),
        location + scale * vector.New(111.22, 18.11), location + scale * vector.New(111.22, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.22, 18.11), location + scale * vector.New(111.22, 18.11),
        location + scale * vector.New(120.31, 12.07), location + scale * vector.New(120.31, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(120.31, 12.07), location + scale * vector.New(120.31, 12.07),
        location + scale * vector.New(124.72, 12.07), location + scale * vector.New(124.72, 12.07), col, thickness)
end
---Draws v100 on screen, with dimensions = scale * [137,48].
---@param ctx ImDrawListPtr
---@param location Vector2
---@param scale number
---@param col integer
---@param thickness integer
function drawV100(ctx, location, scale, col, thickness)
    location = location - vector.New(68.5, 24) * scale
    ctx.AddBezierCubic(location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16),
        location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(14.35, 48.44), location + scale * vector.New(14.35, 48.44),
        location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(10.09, 48.44), location + scale * vector.New(10.09, 48.44),
        location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(0, 21.16), location + scale * vector.New(0, 21.16),
        location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(4.55, 21.16), location + scale * vector.New(4.55, 21.16),
        location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.07, 42.9), location + scale * vector.New(12.07, 42.9),
        location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(12.36, 42.9), location + scale * vector.New(12.36, 42.9),
        location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(19.89, 21.16), location + scale * vector.New(19.89, 21.16),
        location + scale * vector.New(24.43, 21.16), location + scale * vector.New(24.43, 21.16), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07),
        location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(42.68, 48.44), location + scale * vector.New(42.68, 48.44),
        location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 48.44), location + scale * vector.New(38.28, 48.44),
        location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 16.69), location + scale * vector.New(38.28, 16.69),
        location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.07, 16.69), location + scale * vector.New(38.07, 16.69),
        location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 22.59), location + scale * vector.New(29.19, 22.59),
        location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(29.19, 18.11), location + scale * vector.New(29.19, 18.11),
        location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(38.28, 12.07), location + scale * vector.New(38.28, 12.07),
        location + scale * vector.New(42.68, 12.07), location + scale * vector.New(42.68, 12.07), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 48.72),
        location + scale * vector.New(55.376666666666665, 48.72),
        location + scale * vector.New(54.626666666666665, 48.406666666666666), location + scale * vector.New(54, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 47.78),
        location + scale * vector.New(53.36666666666666, 47.153333333333336),
        location + scale * vector.New(53.04999999999999, 46.403333333333336), location + scale * vector.New(53.05, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(53.05, 45.53),
        location + scale * vector.New(53.04999999999999, 44.65),
        location + scale * vector.New(53.36666666666666, 43.89666666666667), location + scale * vector.New(54, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(54, 43.27),
        location + scale * vector.New(54.626666666666665, 42.64333333333333),
        location + scale * vector.New(55.376666666666665, 42.33), location + scale * vector.New(56.25, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(56.25, 42.33),
        location + scale * vector.New(57.123333333333335, 42.33),
        location + scale * vector.New(57.873333333333335, 42.64333333333333), location + scale * vector.New(58.5, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(58.5, 43.27),
        location + scale * vector.New(59.13333333333333, 43.89666666666667), location + scale * vector.New(59.45, 44.65),
        location + scale * vector.New(59.45, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.45, 45.53), location + scale * vector.New(59.45, 46.11),
        location + scale * vector.New(59.30333333333333, 46.63999999999999), location + scale * vector.New(59.01, 47.12),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(59.01, 47.12),
        location + scale * vector.New(58.72333333333333, 47.60666666666666),
        location + scale * vector.New(58.33999999999999, 47.99666666666666), location + scale * vector.New(57.86, 48.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(57.86, 48.29),
        location + scale * vector.New(57.379999999999995, 48.57666666666666),
        location + scale * vector.New(56.843333333333334, 48.72), location + scale * vector.New(56.25, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 48.93),
        location + scale * vector.New(76.08666666666666, 48.92999999999999),
        location + scale * vector.New(73.81, 48.199999999999996), location + scale * vector.New(71.93, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.93, 46.74),
        location + scale * vector.New(70.05, 45.279999999999994), location + scale * vector.New(68.61, 43.15666666666666),
        location + scale * vector.New(67.61, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.61, 40.37),
        location + scale * vector.New(66.61666666666666, 37.58333333333333),
        location + scale * vector.New(66.12, 34.21333333333333), location + scale * vector.New(66.12, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(66.12, 30.26),
        location + scale * vector.New(66.12, 26.326666666666664),
        location + scale * vector.New(66.62, 22.966666666666665), location + scale * vector.New(67.62, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(67.62, 20.18),
        location + scale * vector.New(68.62, 17.39333333333333),
        location + scale * vector.New(70.06333333333333, 15.263333333333332), location + scale * vector.New(71.95, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.95, 13.79),
        location + scale * vector.New(73.84333333333333, 12.316666666666666),
        location + scale * vector.New(76.11333333333333, 11.58), location + scale * vector.New(78.76, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 11.58),
        location + scale * vector.New(81.41333333333333, 11.58),
        location + scale * vector.New(83.68333333333332, 12.316666666666666), location + scale * vector.New(85.57, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.57, 13.79),
        location + scale * vector.New(87.46333333333332, 15.263333333333332),
        location + scale * vector.New(88.91, 17.39333333333333), location + scale * vector.New(89.91, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 20.18),
        location + scale * vector.New(90.91, 22.966666666666665),
        location + scale * vector.New(91.41, 26.326666666666664), location + scale * vector.New(91.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(91.41, 30.26),
        location + scale * vector.New(91.41, 34.21333333333333), location + scale * vector.New(90.91, 37.58333333333333),
        location + scale * vector.New(89.91, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(89.91, 40.37),
        location + scale * vector.New(88.91666666666666, 43.15666666666666),
        location + scale * vector.New(87.47999999999999, 45.279999999999994), location + scale * vector.New(85.6, 46.74),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(85.6, 46.74),
        location + scale * vector.New(83.72, 48.199999999999996), location + scale * vector.New(81.44, 48.92999999999999),
        location + scale * vector.New(78.76, 48.93), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 45.03),
        location + scale * vector.New(81.41333333333333, 45.03), location + scale * vector.New(83.47333333333333, 43.75),
        location + scale * vector.New(84.94, 41.19), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(84.94, 41.19),
        location + scale * vector.New(86.40666666666667, 38.63666666666666),
        location + scale * vector.New(87.14, 34.99333333333333), location + scale * vector.New(87.14, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(87.14, 30.26),
        location + scale * vector.New(87.14, 27.106666666666666),
        location + scale * vector.New(86.80666666666667, 24.423333333333332), location + scale * vector.New(86.14, 22.21),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(86.14, 22.21),
        location + scale * vector.New(85.47333333333333, 19.996666666666666),
        location + scale * vector.New(84.51666666666667, 18.31), location + scale * vector.New(83.27, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(83.27, 17.15),
        location + scale * vector.New(82.01666666666667, 15.989999999999998),
        location + scale * vector.New(80.51333333333334, 15.41), location + scale * vector.New(78.76, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(78.76, 15.41),
        location + scale * vector.New(76.13333333333333, 15.41),
        location + scale * vector.New(74.07999999999998, 16.703333333333333), location + scale * vector.New(72.6, 19.29),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(72.6, 19.29),
        location + scale * vector.New(71.11999999999999, 21.876666666666665),
        location + scale * vector.New(70.38, 25.53333333333333), location + scale * vector.New(70.38, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(70.38, 30.26),
        location + scale * vector.New(70.38, 33.406666666666666), location + scale * vector.New(70.71333333333332, 36.08),
        location + scale * vector.New(71.38, 38.28), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(71.38, 38.28),
        location + scale * vector.New(72.03999999999999, 40.48),
        location + scale * vector.New(72.99666666666667, 42.156666666666666), location + scale * vector.New(74.25, 43.31),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(74.25, 43.31),
        location + scale * vector.New(75.49666666666667, 44.45666666666666), location + scale * vector.New(77, 45.03),
        location + scale * vector.New(78.76, 45.03), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 48.72),
        location + scale * vector.New(100.39999999999998, 48.72),
        location + scale * vector.New(99.64666666666665, 48.406666666666666), location + scale * vector.New(99.02, 47.78),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 47.78),
        location + scale * vector.New(98.39333333333332, 47.153333333333336),
        location + scale * vector.New(98.07999999999998, 46.403333333333336), location + scale * vector.New(98.08, 45.53),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(98.08, 45.53),
        location + scale * vector.New(98.07999999999998, 44.65),
        location + scale * vector.New(98.39333333333332, 43.89666666666667), location + scale * vector.New(99.02, 43.27),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(99.02, 43.27),
        location + scale * vector.New(99.64666666666665, 42.64333333333333),
        location + scale * vector.New(100.39999999999998, 42.33), location + scale * vector.New(101.28, 42.33), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(101.28, 42.33),
        location + scale * vector.New(102.15333333333334, 42.33),
        location + scale * vector.New(102.90333333333334, 42.64333333333333),
        location + scale * vector.New(103.53, 43.27), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(103.53, 43.27),
        location + scale * vector.New(104.15666666666667, 43.89666666666667),
        location + scale * vector.New(104.47, 44.65), location + scale * vector.New(104.47, 45.53), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.47, 45.53), location + scale * vector.New(104.47, 46.11),
        location + scale * vector.New(104.32666666666665, 46.63999999999999),
        location + scale * vector.New(104.04, 47.12), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(104.04, 47.12),
        location + scale * vector.New(103.74666666666667, 47.60666666666666),
        location + scale * vector.New(103.36333333333333, 47.99666666666666),
        location + scale * vector.New(102.89, 48.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(102.89, 48.29),
        location + scale * vector.New(102.41, 48.57666666666666),
        location + scale * vector.New(101.87333333333333, 48.72), location + scale * vector.New(101.28, 48.72), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 48.93),
        location + scale * vector.New(121.11666666666666, 48.92999999999999),
        location + scale * vector.New(118.83999999999999, 48.199999999999996),
        location + scale * vector.New(116.96, 46.74), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.96, 46.74),
        location + scale * vector.New(115.07333333333332, 45.279999999999994),
        location + scale * vector.New(113.63333333333333, 43.15666666666666),
        location + scale * vector.New(112.64, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.64, 40.37),
        location + scale * vector.New(111.64666666666666, 37.58333333333333),
        location + scale * vector.New(111.14999999999999, 34.21333333333333),
        location + scale * vector.New(111.15, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(111.15, 30.26),
        location + scale * vector.New(111.14999999999999, 26.326666666666664),
        location + scale * vector.New(111.64999999999999, 22.966666666666665),
        location + scale * vector.New(112.65, 20.18), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(112.65, 20.18),
        location + scale * vector.New(113.64999999999999, 17.39333333333333),
        location + scale * vector.New(115.09333333333333, 15.263333333333332),
        location + scale * vector.New(116.98, 13.79), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.98, 13.79),
        location + scale * vector.New(118.87333333333333, 12.316666666666666),
        location + scale * vector.New(121.14333333333333, 11.58), location + scale * vector.New(123.79, 11.58), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 11.58),
        location + scale * vector.New(126.44333333333333, 11.58),
        location + scale * vector.New(128.7133333333333, 12.316666666666666), location + scale * vector.New(130.6, 13.79),
        col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.6, 13.79),
        location + scale * vector.New(132.48666666666668, 15.263333333333332),
        location + scale * vector.New(133.93, 17.39333333333333), location + scale * vector.New(134.93, 20.18), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.93, 20.18),
        location + scale * vector.New(135.93, 22.966666666666665),
        location + scale * vector.New(136.43, 26.326666666666664), location + scale * vector.New(136.43, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(136.43, 30.26),
        location + scale * vector.New(136.43, 34.21333333333333),
        location + scale * vector.New(135.93333333333334, 37.58333333333333),
        location + scale * vector.New(134.94, 40.37), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(134.94, 40.37),
        location + scale * vector.New(133.94666666666666, 43.15666666666666),
        location + scale * vector.New(132.51, 45.279999999999994), location + scale * vector.New(130.63, 46.74), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(130.63, 46.74),
        location + scale * vector.New(128.75, 48.199999999999996),
        location + scale * vector.New(126.47, 48.92999999999999), location + scale * vector.New(123.79, 48.93), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 45.03),
        location + scale * vector.New(126.44333333333333, 45.03),
        location + scale * vector.New(128.50333333333333, 43.75), location + scale * vector.New(129.97, 41.19), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(129.97, 41.19),
        location + scale * vector.New(131.43666666666664, 38.63666666666666),
        location + scale * vector.New(132.16999999999996, 34.99333333333333),
        location + scale * vector.New(132.17, 30.26), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(132.17, 30.26),
        location + scale * vector.New(132.16999999999996, 27.106666666666666),
        location + scale * vector.New(131.83666666666664, 24.423333333333332),
        location + scale * vector.New(131.17, 22.21), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(131.17, 22.21),
        location + scale * vector.New(130.50333333333333, 19.996666666666666),
        location + scale * vector.New(129.54333333333332, 18.31), location + scale * vector.New(128.29, 17.15), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(128.29, 17.15),
        location + scale * vector.New(127.04333333333332, 15.989999999999998),
        location + scale * vector.New(125.54333333333334, 15.41), location + scale * vector.New(123.79, 15.41), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(123.79, 15.41),
        location + scale * vector.New(121.16333333333333, 15.41),
        location + scale * vector.New(119.10999999999999, 16.703333333333333),
        location + scale * vector.New(117.63, 19.29), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(117.63, 19.29),
        location + scale * vector.New(116.14999999999999, 21.876666666666665),
        location + scale * vector.New(115.41, 25.53333333333333), location + scale * vector.New(115.41, 30.26), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(115.41, 30.26),
        location + scale * vector.New(115.41, 33.406666666666666),
        location + scale * vector.New(115.74333333333333, 36.08), location + scale * vector.New(116.41, 38.28), col,
        thickness)
    ctx.AddBezierCubic(location + scale * vector.New(116.41, 38.28), location + scale * vector.New(117.07, 40.48),
        location + scale * vector.New(118.02333333333333, 42.156666666666666),
        location + scale * vector.New(119.27, 43.31), col, thickness)
    ctx.AddBezierCubic(location + scale * vector.New(119.27, 43.31),
        location + scale * vector.New(120.52333333333333, 44.45666666666666),
        location + scale * vector.New(122.03, 45.03), location + scale * vector.New(123.79, 45.03), col, thickness)
end
function selectAlternatingMenu()
    local menuVars = getMenuVars("selectAlternating")
    BasicInputInt(menuVars, "every", "Every __ notes", { 1, MAX_SV_POINTS })
    BasicInputInt(menuVars, "offset", "From note #__", { 1, menuVars.every })
    cache.saveTable("selectAlternatingMenu", menuVars)
    simpleActionMenu(
        "Select a note every " ..
        menuVars.every .. pluralize(" note, from note #", menuVars.every, 5) .. menuVars.offset,
        2,
        selectAlternating, menuVars)
end
function selectBookmarkMenu()
    local bookmarks = map.Bookmarks
    local menuVars = getMenuVars("selectBookmark")
    local times = {}
    if (not truthy(bookmarks)) then
        imgui.TextWrapped("There are no bookmarks! Add one to navigate.")
    else
        imgui.PushItemWidth(70)
        _, menuVars.searchTerm = imgui.InputText("Search", menuVars.searchTerm, 4096)
        KeepSameLine()
        _, menuVars.filterTerm = imgui.InputText("Ignore", menuVars.filterTerm, 4096)
        imgui.Columns(3)
        imgui.Text("Time")
        imgui.NextColumn()
        imgui.Text("Bookmark Label")
        imgui.NextColumn()
        imgui.Text("Leap")
        imgui.NextColumn()
        imgui.Separator()
        local skippedBookmarks = 0
        local skippedIndices = 0
        for idx, bm in ipairs(bookmarks) do
            if (bm.StartTime < 0) then
                skippedBookmarks = skippedBookmarks + 1
                skippedIndices = skippedIndices + 1
                goto nextBookmark
            end
            if (menuVars.searchTerm:len() > 0) and (not bm.Note:find(menuVars.searchTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto nextBookmark
            end
            if (menuVars.filterTerm:len() > 0) and (bm.Note:find(menuVars.filterTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto nextBookmark
            end
            vPos = 126.5 + (idx - skippedBookmarks) * 32
            imgui.SetCursorPosY(vPos)
            times[#times + 1] = bm.StartTime
            imgui.Text(bm.StartTime)
            imgui.NextColumn()
            imgui.SetCursorPosY(vPos)
            bmData = {}
            imgui.Text(bm.Note:fixToSize(95))
            imgui.NextColumn()
            buttonText = "Go to #" .. idx - skippedIndices
            if (imgui.Button(buttonText, vector.New(imgui.CalcTextSize(buttonText).x + 20, 24))) then
                actions.GoToObjects(bm.StartTime)
            end
            imgui.NextColumn()
            if (idx ~= #bookmarks) then imgui.Separator() end
            ::nextBookmark::
        end
        local maxTimeLength = math.log(math.max(table.unpack(times) or 0), 10) + 0.5
        imgui.SetColumnWidth(0, maxTimeLength * 11)
        imgui.SetColumnWidth(1, 110)
        imgui.SetColumnWidth(2, 80)
        imgui.PopItemWidth()
        imgui.Columns(1)
    end
    cache.saveTable("selectBookmarkMenu", menuVars)
end
function selectChordSizeMenu()
    local menuVars = getMenuVars("selectChordSize")
    for idx = 1, game.keyCount do
        local varLabel = "select" .. idx
        local label = table.concat({ table.concat({"Size ", idx, " Chord"}) })
        _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
        if (idx % 2 == 1) then KeepSameLine() end
    end
    simpleActionMenu("Select chords within region", 2, selectByChordSizes, menuVars)
    cache.saveTable("selectChordSizeMenu", menuVars)
end
SELECT_TOOLS = {
    "Alternating",
    "Bookmark",
    "By Snap",
    "By Timing Group",
    "Chord Size",
    "Note Type",
}
function selectTab()
    local changedTool = chooseSelectTool()
    AddSeparator()
    if changedTool then state.SetValue("global.selectTypeIndex", globalVars.selectTypeIndex) end
    local toolName = SELECT_TOOLS[globalVars.selectTypeIndex]
    if toolName == "Alternating" then selectAlternatingMenu() end
    if toolName == "Bookmark" then selectBookmarkMenu() end
    if toolName == "By Snap" then selectBySnapMenu() end
    if toolName == "By Timing Group" then selectByTimingGroupMenu() end
    if toolName == "Chord Size" then selectChordSizeMenu() end
    if toolName == "Note Type" then selectNoteTypeMenu() end
end
function chooseSelectTool()
    local tooltipList = {
        "Skip over notes then select one, and repeat.",
        "Jump to a bookmark.",
        "Select all notes with a certain snap color.",
        "Select all notes within a certain timing group.",
        "Select all notes with a certain chord size.",
        "Select rice/ln notes."
    }
    imgui.AlignTextToFramePadding()
    imgui.Text("Current Type:")
    KeepSameLine()
    local oldSelectTypeIndex = globalVars.selectTypeIndex
    globalVars.selectTypeIndex = Combo("##selecttool", SELECT_TOOLS, oldSelectTypeIndex, nil, nil, tooltipList)
    HoverToolTip(tooltipList[globalVars.selectTypeIndex])
    return oldSelectTypeIndex ~= globalVars.selectTypeIndex
end
function selectNoteTypeMenu()
    local menuVars = getMenuVars("selectNoteType")
    _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
    KeepSameLine()
    _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)
    ---@diagnostic disable-next-line: undefined-global
    if hitobject_type then
        _, menuVars.normal = imgui.Checkbox("Select Normals", menuVars.normal)
        KeepSameLine()
        _, menuVars.mine = imgui.Checkbox("Select Mines", menuVars.mine)
    end
    simpleActionMenu("Select notes within region", 2, selectByNoteType, menuVars)
    cache.saveTable("selectNoteTypeMenu", menuVars)
end
function selectBySnapMenu()
    local menuVars = getMenuVars("selectBySnap")
    BasicInputInt(menuVars, "snap", "Snap", { 1, 100 })
    cache.saveTable("selectBySnapMenu", menuVars)
    simpleActionMenu(
        table.concat({"Select notes with 1/", menuVars.snap, " snap"}),
        2,
        selectBySnap, menuVars)
end
function selectByTimingGroupMenu()
    local menuVars = getMenuVars("selectByTimingGroup")
    menuVars.designatedTimingGroup = chooseTimingGroup("Select in:", menuVars.designatedTimingGroup)
    simpleActionMenu(table.concat({ "Select notes in ", menuVars.designatedTimingGroup }), 2, selectByTimingGroup,
        menuVars)
    cache.saveTable("selectByTimingGroupMenu", menuVars)
end
function showAdvancedSettings()
    GlobalCheckbox("hideAutomatic", "Hide Automatically Placed TGs",
        'Timing groups placed by the "Automatic" feature will not be shown in the plumoguSV timing group selector.')
    GlobalCheckbox("useEndTimeOffsets", "Use LN Ends As Offsets",
        "When true, LN ends will be considered as their own offsets, meaning you don't have to select two notes. All functions which rely on getting note offsets will now additionally include LN ends as their own offsets.")
    GlobalCheckbox("ignoreNotesOutsideTg", "Ignore Notes Not In Current Timing Group",
        "Notes that are in a timing group outside of the current one will be ignored by stills, selection checks, etc.")
    chooseMaxDisplacementMultiplierExponent()
end
function chooseMaxDisplacementMultiplierExponent()
    imgui.PushItemWidth(70)
    local oldMaxDisplacementMultiplierExponent = globalVars.maxDisplacementMultiplierExponent
    _, tempMaxDisplacementMultiplierExponent = imgui.SliderInt("Max Displacement Multiplier Exp.",
        oldMaxDisplacementMultiplierExponent, 0, 10)
    HoverToolTip(
        "plumoguSV designs pseudo-instantaneous movement via a very large SV immediately followed by a different SV. To ensure that the movement truly looks instantaneous, the distance between these two SVs is minimal (conventionally, 1/64th of a millisecond). However, as a map progresses over time, this distance is too small for the engine to handle due to floating point errors. This causes issues for SV mappers trying to copy a section from an early part of the map to a later part of a map, where the displacement distance needs to be larger. Lowering this number fixes that, at the cost of potential two-frame teleports during the rendering of the map. In specific, the denominator of the displacement distance (in ms) will be set to 2^{setting}, where ^ denotes exponentiation.")
    globalVars.maxDisplacementMultiplierExponent = math.clamp(tempMaxDisplacementMultiplierExponent, 0, 10)
    imgui.PopItemWidth()
    if (oldMaxDisplacementMultiplierExponent ~= globalVars.maxDisplacementMultiplierExponent) then
        write(globalVars)
    end
end
function showAppearanceSettings()
    if (globalVars.performanceMode) then
        imgui.TextColored(color.vctr.red,
            "Performance mode is currently enabled.\nPlease disable it to access appearance features.")
        imgui.BeginDisabled()
    end
    chooseStyleTheme()
    chooseColorTheme()
    if (COLOR_THEMES[globalVars.colorThemeIndex] ~= "CUSTOM" and imgui.Button("Load Theme to Custom")) then
        setPluginAppearanceColors(COLOR_THEMES[globalVars.colorThemeIndex])
        local customStyle = {}
        for k41 = 1, #customStyleIds do
            local id = customStyleIds[k41]
            local query = id:capitalize()
            if (query:match("%u%l+") == "Loadup") then
                customStyle[id] = loadup[query:sub(7)]
                goto nextCustomStyle
            end
            customStyle[id] = color.uintToRgba(imgui.GetColorU32(imgui_col[query]))
            ::nextCustomStyle::
        end
        globalVars.customStyle = customStyle
        globalVars.colorThemeIndex = table.indexOf(COLOR_THEMES, "CUSTOM")
        setPluginAppearanceColors("CUSTOM")
    end
    HoverToolTip(
        "Clicking this will recreate this theme in the CUSTOM theme option, allowing you to customize it however you'd like without having to clone it manually.")
    AddSeparator()
    chooseCursorTrail()
    chooseCursorTrailShape()
    chooseEffectFPS()
    chooseCursorTrailPoints()
    chooseCursorShapeSize()
    chooseSnakeSpringConstant()
    chooseCursorTrailGhost()
    AddSeparator()
    GlobalCheckbox("disableLoadup", "Disable Loadup Animation",
        "Disables the loadup animation when launching the editor.")
    KeepSameLine()
    if (imgui.Button("Play", vector.New(42, 24))) then
        state.SetValue("logoStartTime", clock.getTime())
    end
    AddSeparator()
    GlobalCheckbox("drawCapybara", "Capybara", "Draws a capybara at the bottom right of the screen")
    imgui.SameLine(0, RADIO_BUTTON_SPACING)
    GlobalCheckbox("drawCapybara2", "Capybara 2", "Draws a capybara at the bottom left of the screen")
    GlobalCheckbox("drawCapybara312", "Capybara 312", "Draws a capybara???!?!??!!!!? AGAIN?!?!")
    AddSeparator()
    choosePulseCoefficient()
    GlobalCheckbox("useCustomPulseColor", "Use Custom Color?")
    if (not globalVars.useCustomPulseColor) then imgui.BeginDisabled() end
    KeepSameLine()
    if (imgui.Button("Edit Color")) then
        state.SetValue("showColorPicker", not state.GetValue("showColorPicker", false))
    end
    if (state.GetValue("showColorPicker")) then
        choosePulseColor()
    end
    if (not globalVars.useCustomPulseColor) then
        imgui.EndDisabled()
        state.SetValue("showColorPicker", false)
    end
    AddSeparator()
    local oldDynamicBgIndex = globalVars.dynamicBackgroundIndex
    globalVars.dynamicBackgroundIndex = Combo("Dynamic BG", DYNAMIC_BACKGROUND_TYPES, oldDynamicBgIndex)
    if (oldDynamicBgIndex ~= globalVars.dynamicBackgroundIndex) then
        write(globalVars)
    end
    if (globalVars.performanceMode) then
        imgui.EndDisabled()
    end
end
customStyleIds = {
    "windowBg",
    "popupBg",
    "border",
    "frameBg",
    "frameBgHovered",
    "frameBgActive",
    "titleBg",
    "titleBgActive",
    "titleBgCollapsed",
    "checkMark",
    "sliderGrab",
    "sliderGrabActive",
    "button",
    "buttonHovered",
    "buttonActive",
    "tab",
    "tabHovered",
    "tabActive",
    "header",
    "headerHovered",
    "headerActive",
    "separator",
    "text",
    "textSelectedBg",
    "scrollbarGrab",
    "scrollbarGrabHovered",
    "scrollbarGrabActive",
    "plotLines",
    "plotLinesHovered",
    "plotHistogram",
    "plotHistogramHovered",
    "loadupOpeningTextColor",
    "loadupPulseTextColorLeft",
    "loadupPulseTextColorRight",
    "loadupBgTl",
    "loadupBgTr",
    "loadupBgBl",
    "loadupBgBr",
}
local customStyleNames = {
    "Window BG",
    "Popup BG",
    "Border",
    "Frame BG",
    "Frame BG\n(Hovered)",
    "Frame BG\n(Active)",
    "Title BG",
    "Title BG\n(Active)",
    "Title BG\n(Collapsed)",
    "Checkmark",
    "Slider Grab",
    "Slider Grab\n(Active)",
    "Button",
    "Button\n(Hovered)",
    "Button\n(Active)",
    "Tab",
    "Tab\n(Hovered)",
    "Tab\n(Active)",
    "Header",
    "Header\n(Hovered)",
    "Header\n(Active)",
    "Separator",
    "Text",
    "Text Selected\n(BG)",
    "Scrollbar Grab",
    "Scrollbar Grab\n(Hovered)",
    "Scrollbar Grab\n(Active)",
    "Plot Lines",
    "Plot Lines\n(Hovered)",
    "Plot Histogram",
    "Plot Histogram\n(Hovered)",
    "Loadup\nOpening Text",
    "Loadup Pulse\nText (Left)",
    "Loadup Pulse\nText (Right)",
    "Loadup BG\n(Top Left)",
    "Loadup BG\n(Top Right)",
    "Loadup BG\n(Bottom Left)",
    "Loadup BG\n(Bottom Right)",
}
function showCustomThemeSettings()
    local settingsChanged = false
    imgui.SeparatorText("Custom Theme Actions")
    if (imgui.Button("Reset")) then
        globalVars.customStyle = table.duplicate(DEFAULT_STYLE)
        write()
    end
    KeepSameLine()
    if (imgui.Button("Import")) then
        state.SetValue("boolean.importingCustomTheme", true)
    end
    KeepSameLine()
    if (imgui.Button("Export")) then
        local str = stringifyCustomStyle(globalVars.customStyle)
        imgui.SetClipboardText(str)
        print("i!", "Exported custom theme to your clipboard.")
    end
    if (state.GetValue("boolean.importingCustomTheme")) then
        local input = state.GetValue("importingCustomThemeInput", "")
        _, input = imgui.InputText("##customThemeStr", input, 69420)
        state.SetValue("importingCustomThemeInput", input)
        KeepSameLine()
        if (imgui.Button("Send")) then
            setCustomStyleString(input)
            settingsChanged = true
            state.SetValue("boolean.importingCustomTheme", false)
            state.SetValue("importingCustomThemeInput", "")
        end
        KeepSameLine()
        if (imgui.Button("X")) then
            state.SetValue("boolean.importingCustomTheme", false)
            state.SetValue("importingCustomThemeInput", "")
        end
    end
    imgui.SeparatorText("Search")
    imgui.PushItemWidth(imgui.GetWindowWidth() - 25)
    local searchText = state.GetValue("customTheme_searchText", "")
    _, searchText = imgui.InputText("##CustomThemeSearch", searchText, 100)
    state.SetValue("customTheme_searchText", searchText)
    imgui.PopItemWidth()
    for idx, id in ipairs(customStyleIds) do
        local name = customStyleNames[idx]
        if (not name:lower():find(searchText:lower())) then goto nextId end
        settingsChanged = ColorInput(globalVars.customStyle, id, name) or settingsChanged
        ::nextId::
    end
    if settingsChanged then
        write(globalVars)
    end
end
function convertStrToShort(str)
    if (str:lower() == str) then
        return str:charAt(1) .. str:sub(-1)
    else
        local newStr = str:charAt(1)
        for char in str:gmatch("%u") do
            newStr = newStr .. char
        end
        return newStr
    end
end
function stringifyCustomStyle(customStyle)
    local keys = table.keys(customStyle)
    local resultStr = "v2 "
    for k42 = 1, #keys do
        local key = keys[k42]
        local value = customStyle[key]
        keyId = convertStrToShort(key)
        if (key:sub(1, 6) == "loadup") then keyId = keyId .. key:sub(-1):upper() end
        local r = math.round(value.x * 255)
        local g = math.round(value.y * 255)
        local b = math.round(value.z * 255)
        local a = math.round(value.w * 255)
        resultStr = resultStr .. keyId .. "" .. color.rgbaToNdua(r, g, b, a) .. " "
    end
    return resultStr:sub(1, -2)
end
function setCustomStyleString(str)
    local keyIdDict = {}
    for _, key in ipairs(table.keys(DEFAULT_STYLE)) do
        keyIdDict[key] = convertStrToShort(key)
        if (key:sub(1, 6) == "loadup") then keyIdDict[key] = keyIdDict[key] .. key:sub(-1):upper() end
    end
    if (str:sub(1, 3) == "v2 ") then
        parseCustomStyleV2(str:sub(4), keyIdDict)
    else
        parseCustomStyleV1(str, keyIdDict)
    end
end
function parseCustomStyleV2(str, keyIdDict)
    local customStyle = {}
    for kvPair in str:gmatch("[^ ]+") do
        local keyId = kvPair:sub(1, kvPair:len() - 5)
        local keyValue = kvPair:sub(-5)
        local key = table.indexOf(keyIdDict, keyId)
        if (not keyId or key == -1) then goto nextPair end
        customStyle[key] = color.nduaToRgba(keyValue) / 255
        ::nextPair::
    end
    globalVars.customStyle = table.duplicate(customStyle)
end
function parseCustomStyleV1(str, keyIdDict)
    local customStyle = {}
    for kvPair in str:gmatch("[0-9#:a-zA-Z]+") do -- Equivalent to validate, no need to change
        local keyId = kvPair:match("[a-zA-Z]+:"):sub(1, -2)
        local hexa = kvPair:match(":[a-f0-9]+"):sub(2)
        local key = table.indexOf(keyIdDict, keyId)
        if (key ~= -1) then customStyle[key] = color.hexaToRgba(hexa) / 255 end
    end
    globalVars.customStyle = table.duplicate(customStyle)
end
function saveSettingPropertiesButton(settingVars, label)
    local saveButtonClicked = imgui.Button("Save##setting" .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:identify()
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.settings) then globalVars.defaultProperties.settings = {} end
    globalVars.defaultProperties.settings[label] = settingVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)
    print("i!",
        'Default setting properties for submenu "' ..
        label .. '" have been set. Changes will be shown on the next plugin refresh.')
end
function saveMenuPropertiesButton(menuVars, label)
    local saveButtonClicked = imgui.Button("Save##menu" .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:identify()
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.menu) then globalVars.defaultProperties.menu = {} end
    globalVars.defaultProperties.menu[label] = menuVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)
    print("i!",
        'Default menu properties for menu "' ..
        label .. '" have been set. Changes will be shown on the next plugin refresh.')
end
function showDefaultPropertiesSettings()
    local standardFnList = {
        linearSettingsMenu,
        exponentialSettingsMenu,
        bezierSettingsMenu,
        hermiteSettingsMenu,
        sinusoidalSettingsMenu,
        circularSettingsMenu,
        randomSettingsMenu,
        customSettingsMenu,
        chinchillaSettingsMenu,
        comboSettingsMenu,
        codeSettingsMenu
    }
    local specialFnList = {
        stutterSettingsMenu,
        teleportStutterSettingsMenu,
        nil,
        automateSVSettingsMenu,
        penisSettingsMenu
    }
    local editFnList = {
        addTeleportSettingsMenu,
        changeGroupsSettingsMenu,
        completeDuplicateSettingsMenu,
        convertSVSSFSettingsMenu,
        copyNPasteSettingsMenu,
        nil,
        displaceNoteSettingsMenu,
        displaceViewSettingsMenu,
        nil,
        flickerSettingsMenu,
        nil,
        nil,
        nil,
        reverseScrollSettingsMenu,
        scaleDisplaceSettingsMenu,
        scaleMultiplySettingsMenu,
        splitSettingsMenu,
        nil,
        verticalShiftSettingsMenu
    }
    imgui.SeparatorText("Create Tab Settings")
    if (imgui.CollapsingHeader("General Standard Settings")) then
        local menuVars = getMenuVars("placeStandard", "Property")
        chooseStandardSVType(menuVars, false)
        AddSeparator()
        chooseInterlace(menuVars)
        saveMenuPropertiesButton(menuVars, "placeStandard")
        cache.saveTable("placeStandardPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Special Settings")) then
        local menuVars = getMenuVars("placeSpecial", "Property")
        chooseSpecialSVType(menuVars)
        saveMenuPropertiesButton(menuVars, "placeSpecial")
        cache.saveTable("placeSpecialPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Still Settings")) then
        local menuVars = getMenuVars("placeStill", "Property")
        chooseStandardSVType(menuVars, false)
        AddSeparator()
        menuVars.noteSpacing = ComputableInputFloat("Note Spacing", menuVars.noteSpacing, 2, "x")
        menuVars.stillBehavior = Combo("Still Behavior", STILL_BEHAVIOR_TYPES, menuVars.stillBehavior)
        chooseStillType(menuVars)
        chooseInterlace(menuVars)
        saveMenuPropertiesButton(menuVars, "placeStill")
        cache.saveTable("placeStillPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Vibrato Settings")) then
        local menuVars = getMenuVars("placeVibrato", "Property")
        chooseVibratoSVType(menuVars)
        AddSeparator()
        imgui.Text("Vibrato Settings:")
        menuVars.vibratoMode = Combo("Vibrato Mode", VIBRATO_TYPES, menuVars.vibratoMode)
        chooseVibratoQuality(menuVars)
        if (menuVars.vibratoMode ~= 2) then
            chooseVibratoSides(menuVars)
        end
        saveMenuPropertiesButton(menuVars, "placeVibrato")
        cache.saveTable("placeVibratoPropertyMenu", menuVars)
    end
    imgui.SeparatorText("Edit Tab Settings")
    local editTabDict = table.map(EDIT_SV_TOOLS, function(element, idx)
        return { label = element, fn = editFnList[idx] }
    end)
    for _, tbl in pairs(editTabDict) do
        local label = tbl.label
        if (not tbl.fn) then goto continue end
        if (imgui.CollapsingHeader(label .. " Settings")) then
            local menuVars = getMenuVars(label, "Property")
            tbl.fn(menuVars)
            saveMenuPropertiesButton(menuVars, label)
            cache.saveTable(label .. "PropertyMenu", menuVars)
        end
        ::continue::
    end
    imgui.SeparatorText("Delete Tab Settings")
    if (imgui.CollapsingHeader("Delete Menu Settings")) then
        local menuVars = getMenuVars("delete", "Property")
        _, menuVars.deleteTable[1] = imgui.Checkbox("Delete Lines", menuVars.deleteTable[1])
        KeepSameLine()
        _, menuVars.deleteTable[2] = imgui.Checkbox("Delete SVs", menuVars.deleteTable[2])
        _, menuVars.deleteTable[3] = imgui.Checkbox("Delete SSFs", menuVars.deleteTable[3])
        imgui.SameLine(0, SAMELINE_SPACING + 3.5)
        _, menuVars.deleteTable[4] = imgui.Checkbox("Delete Bookmarks", menuVars.deleteTable[4])
        saveMenuPropertiesButton(menuVars, "delete")
        cache.saveTable("deletePropertyMenu", menuVars)
    end
    imgui.SeparatorText("Select Tab Settings")
    if (imgui.CollapsingHeader("Select Alternating Settings")) then
        local menuVars = getMenuVars("selectAlternating", "Property")
        BasicInputInt(menuVars, "every", "Every __ notes", { 1, MAX_SV_POINTS })
        BasicInputInt(menuVars, "offset", "From note #__", { 1, menuVars.every })
        saveMenuPropertiesButton(menuVars, "selectAlternating")
        cache.saveTable("selectAlternatingPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select By Snap Settings")) then
        local menuVars = getMenuVars("selectBySnap", "Property")
        BasicInputInt(menuVars, "snap", "Snap", { 1, 100 })
        saveMenuPropertiesButton(menuVars, "selectBySnap")
        cache.saveTable("selectBySnapPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select Chord Size Settings")) then
        local menuVars = getMenuVars("selectChordSize", "Property")
        for idx = 1, game.keyCount do
            local varLabel = "select" .. idx
            local label = table.concat({ table.concat({"Size ", idx, " Chord"}) })
            _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
            if (idx % 2 == 1) then KeepSameLine() end
        end
        saveMenuPropertiesButton(menuVars, "selectChordSize")
        cache.saveTable("selectChordSizePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select Note Type Settings")) then
        local menuVars = getMenuVars("selectNoteType", "Property")
        _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
        KeepSameLine()
        _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)
        saveMenuPropertiesButton(menuVars, "selectNoteType")
        cache.saveTable("selectNoteTypePropertyMenu", menuVars)
    end
    imgui.SeparatorText("Standard/Still Settings")
    local standardMenuDict = table.map(STANDARD_SVS, function(element, idx)
        return { label = element, fn = standardFnList[idx] }
    end)
    for _, tbl in pairs(standardMenuDict) do
        local label = tbl.label
        if (imgui.CollapsingHeader(label .. " Settings")) then
            local settingVars = getSettingVars(label, "Property")
            tbl.fn(settingVars, false, false, "Property")
            saveSettingPropertiesButton(settingVars, label)
            cache.saveTable(label .. "PropertySettings", settingVars)
        end
    end
    imgui.SeparatorText("Special Settings")
    local specialMenuDict = table.map(SPECIAL_SVS, function(element, idx)
        return { label = element, fn = specialFnList[idx] }
    end)
    for _, tbl in pairs(specialMenuDict) do
        local label = tbl.label
        if (not tbl.fn) then goto continue end
        if (imgui.CollapsingHeader(label .. " Settings")) then
            local settingVars = getSettingVars(label, "Property")
            tbl.fn(settingVars)
            saveSettingPropertiesButton(settingVars, label)
            cache.saveTable(label .. "PropertySettings", settingVars)
        end
        ::continue::
    end
    imgui.SeparatorText("SV Vibrato Settings")
    if (imgui.CollapsingHeader("Linear Vibrato SV Settings")) then
        local settingVars = getSettingVars("LinearVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        saveSettingPropertiesButton(settingVars, "LinearVibratoSV")
        cache.saveTable("LinearVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Polynomial Vibrato SV Settings")) then
        local settingVars = getSettingVars("PolynomialVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Bounds##Vibrato", " msx", 0, 0.875)
        saveSettingPropertiesButton(settingVars, "PolynomialVibratoSV")
        cache.saveTable("PolynomialVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Vibrato SV Settings")) then
        local settingVars = getSettingVars("ExponentialVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        saveSettingPropertiesButton(settingVars, "ExponentialVibratoSV")
        cache.saveTable("ExponentialVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Vibrato SV Settings")) then
        local settingVars = getSettingVars("SinusoidalVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseMsxVerticalShift(settingVars, 0)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        saveSettingPropertiesButton(settingVars, "SinusoidalVibratoSV")
        cache.saveTable("SinusoidalVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sigmoidal Vibrato SV Settings")) then
        local settingVars = getSettingVars("SigmoidalVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        saveSettingPropertiesButton(settingVars, "SigmoidalVibratoSV")
        cache.saveTable("SigmoidalVibratoSVPropertySettings", settingVars)
    end
    imgui.SeparatorText("SSF Vibrato Settings")
    if (imgui.CollapsingHeader("Linear Vibrato SSF Settings")) then
        local settingVars = getSettingVars("LinearVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        saveSettingPropertiesButton(settingVars, "LinearVibratoSSF")
        cache.saveTable("LinearVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Vibrato SSF Settings")) then
        local settingVars = getSettingVars("ExponentialVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        saveSettingPropertiesButton(settingVars, "ExponentialVibratoSSF")
        cache.saveTable("ExponentialVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Vibrato SSF Settings")) then
        local settingVars = getSettingVars("SinusoidalVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseConstantShift(settingVars)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        saveSettingPropertiesButton(settingVars, "SinusoidalVibratoSSF")
        cache.saveTable("SinusoidalVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sigmoidal Vibrato SSF Settings")) then
        local settingVars = getSettingVars("SigmoidalVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        saveSettingPropertiesButton(settingVars, "SigmoidalVibratoSSF")
        cache.saveTable("SigmoidalVibratoSSFPropertySettings", settingVars)
    end
end
function showGeneralSettings()
    GlobalCheckbox("performanceMode", "Enable Performance Mode",
        "Disables some visual enhancement to boost performance.")
    GlobalCheckbox("advancedMode", "Enable Advanced Mode",
        "Advanced mode enables a few features that simplify SV creation, at the cost of making the plugin more cluttered.")
    AddSeparator()
    chooseUpscroll()
    AddSeparator()
    GlobalCheckbox("dontReplaceSV", "Don't Replace Existing SVs",
        "Self-explanatory, but applies only to base SVs made with Standard, Special, or Still. Highly recommended to keep this setting disabled.")
    chooseStepSize()
    GlobalCheckbox("dontPrintCreation", "Don't Print SV Creation Messages",
        'Disables printing "Created __ SVs" messages.')
    GlobalCheckbox("equalizeLinear", "Equalize Linear SV",
        "Forces the standard > linear option to have an average sv of 0 if the start and end SVs are equal. For beginners, this should be enabled.")
    GlobalCheckbox("restrictSinusoidalPeriod", "Restrict Sinusoidal Period",
        "If true, restricts the sinusoidal period shift parameter to be the nearest 4th.")
    GlobalCheckbox("comboizeSelect", "Select Using Already Selected Notes",
        "Changes the behavior of the SELECT tab to select notes that are already selected, instead of all notes between the start/end selection.")
    GlobalCheckbox("printLegacyLNMessage", "Print Legacy LN Recommendation",
        "When true, prints a warning to enable legacy LN when the following conditions are met:\n1. Legacy LN Rendering is currently turned off.\n2: When placing stills, or using certain features that can displace, such as flicker, displace note, and displace view.")
end
function chooseUpscroll()
    local oldUpscroll = globalVars.upscroll
    globalVars.upscroll = RadioButtons("Scroll Direction:", globalVars.upscroll, { "Down", "Up" }, { false, true },
        "Orientation for distance graphs and visuals.")
    if (oldUpscroll ~= globalVars.upscroll) then
        write(globalVars)
    end
end
function chooseStepSize()
    imgui.PushItemWidth(40)
    local oldStepSize = globalVars.stepSize
    local _, tempStepSize = imgui.InputFloat("Exponential Intensity Step Size", oldStepSize, 0, 0, "%.0f%%")
    HoverToolTip(
        "Changes what the exponential intensity slider will round the nearest to. Recommended to keep this as a factor of 100 (1, 2, 5, 10, etc).")
    globalVars.stepSize = math.clamp(tempStepSize, 1, 100)
    imgui.PopItemWidth()
    if (oldStepSize ~= globalVars.stepSize) then
        write(globalVars)
    end
end
function showKeybindSettings()
    local awaitingIndex = state.GetValue("hotkey_awaitingIndex", 0)
    for hotkeyIndex, hotkeyCombo in pairs(globalVars.hotkeyList) do
        if imgui.Button(awaitingIndex == hotkeyIndex and "Listening...##listening" or hotkeyCombo .. "##" .. hotkeyIndex) then
            if awaitingIndex == hotkeyIndex then
                awaitingIndex = 0
            else
                awaitingIndex = hotkeyIndex
            end
        end
        KeepSameLine()
        imgui.SetCursorPosX(90)
        imgui.Text(HOTKEY_LABELS[hotkeyIndex])
    end
    simpleActionMenu("Reset Hotkey Settings", 0, function()
        globalVars.hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST)
        write(globalVars)
        awaitingIndex = 0
    end, nil, true, true)
    state.SetValue("hotkey_awaitingIndex", awaitingIndex)
    if awaitingIndex == 0 then return end
    local prefixes, key = kbm.listenForAnyKeyPressed()
    if (key == -1) then return end
    globalVars.hotkeyList[awaitingIndex] = table.concat(prefixes, "+") ..
        (truthy(prefixes) and "+" or "") .. kbm.numToKey(key)
    awaitingIndex = 0
    write(globalVars)
    state.SetValue("hotkey_awaitingIndex", awaitingIndex)
end
SETTING_TYPES = {
    "General",
    "Advanced",
    "Default Properties",
    "Appearance",
    "Custom Theme",
    "Windows + Widgets",
    "Keybinds",
}
function showPluginSettingsWindow()
    if (not globalVars.performanceMode) then
        local bgColor = vector.New(0.2, 0.2, 0.2, 1)
        imgui.PopStyleColor(20)
        setIncognitoColors()
        setPluginAppearanceStyles("Rounded + Border")
        imgui.PushStyleColor(imgui_col.WindowBg, bgColor)
        imgui.PushStyleColor(imgui_col.TitleBg, bgColor)
        imgui.PushStyleColor(imgui_col.TitleBgActive, bgColor)
        imgui.PushStyleColor(imgui_col.Border, vctr4(1))
    end
    startNextWindowNotCollapsed("plumoguSV Settings")
    _, settingsOpened = imgui.Begin("plumoguSV Settings", true, 42)
    imgui.SetWindowSize("plumoguSV Settings", vector.New(433, 400))
    local typeIndex = state.GetValue("settings_typeIndex", 1)
    imgui.Columns(2, "settings_columnList", true)
    imgui.SetColumnWidth(0, 150)
    imgui.SetColumnWidth(1, 283)
    imgui.BeginChild("Setting Categories")
    imgui.Text("Setting Type")
    imgui.Separator()
    --- Key is name of setting. If value with respect to key is true, will hide setting at the left
    local hideSettingDict = {
        ["Advanced"] = not globalVars.advancedMode,
        ["Custom Theme"] = (COLOR_THEMES[globalVars.colorThemeIndex] ~= "CUSTOM" or globalVars.performanceMode)
    }
    for idx, v in pairs(SETTING_TYPES) do
        if (hideSettingDict[v]) then goto nextSetting end
        if (imgui.Selectable(v, typeIndex == idx)) then
            typeIndex = idx
        end
        ::nextSetting::
    end
    AddSeparator()
    if (imgui.Button("Reset Settings")) then
        write({})
        globalVars = DEFAULT_GLOBAL_VARS
        toggleablePrint("e!", "Settings have been reset.")
    end
    if (globalVars.advancedMode) then renderMemeButtons() end
    imgui.EndChild()
    imgui.NextColumn()
    imgui.BeginChild("Settings Data")
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    if (SETTING_TYPES[typeIndex] == "General") then
        showGeneralSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Advanced") then
        showAdvancedSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Default Properties") then
        showDefaultPropertiesSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Windows + Widgets") then
        showWindowSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Appearance") then
        showAppearanceSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Custom Theme") then
        showCustomThemeSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Keybinds") then
        showKeybindSettings()
    end
    imgui.PopItemWidth()
    imgui.EndChild()
    imgui.Columns(1)
    state.SetValue("settings_typeIndex", typeIndex)
    if (not settingsOpened) then
        state.SetValue("windows.showSettingsWindow", false)
        state.SetValue("settings_typeIndex", 1)
        state.SetValue("crazy", "Crazy?")
        state.SetValue("activateCrazy", false)
        state.SetValue("crazyIdx", 1)
    end
    if (not globalVars.performanceMode) then
        imgui.PopStyleColor(41)
        pulseController()
        setPluginAppearanceColors(COLOR_THEMES[globalVars.colorThemeIndex], true)
        setPluginAppearanceStyles(STYLE_THEMES[globalVars.styleThemeIndex])
    end
    imgui.End()
end
function renderMemeButtons()
    if (GradientButton("show me the quzz\n(quaver huzz)", color.vctr.red, color.vctr.white, 1500)) then
        ---@diagnostic disable-next-line: param-type-mismatch
        imgui.Text(nil)
    end
    HoverToolTip("Press this button once (if you don't have any work saved) and never again.")
    if (GradientButton("fuck you and\nyour stupid editor", color.vctr.red, color.vctr.white, 1500)) then
        state.SetValue("boolean.destroyEditor", true)
    end
    HoverToolTip("Press this button once (if you don't have any work saved) and never again.")
    if (state.GetValue("boolean.destroyEditor")) then
        actions.GoToObjects(math.floor(math.random() * map.TrackLength))
        local ho1 = map.HitObjects[1]
        actions.RemoveHitObject(ho1)
        actions.Undo()
    end
    local text = state.GetValue("crazy", "Crazy?")
    local full =
    " I was crazy\nonce. They put me in\na map. A ranked map.\nA ranked map\nwith no SV. And no\nSV makes me crazy.\nCrazy?"
    if (imgui.Button("Crazy?")) then
        state.SetValue("activateCrazy", true)
    end
    if (state.GetValue("activateCrazy")) then
        imgui.TextUnformatted(text)
        if (clock.listen("crazy", 5 * math.exp(- #text / 1500))) then
            local curIdx = state.GetValue("crazyIdx", 1)
            if (curIdx > #full) then curIdx = curIdx - #full end
            local char = full:charAt(curIdx)
            text = text .. full:charAt(curIdx)
            if (full:charAt(curIdx) == "\n") then
                curIdx = curIdx + 1
                text = text .. full:charAt(curIdx)
            end
            state.SetValue("crazyIdx", curIdx + 1)
            state.SetValue("crazy", text)
        end
        if (imgui.GetScrollMaxY() > imgui.GetScrollY()) then
            imgui.SetScrollHereY(1)
        end
    end
end
function showWindowSettings()
    GlobalCheckbox("hideSVInfo", "Hide SV Info Window",
        "Disables the window that shows note distances when placing Standard, Special, or Still SVs.")
    if (globalVars.performanceMode) then
        imgui.TextColored(color.vctr.red,
            "Performance mode is currently enabled.\nPlease disable it to access widgets and windows.")
        imgui.BeginDisabled()
    end
    if (globalVars.hideSVInfo) then imgui.BeginDisabled() end
    GlobalCheckbox("showSVInfoVisualizer", "Show SV Info Visualizer",
        "Enables a visualizer behind the SV info window that shows the general movement of the notes.")
    if (globalVars.hideSVInfo) then imgui.EndDisabled() end
    GlobalCheckbox("showVibratoWidget", "Separate Vibrato Into New Window",
        "For those who are used to having Vibrato as a separate plugin, this option makes a new, independent window with vibrato only.")
    AddSeparator()
    GlobalCheckbox("showNoteDataWidget", "Show Note Data Of Selection",
        "If one note is selected, shows simple data about that note.")
    GlobalCheckbox("showMeasureDataWidget", "Show Measure Data Of Selection",
        "If two notes are selected, shows measure data within the selected region.")
    if (globalVars.performanceMode) then
        imgui.EndDisabled()
    end
end
TAB_MENUS = {
    "Info",
    "Select",
    "Create",
    "Edit",
    "Delete"
}
---Creates a menu tab.
---@param tabName string
function createMenuTab(tabName)
    if not imgui.BeginTabItem(tabName) then return end
    AddPadding()
    if tabName == "Info" then infoTab() end
    if tabName == "Select" then selectTab() end
    if tabName == "Create" then createSVTab() end
    if tabName == "Edit" then editSVTab() end
    if tabName == "Delete" then deleteTab() end
    imgui.EndTabItem()
end
function showCompositeEffectsTutorial()
    imgui.SeparatorText("Exponential Composition")
    imgui.TextWrapped(
        "All of the previous effects we've seen have been done with just one effect; no changing settings, no different shapes. However, mixing and matching these different effects is what will make your SV map truly unique.")
    gpsim("DoubleExpoExample", vctr2(1), function(t, idx)
        return 2 * (t - 0.5) ^ 3 + 0.5 + t / 2
    end, { { 1, 2 }, {}, { 3, 4 }, {} }, 500)
end
function showEditingRemovingSVTutorial()
    imgui.SeparatorText("Directly Editing SVs")
    imgui.TextWrapped(
        "You may want to occasionally directly edit an SV value, without having to navigate through the slow scroll velocity editor. That's what the direct SV feature is for.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Make sure you\'re in the "EDIT" tab, then go to "DIRECT SV".\nSelect two notes, and if there are SVs between them,\nyou should be able to edit their start time and multiplier.')
    imgui.SeparatorText("Scaling SVs")
    imgui.TextWrapped(
        'Sometimes you want to change how fast an SV is, or increase the intensity of a 0.00x average SV effect. You can scale SVs in several different ways, but the easiest one is to use the "SCALE (MULTIPLY)" feature. For more advanced mappers, you can also use ymulch.')
    imgui.TextColored(GUIDELINE_COLOR,
        'Make sure you\'re in the "EDIT" tab, then go to "SCALE (MULTIPLY)".\nYou can either scale the notes to have a different average SV using\nthe "Average SV" mode, or you can multiply all SVs within your\nselection by a constant factor with the "Relative Ratio" mode.')
    imgui.SeparatorText("Deleting SVs")
    imgui.TextWrapped(
        "As with most things, deleting stuff is easier than creating it. Simply select two notes, and the delete tab will help you delete all desired objects within your selection range. You can also make a standard/special/still effect and the effect will remove any lingering SVs within its selection.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Go to the "DELETE" tab, and ensure that "Delete SVs" is enabled.\nThen, select two notes and click the "Delete" button.')
    imgui.SeparatorText("Reversing Effects")
    imgui.TextWrapped(
        'If you like upscroll, you can take any effect and turn it into upscroll using the "REVERSE SCROLL" feature under "EDIT". Generally, you should use 300-400 msx for your upscroll height, which is how much distance the "receptors" would be from the bottom.')
    imgui.TextColored(GUIDELINE_COLOR, 'Select an existing effect, and hit the "Reverse" button.')
    ForceHeight(540)
end
function showStillsAndDisplacementTutorial()
    imgui.SeparatorText("What are Still effects?")
    imgui.TextWrapped(
        "So far, all effects have been done by selecting two notes with no notes between them. However, experienced SV mappers often select notes on a consistent beat (such as every 1/1 note). A naive approach would be to use the previous examples, but simply select two notes with notes in between them. This would produce a result such as the following:")
    gpsim("StillsAndDisplacementNaiveApproach", vctr2(1), function(t, idx)
        return t * t - (4 - idx) ^ 2 / 30
    end, { { 3, 4 }, { 2 }, { 3 }, { 1 } }, 500)
    imgui.TextColored(vctr4(0.8), "The above demonstrates a Standard > Linear 0x - 2x SV.")
    imgui.TextWrapped(
        'Notice how the notes are not the same distance from each other; this is because the SVs between the first two notes have a different average value than the SVs between the second two notes. To fix this, instead of using standard, we will use the "STILL" menu.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "STILL" under the "TYPE" dropdown.')
    if (globalVars.placeTypeIndex ~= 3) then return end
    imgui.TextWrapped(
        'The rest will be the same as before; simply input your desired parameters and click the "Place SVs between selected notes" button. This will make an effect where all notes have the same distance from each other:')
    gpsim("StillsAndDisplacementGoodApproach", vctr2(1), function(t)
        return t * t
    end, { { 3, 4 }, { 2 }, { 3 }, { 1 } }, 500)
    imgui.TextWrapped(
        'You can adjust how far the notes are from each other by altering the "NOTE SPACING" setting. You can also change where the displacement "ends" by changing the "DISPLACEMENT" setting. Note that this is only useful when your average SV and your still note spacing are not equal.')
    imgui.TextColored(GUIDELINE_COLOR,
        "Try using the following settings and place these SVs between\ntwo 1/1 notes in a jumpstream (or any other dense pattern):")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText("Still > Linear")
    imgui.BulletText("Still Spacing 1.00x")
    imgui.BulletText('Displacement "END" 0.00msx')
    imgui.BulletText("Start/End SV -1.5x to 1.5x")
    imgui.PopStyleColor()
    imgui.TextWrapped("You should be able to produce a jumping effect with little issues.")
    ForceHeight(860)
end
function showWorkingWithShapesTutorial()
    imgui.SeparatorText("Working with different shapes")
    imgui.TextWrapped(
        'So far, we\'ve only been working with stutters, but the core of SV is being able to make cohesive and/or fluid movement. We do this by working with particular shapes in the "STANDARD" tab.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "STANDARD" under the "TYPE" dropdown.')
    if (globalVars.placeTypeIndex ~= 1) then return end
    imgui.Dummy(vector.New(0, 10))
    if (globalVars.hideSVInfo) then
        imgui.TextColored(INSTRUCTION_COLOR, 'Please disable the "HIDE SV INFO" option in settings to continue.')
        return
    end
    imgui.TextWrapped(
        'In the tab below the type dropdown, you\'ll notice a plethora of different options to choose from. Don\'t get overwhelmed; most experienced SV mappers usually limit themselves to using 3-5 of these shapes. Most commonly seen, we have the exponential shape, which makes the notes go towards the receptor at an exponential rate.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Under the "STANDARD" tab, select "EXPONENTIAL".')
    local menuVars = getMenuVars("placeStandard")
    if (menuVars.svTypeIndex ~= 2 and not state.GetValue("workingWithShapes_pg")) then return end
    imgui.Dummy(vector.New(0, 10))
    state.SetValue("workingWithShapes_pg", true)
    imgui.TextWrapped(
        "If you are unfamiliar with any of the SV shapes, the SV Info window will be your best friend. Behind the SV Info window is a slightly visible set of 4 notes, which show you (in advance) how the notes will move if you use this particular effect. Notice how if you change the intensity, the speed at which the notes decelerate increases, and vice versa. The SV Info visualizer is particularly noticable when you change a drastic part of the shape's behavior.")
    local settingVars = getSettingVars("Exponential", "Standard")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Change the exponential type to "SPEED UP", either via\nthe dropdown or by pressing "S" on your keyboard. Note that\nany parameter with a button next to it labelled "SWAP" or "S"\ncan be changed with this keybind. Hotkeys will be reviewed later.')
    if (settingVars.behaviorIndex ~= 2) then return end
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        'Now, the SV Info visualizer is showing a more "rain drop" like appearance than a sudden approach. Feel free to experiment with all the shapes and see what you can come up with. Let\'s try making a fun bouncy effect using linear.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select the "LINEAR" shape. Set the start SV to -1.5x,\nand the end SV to 1.5x. Don\'t worry about SV points or final SV.')
    settingVars = getSettingVars("Linear", "Standard")
    ForceHeight(520)
    if (menuVars.svTypeIndex ~= 1 or math.abs(settingVars.startSV + 1.5) > 0.001 or math.abs(settingVars.endSV - 1.5) > 0.001) then return end
    ForceHeight(490)
    imgui.TextWrapped(
        "Take a look at the SV info window, and notice how the notes are jumping. This is exactly what the effect will look like when placed in game:")
    gpsim("Working With Shapes Jumping", vctr2(1), function(t)
        return 0.9 - 2 * (t - t * t)
    end, { { 1, 2, 3, 4 }, {}, {}, {} }, 500)
    imgui.TextColored(GUIDELINE_COLOR,
        'Select more than 2 chords (at least 3 notes with different times),\nand place the SV using an aforementioned method.')
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "If your notes are in different columns, you may have noticed that all the notes have combined into one large chord. Looking at the SV Info window, the reasoning becomes clear; the average SV is 0.00x, meaning the notes are always going to be next to each other. We can remedy this by adding a teleport to each set of notes, so they no longer line up with each other.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Head to the "EDIT" tab, select "ADD TELEPORT",\nthen select your notes and place the SV.')
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "Hopefully you should now have an effect that resembles individual jumping notes! You might recognize this effect from the old SV map PARTY. Now that you're more familiar with the SV info window and shapes, play around and see what you can make. Trial and error is the best way to learn SV.")
    ForceHeight(1010)
end
function showYourFirstEffectTutorial()
    imgui.SeparatorText("Making your first SV effect")
    imgui.TextWrapped(
        "At the absolute basics of SV are the pulse effects, effects that highlight significant parts of the song, such as a repeating drum. We will apply a very basic stutter SV effect on the drum beat (assuming your song has that), like so:")
    gpsim("Your First Effect Stutter Example", vctr2(1), function(t)
        if (t < 0.05) then
            return 4 * t
        elseif (t < 0.25) then
            return 0.25 * t + 0.19
        else
            return t
        end
    end, { { 1, 2 }, { 3 }, { 4 }, { 3 } }, 500)
    imgui.TextWrapped(
        'To implement this effect, we will need to create some SV. Head to the CREATE tab in your plugin, and locate the dropdown with the word "TYPE" next to it.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "SPECIAL" under the "TYPE" dropdown. The tutorial will\ncontinue when you\'ve done so. In the future, all tutorials will go to\nthe next step when the instructions in RED TEXT are completed.')
    if (globalVars.placeTypeIndex ~= 2) then return end
    imgui.TextColored(INSTRUCTION_COLOR,
        'Now, under the "SPECIAL" tab, make sure "STUTTER" is selected.')
    local menuVars = getMenuVars("placeSpecial")
    if (menuVars.svTypeIndex ~= 1) then return end
    local settingVars = getSettingVars("Stutter", "Special")
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "We want to edit the value of the first SV, and the second SV will be updated accordingly. Note that the default SV for a map is 1x, so we will leave average SV on 1x.")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Set the SV value to 4.00x by clicking on the input and inputting "4".')
    ForceHeight(480)
    if (settingVars.startSV ~= 4) then return end
    ForceHeight(440)
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        'At any time, you can see what your SVs will look like in the "SV INFO" window. Looking inside, we notice one of our SVs is negative. This is because of the relatively large SV we just put in, 4. To counter this, we have two options; either let the second SV be negative, or change how long the first SV lasts. Try playing around with the "Duration" slider.')
    imgui.TextColored(INSTRUCTION_COLOR,
        "Set the duration to be 20%%. Either drag the slider along,\nor hold Ctrl and click to edit the slider directly.")
    ForceHeight(610)
    if (settingVars.stutterDuration ~= 20) then return end
    ForceHeight(570)
    imgui.TextColored(vctr4(0), "penis")
    imgui.TextWrapped(
        'If you want, you can change some of the other settings; try seeing what happens when you increase the stutter count. However, for the sake of this tutorial, you are done.')
    imgui.TextColored(GUIDELINE_COLOR,
        'Now, select a note representing a strong sound, and\nthe note after it. Either hit the "T" button, or click\nthe "Place SVs between selected notes" button.')
    ForceHeight(720)
end
function showYourSecondEffectTutorial()
    imgui.SeparatorText("Making your second SV effect")
    imgui.TextWrapped(
        "Stutters are cool and all, but there's another type of stutter that's more versatile: teleport stutters. Usually, these would not be possible in engines like osu, but since Quaver has no limitations on SV size, we can do it here. Take a look at the difference between normal stutter and teleport stutter:")
    imgui.Dummy(vector.New(0, 10))
    imgui.SetCursorPosX(40)
    gpsim("Your Second Effect Stutter Example", vctr2(0.5), function(t)
        local highT = math.frac(t * 4)
        local reductionIdx = math.floor(t * 4)
        if (highT < 0.05) then
            return highT + reductionIdx / 4
        elseif (highT < 0.25) then
            return 0.05 + reductionIdx / 4
        else
            return (highT + reductionIdx) / 4
        end
    end, { { 1, 2 }, { 3 }, { 4 }, { 3 } }, 4000, true)
    KeepSameLine()
    imgui.SetCursorPosX(200)
    gpsim("Your Second Effect Teleport Stutter Example", vctr2(0.5), function(t)
        local highT = math.frac(t * 4)
        local reductionIdx = math.floor(t * 4)
        return (0.5 * highT + 0.5 + reductionIdx) / 4
    end, { { 1, 2 }, { 3 }, { 4 }, { 3 } }, 4000, true)
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "Notice how on the left, the stutter makes the notes visibly move down, but on the right, the teleport stutter (for self-explanatory reasons) makes the notes teleport. Let's try using teleport stutter now.")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "SPECIAL" under the "TYPE" dropdown.')
    if (globalVars.placeTypeIndex ~= 2) then return end
    imgui.TextColored(INSTRUCTION_COLOR,
        'Now, under the "SPECIAL" tab, make sure that the effect\n"TELEPORT STUTTER" is selected.')
    local menuVars = getMenuVars("placeSpecial")
    if (menuVars.svTypeIndex ~= 2) then return end
    imgui.TextWrapped(
        "Teleport Stutter differs from normal stutter, in that you don't control the speed at which the note moves, but rather how far down the note teleports. For example, if your start SV is 75%%, then your note will start 75%% of the way down. If you want the note to land on the receptor, you must make the start SV %% (in decimal form, not percent) and the main SV add up to the average SV.")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Set the main SV to 0.2x. Then, set the start SV %% to be the\npercentage required to have the notes land on the receptor.\nHINT: 1.00x - 0.20x = ??%%')
    local settingVars = getSettingVars("Teleport Stutter", "Special")
    ForceHeight(490)
    if (not settingVars.linearlyChange and (math.abs(settingVars.mainSV - 0.2) > 0.001 or settingVars.svPercent ~= 80)) then return end
    ForceHeight(450)
    imgui.TextColored(GUIDELINE_COLOR,
        'Similarly, select a note representing a strong sound, and\nthe note after it. Either hit the "T" button on your keyboard or click\nthe "Place SVs between selected notes" button. Alternatively,\nyou can try selecting all the notes which you want to have SV.')
    imgui.SeparatorText("Experimenting with Teleport Stutter")
    imgui.TextWrapped(
        'It would be kind of boring if the teleport stutter remained the same throughout. You can adjust how the teleport stutter acts over time by enabling the "Change Stutter Over Time" option.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Enable "Change Stutter Over Time".')
    ForceHeight(640)
    if (not settingVars.linearlyChange) then return end
    ForceHeight(610)
    imgui.TextWrapped(
        'You\'ll now notice that we have two options for both start SV %% and main SV value; one for start, and one for end. The way this works is that when you select more than two notes (obviously with different times), the teleport stutter for that note will change linearly according to the start/end values. For example, if your start SV %% (start) is 100%%, and your start SV %% (end) is 0%%, then a note in the very middle of your selection would have a teleport stutter with start SV %% of 50%%. We will use this to create some dynamic effects.')
    imgui.TextColored(INSTRUCTION_COLOR,
        "Set the Start SV %% (start) to 100%%, the main SV (start) to 0.00x,\nand main SV (end) to whichever value it must be such that the\nnote lines up with the receptor. HINT: 0%% + ?.??x = 1.00x")
    ForceHeight(820)
    if (math.abs(settingVars.mainSV) > 0.001 or math.abs(settingVars.mainSV2 - 1) > 0.001 or settingVars.svPercent ~= 100 or settingVars.svPercent2 ~= 0) then return end
    ForceHeight(800)
    imgui.TextWrapped(
        "What we have set up here is a teleport stutter that initially has a very strong teleporting strength (start SV 100%%, main SV 0.00x, so the notes don't appear to move at all) to an extremely weak strength (start SV 0%%, main SV 1.00x, so it's as if they haven't even teleported). All of the notes between will lie somewhere within its boundary.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Select a large group of notes and either hit the "T" button on\nyour keyboard or click the Place SV button.')
    ForceHeight(920)
    imgui.TextWrapped(
        "Now that you're hopefully feeling familiar with teleport stutter, try playing around with some of the parameters. Here are some ideas to try. All the effects below will be presented as a list of four numbers, where the first two are the start SV %% (start and end), while the last two are the main SV (start and end).")
    imgui.BulletText("0%%, 100%%, 1.00x, 0.00x")
    imgui.BulletText("100%%, 100%%, -1.00x, 0.00x")
    imgui.BulletText("100%%, 0%%, -1.00x, 1.00x")
    imgui.TextWrapped('Fun fact: the above effect is used in the popular SV map Hypnotizer.')
    ForceHeight(1120)
end
function showStartingTutorial()
    imgui.SeparatorText("The Very Beginning")
    imgui.TextWrapped(
        "So, you want to make some SV maps, or scroll velocity maps. For those who don't know, scroll velocities are objects that change the speed at which notes fall towards the receptor. If you're new to plumogu, welcome! This plugin is your one-stop shop for creating SV maps. However, there are a few things we will need to go over before starting. These are important, so please read them!")
    imgui.SeparatorText("Colors in the Tutorial")
    imgui.Text("You may come across some instructions in ")
    imgui.SameLine(0, 0)
    imgui.TextColored(INSTRUCTION_COLOR, "Red")
    imgui.SameLine(0, 0)
    imgui.Text(" or ")
    imgui.SameLine(0, 0)
    imgui.TextColored(GUIDELINE_COLOR, "Blue")
    imgui.SameLine(0, 0)
    imgui.Text(".")
    imgui.PushStyleColor(imgui_col.Text, INSTRUCTION_COLOR)
    imgui.BulletText("Red text indicates an instruction that MUST\nbe completed for the tutorial to continue.")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText(
        "Blue text indicates an instruction that could be skipped \nand won't progress the tutorial, but helps for learning.")
    imgui.PopStyleColor(2)
    imgui.SeparatorText("Selections")
    imgui.TextWrapped(
        'Often times we will say the phrase "within the selection", which just means within a specific time (e.g. between 5 seconds and 6 seconds into the song). If you select two notes, the SVs within the selection are all SVs with a start time between the first note and the last note. This definition applies to all objects with a StartTime property, that being SVs, SSFs, and timing lines.')
    imgui.SeparatorText("SVs vs SSFs")
    imgui.TextWrapped(
        "If you come from osu!, you may not be familiar with SSFs, or scroll speed factors; objects that change the player's scroll speed to some multiplier. The critical difference between SSFs and SVs is that while SVs do not instantly change the position of notes, SSFs do.")
    imgui.SeparatorText("Now, let's start making some effects!")
    imgui.Text('Click "Placing Basic SVs" at the left, and start from "Your First Effect".')
end
function showHotkeyTutorial()
    imgui.SeparatorText("Basic Hotkeys")
    imgui.TextWrapped(
        "The most basic hotkeys are ones that can simply speed up your SV making process; whether that be placing SVs/SSFs or quickly editing settings.")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText('Press "' .. globalVars.hotkeyList[hotkeys_enum.exec_primary] .. '" to quickly place SVs.')
    imgui.BulletText('Press "' .. globalVars.hotkeyList[hotkeys_enum.exec_secondary] .. '" to quickly place SSFs.')
    imgui.BulletText('If you have a vibrato window, press "' ..
        globalVars.hotkeyList[hotkeys_enum.exec_vibrato] .. '" to quickly place vibrato.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.swap_primary] .. '" to quickly swap any swappable parameters.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.negate_primary] .. '" to quickly negatable any negatable parameters.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.reset_secondary] .. '" to quickly reset any resettable parameters.')
    imgui.PopStyleColor()
    imgui.SeparatorText("Advanced Hotkeys")
    imgui.TextWrapped(
        "Typically, these hotkeys are used in combination with advanced mode to efficiently switch between timing groups:")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.go_to_prev_tg] .. '" to go to the previous timing group.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.go_to_next_tg] .. '" to go to the next timing group.')
    imgui.BulletText('Press "' ..
        globalVars.hotkeyList[hotkeys_enum.go_to_note_tg] .. '" to go to the timing group of the selected note.')
    imgui.PopStyleColor()
    imgui.SeparatorText("Lock Mode")
    imgui.TextWrapped(
        'Sometimes, typing letters/numbers on your keyboard will unintentionally interact with the editor in ways you don\'t want. You can remedy this by using the built-in "NOTE LOCK" feature.')
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText('Press "' .. globalVars.hotkeyList[hotkeys_enum.toggle_note_lock] .. '" to change the locking mode.')
    imgui.PopStyleColor()
end
function showWhatIsMsxTutorial()
    imgui.SeparatorText("Units of Distance and Velocity")
    imgui.TextColored(GUIDELINE_COLOR, "TLDR: 1 msx is the distance a note travels in 1 ms at 1x SV.")
    imgui.TextWrapped(
        "First and foremost, msx is a unit of distance. Similarly to how the meter is defined in real life, we define msx using speed instead of any objective distance. In real life, a meter is defined by the distance light travels in 1/299792458th of a second. Of course, in Quaver, we have much more control over how things move, so we can simply write that 1 msx is the distance a note travels in 1 millisecond at 1x scroll velocity. We can generalize this with the equation:")
    imgui.SetCursorPosX(175)
    imgui.TextColored(INSTRUCTION_COLOR, "d = vt")
    imgui.TextWrapped(
        "Those who have taken physics will be familiar with this equation; assuming constant velocity, the distance travelled by an object (in our case, a Quvaer note) is equal to the velocity (scroll velocity) multiplied by time (in milliseconds). We use this fact to compute msx in any constant velocity scenario:")
    imgui.SetCursorPosX(110)
    imgui.TextColored(INSTRUCTION_COLOR, "(0.5x SV) * (500 ms) = 250 msx")
    imgui.TextWrapped(
        "Since SV points are discrete (that is, there is no changing velocity between two SVs), ALL distance can be computed by breaking up effects into chunks of two SVs and computing their distances individually, then summing them. For those who have taken calculus, it is effectively a discrete sum, that when generalized turns into an integral (similar to how distance is the integral of velocity when velocity is a continuous function of time).")
    imgui.TextWrapped(
        "Like any other equation, we can rewrite the above to solve for what we need. Maybe we want an effect to travel 300 msx in the timespan of 500 milliseconds. The resulting average SV should then be:")
    imgui.SetCursorPosX(115)
    imgui.TextColored(INSTRUCTION_COLOR, "(300 msx) / (500 ms) = 0.6x")
    imgui.TextWrapped(
        "Hopefully the nomenclature for msx makes sense; it is quite literally ms * x. If you know a little bit of dimensional analysis, you can use this fact to easily compute average SVs and displacements.")
end
function showTutorialWindow()
    imgui.SetNextWindowSize(vector.New(600, 500), imgui_cond.Always)
    imgui.PushStyleColor(imgui_col.WindowBg, imgui.GetColorU32(imgui_col.WindowBg, 0) + 4278190080)
    imgui.PushStyleColor(imgui_col.TitleBg, imgui.GetColorU32(imgui_col.TitleBg, 0) + 4278190080)
    startNextWindowNotCollapsed("plumoguSV Tutorial Menu")
    _, tutorialOpened = imgui.Begin("plumoguSV Tutorial Menu", true, 26)
    local tutorialWindowName = state.GetValue("tutorialWindowName") or ""
    if (not tutorialOpened) then
        state.SetValue("windows.showTutorialWindow", false)
    end
    local navigatorWidth = 200
    local nullFn = function()
        imgui.Text("Select a tutorial on the left to view it.")
    end
    local incompleteFn = function()
        imgui.TextWrapped("Sorry, this tutorial is not ready yet. Please come back when a new version comes out.")
    end
    local tree = {
        ["For Beginners"] = {
            ["Start Here"] = showStartingTutorial,
            ["Placing Basic SVs"] = {
                ["Your First Effect"] = showYourFirstEffectTutorial,
                ["Your Second Effect"] = showYourSecondEffectTutorial,
                ["Working With Shapes"] = showWorkingWithShapesTutorial,
                ["Editing/Removing SVs"] = showEditingRemovingSVTutorial,
                ["Stills and Displacement"] = showStillsAndDisplacementTutorial,
                ["Composite Effects"] = showCompositeEffectsTutorial,
            },
            ["Adding Effects"] = {
                ["Flickers"] = incompleteFn,
                ["Vibrato"] = incompleteFn,
            },
        },
        ["Helpful Info"] = {
            ["Plugin Efficiency Tips"] = {
                ["Hotkeys"] = showHotkeyTutorial,
            },
            ["The Math Behind SV"] = {
                ["What IS msx?"] = showWhatIsMsxTutorial,
                ["The calculus of SV"] = incompleteFn,
                ["Why do we call them shapes?"] = incompleteFn,
                ["Analogies to Physics"] = incompleteFn,
            }
        }
    }
    imgui.Columns(2)
    imgui.SetColumnWidth(0, 200)
    imgui.SetColumnWidth(1, 400)
    imgui.BeginChild("Tutorial Navigator")
    function renderBranch(branch, branchName)
        for text, data in pairs(branch) do
            local leafName = table.concat({ branchName, ".", text })
            if (type(data) == "table") then
                if (imgui.TreeNode(text)) then
                    renderBranch(data, leafName)
                    imgui.TreePop()
                end
            else
                if (imgui.GetCursorPosX() < 10) then imgui.SetCursorPosX(10) end
                imgui.Selectable(text)
                if (imgui.IsItemClicked()) then
                    tutorialWindowName = leafName
                    state.SetValue("tutorialWindowName", tutorialWindowName)
                end
            end
        end
    end
    for text, data in pairs(tree) do
        imgui.SeparatorText(text)
        renderBranch(data, text)
    end
    imgui.EndChild()
    imgui.NextColumn()
    imgui.BeginChild("Tutorial Data", vector.New(380, 500), imgui_child_flags
        .AlwaysUseWindowPadding)
    imgui.SetCursorPosY(0)
    function ForceHeight(h)
        imgui.SetCursorPosY(h)
        imgui.TextColored(vctr4(0), "penis")
    end
    if (game.keyCount ~= 4) then
        imgui.SeparatorText("This tutorial does not support this key mode.")
        imgui.Text("Please go to a 4K map to continue.")
        goto tutorialRenderSkip
    end
    if (state.GetValue("tutorialWindowQueue")) then
        tutorialWindowName = state.GetValue("tutorialWindowQueue")
        state.SetValue("tutorialWindowQueue", nil)
    end
    if (tutorialWindowName == "") then
        nullFn()
        goto tutorialRenderSkip
    end
    table.nestedValue(tree, tutorialWindowName:split("."))()
    ::tutorialRenderSkip::
    imgui.EndChild()
    imgui.Columns(1)
    imgui.End()
    imgui.PopStyleColor(2)
end
function renderMeasureDataWidget()
    if not truthy(state.SelectedHitObjects) then return end
    local widgetVars = {
        oldStartOffset = -69,
        oldEndOffset = -69,
        nsvDistance = 0,
        roundedSVDistance = 0,
        roundedAvgSV = 0,
        tgName = ""
    }
    cache.loadTable("measureWidget", widgetVars)
    local uniqueDict = {}
    for _, ho in ipairs(state.SelectedHitObjects) do
        if (not table.contains(uniqueDict, ho.StartTime)) then
            uniqueDict[#uniqueDict + 1] = ho.StartTime
        end
        if (#uniqueDict > 2) then return end
    end
    if (#state.SelectedHitObjects == 1 and state.SelectedHitObjects[1].EndTime ~= 0) then
        uniqueDict = { state.SelectedHitObjects[1].StartTime, state.SelectedHitObjects[1].EndTime }
        imgui.BeginTooltip()
        AddSeparator()
        imgui.EndTooltip()
    end
    uniqueDict = sort(uniqueDict, sortAscending) ---@type number[]
    local startOffset = uniqueDict[1]
    local endOffset = uniqueDict[2] or uniqueDict[1]
    if (math.abs(endOffset - startOffset) < 1e-10 and not state.GetValue("boolean.changeOccurred") and state.SelectedScrollGroupId == widgetVars.tgName) then return end
    if (endOffset ~= widgetVars.oldEndOffset or startOffset ~= widgetVars.oldStartOffset or state.GetValue("boolean.changeOccurred") or state.SelectedScrollGroupId ~= widgetVars.tgName) then
        svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        widgetVars.nsvDistance = endOffset - startOffset
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        totalDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset) or 0
        widgetVars.roundedSVDistance = math.round(totalDistance, 3)
        avgSV = totalDistance / (endOffset - startOffset)
        widgetVars.roundedAvgSV = math.round(avgSV, 3)
        widgetVars.tgName = state.SelectedScrollGroupId
    end
    imgui.BeginTooltip()
    imgui.Text("Measure Info:")
    imgui.Text(table.concat({"NSV Distance = ", widgetVars.nsvDistance, " ms"}))
    imgui.Text(table.concat({"SV Distance = ", widgetVars.roundedSVDistance, " msx"}))
    imgui.Text(table.concat({"Avg SV = ", widgetVars.roundedAvgSV, "x"}))
    imgui.EndTooltip()
    widgetVars.oldStartOffset = startOffset
    widgetVars.oldEndOffset = endOffset
    cache.saveTable("measureWidget", widgetVars)
end
function renderNoteDataWidget()
    if (#state.SelectedHitObjects ~= 1) then return end
    imgui.BeginTooltip()
    imgui.Text("Note Info:")
    local selectedNote = state.SelectedHitObjects[1]
    imgui.Text(table.concat({"StartTime = ", selectedNote.StartTime, " ms"}))
    local noteIsNotLN = selectedNote.EndTime == 0
    if noteIsNotLN then
        imgui.EndTooltip()
        return
    end
    local lnLength = selectedNote.EndTime - selectedNote.StartTime
    imgui.Text(table.concat({"EndTime = ", selectedNote.EndTime, " ms"}))
    imgui.Text(table.concat({"LN Length = ", lnLength, " ms"}))
    imgui.EndTooltip()
end
function chooseAddComboMultipliers(settingVars)
    local oldValues = vector.New(settingVars.comboMultiplier1, settingVars.comboMultiplier2)
    local _, newValues = imgui.InputFloat2("ax + by", oldValues, "%.2f")
    HelpMarker("a = multiplier for SV Type 1, b = multiplier for SV Type 2")
    settingVars.comboMultiplier1 = newValues.x
    settingVars.comboMultiplier2 = newValues.y
    return oldValues ~= newValues
end
function chooseArcPercent(settingVars)
    local oldPercent = settingVars.arcPercent
    _, settingVars.arcPercent = imgui.SliderInt("Arc Percent", math.clamp(oldPercent, 1, 99), 1, 99, oldPercent .. "%%")
    return oldPercent ~= settingVars.arcPercent
end
function chooseAverageSV(menuVars)
    local outputValue, settingsChanged = NegatableComputableInputFloat("Average SV", menuVars.avgSV, 2, "x")
    menuVars.avgSV = outputValue
    return settingsChanged
end
function chooseInteractiveBezier(settingVars, optionalLabel)
    local pos1 = (settingVars.p1 * 150) or vector.New(30, 75)
    local pos2 = (settingVars.p2 * 150) or vector.New(120, 75)
    local normalizedPos1 = pos1 / 150
    local normalizedPos2 = pos2 / 150
    if (not settingVars.manualMode) then
        imgui.BeginChild("Bezier Interactive Window" .. optionalLabel, vctr2(150), 67, 31)
        local red = 4278190335
        local blue = 4294901760
        pos1.y = 150 - pos1.y
        pos2.y = 150 - pos2.y
        local pointList = { { pos = pos1, col = red, size = 5 }, { pos = pos2, col = blue, size = 5 } }
        local ctx = renderGraph("Bezier Interactive Window" .. optionalLabel, vctr2(150), pointList, settingVars
            .freeMode)
        local topLeft = imgui.GetWindowPos()
        local dim = imgui.GetWindowSize()
        if (not settingVars.freeMode) then
            pointList[1].pos = vector.Clamp(pointList[1].pos, vctr2(0), vctr2(150))
            pointList[2].pos = vector.Clamp(pointList[2].pos, vctr2(0), vctr2(150))
        end
        pos1 = pointList[1].pos
        pos2 = pointList[2].pos
        local dottedCol = imgui.GetColorU32(imgui_col.ButtonHovered)
        local mainCol = imgui.GetColorU32(imgui_col.ButtonActive)
        local bottomLeft = vector.New(topLeft.x, topLeft.y + dim.y)
        local topRight = vector.New(topLeft.x + dim.x, topLeft.y)
        ctx.AddBezierCubic(bottomLeft, topLeft + pos1, topLeft + pos2, topRight, mainCol, 3)
        local dist1 = vector.Distance(bottomLeft, topLeft + pos1)
        local dist2 = vector.Distance(topRight, topLeft + pos2)
        local factor1 = 1 - 10 / dist1
        local factor2 = 1 - 10 / dist2
        ctx.AddLine(bottomLeft, bottomLeft + factor1 * vector.New(pos1.x, pos1.y - dim.y), dottedCol, 2)
        ctx.AddLine(topRight, topRight + factor2 * vector.New(pos2.x - dim.x, pos2.y), dottedCol, 2)
        imgui.EndChild()
        KeepSameLine()
        imgui.BeginChild("Bezier Data", vector.New(100, 150))
        imgui.SetCursorPosX(7)
        pos1.y = 150 - pos1.y
        pos2.y = 150 - pos2.y
        normalizedPos1 = pos1 / 150
        normalizedPos2 = pos2 / 150
        imgui.Text("\n         Point 1:\n      (" ..
            string.format("%.2f", normalizedPos1.x) ..
            table.concat({", ", string.format("%.2f", normalizedPos1.y), ")\n         Point 2:\n      ("}) ..
            string.format("%.2f", normalizedPos2.x) .. table.concat({", ", string.format("%.2f", normalizedPos2.y), ")\n"}))
        imgui.SetCursorPosY(80)
        imgui.SetCursorPosX(5)
        _, settingVars.freeMode = imgui.Checkbox("Free Mode##Bezier", settingVars.freeMode)
        HoverToolTip(
            "Enable this to allow the bezier control points to move outside the boundary. WARNING: ONCE MOVED OUTSIDE, THEY CANNOT BE MOVED BACK IN. DISABLE AND RE-ENABLE FREE MODE TO ALLOW THEM TO BE INTERACTED WITH.")
        imgui.SetCursorPosX(5)
        _, settingVars.manualMode = imgui.Checkbox("Manual Edit##Bezier", settingVars.manualMode)
        HoverToolTip(
            "Enable this to directly edit the bezier points.")
        imgui.EndChild()
    else
        imgui.SetNextItemWidth(DEFAULT_WIDGET_WIDTH)
        _, normalizedPos1 = imgui.SliderFloat2("Point 1", pos1 / 150, 0, 1)
        imgui.SetNextItemWidth(DEFAULT_WIDGET_WIDTH)
        _, normalizedPos2 = imgui.SliderFloat2("Point 2", pos2 / 150, 0, 1)
        _, settingVars.manualMode = imgui.Checkbox("Manual Edit##Bezier", settingVars.manualMode)
        HoverToolTip(
            "Disable this to edit the bezier points with an interactive graph.")
    end
    local oldP1 = settingVars.p1
    local oldP2 = settingVars.p2
    settingVars.p1 = normalizedPos1
    settingVars.p2 = normalizedPos2
    state.SetValue("boolean.bezierFreeMode", settingVars.freeMode)
    state.SetValue("boolean.bezierManualMode", settingVars.manualMode)
    return oldP1 ~= settingVars.p1 or oldP2 ~= settingVars.p2
end
function chooseChinchillaIntensity(settingVars)
    local oldIntensity = settingVars.chinchillaIntensity
    local _, newIntensity = imgui.SliderFloat("Intensity##chinchilla", oldIntensity, 0, 10, "%.3f")
    HelpMarker("Ctrl + click slider to input a specific number")
    settingVars.chinchillaIntensity = math.clamp(newIntensity, 0, 727)
    return oldIntensity ~= settingVars.chinchillaIntensity
end
function chooseChinchillaType(settingVars)
    local oldIndex = settingVars.chinchillaTypeIndex
    settingVars.chinchillaTypeIndex = Combo("Chinchilla Type", CHINCHILLA_TYPES, oldIndex)
    return oldIndex ~= settingVars.chinchillaTypeIndex
end
function chooseColorTheme()
    local oldColorThemeIndex = globalVars.colorThemeIndex
    globalVars.colorThemeIndex = Combo("Color Theme", COLOR_THEMES, globalVars.colorThemeIndex, COLOR_THEME_COLORS)
    if (oldColorThemeIndex ~= globalVars.colorThemeIndex) then
        write(globalVars)
    end
    local currentTheme = COLOR_THEMES[globalVars.colorThemeIndex]
    local isRGBColorTheme = currentTheme:find("RGB") or currentTheme:find("BGR")
    if not isRGBColorTheme then return end
    chooseRGBPeriod()
end
function chooseComboSVOption(settingVars, maxComboPhase)
    local oldIndex = settingVars.comboTypeIndex
    settingVars.comboTypeIndex = Combo("Combo Type", COMBO_SV_TYPE, settingVars.comboTypeIndex)
    local currentComboType = COMBO_SV_TYPE[settingVars.comboTypeIndex]
    local addTypeChanged = false
    if currentComboType ~= "SV Type 1 Only" and currentComboType ~= "SV Type 2 Only" then
        addTypeChanged = BasicInputInt(settingVars, "comboPhase", "Combo Phase", { 0, maxComboPhase }) or addTypeChanged
    end
    if currentComboType == "Add" then
        addTypeChanged = chooseAddComboMultipliers(settingVars) or addTypeChanged
    end
    return (oldIndex ~= settingVars.comboTypeIndex) or addTypeChanged
end
function chooseConstantShift(settingVars, defaultShift)
    local oldShift = settingVars.verticalShift
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local resetButtonPressed = imgui.Button("R", TERTIARY_BUTTON_SIZE)
    if (resetButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.reset_secondary])) then
        settingVars.verticalShift = defaultShift
    end
    HoverToolTip("Reset vertical shift to initial values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N", TERTIARY_BUTTON_SIZE)
    if negateButtonPressed and settingVars.verticalShift ~= 0 then
        settingVars.verticalShift = -settingVars.verticalShift
    end
    HoverToolTip("Negate vertical shift")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local inputText = "Vertical Shift"
    _, settingVars.verticalShift = imgui.InputFloat(inputText, settingVars.verticalShift, 0, 0, "%.3fx")
    imgui.PopItemWidth()
    imgui.PopStyleVar(3)
    return oldShift ~= settingVars.verticalShift
end
function chooseMsxVerticalShift(settingVars, defaultShift)
    local oldShift = settingVars.verticalShift
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local resetButtonPressed = imgui.Button("R", TERTIARY_BUTTON_SIZE)
    if (resetButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.reset_secondary])) then
        settingVars.verticalShift = defaultShift or 0
    end
    HoverToolTip("Reset vertical shift to initial values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N", TERTIARY_BUTTON_SIZE)
    if negateButtonPressed and settingVars.verticalShift ~= 0 then
        settingVars.verticalShift = -settingVars.verticalShift
    end
    HoverToolTip("Negate vertical shift")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local inputText = "Vertical Shift"
    _, settingVars.verticalShift = imgui.InputFloat(inputText, settingVars.verticalShift, 0, 0, "%.0f msx")
    imgui.PopItemWidth()
    imgui.PopStyleVar(3)
    return oldShift ~= settingVars.verticalShift
end
function chooseControlSecondSV(settingVars)
    local oldChoice = settingVars.controlLastSV
    local stutterControlsIndex = 1
    if oldChoice then stutterControlsIndex = 2 end
    local newStutterControlsIndex = Combo("Control SV", STUTTER_CONTROLS, stutterControlsIndex)
    settingVars.controlLastSV = newStutterControlsIndex == 2
    local choiceChanged = oldChoice ~= settingVars.controlLastSV
    if choiceChanged then settingVars.stutterDuration = 100 - settingVars.stutterDuration end
    return choiceChanged
end
function chooseCurrentFrame(settingVars)
    imgui.AlignTextToFramePadding()
    imgui.Text("Previewing frame:")
    KeepSameLine()
    imgui.PushItemWidth(35)
    if imgui.ArrowButton("##leftFrame", imgui_dir.Left) then
        settingVars.currentFrame = settingVars.currentFrame - 1
    end
    KeepSameLine()
    _, settingVars.currentFrame = imgui.InputInt("##currentFrame", settingVars.currentFrame, 0, 0)
    KeepSameLine()
    if imgui.ArrowButton("##rightFrame", imgui_dir.Right) then
        settingVars.currentFrame = settingVars.currentFrame + 1
    end
    settingVars.currentFrame = math.wrappedClamp(settingVars.currentFrame, 1, settingVars.numFrames)
    imgui.PopItemWidth()
end
function chooseCursorTrail()
    local oldCursorTrailIndex = globalVars.cursorTrailIndex
    globalVars.cursorTrailIndex = Combo("Cursor Trail", CURSOR_TRAILS, oldCursorTrailIndex)
    if (oldCursorTrailIndex ~= globalVars.cursorTrailIndex) then
        write(globalVars)
    end
end
function chooseCursorTrailGhost()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    GlobalCheckbox("cursorTrailGhost", "No Ghost")
end
function chooseCursorTrailPoints()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    local settingChanged = BasicInputInt(globalVars, "cursorTrailPoints", "Trail Points")
    if settingChanged then
        write(globalVars)
    end
end
function chooseCursorTrailShape()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    local label = "Trail Shape"
    local oldTrailShapeIndex = globalVars.cursorTrailShapeIndex
    globalVars.cursorTrailShapeIndex = Combo(label, TRAIL_SHAPES, oldTrailShapeIndex)
    if (oldTrailShapeIndex ~= globalVars.cursorTrailShapeIndex) then
        write(globalVars)
    end
end
function chooseCursorShapeSize()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    local settingChanged = BasicInputInt(globalVars, "cursorTrailSize", "Shape Size")
    if settingChanged then
        write(globalVars)
    end
end
function chooseCurveSharpness(settingVars)
    local oldSharpness = settingVars.curveSharpness
    if imgui.Button("Reset##curveSharpness", SECONDARY_BUTTON_SIZE) then
        settingVars.curveSharpness = 50
    end
    KeepSameLine()
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local _, newSharpness = imgui.SliderInt("Curve Sharpness", settingVars.curveSharpness, 1, 100, "%d%%")
    imgui.PopItemWidth()
    settingVars.curveSharpness = newSharpness
    return oldSharpness ~= newSharpness
end
function chooseCustomMultipliers(settingVars)
    imgui.BeginChild("Custom Multipliers", vector.New(imgui.GetContentRegionAvailWidth(), 90), 1)
    for i = 1, #settingVars.svMultipliers do
        local selectableText = i .. " )   " .. settingVars.svMultipliers[i]
        if imgui.Selectable(selectableText, settingVars.selectedMultiplierIndex == i) then
            settingVars.selectedMultiplierIndex = i
        end
    end
    imgui.EndChild()
    local index = settingVars.selectedMultiplierIndex
    local oldMultiplier = settingVars.svMultipliers[index]
    local _, newMultiplier = imgui.InputFloat("SV Multiplier", oldMultiplier, 0, 0, "%.2fx")
    settingVars.svMultipliers[index] = newMultiplier
    return oldMultiplier ~= newMultiplier
end
function chooseDistance(menuVars)
    local oldDistance = menuVars.distance
    menuVars.distance = NegatableComputableInputFloat("Distance", menuVars.distance, 3, " msx")
    return oldDistance ~= menuVars.distance
end
function chooseVaryingDistance(settingVars)
    if (not settingVars.linearlyChange) then
        settingVars.distance = NegatableComputableInputFloat("Distance", settingVars.distance, 3, " msx")
        return
    end
    return SwappableNegatableInputFloat2(settingVars, "distance1", "distance2", "Dist.", "msx", 2)
end
function chooseEffectFPS()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    local settingChanged = BasicInputInt(globalVars, "effectFPS", "Effect FPS", { 2, 1000 },
        "Set this to a multiple of UPS or FPS to make cursor effects smooth")
    if settingChanged then
        write(globalVars)
    end
end
function chooseFinalSV(settingVars, skipFinalSV)
    if skipFinalSV then return false end
    local oldIndex = settingVars.finalSVIndex
    local oldCustomSV = settingVars.customSV
    local finalSVType = FINAL_SV_TYPES[settingVars.finalSVIndex]
    if finalSVType ~= "Normal" then
        imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.35)
        _, settingVars.customSV = imgui.InputFloat("SV", settingVars.customSV, 0, 0, "%.2fx")
        KeepSameLine()
        imgui.PopItemWidth()
    else
        imgui.Indent(DEFAULT_WIDGET_WIDTH * 0.35 + 25)
    end
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.5)
    settingVars.finalSVIndex = Combo("Final SV", FINAL_SV_TYPES, settingVars.finalSVIndex)
    HelpMarker("Final SV won't be placed if there's already an SV at the end time")
    if finalSVType == "Normal" then
        imgui.Unindent(DEFAULT_WIDGET_WIDTH * 0.35 + 25)
    end
    imgui.PopItemWidth()
    return (oldIndex ~= settingVars.finalSVIndex) or (oldCustomSV ~= settingVars.customSV)
end
function chooseFrameSpacing(settingVars)
    _, settingVars.frameDistance = imgui.InputFloat("Frame Spacing", settingVars.frameDistance,
        0, 0, "%.0f msx")
    settingVars.frameDistance = math.clamp(settingVars.frameDistance, 2000, 100000)
end
function chooseFrameTimeData(settingVars)
    if not truthy(settingVars.frameTimes) then return end
    local frameTime = settingVars.frameTimes[settingVars.selectedTimeIndex]
    _, frameTime.frame = imgui.InputInt("Frame #", math.floor(frameTime.frame))
    frameTime.frame = math.clamp(frameTime.frame, 1, settingVars.numFrames)
    _, frameTime.position = imgui.InputInt("Note height", math.floor(frameTime.position))
end
function chooseIntensity(settingVars)
    local userStepSize = globalVars.stepSize or 5
    local totalSteps = math.ceil(100 / userStepSize)
    local oldIntensity = settingVars.intensity
    local stepIndex = math.floor((oldIntensity - 0.01) / userStepSize)
    local _, newStepIndex = imgui.SliderInt(
        "Intensity",
        stepIndex,
        0,
        totalSteps - 1,
        settingVars.intensity .. "%%"
    )
    local newIntensity = newStepIndex * userStepSize + 99 % userStepSize + 1
    settingVars.intensity = math.clamp(newIntensity, 1, 100)
    return oldIntensity ~= settingVars.intensity
end
function chooseInterlace(menuVars)
    local interlaceChanged = BasicCheckbox(menuVars, "interlace", "Interlace")
    if not menuVars.interlace then return interlaceChanged end
    KeepSameLine()
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.5)
    local oldRatio = menuVars.interlaceRatio
    _, menuVars.interlaceRatio = imgui.InputFloat("Ratio##interlace", menuVars.interlaceRatio,
        0, 0, "%.2f")
    imgui.PopItemWidth()
    return interlaceChanged or oldRatio ~= menuVars.interlaceRatio
end
function chooseMainSV(settingVars)
    local label = "Main SV"
    if settingVars.linearlyChange then label = label .. " (start)" end
    _, settingVars.mainSV = imgui.InputFloat(label, settingVars.mainSV, 0, 0, "%.2fx")
    local helpMarkerText = "This SV will last ~99.99%% of the stutter"
    if not settingVars.linearlyChange then
        HelpMarker(helpMarkerText)
        return
    end
    _, settingVars.mainSV2 = imgui.InputFloat("Main SV (end)", settingVars.mainSV2, 0, 0, "%.2fx")
end
function chooseMenuStep(settingVars)
    imgui.AlignTextToFramePadding()
    imgui.Text("Step # :")
    KeepSameLine()
    imgui.PushItemWidth(24)
    if imgui.ArrowButton("##leftMenuStep", imgui_dir.Left) then
        settingVars.menuStep = settingVars.menuStep - 1
    end
    KeepSameLine()
    _, settingVars.menuStep = imgui.InputInt("##currentMenuStep", settingVars.menuStep, 0, 0)
    KeepSameLine()
    if imgui.ArrowButton("##rightMenuStep", imgui_dir.Right) then
        settingVars.menuStep = settingVars.menuStep + 1
    end
    imgui.PopItemWidth()
    settingVars.menuStep = math.wrappedClamp(settingVars.menuStep, 1, 3)
end
function chooseNoNormalize(settingVars)
    AddPadding()
    return BasicCheckbox(settingVars, "dontNormalize", "Don't normalize to average SV")
end
function chooseNoteSkinType(settingVars)
    settingVars.noteSkinTypeIndex = Combo("Preview skin", NOTE_SKIN_TYPES,
        settingVars.noteSkinTypeIndex)
    HelpMarker("Note skin type for the preview of the frames")
end
function chooseFlickerPosition(menuVars)
    _, menuVars.flickerPosition = imgui.SliderFloat("Flicker Position", menuVars.flickerPosition, 0.05, 0.95,
        math.round(menuVars.flickerPosition * 100) .. "%%")
    menuVars.flickerPosition = math.round(menuVars.flickerPosition * 2, 1) * 0.5
end
function chooseNumPeriods(settingVars)
    local oldPeriods = settingVars.periods
    local _, newPeriods = imgui.InputFloat("Periods/Cycles", oldPeriods, 0.25, 0.25, "%.2f")
    newPeriods = math.quarter(newPeriods)
    newPeriods = math.clamp(newPeriods, 0.25, 69420)
    settingVars.periods = newPeriods
    return oldPeriods ~= newPeriods
end
function choosePeriodShift(settingVars)
    local oldShift = settingVars.periodsShift
    local _, newShift = imgui.InputFloat("Phase Shift", oldShift, 0.25, 0.25, "%.2f")
    if (globalVars.restrictSinusoidalPeriod) then
        newShift = math.quarter(newShift)
        newShift = math.wrappedClamp(newShift, -0.75, 1)
    else
        newShift = math.wrappedClamp(newShift, -1, 1)
    end
    settingVars.periodsShift = newShift
    return oldShift ~= newShift
end
function chooseCurrentScrollGroup()
    imgui.AlignTextToFramePadding()
    imgui.Text("  Timing Group: ")
    KeepSameLine()
    local groups = { "$Default", "$Global" }
    local cols = { map.TimingGroups["$Default"].ColorRgb or "86,253,110", map.TimingGroups["$Global"].ColorRgb or
    "255,255,255" }
    local hiddenGroups = {}
    for tgId, tg in pairs(map.TimingGroups) do
        if string.find(tgId, "%$") then goto nextTG end
        if (globalVars.hideAutomatic and string.find(tgId, "automate_")) then hiddenGroups[#hiddenGroups + 1] = tgId end
        groups[#groups + 1] = tgId
        table.insert(cols, tg.ColorRgb or "255,255,255")
        ::nextTG::
    end
    local prevIndex = globalVars.scrollGroupIndex
    imgui.PushItemWidth(155)
    globalVars.scrollGroupIndex = Combo("##scrollGroup", groups, globalVars.scrollGroupIndex, cols, hiddenGroups)
    imgui.PopItemWidth()
    AddSeparator()
    if (prevIndex ~= globalVars.scrollGroupIndex) then
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
    end
end
function chooseTimingGroup(label, previousGroup)
    imgui.AlignTextToFramePadding()
    imgui.Text(label)
    KeepSameLine()
    local groups = { "$Default", "$Global" }
    local cols = { map.TimingGroups["$Default"].ColorRgb or "86,253,110", map.TimingGroups["$Global"].ColorRgb or
    "255,255,255" }
    local hiddenGroups = {}
    for tgId, tg in pairs(map.TimingGroups) do
        if string.find(tgId, "%$") then goto nextTG end
        if (globalVars.hideAutomatic and string.find(tgId, "automate_")) then
            table.insert(hiddenGroups,
                tgId)
        end
        groups[#groups + 1] = tgId
        table.insert(cols, tg.ColorRgb or "255,255,255")
        ::nextTG::
    end
    imgui.PushItemWidth(155)
    local previousIndex = table.indexOf(groups, previousGroup)
    local newIndex = Combo("##changingScrollGroup", groups, previousIndex, cols, hiddenGroups)
    imgui.PopItemWidth()
    imgui.Dummy(vector.New(0, 2))
    return groups[newIndex]
end
function chooseRandomScale(settingVars)
    local oldScale = settingVars.randomScale
    local _, newScale = imgui.InputFloat("Random Scale", oldScale, 0, 0, "%.2fx")
    settingVars.randomScale = newScale
    return oldScale ~= newScale
end
function chooseRandomType(settingVars)
    local oldIndex = settingVars.randomTypeIndex
    settingVars.randomTypeIndex = Combo("Random Type", RANDOM_TYPES, settingVars.randomTypeIndex)
    return oldIndex ~= settingVars.randomTypeIndex
end
function chooseRGBPeriod()
    local oldRGBPeriod = globalVars.rgbPeriod
    _, globalVars.rgbPeriod = imgui.InputFloat("RGB cycle length", oldRGBPeriod, 0, 0,
        "%.0f second" .. (math.round(globalVars.rgbPeriod) ~= 1 and "s" or ""))
    globalVars.rgbPeriod = math.clamp(globalVars.rgbPeriod, MIN_RGB_CYCLE_TIME,
        MAX_RGB_CYCLE_TIME)
    if (oldRGBPeriod ~= globalVars.rgbPeriod) then
        write(globalVars)
    end
end
function chooseScaleType(menuVars)
    local label = "Scale Type"
    menuVars.scaleTypeIndex = Combo(label, SCALE_TYPES, menuVars.scaleTypeIndex)
    local scaleType = SCALE_TYPES[menuVars.scaleTypeIndex]
    if scaleType == "Average SV" then chooseAverageSV(menuVars) end
    if scaleType == "Absolute Distance" then chooseDistance(menuVars) end
    if scaleType == "Relative Ratio" then menuVars.ratio = ComputableInputFloat("Ratio", menuVars.ratio, 3) end
end
function chooseSnakeSpringConstant()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    local oldValue = globalVars.snakeSpringConstant
    _, globalVars.snakeSpringConstant = imgui.InputFloat("Reactiveness##snake", oldValue, 0, 0, "%.2f")
    HelpMarker("Pick any number from 0.01 to 1")
    globalVars.snakeSpringConstant = math.clamp(globalVars.snakeSpringConstant, 0.01, 1)
    if (globalVars.snakeSpringConstant ~= oldValue) then
        write(globalVars)
    end
end
function chooseSpecialSVType(menuVars)
    local emoticonIndex = menuVars.svTypeIndex + #STANDARD_SVS
    local label = "  " .. EMOTICONS[emoticonIndex]
    menuVars.svTypeIndex = Combo(label, SPECIAL_SVS, menuVars.svTypeIndex)
end
function chooseVibratoSVType(menuVars)
    local emoticonIndex = menuVars.svTypeIndex + #VIBRATO_SVS
    local label = "  " .. EMOTICONS[emoticonIndex]
    menuVars.svTypeIndex = Combo(label, VIBRATO_SVS, menuVars.svTypeIndex)
end
function chooseVibratoQuality(menuVars)
    menuVars.vibratoQuality = Combo("Vibrato Quality", VIBRATO_DETAILED_QUALITIES, menuVars.vibratoQuality)
    HoverToolTip("Note that higher FPS will look worse on lower refresh rate monitors.")
end
function chooseCurvatureCoefficient(settingVars, plotFn)
    plotFn(settingVars)
    imgui.SameLine(0, 0)
    _, settingVars.curvatureIndex = imgui.SliderInt("Curvature", settingVars.curvatureIndex, 1, #VIBRATO_CURVATURES,
        tostring(VIBRATO_CURVATURES[settingVars.curvatureIndex]))
end
function chooseStandardSVType(menuVars, excludeCombo)
    local oldIndex = menuVars.svTypeIndex
    local label = " " .. EMOTICONS[oldIndex]
    local svTypeList = STANDARD_SVS
    if excludeCombo then svTypeList = STANDARD_SVS_NO_COMBO end
    menuVars.svTypeIndex = Combo(label, svTypeList, menuVars.svTypeIndex)
    return oldIndex ~= menuVars.svTypeIndex
end
function chooseStandardSVTypes(settingVars)
    local oldIndex1 = settingVars.svType1Index
    local oldIndex2 = settingVars.svType2Index
    settingVars.svType1Index = Combo("SV Type 1", STANDARD_SVS_NO_COMBO, settingVars.svType1Index)
    settingVars.svType2Index = Combo("SV Type 2", STANDARD_SVS_NO_COMBO, settingVars.svType2Index)
    return (oldIndex2 ~= settingVars.svType2Index) or (oldIndex1 ~= settingVars.svType1Index)
end
function chooseStartEndSVs(settingVars)
    if settingVars.linearlyChange == false then
        local oldValue = settingVars.startSV
        _, settingVars.startSV = imgui.InputFloat("SV Value", oldValue, 0, 0, "%.2fx")
        return oldValue ~= settingVars.startSV
    end
    return SwappableNegatableInputFloat2(settingVars, "startSV", "endSV", "Start/End SV")
end
function chooseStartSVPercent(settingVars)
    local label1 = "Start SV %"
    if settingVars.linearlyChange then label1 = label1 .. " (start)" end
    _, settingVars.svPercent = imgui.InputFloat(label1, settingVars.svPercent, 1, 1, "%.2f%%")
    local helpMarkerText = "%% distance between notes"
    if not settingVars.linearlyChange then
        HelpMarker(helpMarkerText)
        return
    end
    local label2 = "Start SV % (end)"
    _, settingVars.svPercent2 = imgui.InputFloat(label2, settingVars.svPercent2, 1, 1, "%.2f%%")
end
function chooseStillType(menuVars)
    local tooltipList = {
        "Don't use an initial or end displacement.",
        "Use an initial starting displacement for the still.",
        "Have a displacement to end at for the still.",
        "Use last displacement of the previous still to start.",
        "Use next displacement of the next still to end at.",
    }
    local stillType = STILL_TYPES[menuVars.stillTypeIndex]
    local dontChooseDistance = stillType == "No" or
        stillType == "Auto" or
        stillType == "Otua"
    local indentWidth = DEFAULT_WIDGET_WIDTH * 0.5 + 16
    if dontChooseDistance then
        imgui.Indent(indentWidth)
    else
        imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.6 - 5)
        menuVars.stillDistance = ComputableInputFloat("##still", menuVars.stillDistance, 2, " msx")
        KeepSameLine()
        imgui.PopItemWidth()
    end
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.4)
    menuVars.stillTypeIndex = Combo("Displacement", STILL_TYPES, menuVars.stillTypeIndex, {}, {}, tooltipList)
    HoverToolTip(tooltipList[menuVars.stillTypeIndex])
    if dontChooseDistance then
        imgui.Unindent(indentWidth)
    end
    imgui.PopItemWidth()
end
function chooseStutterDuration(settingVars)
    local oldDuration = settingVars.stutterDuration
    if settingVars.controlLastSV then oldDuration = 100 - oldDuration end
    local _, newDuration = imgui.SliderInt("Duration", oldDuration, 1, 99, oldDuration .. "%%")
    newDuration = math.clamp(newDuration, 1, 99)
    local durationChanged = oldDuration ~= newDuration
    if settingVars.controlLastSV then newDuration = 100 - newDuration end
    settingVars.stutterDuration = newDuration
    return durationChanged
end
function chooseStyleTheme()
    local oldStyleTheme = globalVars.styleThemeIndex
    globalVars.styleThemeIndex = Combo("Style Theme", STYLE_THEMES, oldStyleTheme)
    if (oldStyleTheme ~= globalVars.styleThemeIndex) then
        write(globalVars)
    end
end
function chooseSVBehavior(settingVars)
    local swapButtonPressed = imgui.Button("Swap", SECONDARY_BUTTON_SIZE)
    HoverToolTip("Switch between slow down/speed up")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local oldBehaviorIndex = settingVars.behaviorIndex
    settingVars.behaviorIndex = Combo("Behavior", SV_BEHAVIORS, oldBehaviorIndex)
    imgui.PopItemWidth()
    if (swapButtonPressed or kbm.pressedKeyCombo(globalVars.hotkeyList[hotkeys_enum.swap_primary])) then
        settingVars.behaviorIndex = tn(oldBehaviorIndex == 1) + 1
    end
    imgui.PopStyleVar()
    return oldBehaviorIndex ~= settingVars.behaviorIndex
end
function chooseSVPerQuarterPeriod(settingVars)
    local oldPoints = settingVars.svsPerQuarterPeriod
    local _, newPoints = imgui.InputInt("SV Points##perQuarter", oldPoints, 1, 1)
    HelpMarker("Number of SV points per 0.25 period/cycle")
    local maxSVsPerQuarterPeriod = MAX_SV_POINTS / (4 * settingVars.periods)
    newPoints = math.clamp(newPoints, 1, maxSVsPerQuarterPeriod)
    settingVars.svsPerQuarterPeriod = newPoints
    return oldPoints ~= newPoints
end
function chooseSVPoints(settingVars, svPointsForce)
    if svPointsForce then
        settingVars.svPoints = svPointsForce
        return false
    end
    return BasicInputInt(settingVars, "svPoints", "SV Points##regular", { 1, MAX_SV_POINTS })
end
function chooseDistanceMode(menuVars)
    local oldMode = menuVars.distanceMode
    menuVars.distanceMode = Combo("Distance Type", DISTANCE_TYPES, menuVars.distanceMode)
    return oldMode ~= menuVars.distanceMode
end
function choosePulseCoefficient()
    local oldCoefficient = globalVars.pulseCoefficient
    _, globalVars.pulseCoefficient = imgui.SliderFloat("Pulse Strength", oldCoefficient, 0, 1,
        math.round(globalVars.pulseCoefficient * 100) .. "%%")
    globalVars.pulseCoefficient = math.clamp(globalVars.pulseCoefficient, 0, 1)
    if (oldCoefficient ~= globalVars.pulseCoefficient) then
        write(globalVars)
    end
end
function choosePulseColor()
    _, colorPickerOpened = imgui.Begin("plumoguSV Pulse Color Picker", true,
        imgui_window_flags.AlwaysAutoResize)
    local oldColor = globalVars.pulseColor
    _, globalVars.pulseColor = imgui.ColorPicker4("Pulse Color", globalVars.pulseColor)
    if (oldColor ~= globalVars.pulseColor) then
        write(globalVars)
    end
    if (not colorPickerOpened) then
        state.SetValue("showColorPicker", false)
    end
    imgui.End()
end
function chooseVibratoSides(menuVars)
    imgui.Dummy(vector.New(27, 0))
    KeepSameLine()
    menuVars.sides = RadioButtons("Sides:", menuVars.sides, { "1", "2", "3" }, { 1, 2, 3 })
end
function chooseConvertSVSSFDirection(menuVars)
    menuVars.conversionDirection = RadioButtons("Direction:", menuVars.conversionDirection, { "SSF -> SV", "SV -> SSF" },
        { false, true })
end
function calculateDisplacementsFromNotes(noteOffsets, noteSpacing)
    local totalDisplacement = 0
    local displacements = { 0 }
    for i = 1, #noteOffsets - 1 do
        local time = (noteOffsets[i + 1] - noteOffsets[i])
        local distance = time * noteSpacing
        totalDisplacement = totalDisplacement + distance
        displacements[#displacements + 1] = totalDisplacement
    end
    return displacements
end
function calculateDisplacementFromSVs(svs, startOffset, endOffset)
    return calculateDisplacementsFromSVs(svs, { startOffset, endOffset })[2]
end
function calculateDisplacementsFromSVs(svs, offsets)
    local totalDisplacement = 0
    local displacements = {}
    local lastOffset = offsets[#offsets]
    addSVToList(svs, lastOffset, 0, true)
    local j = 1
    for i = 1, (#svs - 1) do
        local lastSV = svs[i]
        local nextSV = svs[i + 1]
        local svTimeDifference = nextSV.StartTime - lastSV.StartTime
        while nextSV.StartTime > offsets[j] do
            local svToOffsetTime = offsets[j] - lastSV.StartTime
            local displacement = totalDisplacement
            if svToOffsetTime > 0 then
                displacement = displacement + lastSV.Multiplier * svToOffsetTime
            end
            displacements[#displacements + 1] = displacement
            j = j + 1
        end
        if svTimeDifference > 0 then
            local thisDisplacement = svTimeDifference * lastSV.Multiplier
            totalDisplacement = totalDisplacement + thisDisplacement
        end
    end
    table.remove(svs)
    displacements[#displacements + 1] = totalDisplacement
    return displacements
end
function calculateStillDisplacements(stillType, stillDistance, svDisplacements, nsvDisplacements)
    local finalDisplacements = {}
    for i = 1, #svDisplacements do
        local difference = nsvDisplacements[i] - svDisplacements[i]
        finalDisplacements[#finalDisplacements + 1] = difference
    end
    local extraDisplacement = stillDistance
    if stillType == "End" or stillType == "Otua" then
        extraDisplacement = stillDistance - finalDisplacements[#finalDisplacements]
    end
    if stillType ~= "No" then
        for i = 1, #finalDisplacements do
            finalDisplacements[i] = finalDisplacements[i] + extraDisplacement
        end
    end
    return finalDisplacements
end
--
--
function getUsableDisplacementMultiplier(offset)
    local exponent = math.clamp(23 - math.floor(math.log(math.abs(offset) + 1, 2)), 0,
        globalVars.maxDisplacementMultiplierExponent)
    return 2 ^ exponent
end
function prepareDisplacingSV(svsToAdd, svTimeIsAdded, svTime, displacement, displacementMultiplier, hypothetical, svs)
    svTimeIsAdded[svTime] = true
    local currentSVMultiplier = game.getSVMultiplierAt(svTime)
    if hypothetical == true then
        currentSVMultiplier = getHypotheticalSVMultiplierAt(svs, svTime)
    end
    local newSVMultiplier = displacementMultiplier * displacement + currentSVMultiplier
    addSVToList(svsToAdd, svTime, newSVMultiplier, true)
end
function prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, beforeDisplacement, atDisplacement,
                              afterDisplacement, hypothetical, baseSVs)
    local displacementMultiplier = getUsableDisplacementMultiplier(offset)
    local duration = 1 / displacementMultiplier
    if beforeDisplacement then
        local timeBefore = offset - duration
        prepareDisplacingSV(svsToAdd, svTimeIsAdded, timeBefore, beforeDisplacement,
            displacementMultiplier, hypothetical, baseSVs)
    end
    if atDisplacement then
        local timeAt = offset
        prepareDisplacingSV(svsToAdd, svTimeIsAdded, timeAt, atDisplacement,
            displacementMultiplier, hypothetical, baseSVs)
    end
    if afterDisplacement then
        local timeAfter = offset + duration
        prepareDisplacingSV(svsToAdd, svTimeIsAdded, timeAfter, afterDisplacement,
            displacementMultiplier, hypothetical, baseSVs)
    end
end
function generateBezierSet(p1, p2, avgValue, numValues, verticalShift)
    avgValue = avgValue - verticalShift
    local startingTimeGuess = 0.5
    local timeGuesses = {}
    local targetXPositions = {}
    local iterations = 20
    local xPosCount = numValues
    if (globalVars.equalizeLinear) then xPosCount = xPosCount - 1 end
    for i = 1, numValues do
        timeGuesses[#timeGuesses + 1] = startingTimeGuess
        targetXPositions[#targetXPositions + 1] = i / xPosCount
    end
    for i = 1, iterations do
        local timeIncrement = 0.5 ^ (i + 1)
        for j = 1, numValues do
            local xPositionGuess = math.cubicBezier(p1.x, p2.x, timeGuesses[j])
            if xPositionGuess < targetXPositions[j] then
                timeGuesses[j] = timeGuesses[j] + timeIncrement
            elseif xPositionGuess > targetXPositions[j] then
                timeGuesses[j] = timeGuesses[j] - timeIncrement
            end
        end
    end
    local yPositions = { 0 }
    for i = 1, #timeGuesses do
        local yPosition = math.cubicBezier(p1.y, p2.y, timeGuesses[i])
        yPositions[#yPositions + 1] = yPosition
    end
    local bezierSet = {}
    for i = 1, #yPositions - 1 do
        local slope = (yPositions[i + 1] - yPositions[i]) * numValues
        bezierSet[#bezierSet + 1] = slope
    end
    bezierSet = table.normalize(bezierSet, avgValue, false)
    for i = 1, #bezierSet do
        bezierSet[i] = bezierSet[i] + verticalShift
    end
    return bezierSet
end
function generateChinchillaSet(settingVars)
    if settingVars.svPoints == 1 then return { settingVars.avgSV, settingVars.avgSV } end
    local avgValue = settingVars.avgSV - settingVars.verticalShift
    local chinchillaSet = {}
    local percents = generateLinearSet(0, 1, settingVars.svPoints + 1)
    local newPercents = {}
    for i = 1, #percents do
        local currentPercent = percents[i]
        local newPercent = scalePercent(settingVars, currentPercent) --
        newPercents[#newPercents + 1] = newPercent
    end
    local numValues = settingVars.svPoints
    for i = 1, numValues do
        local distance = newPercents[i + 1] - newPercents[i]
        local slope = distance * numValues
        chinchillaSet[i] = slope
    end
    chinchillaSet = table.normalize(chinchillaSet, avgValue, true)
    for i = 1, #chinchillaSet do
        chinchillaSet[i] = chinchillaSet[i] + settingVars.verticalShift
    end
    chinchillaSet[#chinchillaSet + 1] = settingVars.avgSV
    return chinchillaSet
end
function scalePercent(settingVars, percent)
    local behaviorType = SV_BEHAVIORS[settingVars.behaviorIndex]
    local slowDownType = behaviorType == "Slow down"
    local workingPercent = percent
    if slowDownType then workingPercent = 1 - percent end
    local newPercent
    local a = settingVars.chinchillaIntensity
    local scaleType = CHINCHILLA_TYPES[settingVars.chinchillaTypeIndex]
    if scaleType == "Exponential" then
        local exponent = a * (workingPercent - 1)
        newPercent = (workingPercent * math.exp(exponent))
    elseif scaleType == "Polynomial" then
        local exponent = a + 1
        newPercent = workingPercent ^ exponent
    elseif scaleType == "Circular" then
        if a == 0 then return percent end
        local b = 1 / (a ^ (a + 1))
        local radicand = (b + 1) ^ 2 + b * b - (workingPercent + b) ^ 2
        newPercent = b + 1 - math.sqrt(radicand)
    elseif scaleType == "Sine Power" then
        local exponent = math.log(a + 1)
        local base = math.sin(math.pi * (workingPercent - 1) * 0.5) + 1
        newPercent = workingPercent * (base ^ exponent)
    elseif scaleType == "Arc Sine Power" then
        local exponent = math.log(a + 1)
        local base = 2 * math.asin(workingPercent) / math.pi
        newPercent = workingPercent * (base ^ exponent)
    elseif scaleType == "Inverse Power" then
        local denominator = 1 + (workingPercent ^ -a)
        newPercent = 2 * workingPercent / denominator
    elseif "Peter Stock" then
        if a == 0 then return percent end
        local c = a / (1 - a)
        newPercent = (workingPercent ^ 2) * (1 + c) / (workingPercent + c)
    end
    if slowDownType then newPercent = 1 - newPercent end
    return math.clamp(newPercent, 0, 1)
end
function generateCircularSet(behavior, arcPercent, avgValue, verticalShift, numValues,
                             dontNormalize)
    local increaseValues = (behavior == "Speed up")
    avgValue = avgValue - verticalShift
    local startingAngle = math.pi * (arcPercent * 0.01)
    local angles = generateLinearSet(startingAngle, 0, numValues)
    local yCoords = {}
    for i = 1, #angles do
        local angle = math.round(angles[i], 8)
        local x = math.cos(angle)
        yCoords[i] = -avgValue * math.sqrt(1 - x * x)
    end
    local circularSet = {}
    for i = 1, #yCoords - 1 do
        local startY = yCoords[i]
        local endY = yCoords[i + 1]
        circularSet[i] = (endY - startY) * (numValues - 1)
    end
    if not increaseValues then circularSet = table.reverse(circularSet) end
    if not dontNormalize then circularSet = table.normalize(circularSet, avgValue, true) end
    for i = 1, #circularSet do
        circularSet[i] = circularSet[i] + verticalShift
    end
    circularSet[#circularSet + 1] = avgValue
    return circularSet
end
function generateComboSet(values1, values2, comboPhase, comboType, comboMultiplier1,
                          comboMultiplier2, dontNormalize, avgValue, verticalShift)
    local comboValues = {}
    if comboType == "SV Type 1 Only" then
        comboValues = table.duplicate(values1)
    elseif comboType == "SV Type 2 Only" then
        comboValues = table.duplicate(values2)
    else
        local lastValue1 = table.remove(values1)
        local lastValue2 = table.remove(values2)
        local endIndex1 = #values1 - comboPhase
        local startIndex1 = comboPhase + 1
        local endIndex2 = comboPhase - #values1
        local startIndex2 = #values1 + #values2 + 1 - comboPhase
        for i = 1, endIndex1 do
            comboValues[#comboValues + 1] = values1[i]
        end
        for i = 1, endIndex2 do
            comboValues[#comboValues + 1] = values2[i]
        end
        if comboType ~= "Remove" then
            local comboValues1StartIndex = endIndex1 + 1
            local comboValues1EndIndex = startIndex2 - 1
            local comboValues2StartIndex = endIndex2 + 1
            local comboValues2EndIndex = startIndex1 - 1
            local comboValues1 = {}
            for i = comboValues1StartIndex, comboValues1EndIndex do
                comboValues1[#comboValues1 + 1] = values1[i]
            end
            local comboValues2 = {}
            for i = comboValues2StartIndex, comboValues2EndIndex do
                comboValues2[#comboValues2 + 1] = values2[i]
            end
            for i = 1, #comboValues1 do
                local comboValue1 = comboValues1[i]
                local comboValue2 = comboValues2[i]
                local finalValue
                if comboType == "Add" then
                    finalValue = comboMultiplier1 * comboValue1 + comboMultiplier2 * comboValue2
                elseif comboType == "Cross Multiply" then
                    finalValue = comboValue1 * comboValue2
                elseif comboType == "Min" then
                    finalValue = math.min(comboValue1, comboValue2)
                elseif comboType == "Max" then
                    finalValue = math.max(comboValue1, comboValue2)
                end
                comboValues[#comboValues + 1] = finalValue
            end
        end
        for i = startIndex1, #values2 do
            comboValues[#comboValues + 1] = values2[i]
        end
        for i = startIndex2, #values1 do
            comboValues[#comboValues + 1] = values1[i]
        end
        if not truthy(comboValues) then comboValues[#comboValues + 1] = 1 end
        if (comboPhase - #values2 >= 0) then
            comboValues[#comboValues + 1] = lastValue1
        else
            comboValues[#comboValues + 1] = lastValue2
        end
    end
    avgValue = avgValue - verticalShift
    if not dontNormalize then
        comboValues = table.normalize(comboValues, avgValue, false)
    end
    for i = 1, #comboValues do
        comboValues[i] = comboValues[i] + verticalShift
    end
    return comboValues
end
function generateCustomSet(values)
    local newValues = table.duplicate(values)
    local averageMultiplier = table.average(newValues, true)
    newValues[#newValues + 1] = averageMultiplier
    return newValues
end
function generateExponentialSet(behavior, numValues, avgValue, intensity, verticalShift)
    avgValue = avgValue - verticalShift
    local exponentialIncrease = (behavior == "Speed up")
    local exponentialSet = {}
    intensity = intensity * 0.2
    for i = 0, numValues - 1 do
        local x
        if exponentialIncrease then
            x = (i + 0.5) * intensity / numValues
        else
            x = (numValues - i - 0.5) * intensity / numValues
        end
        local y = math.exp(x - 1) / intensity
        exponentialSet[#exponentialSet + 1] = y
    end
    exponentialSet = table.normalize(exponentialSet, avgValue, false)
    for i = 1, #exponentialSet do
        exponentialSet[i] = exponentialSet[i] + verticalShift
    end
    return exponentialSet
end
function generateExponentialSet2(behavior, numValues, startValue, endValue, intensity)
    local exponentialSet = {}
    intensity = intensity * 0.2
    if (behavior == "Slow down" and startValue ~= endValue) then
        startValue, endValue = endValue, startValue
    end
    for i = 0, numValues - 1 do
        fx = startValue
        local x = i / (numValues - 1)
        local k = (endValue - startValue) / (math.exp(intensity) - 1)
        fx = k * math.exp(intensity * x) + startValue - k
        exponentialSet[#exponentialSet + 1] = fx
    end
    if (behavior == "Slow down" and startValue ~= endValue) then
        exponentialSet = table.reverse(exponentialSet)
    end
    return exponentialSet
end
function generateHermiteSet(startValue, endValue, verticalShift, avgValue, numValues)
    avgValue = avgValue - verticalShift
    local xCoords = generateLinearSet(0, 1, numValues)
    local yCoords = {}
    for i = 1, #xCoords do
        yCoords[i] = math.hermite(startValue, endValue, avgValue, xCoords[i])
    end
    local hermiteSet = {}
    for i = 1, #yCoords - 1 do
        local startY = yCoords[i]
        local endY = yCoords[i + 1]
        hermiteSet[i] = (endY - startY) * (numValues - 1)
    end
    for i = 1, #hermiteSet do
        hermiteSet[i] = hermiteSet[i] + verticalShift
    end
    hermiteSet[#hermiteSet + 1] = avgValue
    return hermiteSet
end
function generateLinearSet(startValue, endValue, numValues, placingSV)
    local linearSet = { startValue }
    if numValues < 2 then return linearSet end
    if (globalVars.equalizeLinear and placingSV and numValues > 2) then
        endValue = endValue +
            (endValue - startValue) / (numValues - 2)
    end
    local increment = (endValue - startValue) / (numValues - 1)
    for i = 1, (numValues - 1) do
        linearSet[#linearSet + 1] = startValue + i * increment
    end
    return linearSet
end
function getRandomSet(values, avgValue, verticalShift, dontNormalize)
    avgValue = avgValue - verticalShift
    local randomSet = {}
    for i = 1, #values do
        randomSet[#randomSet + 1] = values[i]
    end
    if not dontNormalize then
        randomSet = table.normalize(randomSet, avgValue, false)
    end
    for i = 1, #randomSet do
        randomSet[i] = randomSet[i] + verticalShift
    end
    return randomSet
end
function generateRandomSet(numValues, randomType, randomScale)
    local randomSet = {}
    for _ = 1, numValues do
        if randomType == "Uniform" then
            local randomValue = randomScale * 2 * (0.5 - math.random())
            randomSet[#randomSet + 1] = randomValue
        elseif randomType == "Normal" then
            local u1 = math.random()
            local u2 = math.random()
            local randomIncrement = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
            local randomValue = randomScale * randomIncrement
            randomSet[#randomSet + 1] = randomValue
        end
    end
    return randomSet
end
function generateSinusoidalSet(startAmplitude, endAmplitude, periods, periodsShift,
                               valuesPerQuarterPeriod, verticalShift, curveSharpness)
    local sinusoidalSet = {}
    local quarterPeriods = 4 * periods
    local quarterPeriodsShift = 4 * periodsShift
    local totalValues = valuesPerQuarterPeriod * quarterPeriods
    local amplitudes = generateLinearSet(startAmplitude, endAmplitude, totalValues + 1)
    local normalizedSharpness
    if curveSharpness > 50 then
        normalizedSharpness = math.sqrt((curveSharpness - 50) * 2)
    else
        normalizedSharpness = (curveSharpness * 0.02) ^ 2
    end
    for i = 0, totalValues do
        local angle = (math.pi * 0.5) * ((i / valuesPerQuarterPeriod) + quarterPeriodsShift)
        local value = amplitudes[i + 1] * (math.abs(math.sin(angle)) ^ (normalizedSharpness))
        value = value * math.sign(math.sin(angle)) + verticalShift
        sinusoidalSet[#sinusoidalSet + 1] = value
    end
    return sinusoidalSet
end
function generateStutterSet(stutterValue, stutterDuration, avgValue, controlLastValue)
    local durationPercent = stutterDuration * 0.01
    if controlLastValue then durationPercent = 1 - durationPercent end
    local otherValue = (avgValue - stutterValue * durationPercent) / (1 - durationPercent)
    local stutterSet = { stutterValue, otherValue, avgValue }
    if controlLastValue then stutterSet = { otherValue, stutterValue, avgValue } end
    return stutterSet
end
function generateSVMultipliers(svType, settingVars, interlaceMultiplier)
    local multipliers = { 727, 69 } ---@type number[]
    if svType == "Linear" then
        multipliers = generateLinearSet(settingVars.startSV, settingVars.endSV,
            settingVars.svPoints + 1, true)
    elseif svType == "Exponential" then
        local behavior = SV_BEHAVIORS[settingVars.behaviorIndex]
        if (settingVars.distanceMode == 3) then
            multipliers = generateExponentialSet2(behavior, settingVars.svPoints + 1, settingVars.startSV,
                settingVars.endSV,
                settingVars.intensity)
        else
            multipliers = generateExponentialSet(behavior, settingVars.svPoints + 1, settingVars.avgSV,
                settingVars.intensity, settingVars.verticalShift)
        end
    elseif svType == "Bezier" then
        multipliers = generateBezierSet(settingVars.p1, settingVars.p2, settingVars.avgSV,
            settingVars.svPoints + 1, settingVars.verticalShift)
    elseif svType == "Hermite" then
        multipliers = generateHermiteSet(settingVars.startSV, settingVars.endSV,
            settingVars.verticalShift, settingVars.avgSV,
            settingVars.svPoints + 1)
    elseif svType == "Sinusoidal" then
        multipliers = generateSinusoidalSet(settingVars.startSV, settingVars.endSV,
            settingVars.periods, settingVars.periodsShift,
            settingVars.svsPerQuarterPeriod,
            settingVars.verticalShift, settingVars.curveSharpness)
    elseif svType == "Circular" then
        local behavior = SV_BEHAVIORS[settingVars.behaviorIndex]
        multipliers = generateCircularSet(behavior, settingVars.arcPercent, settingVars.avgSV,
            settingVars.verticalShift, settingVars.svPoints + 1,
            settingVars.dontNormalize)
    elseif svType == "Random" then
        if not truthy(settingVars.svMultipliers) then
            generateRandomSetMenuSVs(settingVars)
        end
        multipliers = getRandomSet(settingVars.svMultipliers, settingVars.avgSV,
            settingVars.verticalShift, settingVars.dontNormalize)
    elseif svType == "Custom" then
        multipliers = generateCustomSet(settingVars.svMultipliers)
    elseif svType == "Chinchilla" then
        multipliers = generateChinchillaSet(settingVars)
    elseif svType == "Combo" then
        local svType1 = STANDARD_SVS[settingVars.svType1Index]
        local settingVars1 = getSettingVars(svType1, "Combo1")
        local multipliers1 = generateSVMultipliers(svType1, settingVars1, nil)
        local labelText1 = svType1 .. "Combo1"
        cache.saveTable(labelText1 .. "Settings", settingVars1)
        local svType2 = STANDARD_SVS[settingVars.svType2Index]
        local settingVars2 = getSettingVars(svType2, "Combo2")
        local multipliers2 = generateSVMultipliers(svType2, settingVars2, nil)
        local labelText2 = svType2 .. "Combo2"
        cache.saveTable(labelText2 .. "Settings", settingVars2)
        local comboType = COMBO_SV_TYPE[settingVars.comboTypeIndex]
        multipliers = generateComboSet(multipliers1, multipliers2, settingVars.comboPhase,
            comboType, settingVars.comboMultiplier1,
            settingVars.comboMultiplier2, settingVars.dontNormalize,
            settingVars.avgSV, settingVars.verticalShift)
    elseif svType == "Code" then
        multipliers = {}
        local fn = eval(settingVars.code) ---@type fun(t: number): number
        for i = 0, settingVars.svPoints do
            multipliers[#multipliers + 1] = fn(i / settingVars.svPoints)
        end
    elseif svType == "Stutter1" then
        multipliers = generateStutterSet(settingVars.startSV, settingVars.stutterDuration,
            settingVars.avgSV, settingVars.controlLastSV)
    elseif svType == "Stutter2" then
        multipliers = generateStutterSet(settingVars.endSV, settingVars.stutterDuration,
            settingVars.avgSV, settingVars.controlLastSV)
    end
    if interlaceMultiplier then
        local newMultipliers = {}
        for i = 1, #multipliers do
            newMultipliers[#newMultipliers + 1] = multipliers[i]
            newMultipliers[#newMultipliers + 1] = multipliers[i] * interlaceMultiplier
        end
        if settingVars.avgSV and not settingVars.dontNormalize then
            newMultipliers = table.normalize(newMultipliers, settingVars.avgSV, false)
        end
        multipliers = newMultipliers
    end
    return multipliers
end
function createFrameTime(thisTime, thisLanes, thisFrame, thisPosition)
    local frameTime = {
        time = thisTime,
        lanes = thisLanes,
        frame = thisFrame,
        position = thisPosition
    }
    return frameTime
end
function listenForTimingGroupCount()
    state.SetValue("tgList", game.getTimingGroupList())
    listen(function(action, type, fromLua)
        local actionIndex = tonumber(action.Type)
        if (actionIndex < action_type.CreateTimingGroup and actionIndex ~= action_type.Batch) then return end
        state.SetValue("tgList", game.getTimingGroupList())
    end)
end
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
    if (not globalVars.printLegacyLNMessage or state.GetValue("disablePrintLegacyLNMessage")) then return end
    if (not checkNotesForLNs(state.SelectedHitObjects) or map.LegacyLNRendering) then return end
    print("w!",
        'Using any sort of displacements with LNs while Legacy LN rendering is highly discouraged. Consider turning on Legacy LN Rendering in the F1 menu. You can permanently disable this message in the plumoguSV settings.')
    state.SetValue("disablePrintLegacyLNMessage", true)
end
---Alias for [`utils.CreateScrollVelocity`](lua://utils.CreateScrollVelocity).
---@param startTime number
---@param multiplier number
---@return ScrollVelocity
function createSV(startTime, multiplier)
    return utils.CreateScrollVelocity(startTime, multiplier)
end
---Alias for [`utils.CreateScrollSpeedFactor`](lua://utils.CreateScrollSpeedFactor).
---@param startTime number
---@param multiplier number
---@return ScrollSpeedFactor
function createSSF(startTime, multiplier)
    return utils.CreateScrollSpeedFactor(startTime, multiplier)
end
---Alias for [`utils.CreateEditorAction`](lua://utils.CreateEditorAction).
---@param actionType EditorActionType
---@param ... any
---@return EditorAction
function createEA(actionType, ...)
    return utils.CreateEditorAction(actionType, ...)
end
---Alias for [`utils.CreateScrollGroup`](lua://utils.CreateScrollGroup).
---@param svs ScrollVelocity[]
---@param initialSV? number
---@param colorRgb? string
---@return ScrollGroup
function createSG(svs, initialSV, colorRgb)
    return utils.CreateScrollGroup(svs, initialSV, colorRgb)
end
---Removes and adds SVs.
---@param svsToRemove ScrollVelocity[]
---@param svsToAdd ScrollVelocity[]
function removeAndAddSVs(svsToRemove, svsToAdd)
    local tolerance = 0.035
    if not truthy(svsToAdd) then return end
    for idx, sv in pairs(svsToRemove) do
        local baseSV = game.getSVStartTimeAt(sv.StartTime)
        if (math.abs(baseSV - sv.StartTime) > tolerance) then
            table.remove(svsToRemove, idx)
        end
    end
    local editorActions = {
        createEA(action_type.RemoveScrollVelocityBatch, svsToRemove),
        createEA(action_type.AddScrollVelocityBatch, svsToAdd)
    }
    actions.PerformBatch(editorActions)
    toggleablePrint("s!", table.concat({"Created ", #svsToAdd, pluralize(" SV.", #svsToAdd, -2)}))
end
function removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
    if not truthy(ssfsToAdd) then return end
    local editorActions = {
        createEA(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        createEA(action_type.AddScrollSpeedFactorBatch, ssfsToAdd)
    }
    actions.PerformBatch(editorActions)
    toggleablePrint("s!", table.concat({"Created ", #ssfsToAdd, pluralize(" SSF.", #ssfsToAdd, -2)}))
end
function addFinalSV(svsToAdd, endOffset, svMultiplier, force)
    local sv = map.GetScrollVelocityAt(endOffset)
    local svExistsAtEndOffset = sv and (sv.StartTime == endOffset)
    if svExistsAtEndOffset and not force then return end
    addSVToList(svsToAdd, endOffset, svMultiplier, true)
end
function addFinalSSF(ssfsToAdd, endOffset, ssfMultiplier, force)
    local ssf = map.GetScrollSpeedFactorAt(endOffset)
    local ssfExistsAtEndOffset = ssf and (ssf.StartTime == endOffset)
    if ssfExistsAtEndOffset and not force then return end
    addSSFToList(ssfsToAdd, endOffset, ssfMultiplier, true)
end
function addInitialSSF(ssfsToAdd, startOffset)
    local ssf = map.GetScrollSpeedFactorAt(startOffset)
    if ssf == nil then return end
    local ssfExistsAtStartOffset = ssf and (ssf.StartTime == startOffset)
    if ssfExistsAtStartOffset then return end
    addSSFToList(ssfsToAdd, startOffset, ssf.Multiplier, true)
end
function addStartSVIfMissing(svs, startOffset)
    if #svs ~= 0 and svs[1].StartTime == startOffset then return end
    addSVToList(svs, startOffset, game.getSVMultiplierAt(startOffset), false)
end
function addSVToList(svList, offset, multiplier, endOfList)
    local newSV = createSV(offset, multiplier)
    if endOfList then
        svList[#svList + 1] = newSV
        return
    end
    table.insert(svList, 1, newSV)
end
function addSSFToList(ssfList, offset, multiplier, endOfList)
    local newSSF = createSSF(offset, multiplier)
    if endOfList then
        ssfList[#ssfList + 1] = newSSF
        return
    end
    table.insert(ssfList, 1, newSSF)
end
function getRemovableSVs(svsToRemove, svTimeIsAdded, startOffset, endOffset, retroactiveSVRemovalTable)
    for _, sv in ipairs(map.ScrollVelocities) do
        local svIsInRange = sv.StartTime >= startOffset - 1 and sv.StartTime <= endOffset + 1
        if svIsInRange then
            local svIsRemovable = svTimeIsAdded[sv.StartTime]
            if svIsRemovable then svsToRemove[#svsToRemove + 1] = sv end
        end
    end
    if (not retroactiveSVRemovalTable) then return end
    for idx, sv in pairs(retroactiveSVRemovalTable) do
        local svIsInRange = sv.StartTime >= startOffset - 1 and sv.StartTime <= endOffset + 1
        if svIsInRange then
            local svIsRemovable = svTimeIsAdded[sv.StartTime]
            if svIsRemovable then table.remove(retroactiveSVRemovalTable, idx) end
        end
    end
end
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
---Given a predetermined set of SVs, returns a list of [scroll velocities](lua://ScrollVelocity) within a temporal boundary.
---@param startOffset number The lower bound of the search area.
---@param endOffset number The upper bound of the search area.
---@return ScrollVelocity[] svs All of the [scroll velocities](lua://ScrollVelocity) within the area.
function getHypotheticalSVsBetweenOffsets(svs, startOffset, endOffset)
    local svsBetweenOffsets = {} ---@type ScrollVelocity[]
    for k43 = 1, #svs do
        local sv = svs[k43]
        local svIsInRange = sv.StartTime >= startOffset - 1 and sv.StartTime < endOffset + 1
        if svIsInRange then svsBetweenOffsets[#svsBetweenOffsets + 1] = sv end
    end
    return sort(svsBetweenOffsets, sortAscendingStartTime)
end
function updateMenuSVs(currentSVType, menuVars, settingVars, skipFinalSV)
    local interlaceMultiplier = nil
    if menuVars.interlace then interlaceMultiplier = menuVars.interlaceRatio end
    menuVars.svMultipliers = generateSVMultipliers(currentSVType, settingVars, interlaceMultiplier)
    local svMultipliersNoEndSV = table.duplicate(menuVars.svMultipliers)
    if (#svMultipliersNoEndSV > 1) then table.remove(svMultipliersNoEndSV) end
    menuVars.svDistances = calculateDistanceVsTime(svMultipliersNoEndSV)
    updateFinalSV(settingVars.finalSVIndex, menuVars.svMultipliers, settingVars.customSV,
        skipFinalSV)
    updateSVStats(menuVars.svGraphStats, menuVars.svStats, menuVars.svMultipliers,
        svMultipliersNoEndSV, menuVars.svDistances)
end
function updateFinalSV(finalSVIndex, svMultipliers, customSV, skipFinalSV)
    if skipFinalSV then
        table.remove(svMultipliers)
        return
    end
    local finalSVType = FINAL_SV_TYPES[finalSVIndex]
    if finalSVType == "Normal" then return end
    svMultipliers[#svMultipliers] = customSV
end
function updateStutterMenuSVs(settingVars)
    settingVars.svMultipliers = generateSVMultipliers("Stutter1", settingVars, nil)
    local svMultipliersNoEndSV = table.duplicate(settingVars.svMultipliers)
    table.remove(svMultipliersNoEndSV)
    settingVars.svMultipliers2 = generateSVMultipliers("Stutter2", settingVars, nil)
    local svMultipliersNoEndSV2 = table.duplicate(settingVars.svMultipliers2)
    table.remove(svMultipliersNoEndSV2)
    settingVars.svDistances = calculateStutterDistanceVsTime(svMultipliersNoEndSV,
        settingVars.stutterDuration,
        settingVars.stuttersPerSection)
    settingVars.svDistances2 = calculateStutterDistanceVsTime(svMultipliersNoEndSV2,
        settingVars.stutterDuration,
        settingVars.stuttersPerSection)
    if settingVars.linearlyChange then
        updateFinalSV(settingVars.finalSVIndex, settingVars.svMultipliers2, settingVars.customSV,
            false)
        table.remove(settingVars.svMultipliers)
    else
        updateFinalSV(settingVars.finalSVIndex, settingVars.svMultipliers, settingVars.customSV,
            false)
    end
    updateGraphStats(settingVars.svGraphStats, settingVars.svMultipliers, settingVars.svDistances)
    updateGraphStats(settingVars.svGraph2Stats, settingVars.svMultipliers2,
        settingVars.svDistances2)
end
---Calculates distance vs. time values of a note, given a set of SV values.
---@param svValues number[]
---@return number[]
function calculateDistanceVsTime(svValues)
    local distance = 0
    local multiplier = 1
    if globalVars.upscroll then multiplier = -1 end
    local distancesBackwards = { multiplier * distance }
    local svValuesBackwards = table.reverse(svValues)
    for i = 1, #svValuesBackwards do
        distance = distance + (multiplier * svValuesBackwards[i])
        distancesBackwards[#distancesBackwards + 1] = distance
    end
    return table.reverse(distancesBackwards)
end
---Calculates the minimum and maximum scale of a plot.
---@param plotValues number[]
---@return number
---@return number
function calculatePlotScale(plotValues)
    local min = math.min(table.unpack(plotValues))
    local max = math.max(table.unpack(plotValues))
    local absMax = math.max(math.abs(min), math.abs(max))
    local minScale = -absMax
    local maxScale = absMax
    if max <= 0 then maxScale = 0 end
    if min >= 0 then minScale = 0 end
    return minScale, maxScale
end
---Calculates distance vs. time values of a note, given a set of stutter SV values.
---@param svValues number[]
---@param stutterDuration number
---@param stuttersPerSection integer
---@return number[]
function calculateStutterDistanceVsTime(svValues, stutterDuration, stuttersPerSection)
    local distance = 0
    local distancesBackwards = { distance }
    local iterations = stuttersPerSection * 100
    if iterations > 1000 then iterations = 1000 end
    for i = 1, iterations do
        local x = ((i - 1) % 100) + 1
        if x <= (100 - stutterDuration) then
            distance = distance + svValues[2]
        else
            distance = distance + svValues[1]
        end
        distancesBackwards[#distancesBackwards + 1] = distance
    end
    return table.reverse(distancesBackwards)
end
---Creates a distance vs. time graph of SV distances.
---@param noteDistances number[]
---@param minScale number
---@param maxScale number
function plotSVMotion(noteDistances, minScale, maxScale)
    local plotSize = PLOT_GRAPH_SIZE
    imgui.PlotLines("##motion", noteDistances, #noteDistances, 0, "", minScale, maxScale, plotSize)
end
---Creates a histogram of SV values.
---@param svVals number[]
---@param minScale number
---@param maxScale number
function plotSVs(svVals, minScale, maxScale)
    local plotSize = PLOT_GRAPH_SIZE
    imgui.PlotHistogram("##svplot", svVals, #svVals, 0, "", minScale, maxScale, plotSize)
end
function plotExponentialCurvature(settingVars)
    imgui.PushItemWidth(28)
    imgui.PushStyleColor(imgui_col.FrameBg, 0)
    local RESOLUTION = 32
    local values = table.construct()
    for i = 1, RESOLUTION do
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local t = i / RESOLUTION
        local value = t
        if curvature >= 1 then
            value = t ^ curvature
        else
            value = (1 - (1 - t) ^ (1 / curvature))
        end
        if ((settingVars.startMsx or settingVars.lowerStart) > (settingVars.endMsx or settingVars.lowerEnd)) then
            value = 1 - value
        elseif ((settingVars.startMsx or settingVars.lowerStart) == (settingVars.endMsx or settingVars.lowerEnd)) then
            value = 0.5
        end
        values:insert(value)
    end
    imgui.PlotLines("##CurvaturePlot", values, #values, 0, "", 0, 1)
    imgui.PopStyleColor()
    imgui.PopItemWidth()
end
function plotSigmoidalCurvature(settingVars)
    imgui.PushItemWidth(28)
    imgui.PushStyleColor(imgui_col.FrameBg, 0)
    local RESOLUTION = 32
    local values = table.construct()
    for i = 1, RESOLUTION do
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local t = i / RESOLUTION * 2
        local value = t
        if curvature >= 1 then
            if t <= 1 then
                value = t ^ curvature
            else
                value = 2 - (2 - t) ^ curvature
            end
        else
            if t <= 1 then
                value = (1 - (1 - t) ^ (1 / curvature))
            else
                value = (t - 1) ^ (1 / curvature) + 1
            end
        end
        value = value / 2
        if ((settingVars.startMsx or settingVars.lowerStart) > (settingVars.endMsx or settingVars.lowerEnd)) then
            value = 1 - value
        elseif ((settingVars.startMsx or settingVars.lowerStart) == (settingVars.endMsx or settingVars.lowerEnd)) then
            value = 0.5
        end
        values:insert(value)
    end
    imgui.PlotLines("##CurvaturePlot", values, #values, 0, "", 0, 1)
    imgui.PopStyleColor()
    imgui.PopItemWidth()
end
function updateSVStats(svGraphStats, svStats, svMultipliers, svMultipliersNoEndSV, svDistances)
    updateGraphStats(svGraphStats, svMultipliers, svDistances)
    svStats.minSV = math.round(math.min(table.unpack(svMultipliersNoEndSV)), 2)
    svStats.maxSV = math.round(math.max(table.unpack(svMultipliersNoEndSV)), 2)
    svStats.avgSV = math.round(table.average(svMultipliersNoEndSV, true), 3)
end
function updateGraphStats(graphStats, svMultipliers, svDistances)
    graphStats.minScale, graphStats.maxScale = calculatePlotScale(svMultipliers)
    graphStats.distMinScale, graphStats.distMaxScale = calculatePlotScale(svDistances)
end
function makeSVInfoWindow(windowText, svGraphStats, svStats, svDistances, svMultipliers,
                          stutterDuration, skipDistGraph)
    if (globalVars.hideSVInfo) then return end
    imgui.Begin(windowText, imgui_window_flags.AlwaysAutoResize)
    if (globalVars.showSVInfoVisualizer and not globalVars.performanceMode) then
        local ctx = imgui.GetWindowDrawList()
        local topLeft = imgui.GetWindowPos()
        local dim = imgui.GetWindowSize()
        local simTime = math.expoClamp(120000 / game.getTimingPointAt(state.SongTime).Bpm, 600, 1200, 2)
        local curTime = state.UnixTime % simTime
        local progress = curTime / simTime
        local maxDist = math.max(table.unpack(svDistances))
        local minDist = math.min(table.unpack(svDistances))
        local beforeIdx = math.floor((#svDistances - 1) * progress) + 1
        local afterIdx = beforeIdx + 1
        local beforeDist = svDistances[beforeIdx]
        local afterDist = svDistances[math.clamp(afterIdx, 1, #svDistances)]
        local subProgress = progress * (#svDistances - 1) + 1 - beforeIdx
        local curDist = afterDist * subProgress + (1 - subProgress) * beforeDist - minDist
        local heightValue = topLeft.y + dim.y - curDist * dim.y / (maxDist - minDist)
        for i = 1, game.keyCount do
            ctx.AddRectFilled(vector.New(topLeft.x + (i - 1) * dim.x / game.keyCount + 5, heightValue),
                vector.New(topLeft.x + i * dim.x / game.keyCount - 5, heightValue + 20),
                imgui.GetColorU32(imgui_col.Header, (1 - (1 - progress) ^ 10)))
        end
        if svStats then
            local normativeMax = math.max(math.abs(svStats.minSV), math.abs(svStats.maxSV))
            local appearanceTime = 0.5
            local inverseProgress = 1 - progress
            for idx, m in ipairs(svMultipliers) do
                local x
                local y = (#svMultipliers - idx + 1) / (#svMultipliers + 1)
                local apx = y - (inverseProgress * 2 - 0.6)
                if (math.abs(apx) > appearanceTime) then goto nextMultiplier end
                apx = apx / appearanceTime / 2 + 0.5
                x = math.abs(m) / normativeMax
                ctx.AddRectFilled(
                    vector.New(topLeft.x,
                        topLeft.y + dim.y * (y + (1 - 2 * math.min(apx, 0.5)) / (#svMultipliers + 1))),
                    vector.New(topLeft.x + dim.x * x,
                        topLeft.y + dim.y * (y + 2 * (1 - math.max(apx, 0.5)) / (#svMultipliers + 1))),
                    imgui.GetColorU32(imgui_col.PlotHistogram, (apx - apx * apx) * 2))
                ::nextMultiplier::
            end
        end
    end
    if not skipDistGraph then
        imgui.Text("Projected Note Motion:")
        HelpMarker("Distance vs Time graph of notes")
        plotSVMotion(svDistances, svGraphStats.distMinScale, svGraphStats.distMaxScale)
        if imgui.CollapsingHeader("New All -w-") then
            for i = 1, #svDistances do
                local svDistance = svDistances[i]
                local content = tostring(svDistance)
                imgui.PushItemWidth(imgui.GetContentRegionAvailWidth())
                imgui.InputText("##" .. i, content, #content, imgui_input_text_flags.AutoSelectAll)
                imgui.PopItemWidth()
            end
        end
    end
    local projectedText = "Projected SVs:"
    if skipDistGraph then projectedText = "Projected Scaling (Avg SVs):" end
    imgui.Text(projectedText)
    plotSVs(svMultipliers, svGraphStats.minScale, svGraphStats.maxScale)
    if stutterDuration then
        displayStutterSVStats(svMultipliers, stutterDuration)
    else
        displaySVStats(svStats)
    end
    imgui.End()
end
function displayStutterSVStats(svMultipliers, stutterDuration)
    local firstSV = math.round(svMultipliers[1], 3)
    local secondSV = math.round(svMultipliers[2], 3)
    local firstDuration = stutterDuration
    local secondDuration = 100 - stutterDuration
    imgui.Columns(2, "SV Stutter Stats", false)
    imgui.Text("First SV:")
    imgui.Text("Second SV:")
    imgui.NextColumn()
    imgui.Text(firstSV .. table.concat({"x  (", firstDuration, "%% duration)"}))
    imgui.Text(secondSV .. table.concat({"x  (", secondDuration, "%% duration)"}))
    imgui.Columns(1)
end
function displaySVStats(svStats)
    imgui.Columns(2, "SV Stats", false)
    imgui.Text("Max SV:")
    imgui.Text("Min SV:")
    imgui.Text("Average SV:")
    imgui.NextColumn()
    imgui.Text(svStats.maxSV .. "x")
    imgui.Text(svStats.minSV .. "x")
    imgui.Text(svStats.avgSV .. "x")
    HelpMarker("Rounded to 3 decimal places")
    imgui.Columns(1)
end
function startNextWindowNotCollapsed(windowName)
    if state.GetValue(windowName) then return end
    imgui.SetNextWindowCollapsed(false)
    state.SetValue(windowName, true)
end
function displayStutterSVWindows(settingVars)
    if settingVars.linearlyChange then
        startNextWindowNotCollapsed("SV Info (Starting first SV)")
        makeSVInfoWindow("SV Info (Starting first SV)", settingVars.svGraphStats, nil,
            settingVars.svDistances, settingVars.svMultipliers,
            settingVars.stutterDuration, false)
        startNextWindowNotCollapsed("SV Info (Ending first SV)")
        makeSVInfoWindow("SV Info (Ending first SV)", settingVars.svGraph2Stats, nil,
            settingVars.svDistances2, settingVars.svMultipliers2,
            settingVars.stutterDuration, false)
    else
        startNextWindowNotCollapsed("SV Info")
        makeSVInfoWindow("SV Info", settingVars.svGraphStats, nil, settingVars.svDistances,
            settingVars.svMultipliers, settingVars.stutterDuration, false)
    end
end
function bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce, optionalLabel)
    local settingsChanged = false
    settingsChanged = chooseInteractiveBezier(settingVars, optionalLabel or "") or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function chinchillaSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseSVBehavior(settingVars) or settingsChanged
    settingsChanged = chooseChinchillaType(settingVars) or settingsChanged
    settingsChanged = chooseChinchillaIntensity(settingVars) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function circularSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseSVBehavior(settingVars) or settingsChanged
    settingsChanged = chooseArcPercent(settingVars) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    settingsChanged = chooseNoNormalize(settingVars) or settingsChanged
    return settingsChanged
end
function codeSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    CodeInput(settingVars, "code", "##code",
        "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the scroll velocity multiplier at (100t)% of the way between the first and last selected note times.")
    if (imgui.Button("Refresh Plot", vector.New(ACTION_BUTTON_SIZE.x, 30))) then
        settingsChanged = true
    end
    imgui.Separator()
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function comboSettingsMenu(settingVars, _, _, hideSettings)
    local settingsChanged = false
    local maxComboPhase = 0
    if (not hideSettings) then
        startNextWindowNotCollapsed("SV Type 1 Settings")
        imgui.Begin("SV Type 1 Settings", imgui_window_flags.AlwaysAutoResize)
        imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
        local svType1 = STANDARD_SVS[settingVars.svType1Index]
        local settingVars1 = getSettingVars(svType1, "Combo1")
        settingsChanged = showSettingsMenu(svType1, settingVars1, true, nil, "Combo1") or settingsChanged
        local labelText1 = svType1 .. "Combo1"
        cache.saveTable(labelText1 .. "Settings", settingVars1)
        imgui.End()
        startNextWindowNotCollapsed("SV Type 2 Settings")
        imgui.Begin("SV Type 2 Settings", imgui_window_flags.AlwaysAutoResize)
        imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
        local svType2 = STANDARD_SVS[settingVars.svType2Index]
        local settingVars2 = getSettingVars(svType2, "Combo2")
        settingsChanged = showSettingsMenu(svType2, settingVars2, true, nil, "Combo2") or settingsChanged
        local labelText2 = svType2 .. "Combo2"
        cache.saveTable(labelText2 .. "Settings", settingVars2)
        imgui.End()
        maxComboPhase = settingVars1.svPoints + settingVars2.svPoints
    end
    settingsChanged = chooseStandardSVTypes(settingVars) or settingsChanged
    if (not hideSettings) then settingsChanged = chooseComboSVOption(settingVars, maxComboPhase) or settingsChanged end
    AddSeparator()
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    if not settingVars.dontNormalize then
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    end
    settingsChanged = chooseFinalSV(settingVars, false) or settingsChanged
    settingsChanged = chooseNoNormalize(settingVars) or settingsChanged
    return settingsChanged
end
function customSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = importCustomSVs(settingVars) or settingsChanged
    settingsChanged = chooseCustomMultipliers(settingVars) or settingsChanged
    if not (svPointsForce and skipFinalSV) then AddSeparator() end
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    adjustNumberOfMultipliers(settingVars)
    return settingsChanged
end
function importCustomSVs(settingVars)
    local svsParsed = false
    local customSVText = state.GetValue("import_customText") or "Import SV values here"
    local imguiFlag = imgui_input_text_flags.AutoSelectAll
    _, customSVText = imgui.InputText("##customSVs", customSVText, 99999, imguiFlag)
    KeepSameLine()
    if imgui.Button("Parse##customSVs", SECONDARY_BUTTON_SIZE) then
        local regex = "(-?%d*%.?%d+)"
        local values = {}
        for value, _ in string.gmatch(customSVText, regex) do
            values[#values + 1] = tn(value)
        end
        if #values >= 1 then
            settingVars.svMultipliers = values
            settingVars.selectedMultiplierIndex = 1
            settingVars.svPoints = #values
            svsParsed = true
        end
        customSVText = "Import SV values here"
    end
    state.SetValue("import_customText", customSVText)
    HelpMarker("Paste custom SV values in the box then hit the parse button (ex. 2 -1 2 -1)")
    return svsParsed
end
function adjustNumberOfMultipliers(settingVars)
    if settingVars.svPoints > #settingVars.svMultipliers then
        local difference = settingVars.svPoints - #settingVars.svMultipliers
        for _ = 1, difference do
            table.insert(settingVars.svMultipliers, 1)
        end
    end
    if settingVars.svPoints >= #settingVars.svMultipliers then return end
    if settingVars.selectedMultiplierIndex > settingVars.svPoints then
        settingVars.selectedMultiplierIndex = settingVars.svPoints
    end
    local difference = #settingVars.svMultipliers - settingVars.svPoints
    for _ = 1, difference do
        table.remove(settingVars.svMultipliers)
    end
end
function exponentialSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseSVBehavior(settingVars) or settingsChanged
    settingsChanged = chooseIntensity(settingVars) or settingsChanged
    if (globalVars.advancedMode) then
        settingsChanged = chooseDistanceMode(settingVars) or settingsChanged
    end
    if (settingVars.distanceMode ~= 3) then
        settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    end
    if (settingVars.distanceMode == 1) then
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    elseif (settingVars.distanceMode == 2) then
        settingsChanged = chooseDistance(settingVars) or settingsChanged
    else
        settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    end
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function hermiteSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function linearSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function randomSettingsMenu(settingVars, skipFinalSV, svPointsForce, disableRegeneration)
    local settingsChanged = false
    settingsChanged = chooseRandomType(settingVars) or settingsChanged
    settingsChanged = chooseRandomScale(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    if not disableRegeneration and imgui.Button("Generate New Random Set", BEEG_BUTTON_SIZE) then
        generateRandomSetMenuSVs(settingVars)
        settingsChanged = true
    end
    AddSeparator()
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    if not settingVars.dontNormalize then
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    end
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    settingsChanged = chooseNoNormalize(settingVars) or settingsChanged
    return settingsChanged
end
function generateRandomSetMenuSVs(settingVars)
    local randomType = RANDOM_TYPES[settingVars.randomTypeIndex]
    settingVars.svMultipliers = generateRandomSet(settingVars.svPoints + 1, randomType,
        settingVars.randomScale)
end
function sinusoidalSettingsMenu(settingVars, skipFinalSV)
    local settingsChanged = false
    imgui.Text("Amplitude:")
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    settingsChanged = chooseCurveSharpness(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 1) or settingsChanged
    settingsChanged = chooseNumPeriods(settingVars) or settingsChanged
    settingsChanged = choosePeriodShift(settingVars) or settingsChanged
    settingsChanged = chooseSVPerQuarterPeriod(settingVars) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
---Prints a message if creation messages are enabled.
---@param type "e!"|"w!"|"i!"|"s!"
---@param msg string
function toggleablePrint(type, msg)
    local creationMsg = msg:find("Create") and true or false
    if (creationMsg and globalVars.dontPrintCreation) then return end
    print(type, msg)
end
function draw()
    if (not state.CurrentTimingPoint) then return end
    local performanceMode = globalVars.performanceMode
    PLUGIN_NAME = "plumoguSV-dev"
    state.IsWindowHovered = imgui.IsWindowHovered()
    startNextWindowNotCollapsed(PLUGIN_NAME)
    imgui.SetNextWindowSizeConstraints(vctr2(0), vector.Max(table.vectorize2(state.WindowSize) / 2, vctr2(600)))
    imgui.Begin(PLUGIN_NAME, imgui_window_flags.AlwaysAutoResize)
    if (not performanceMode) then
        addGradient()
        renderBackground()
        drawCapybaraParent()
        drawCursorTrail()
        pulseController()
        checkForGlobalHotkeys()
        setPluginAppearance()
    end
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    imgui.BeginTabBar("SV tabs")
    for i = 1, #TAB_MENUS do
        createMenuTab(TAB_MENUS[i])
    end
    imgui.EndTabBar()
    if (not performanceMode) then
        if (globalVars.showVibratoWidget) then
            imgui.Begin("plumoguSV-vibrato", imgui_window_flags.AlwaysAutoResize)
            imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
            placeVibratoSVMenu(true)
            imgui.End()
        end
        if (globalVars.showNoteDataWidget) then
            renderNoteDataWidget()
        end
        if (globalVars.showMeasureDataWidget) then
            renderMeasureDataWidget()
        end
    end
    if (state.GetValue("windows.showTutorialWindow")) then
        showTutorialWindow()
    end
    if (state.GetValue("windows.showSettingsWindow")) then
        showPluginSettingsWindow()
    end
    if (state.GetValue("windows.showPatchNotesWindow")) then
        showPatchNotesWindow()
    end
    imgui.End()
    logoThread()
    state.SetValue("boolean.changeOccurred", false)
    local groups = state.GetValue("tgList")
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end
end
function awake()
    loadup = {} -- later inserted to via setStyleVars.lua
    local tempGlobalVars = read()
    if (not tempGlobalVars) then
        write(DEFAULT_GLOBAL_VARS) -- First time launching plugin
        print("w!",
            'This seems to be your first time using plumoguSV. If you need any help, please press the button labelled "View Tutorials" in the "Info" tab.')
        setPresets({})
    else
        setGlobalVars(tempGlobalVars)
        loadDefaultProperties(tempGlobalVars.defaultProperties)
        setPresets(tempGlobalVars.presets or {})
    end
    initializeNoteLockMode()
    listenForTimingGroupCount()
    setPluginAppearance()
    state.SelectedScrollGroupId = "$Default" or map.GetTimingGroupIds()[1]
    if (not truthy(map.TimingPoints)) then
        print("e!", "Please place a timing point before attempting to use plumoguSV.")
    end
    if (state.Scale ~= 1) then
        local printedScale = math.round(state.Scale * 100)
        print("e!",
            "Your ImGui scale is set to " ..
            printedScale .. "% instead of 100%. For visual purposes, please set it back to 100%.")
    end
    clock.prevTime = state.UnixTime
    game.keyCount = map.GetKeyCount()
end
function draw()
    if (not state.CurrentTimingPoint) then return end
    local performanceMode = globalVars.performanceMode
    PLUGIN_NAME = "plumoguSV-dev"
    state.IsWindowHovered = imgui.IsWindowHovered()
    startNextWindowNotCollapsed(PLUGIN_NAME)
    imgui.SetNextWindowSizeConstraints(vctr2(0), vector.Max(table.vectorize2(state.WindowSize) / 2, vctr2(600)))
    imgui.Begin(PLUGIN_NAME, imgui_window_flags.AlwaysAutoResize)
    if (not performanceMode) then
        addGradient()
        renderBackground()
        drawCapybaraParent()
        drawCursorTrail()
        pulseController()
        checkForGlobalHotkeys()
        setPluginAppearance()
    end
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    imgui.BeginTabBar("SV tabs")
    for i = 1, #TAB_MENUS do
        createMenuTab(TAB_MENUS[i])
    end
    imgui.EndTabBar()
    if (not performanceMode) then
        if (globalVars.showVibratoWidget) then
            imgui.Begin("plumoguSV-vibrato", imgui_window_flags.AlwaysAutoResize)
            imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
            placeVibratoSVMenu(true)
            imgui.End()
        end
        if (globalVars.showNoteDataWidget) then
            renderNoteDataWidget()
        end
        if (globalVars.showMeasureDataWidget) then
            renderMeasureDataWidget()
        end
    end
    if (state.GetValue("windows.showTutorialWindow")) then
        showTutorialWindow()
    end
    if (state.GetValue("windows.showSettingsWindow")) then
        showPluginSettingsWindow()
    end
    if (state.GetValue("windows.showPatchNotesWindow")) then
        showPatchNotesWindow()
    end
    imgui.End()
    logoThread()
    state.SetValue("boolean.changeOccurred", false)
    local groups = state.GetValue("tgList")
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end
    tempClockCount = 0
end