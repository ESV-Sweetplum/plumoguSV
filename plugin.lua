game = {}
kb = {}
matrix = {}
clock = {}
---Returns true every `interval` ms.
---@param id string The unique identifier of the clock.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.listen(id, interval)
    local currentTime = state
        .UnixTime
    local stateId = table.concat({ "clock_", id })
    if (not state.GetValue(stateId)) then
        state.SetValue(stateId,
            currentTime)
    end
    local previousExecutionTime = state.GetValue(stateId)
    if (currentTime - previousExecutionTime > interval) then
        state.SetValue(stateId, currentTime)
        return true
    end
    return false
end
function game.getTimingPointAt(offset)
    local line = map.getTimingPointAt(offset)
    if line then return line end
    return { StartTime = -69420, Bpm = 42.69 }
end
function game.getNoteOffsetAt(offset, forward)
    local startTimes = state.GetValue("hoStartTimes", {})
    if (not truthy(#startTimes)) then return -1 end
    if (state.SongTime > startTimes[#startTimes]) then return startTimes[#startTimes] end
    if (state.SongTime < startTimes[1]) then return startTimes[1] end
    local startTime = table.searchClosest(startTimes, offset, forward and 2 or 1)
    return startTime
end
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
function game.getSSFStartTimeAt(offset, tgId)
    local sv = map.GetScrollSpeedFactorAt(offset, tgId)
    if sv then return sv.StartTime end
    return -1
end
function game.getSSFMultiplierAt(offset)
    local ssf = map.GetScrollSpeedFactorAt(offset)
    if ssf then return ssf.Multiplier end
    return 1
end
function game.getSVStartTimeAt(offset)
    local sv = map.GetScrollVelocityAt(offset)
    if sv then return sv.StartTime end
    return -1
end
function game.getSVMultiplierAt(offset)
    local sv = map.GetScrollVelocityAt(offset)
    if sv then return sv.Multiplier end
    if (map.InitialScrollVelocity == 0) then return 1 end
    return map.InitialScrollVelocity or 1
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
---@return ScrollSpeedFactor[] ssfs All of the [scroll speed factors](lua://ScrollSpeedFactor) within the area.
function game.getSSFsBetweenOffsets(startOffset, endOffset, includeEnd)
    local ssfsBetweenOffsets = {} ---@type ScrollSpeedFactor[]
    local ssfs = map.ScrollSpeedFactors
    if (ssfs == nil) then
        ssfs = {}
    else
        for _, ssf in ipairs(map.ScrollSpeedFactors) do
            local ssfIsInRange = ssf.StartTime >= startOffset and ssf.StartTime < endOffset
            if (includeEnd and ssf.StartTime == endOffset) then ssfIsInRange = true end
            if ssfIsInRange then ssfsBetweenOffsets[#ssfsBetweenOffsets + 1] = ssf end
        end
    end
    return sort(ssfsBetweenOffsets, sortAscendingStartTime)
end
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
        if svIsInRange then svsBetweenOffsets[#svsBetweenOffsets + 1] = sv end
    end
    if (dontSort) then return svsBetweenOffsets end
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
    for i, ho in pairs(state.SelectedHitObjects) do
        offsets[i] = ho.StartTime
    end
    offsets = table.dedupe(offsets)
    offsets = sort(offsets, sortAscending)
    if (#offsets == 0) then return {} end
    return offsets
end
function game.uniqueNotesBetweenSelected()
    local selectedNoteOffsets = game.uniqueSelectedNoteOffsets()
    if (not selectedNoteOffsets) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    local startOffset = selectedNoteOffsets[1]
    local endOffset = selectedNoteOffsets[#selectedNoteOffsets]
    local offsets = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (#offsets < 2) then
        toggleablePrint("e!",
            "Warning: There are not enough notes in the current selection (within this timing group) to perform the action.")
        return {}
    end
    return offsets
end
---Finds and returns a list of all unique offsets of notes between a start and an end time [Table]
---@param startOffset number
---@param endOffset number
---@param includeLN? boolean
---@return number[]
function game.uniqueNoteOffsetsBetween(startOffset, endOffset, includeLN)
    local noteOffsetsBetween = {}
    for _, ho in ipairs(map.HitObjects) do
        if ho.StartTime >= startOffset and ho.StartTime <= endOffset then
            local skipNote = false
            if (state.SelectedScrollGroupId ~= ho.TimingGroup and globalVars.ignoreNotesOutsideTg) then skipNote = true end
            if (ho.StartTime == startOffset or ho.StartTime == endOffset) then skipNote = false end
            if (skipNote) then goto skip end
            noteOffsetsBetween[#noteOffsetsBetween + 1] = ho.StartTime
            if (ho.EndTime ~= 0 and ho.EndTime <= endOffset and includeLN) then
                table.insert(noteOffsetsBetween,
                    ho.EndTime)
            end
            ::skip::
        end
    end
    noteOffsetsBetween = table.dedupe(noteOffsetsBetween)
    noteOffsetsBetween = sort(noteOffsetsBetween, sortAscending)
    return noteOffsetsBetween
end
game.getUniqueNoteOffsetsBetween = game.uniqueNoteOffsetsBetween
function kb.listenForAnyKeyPressed()
    local isCtrlHeld = utils.IsKeyDown(keys.LeftControl) or utils.IsKeyDown(keys.RightControl)
    local isShiftHeld = utils.IsKeyDown(keys.LeftShift) or utils.IsKeyDown(keys.RightShift)
    local isAltHeld = utils.IsKeyDown(keys.LeftAlt) or utils.IsKeyDown(keys.RightAlt)
    local key = -1
    local prefixes = {}
    if (isCtrlHeld) then prefixes[#prefixes + 1] = "Ctrl" end
    if (isShiftHeld) then prefixes[#prefixes + 1] = "Shift" end
    if (isAltHeld) then prefixes[#prefixes + 1] = "Alt" end
    for i = 65, 90 do
        if (utils.IsKeyPressed(i)) then
            key = i
        end
    end
    return prefixes, key
end
ALPHABET_LIST = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
    "V", "W", "X", "Y", "Z" }
function kb.numToKey(num)
    return ALPHABET_LIST[math.clamp(num - 64, 1, #ALPHABET_LIST)]
end
function kb.pressedKeyCombo(keyCombo)
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
kb.executedKeyCombo = kb.pressedKeyCombo
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
---Returns n choose r, or nCr.
---@param n integer
---@param r integer
---@return integer
function math.binom(n, r)
    return math.factorial(n) / (math.factorial(r) * math.factorial(n - r))
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
---Returns the factorial of an integer.
---@param n integer
---@return integer
function math.factorial(n)
    local product = 1
    for i = 2, n do
        product = product * i
    end
    return product
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
---Interpolates circular parameters of the form (x-h)^2+(y-k)^2=r^2 with three, non-colinear points.
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@return number, number, number
function math.interpolateCircle(p1, p2, p3)
    local mtrx = {
        vector.Table(2 * (p2 - p1)),
        vector.Table(2 * (p3 - p1))
    }
    local vctr = {
        vector.Length(p2) ^ 2 - vector.Length(p1) ^ 2,
        vector.Length(p3) ^ 2 - vector.Length(p1) ^ 2
    }
    h, k = matrix.solve(mtrx, vctr)
    r = math.sqrt((p1.x) ^ 2 + (p1.y) ^ 2 + h * h + k * k - 2 * h * p1.x - 2 * k * p1.y)
    ---@type number, number, number
    return h, k, r
end
---Interpolates quadratic parameters of the form y=ax^2+bx+c with three, non-colinear points.
---@param p1 Vector2
---@param p2 Vector2
---@param p3 Vector2
---@return number, number, number
function math.interpolateQuadratic(p1, p2, p3)
    local mtrx = {
        (p2.x) ^ 2 - (p1.x) ^ 2, (p2 - p1).x,
        (p3.x) ^ 2 - (p1.x) ^ 2, (p3 - p1).x,
    }
    local vctr = {
        (p2 - p1).y,
        (p3 - p1).y
    }
    a, b = matrix.solve(mtrx, vctr)
    c = p1.y - p1.x * b - (p1.x) ^ 2 * a
    ---@type number, number, number
    return a, b, c
end
---Returns a number that is `(weight * 100)%` of the way from travelling between `lowerBound` and `upperBound`.
---@param weight number
---@param lowerBound number
---@param upperBound number
---@return number
function math.lerp(weight, lowerBound, upperBound)
    return upperBound * weight + lowerBound * (1 - weight)
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
            if (num ~= 0) then
                zeroRow = false
                goto continue
            end
        end
        ::continue::
        if (zeroRow) then return idx end
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
    if (#vctr ~= #mtrx) then return end
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
    return table.unpack(table.property(augMtrx, #mtrx + 1))
end
function matrix.swapRows(mtrx, rowIdx1, rowIdx2)
    local temp = mtrx[rowIdx1]
    mtrx[rowIdx1] = mtrx[rowIdx2]
    mtrx[rowIdx2] = temp
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
    if (x == true) then return 1 end
    local result = tonumber(x)
    if (not result or type(result) ~= "number") then return 0 end
    return result
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
---@return string pluralizedStr A new string that is pluralized if `val ~= 1`.
function pluralize(str, val, pos)
    if (pos) then
        strEnding = str:sub(pos + 1, -1)
        str = str:sub(1, pos)
    end
    local finalStrTbl = { str, "s" }
    if (val == 1) then return str .. (strEnding or "") end
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
---Returns the `idx`th character in a string. Simply used for shorthand. Also supports negative indexes.
---@param str string The string to search.
---@param idx integer If positive, returns the `i`th character. If negative, returns the `i`th character from the end of the string (e.g. -1 returns the last character).
function string.charAt(str, idx)
    return str:sub(idx, idx)
end
---Changes a string to fit a certain size, with a ... at the end.
---@param str string
---@param targetSize integer
---@return string dottedStr
function string.fixToSize(str, targetSize)
    local size = imgui.CalcTextSize(str).x
    if (size <= targetSize) then return str end
    while (str:len() > 3 and size > targetSize) do
        str = str:sub(1, -2)
        size = imgui.CalcTextSize(str .. "...").x
    end
    return str .. "..."
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
function string.shorten(str)
    local consonants = str:removeVowels()
    return table.concat({ consonants:charAt(1), consonants:charAt(2), consonants:charAt(-1) })
end
---Returns the average value of an array.
---@param values number[] The list of numbers.
---@param includeLastValue? boolean Whether or not to include the last value in the table.
---@return number avg The arithmetic mean of the table.
function table.average(values, includeLastValue)
    if #values == 0 then return 0 end
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
---Concatenates two arrays together.
---@param t1 any[] The first table.
---@param t2 any[] The second table.
---@return any[] tbl The resultant table.
function table.combine(t1, t2)
    local newTbl = table.duplicate(t1)
    for i = 1, #t2 do
        newTbl[#newTbl + 1] = t2[i]
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
---@generic T: string | number | boolean
---@param item T The entry to use.
---@param num integer The number of entries to put into the table.
---@return T[] tbl A table with the given entries.
function table.constructRepeating(item, num)
    local tbl = {}
    for _ = 1, num do
        tbl[#tbl + 1] = item
    end
    return tbl
end
---Returns a boolean value corresponding to whether or not an element exists within a table.
---@param tbl table The table to search in.
---@param item any The item to search for.
---@return boolean contains Whether or not the item given is within the table.
function table.contains(tbl, item)
    for k3 = 1, #tbl do
        local v = tbl[k3]
        if (v == item) then return true end
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
---Returns a 1-indexed value corresponding to the location of an element within a table.
---@param tbl table The table to search in.
---@param item any The item to search for.
---@return integer idx The index of the item. If the item doesn't exist, returns -1 instead.
function table.indexOf(tbl, item)
  for i, v in pairs(tbl) do
    if (v == item) then return i end
  end
  return -1
end
---Returns a table of keys from a table.
---@param tbl { [string]: any } The table to search in.
---@return string[] keys A list of keys.
function table.keys(tbl)
    local resultsTbl = {}
    for k, _ in pairs(tbl) do
        resultsTbl[#resultsTbl + 1] = k
    end
    return table.dedupe(resultsTbl)
end
---Transforms an array element-wise using a given function.
---@generic T: string | number | boolean
---@param tbl T[]
---@param fn fun(element: T): T
---@return T[]
function table.map(tbl, fn)
    local newTbl = {}
    for k6 = 1, #tbl do
        local v = tbl[k6]
        newTbl[#newTbl + 1] = fn(v)
    end
    return newTbl
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
    while true do
        local nestedTableFactor = table.contains({ "[", "{" }, str:charAt(2)) and 1 or 0
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
        for k7 = 1, #terms do
            local v = terms[k7]
            tbl[#tbl + 1] = table.parse(v)
        end
    else
        for k8 = 1, #terms do
            local v = terms[k8]
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
    for k9 = 1, #tbl do
        local v = tbl[k9]
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
    for k10 = 1, #tbl do
        local v = tbl[k10]
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
---@param searchMode? 0|1|2 `0`: Search before and after. `1`: Search only before. `2`: Search only after.
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
---Sorts a table given a sorting function. Should be passed into [`table.sort`](lua://table.sort).
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
        if (not truthy(#var)) then return "[]" end
        local str = "["
        for k11 = 1, #var do
            local v = var[k11]
            str = str .. table.stringify(v) .. ","
        end
        return str:sub(1, -2) .. "]"
    end
    if (not truthy(#table.keys(var))) then return "[]" end
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
    for k12 = 1, #validKeys do
        local key = validKeys[k12]
        if (table.contains(tableKeys, key)) then
            outputTable[key] = tbl[key]
        end
        if (not table.contains(tableKeys, key) and extrapolateData) then
            outputTable[key] = checkList[key]
        end
        if (inferTypes and outputTable[key]) then
            outputTable[key] = parseProperty(outputTable[key], checkList[key]) or outputTable[key]
        end
    end
    return outputTable
end
---Returns a table of values from a table.
---@param tbl { [string]: any } The table to search in.
---@return string[] values A list of values.
function table.values(tbl)
    local resultsTbl = {}
    for k13 = 1, #tbl do
        local v = tbl[k13]
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
    if (not tbl) then return vector4(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2] and tbl[3] and tbl[4]) then return vector.New(tbl[1], tbl[2], tbl[3], tbl[4]) end
    return vector.New(tbl.x, tbl.y, tbl.z, tbl.w)
end
---Converts a table of length 3 into a [`Vector3`](lua://Vector3).
---@param tbl number[] | { x: number, y: number, z: number } The table to convert.
---@return Vector3 vctr The output vector.
function table.vectorize3(tbl)
    if (not tbl) then return vector3(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2] and tbl[3]) then return vector.New(tbl[1], tbl[2], tbl[3]) end
    return vector.New(tbl.x, tbl.y, tbl.z)
end
---Converts a table of length 2 into a [`Vector2`](lua://Vector2).
---@param tbl number[] | { x: number, y: number } The table to convert.
---@return Vector2 vctr The output vector.
function table.vectorize2(tbl)
    if (not tbl) then return vector2(0) end
    if (type(tbl) == "userdata") then return tbl end
    if (tbl[1] and tbl[2]) then return vector.New(tbl[1], tbl[2]) end
    return vector.New(tbl.x, tbl.y)
end
---Prints a message if creation messages are enabled.
---@param type "e!"|"w!"|"i!"|"s!"
---@param msg string
function toggleablePrint(type, msg)
    local creationMsg = msg:find("Create") and true or false
    if (creationMsg and globalVars.dontPrintCreation) then return end
    print(type, msg)
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
function vector4(n)
    return vector.New(n, n, n, n)
end
---Creates a new [`Vector3`](lua://Vector4) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector3 vctr The resultant vector of style `<n, n, n>`.
function vector3(n)
    return vector.New(n, n, n)
end
---Creates a new [`Vector2`](lua://Vector2) with all elements being the given number.
---@param n number The number to use as the entries.
---@return Vector2 vctr The resultant vector of style `<n, n>`.
function vector2(n)
    return vector.New(n, n)
end
function unit2(theta)
    return vector.New(math.cos(theta), math.sin(theta))
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
    "BGR + otingocnI",
    "otingocnI",
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
    "100,100,255",
    "255,255,255",
    "0,0,0",
}
DYNAMIC_BACKGROUND_TYPES = {
    "None",
    "Reactive Stars",
    "Reactive Singularity",
    "Synthesis",
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
    "[ m w m ]",
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
VIBRATO_FRAME_RATES = { 45, 90, 150, 210, 450 }
VIBRATO_DETAILED_QUALITIES = {}
for i, v in pairs(VIBRATO_QUALITIES) do
    VIBRATO_DETAILED_QUALITIES[#VIBRATO_DETAILED_QUALITIES + 1] = v .. table.concat({"  (~", VIBRATO_FRAME_RATES[i], "fps)"})
end
VIBRATO_CURVATURES = { 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.2, 2.4, 2.6, 2.8, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5 }
DEFAULT_STYLE = {
    windowBg = vector.New(0.00, 0.00, 0.00, 1.00),
    popupBg = vector.New(0.08, 0.08, 0.08, 0.94),
    border = vector.New(0, 0, 0, 1),
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
        vector.New(1.00, 0.60, 0.00, 1.00)
}
DEFAULT_HOTKEY_LIST = { "T", "Shift+T", "S", "N", "R", "B", "M", "V", "G", "Ctrl+Shift+Alt+L" }
HOTKEY_LABELS = { "Execute Primary Action", "Execute Secondary Action", "Swap Primary Inputs",
    "Negate Primary Inputs", "Reset Secondary Input", "Go To Prev. Scroll Group", "Go To Next Scroll Group",
    "Execute Vibrato Separately", "Use TG of Selected Note", "Toggle Note Lock Mode" }
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
---#### (NOTE: This function is impure and has no return value. This should be changed eventually.)
---Gets a list of variables.
---@param listName string An identifier to avoid state collisions.
---@param variables { [string]: any } The key-value table to get data for.
function getVariables(listName, variables)
    for key, _ in pairs(variables) do
        if (state.GetValue(listName .. key) ~= nil) then
            variables[key] = state.GetValue(listName .. key)
        end
    end
end
---Saves a table in state, independently.
---@param listName string An identifier to avoid state collisions.
---@param variables { [string]: any } A key-value table to save.
function saveVariables(listName, variables)
    for key, value in pairs(variables) do
        state.SetValue(listName .. key, value)
    end
end
function loadDefaultProperties(defaultProperties)
    if (not defaultProperties) then return end
    if (not defaultProperties.menu) then goto skipMenu end
    for label, tbl in pairs(defaultProperties.menu) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_MENU_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseProperty(settingValue, defaultTable[settingName])
            if (not defaultSetting) then
                goto skipSetting
            end
            DEFAULT_STARTING_MENU_VARS[label][settingName] = defaultSetting
            ::skipSetting::
        end
    end
    ::skipMenu::
    for label, tbl in pairs(defaultProperties.settings) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_SETTING_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseProperty(settingValue, defaultTable[settingName])
            if (not defaultSetting) then
                goto skipSetting
            end
            DEFAULT_STARTING_SETTING_VARS[label][settingName] = defaultSetting
            ::skipSetting::
        end
    end
    globalVars.defaultProperties = { settings = DEFAULT_STARTING_SETTING_VARS, menu = DEFAULT_STARTING_MENU_VARS }
end
function parseProperty(v, default)
    if (not default or type(default) == "table" or type(default) == "userdata") then
        return nil
    end
    if (type(default) == "number") then
        return math.toNumber(v)
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
    stepSize = 5,
    dontReplaceSV = false,
    upscroll = false,
    colorThemeIndex = 1,
    styleThemeIndex = 1,
    effectFPS = 90,
    cursorTrailIndex = 1,
    cursorTrailShapeIndex = 1,
    cursorTrailPoints = 10,
    cursorTrailSize = 5,
    snakeSpringConstant = 1,
    cursorTrailGhost = false,
    rgbPeriod = 2,
    drawCapybara = false,
    drawCapybara2 = false,
    drawCapybara312 = false,
    selectTypeIndex = 1,
    placeTypeIndex = 1,
    editToolIndex = 1,
    showPresetMenu = false,
    scrollGroupIndex = 1,
    hideSVInfo = false,
    showSVInfoVisualizer = true,
    showVibratoWidget = false,
    showNoteDataWidget = false,
    showMeasureDataWidget = false,
    ignoreNotesOutsideTg = false,
    advancedMode = false,
    hideAutomatic = false,
    pulseCoefficient = 0,
    pulseColor = { 0, 0, 0, 0 },
    useCustomPulseColor = false,
    hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST),
    customStyle = {},
    dontPrintCreation = false,
    equalizeLinear = false,
    comboizeSelect = false,
    defaultProperties = { settings = {}, menu = {} },
    presets = {},
    dynamicBackgroundIndex = 1,
}
DEFAULT_GLOBAL_VARS = table.duplicate(globalVars)
function setGlobalVars(tempGlobalVars)
    globalVars.useCustomPulseColor = truthy(tempGlobalVars.useCustomPulseColor)
    globalVars.pulseColor = table.vectorize4(tempGlobalVars.pulseColor)
    globalVars.pulseCoefficient = math.toNumber(tempGlobalVars.pulseCoefficient)
    globalVars.stepSize = math.toNumber(tempGlobalVars.stepSize)
    globalVars.dontReplaceSV = truthy(tempGlobalVars.dontReplaceSV)
    globalVars.upscroll = truthy(tempGlobalVars.upscroll)
    globalVars.colorThemeIndex = math.toNumber(tempGlobalVars.colorThemeIndex)
    globalVars.styleThemeIndex = math.toNumber(tempGlobalVars.styleThemeIndex)
    globalVars.rgbPeriod = math.toNumber(tempGlobalVars.rgbPeriod)
    globalVars.cursorTrailIndex = math.toNumber(tempGlobalVars.cursorTrailIndex)
    globalVars.cursorTrailShapeIndex = math.toNumber(tempGlobalVars.cursorTrailShapeIndex)
    globalVars.effectFPS = math.toNumber(tempGlobalVars.effectFPS)
    globalVars.cursorTrailPoints = math.clamp(math.toNumber(tempGlobalVars.cursorTrailPoints), 0, 100)
    globalVars.cursorTrailSize = math.toNumber(tempGlobalVars.cursorTrailSize)
    globalVars.snakeSpringConstant = math.toNumber(tempGlobalVars.snakeSpringConstant)
    globalVars.cursorTrailGhost = truthy(tempGlobalVars.cursorTrailGhost)
    globalVars.drawCapybara = truthy(tempGlobalVars.drawCapybara)
    globalVars.drawCapybara2 = truthy(tempGlobalVars.drawCapybara2)
    globalVars.drawCapybara312 = truthy(tempGlobalVars.drawCapybara312)
    globalVars.ignoreNotes = truthy(tempGlobalVars.ignoreNotesOutsideTg)
    globalVars.hideSVInfo = truthy(tempGlobalVars.hideSVInfo)
    globalVars.showSVInfoVisualizer = truthy(tempGlobalVars.showSVInfoVisualizer, true)
    globalVars.showVibratoWidget = truthy(tempGlobalVars.showVibratoWidget)
    globalVars.showNoteDataWidget = truthy(tempGlobalVars.showNoteDataWidget)
    globalVars.showMeasureDataWidget = truthy(tempGlobalVars.showMeasureDataWidget)
    globalVars.advancedMode = truthy(tempGlobalVars.advancedMode)
    globalVars.hideAutomatic = truthy(tempGlobalVars.hideAutomatic)
    globalVars.dontPrintCreation = truthy(tempGlobalVars.dontPrintCreation)
    globalVars.hotkeyList = table.validate(DEFAULT_HOTKEY_LIST, table.duplicate(tempGlobalVars.hotkeyList), true)
    globalVars.customStyle = tempGlobalVars.customStyle or table.construct()
    if (globalVars.customStyle.border) then
        globalVars.customStyle.border = table.vectorize4(globalVars.customStyle
            .border)
    end
    globalVars.equalizeLinear = truthy(tempGlobalVars.equalizeLinear)
    globalVars.comboizeSelect = truthy(tempGlobalVars.comboizeSelect)
    globalVars.dynamicBackgroundIndex = math.toNumber(tempGlobalVars.dynamicBackgroundIndex)
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
    },
    convertSVSSF = {
        conversionDirection = true
    },
    copy = {
        copyTable = { true, true, true, true },
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
    verticalShift = {
        verticalShift = 1
    },
    selectAlternating = {
        every = 1,
        offset = 0
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
        ln = false
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
    local menuVars = table.duplicate(DEFAULT_STARTING_MENU_VARS[menuType])
    local labelText = menuType .. optionalLabel .. "Menu"
    getVariables(labelText, menuVars)
    return menuVars
end
function setPresets(presetList)
    globalVars.presets = {}
    for _, preset in pairs(presetList) do
        local presetIsValid, presetData = checkPresetValidity(preset)
        if (not presetIsValid) then goto continue end
        table.insert(globalVars.presets,
            { name = preset.name, type = preset.type, menu = preset.menu, data = presetData })
        ::continue::
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
    if (not truthy(#validMenus)) then return false, nil end
    if (not table.includes(validMenus, preset.menu)) then return false, nil end
    local realType = "place" .. preset.type
    return true, preset.data
end
DEFAULT_STARTING_SETTING_VARS = {
    linearVibratoSV = {
        startMsx = 100,
        endMsx = 0
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
        p1 = vector2(0),
        p2 = vector2(1),
        verticalShift = 0,
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
        customSV = 1
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
    searchTerm = svType:gsub("[%s%(%)#]+", "")
    searchTerm = searchTerm:charAt(1):lower() .. searchTerm:sub(2)
    local settingVars = table.duplicate(DEFAULT_STARTING_SETTING_VARS[searchTerm])
    local labelText = svType .. label .. "Settings"
    getVariables(labelText, settingVars)
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
    if (not #svs or #svs == 0) then
        toggleablePrint("w!", "No SVs found within the copiable region.")
        return
    end
    local firstSVTime = svs[1].StartTime
    local svs = game.getSVsBetweenOffsets(startOffset, endOffset)
    for k14 = 1, #svs do
        local sv = svs[k14]
        local copiedSV = {
            relativeOffset = sv.StartTime - firstSVTime,
            multiplier = sv.Multiplier
        }
        table.insert(settingVars.copiedSVs, copiedSV)
    end
    if (#settingVars.copiedSVs > 0) then toggleablePrint("s!", table.concat({"Copied ", #settingVars.copiedSVs, " SVs."})) end
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
        if (not settingVars.maintainMs and idx == 1) then goto continue end
        do
            local thisTime = truthy(ho.EndTime) and ho.EndTime or ho.StartTime
            local prevTime = truthy(selected[math.max(1, idx - 1)].EndTime) and selected[math.max(1, idx - 1)].EndTime or
                selected[math.max(1, idx - 1)].StartTime
            timeSinceLastObject = timeSinceLastObject + thisTime - prevTime
            if (timeSinceLastObject > settingVars.ms and settingVars.maintainMs and settingVars.optimizeTGs) then
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
                if (settingVars.scaleSVs) then
                    local scalingFactor =
                        (currentTime - startTime) / (secondaryTime - startTime)
                    if (not settingVars.maintainMs) then scalingFactor = 1 / scalingFactor end
                    sv.multiplier = sv.multiplier * scalingFactor
                end
                if (settingVars.maintainMs) then
                    svTime = currentTime - progress * settingVars.ms
                else
                    svTime = currentTime - progress * (currentTime - startTime)
                end
                table.insert(neededIds[idName].svs, createSV(svTime, sv.multiplier))
            end
        end
        ::continue::
    end
    for id, data in pairs(neededIds) do
        local r = math.random(255)
        local g = math.random(255)
        local b = math.random(255)
        local tg = utils.CreateScrollGroup(data.svs, settingVars.initialSV or 1, table.concat({ r, g, b }, ","))
        local action = utils.CreateEditorAction(action_type.CreateTimingGroup, id, tg, data.hos)
        actionList[#actionList + 1] = action
    end
    actions.PerformBatch(actionList)
    toggleablePrint("w!", "Automated.")
end
function placePenisSV(settingVars)
    local startTime = game.uniqueNoteOffsetsBetweenSelected()[1]
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
            local svMultipliers = generateStutterSet(firstStutterSVs[stutterIndex],
                settingVars.stutterDuration,
                settingVars.avgSV,
                settingVars.controlLastSV)
            local stutterStart = stutterOffsets[j]
            local stutterEnd = stutterOffsets[j + 1]
            local timeInterval = stutterEnd - stutterStart
            local secondSVOffset = stutterStart + timeInterval * settingVars.stutterDuration * 0.01
            addSVToList(svsToAdd, stutterStart, svMultipliers[1], true)
            addSVToList(svsToAdd, secondSVOffset, svMultipliers[2], true)
            stutterIndex = stutterIndex + 1
        end
    end
    addFinalSV(svsToAdd, lastOffset, lastMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function placeStutterSSFs(settingVars)
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
    local ssfsToAdd = {}
    local ssfsToRemove = game.getSSFsBetweenOffsets(firstOffset, lastOffset)
    local stutterIndex = 1
    for i = 1, #offsets - 1 do
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local stutterOffsets = generateLinearSet(startOffset, endOffset,
            settingVars.stuttersPerSection + 1)
        for j = 1, #stutterOffsets - 1 do
            local ssfMultipliers = generateStutterSet(firstStutterSVs[stutterIndex],
                settingVars.stutterDuration,
                settingVars.avgSV,
                settingVars.controlLastSV)
            local stutterStart = stutterOffsets[j]
            local stutterEnd = stutterOffsets[j + 1]
            local timeInterval = stutterEnd - stutterStart
            local secondSVOffset = stutterStart + timeInterval * settingVars.stutterDuration * 0.01
            addSSFToList(ssfsToAdd, stutterStart, ssfMultipliers[1], true)
            addSSFToList(ssfsToAdd, secondSVOffset, ssfMultipliers[2], true)
            stutterIndex = stutterIndex + 1
        end
    end
    addFinalSSF(ssfsToAdd, lastOffset, lastMultiplier)
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
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
        addSVToList(svsToAdd, startOffset, sv1, true)
        if sv2 ~= sv1 then addSVToList(svsToAdd, startOffset + startDuration, sv2, true) end
        if sv3 ~= sv2 then addSVToList(svsToAdd, endOffset - endDuration, sv3, true) end
    end
    local finalMultiplier = settingVars.avgSV
    if finalSVType ~= "Normal" then
        finalMultiplier = settingVars.customSV
    end
    addFinalSV(svsToAdd, lastOffset, finalMultiplier, finalSVType == "Override")
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function placeTeleportStutterSSFs(settingVars)
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
    local ssfsToAdd = {}
    local ssfsToRemove = game.getSSFsBetweenOffsets(firstOffset, lastOffset, finalSVType == "Override")
    local ssfPercents = generateLinearSet(svPercent, lastSVPercent, numTeleportSets)
    local mainSSFs = generateLinearSet(settingVars.mainSV, lastMainSV, numTeleportSets)
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
    for i = 1, numTeleportSets do
        local thisMainSSF = mainSSFs[i]
        local startOffset = offsets[i]
        local endOffset = offsets[i + 1]
        local offsetInterval = endOffset - startOffset
        local startMultiplier = getUsableDisplacementMultiplier(startOffset)
        local startDuration = 1 / startMultiplier
        local endMultiplier = getUsableDisplacementMultiplier(endOffset)
        local endDuration = 1 / endMultiplier
        local startDistance = offsetInterval * ssfPercents[i]
        if settingVars.useDistance then startDistance = settingVars.distance end
        local expectedDistance = offsetInterval * settingVars.avgSV
        local traveledDistance = offsetInterval * thisMainSSF
        local endDistance = expectedDistance - startDistance - traveledDistance
        local ssf1 = thisMainSSF + startDistance * startMultiplier
        local ssf2 = thisMainSSF
        local ssf3 = thisMainSSF + endDistance * endMultiplier
        addSSFToList(ssfsToAdd, startOffset, ssf1, true)
        if ssf2 ~= ssf1 then addSSFToList(ssfsToAdd, startOffset + startDuration, ssf2, true) end
        if ssf3 ~= ssf2 then addSSFToList(ssfsToAdd, endOffset - endDuration, ssf3, true) end
    end
    local finalMultiplier = settingVars.avgSV
    if finalSVType ~= "Normal" then
        finalMultiplier = settingVars.customSV
    end
    addFinalSSF(ssfsToAdd, lastOffset, finalMultiplier, finalSVType == "Override")
    removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
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
function placeSVs(menuVars, place, optionalStart, optionalEnd, optionalDistance)
    local finalSVType = FINAL_SV_TYPES[menuVars.settingVars.finalSVIndex]
    local placingStillSVs = menuVars.noteSpacing ~= nil
    local numMultipliers = #menuVars.svMultipliers
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    if placingStillSVs then
        offsets = game.uniqueNoteOffsetsBetweenSelected()
        if (not truthy(offsets)) then return end
        if (place == false) then
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
            if (optionalDistance ~= nil) then
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
        sort(svsToAdd, sortAscendingStartTime), svsToAdd)
    svsToRemove = table.combine(svsToRemove, tbl.svsToRemove)
    svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
function placeStillSVsParent(menuVars)
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
            tbl = placeSVs(menuVars, false, offsets[i], offsets[i + 1], menuVars.settingVars.distance)
        else
            tbl = placeSVs(menuVars, false, offsets[i], offsets[i + 1])
        end
        svsToRemove = table.combine(svsToRemove, tbl.svsToRemove)
        svsToAdd = table.combine(svsToAdd, tbl.svsToAdd)
    end
    addFinalSV(svsToAdd, offsets[#offsets], menuVars.svMultipliers[#menuVars.svMultipliers], true)
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function getStillSVs(menuVars, optionalStart, optionalEnd, svs, retroactiveSVRemovalTable)
    local stillType = STILL_TYPES[menuVars.stillTypeIndex]
    local noteSpacing = menuVars.noteSpacing
    local stillDistance = menuVars.stillDistance
    local noteOffsets = game.uniqueNoteOffsetsBetween(optionalStart, optionalEnd, true)
    if (not noteOffsets) then return { svsToRemove = {}, svsToAdd = {} } end
    local firstOffset = noteOffsets[1]
    local lastOffset = noteOffsets[#noteOffsets]
    if stillType == "Auto" then
        local multiplier = getUsableDisplacementMultiplier(firstOffset)
        local duration = 1 / multiplier
        local timeBefore = firstOffset - duration
        multiplierBefore = game.getSVMultiplierAt(timeBefore)
        stillDistance = multiplierBefore * duration
    elseif stillType == "Otua" then
        local multiplier = getUsableDisplacementMultiplier(lastOffset)
        local duration = 1 / multiplier
        local timeAt = lastOffset
        local multiplierAt = game.getSVMultiplierAt(timeAt)
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
        utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfs)
    })
    toggleablePrint("s!", table.concat({"Created ", #ssfs, pluralize(" SSF.", #ssfs, -2)}))
end
function svVibrato(menuVars, heightFn)
    local offsets = game.uniqueNoteOffsetsBetweenSelected()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svsToAdd = {} ---@type ScrollVelocity[]
    local svsToRemove = {} ---@type ScrollVelocity[]
    local svTimeIsAdded = {}
    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality]
    for i = 1, #offsets - 1 do
        local start = offsets[i]
        local next = offsets[i + 1]
        local startPos = (start - startOffset) / (endOffset - startOffset)
        local endPos = (next - startOffset) / (endOffset - startOffset)
        local posDifference = endPos - startPos
        local roundingFactor = math.max(menuVars.sides, 2)
        local teleportCount = math.floor((next - start) / 1000 * fps / roundingFactor) * roundingFactor
        if (menuVars.sides == 1) then
            for tp = 1, teleportCount do
                local x = (tp - 1) / (teleportCount)
                local offset = next * x + start * (1 - x)
                local height = heightFn(((math.floor((tp - 1) * 0.5) * 2) / (teleportCount - 2)) * posDifference +
                    startPos, tp)
                if (tp % 2 == 1) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
        elseif (menuVars.sides == 2) then
            prepareDisplacingSVs(start, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 1), 0)
            for tp = 1, teleportCount - 2 do
                local x = tp / (teleportCount - 1)
                local offset = next * x + start * (1 - x)
                local initHeight = heightFn(tp / (teleportCount - 1) * posDifference +
                    startPos, tp - 1)
                local newHeight = heightFn((tp + 1) / (teleportCount - 1) * posDifference +
                    startPos, tp)
                local height = initHeight + newHeight
                if (tp % 2 == 0) then
                    height = -height
                end
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height, 0)
            end
            prepareDisplacingSVs(next, svsToAdd, svTimeIsAdded,
                heightFn(endPos, teleportCount), 0, nil)
        else
            prepareDisplacingSVs(start, svsToAdd, svTimeIsAdded, nil,
                -heightFn(startPos, 1), 0)
            prepareDisplacingSVs(start, svsToAdd, svTimeIsAdded, nil,
                heightFn(startPos + 2 / (teleportCount - 1) * posDifference, 3) + heightFn(startPos, 1), 0)
            for tp = 3, teleportCount - 3, 3 do
                local x = (tp - 1) / (teleportCount - 1)
                local offset = next * x + start * (1 - x)
                local height = heightFn(startPos + tp / (teleportCount - 1) * posDifference, tp)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = tp / (teleportCount - 1)
                offset = next * x + start * (1 - x)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    -height, 0)
                x = (tp + 1) / (teleportCount - 1)
                offset = next * x + start * (1 - x)
                local newHeight = heightFn(startPos + (tp + 3) / (teleportCount - 1) * posDifference, tp + 2)
                prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, nil,
                    height + newHeight, 0)
            end
            prepareDisplacingSVs(next, svsToAdd, svTimeIsAdded,
                heightFn(endPos, teleportCount), 0, nil)
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
            utils.CreateEditorAction(
                action_type.RemoveTimingPointBatch, linesToRemove),
            utils.CreateEditorAction(
                action_type.RemoveScrollVelocityBatch, svsToRemove),
            utils.CreateEditorAction(
                action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
            utils.CreateEditorAction(
                action_type.RemoveBookmarkBatch, bmsToRemove) })
    end
    if (truthy(#linesToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #linesToRemove, pluralize(" timing point.", #linesToRemove, -2)}))
    end
    if (truthy(#svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(#ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(#bmsToRemove)) then
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
function alignTimingLines()
    local tpsToRemove = {}
    local currentTP = state.CurrentTimingPoint
    local starttime = currentTP.StartTime
    local length = map.GetTimingPointLength(currentTP)
    local endtime = starttime + length
    local signature = math.toNumber(currentTP.Signature)
    local bpm = currentTP.Bpm
    local mspb = 60000 / bpm
    local msptl = mspb * signature
    local noteTimes = table.property(map.HitObjects, "StartTime")
    local times = {}
    local timingpoints = {}
    for time = starttime, endtime, msptl do
        local originalTime = math.floor(time)
        while (truthy(#noteTimes) and (noteTimes[1] < originalTime - 5)) do
            table.remove(noteTimes, 1)
        end
        if (#noteTimes == 0) then
            times[#times + 1] = originalTime
        elseif (math.abs(noteTimes[1] - originalTime) <= 5) then
            times[#times + 1] = noteTimes[1]
        else
            times[#times + 1] = originalTime
        end
    end
    for k15 = 1, #times do
        local time = times[k15]
        if (game.getTimingPointAt(time).StartTime == time) then
            tpsToRemove[#tpsToRemove + 1] = game.getTimingPointAt(time)
        end
        table.insert(timingpoints, utils.CreateTimingPoint(time, bpm, signature))
    end
    actions.PerformBatch({
        utils.CreateEditorAction(action_type.AddTimingPointBatch, timingpoints),
        utils.CreateEditorAction(action_type.RemoveTimingPointBatch, tpsToRemove)
    })
    toggleablePrint("s!", table.concat({"Created ", #timingpoints, pluralize(" timing point.", #timingpoints, -2)}))
    toggleablePrint("e!", table.concat({"Deleted ", #tpsToRemove, pluralize(" timing point.", #tpsToRemove, -2)}))
end
function changeGroups(menuVars)
    if (state.SelectedScrollGroupId == menuVars.designatedTimingGroup) then
        print("w!", "Moving from one timing group to the same timing group will do nothing.")
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
    for k16 = 1, #svsToRemove do
        local sv = svsToRemove[k16]
        table.insert(svsToAdd, createSV(sv.StartTime, sv.Multiplier))
    end
    for k17 = 1, #ssfsToRemove do
        local ssf = ssfsToRemove[k17]
        table.insert(ssfsToAdd, createSSF(ssf.StartTime, ssf.Multiplier))
    end
    local actionList = {}
    local willChangeSVs = menuVars.changeSVs and #svsToRemove ~= 0
    local willChangeSSFs = menuVars.changeSSFs and #ssfsToRemove ~= 0
    if (willChangeSVs) then
        table.insert(actionList, utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove))
        state.SelectedScrollGroupId = menuVars
            .designatedTimingGroup
        table.insert(actionList, utils.CreateEditorAction(action_type.AddScrollVelocityBatch, svsToAdd))
    end
    if (willChangeSSFs) then
        table.insert(actionList, utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove))
        state.SelectedScrollGroupId = menuVars.designatedTimingGroup
        table.insert(actionList, utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfsToAdd))
    end
    if (#actionList == 0) then
        state.SelectedScrollGroupId = oldGroup
        return
    end
    actions.PerformBatch(actionList)
    if (willChangeSVs) then
        toggleablePrint("s!",
            "Successfully moved " .. #svsToRemove ..
            pluralize(" SV", #svsToRemove) .. ' to "' .. menuVars.designatedTimingGroup .. '".')
    end
    if (willChangeSSFs) then
        toggleablePrint("s!",
            "Successfully moved " .. #ssfsToRemove ..
            pluralize(" SSF", #ssfsToRemove) .. ' to "' .. menuVars.designatedTimingGroup .. '".')
    end
end
function convertSVSSF(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local objects = {}
    local editorActions = {}
    if (menuVars.conversionDirection) then
        local svs = game.getSVsBetweenOffsets(startOffset, endOffset, false)
        for k18 = 1, #svs do
            local sv = svs[k18]
            table.insert(objects, { StartTime = sv.StartTime, Multiplier = sv.Multiplier })
        end
        table.insert(editorActions, utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svs))
    else
        local ssfs = game.getSSFsBetweenOffsets(startOffset, endOffset, false)
        for k19 = 1, #ssfs do
            local ssf = ssfs[k19]
            table.insert(objects, { StartTime = ssf.StartTime, Multiplier = ssf.Multiplier })
        end
        table.insert(editorActions, utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfs))
    end
    local createTable = {}
    for k20 = 1, #objects do
        local obj = objects[k20]
        if (menuVars.conversionDirection) then
            table.insert(createTable, createSSF(obj.StartTime,
                obj.Multiplier))
        else
            table.insert(createTable, createSV(obj.StartTime, obj.Multiplier))
        end
    end
    if (menuVars.conversionDirection) then
        table.insert(editorActions, utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, createTable))
    else
        table.insert(editorActions, utils.CreateEditorAction(action_type.AddScrollVelocityBatch, createTable))
    end
    actions.PerformBatch(editorActions)
    toggleablePrint("w!", "Successfully converted.")
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
    if (not menuVars.copyTable[1]) then goto continue1 end
    for k21 = 1, #lines do
        local line = lines[k21]
        local copiedLine = {
            relativeOffset = line.StartTime - startOffset,
            bpm = line.Bpm,
            signature = line.Signature,
            hidden = line.Hidden,
        }
        table.insert(menuVars.copied.lines[menuVars.curSlot], copiedLine)
    end
    ::continue1::
    if (not menuVars.copyTable[2]) then goto continue2 end
    for k22 = 1, #svs do
        local sv = svs[k22]
        local copiedSV = {
            relativeOffset = sv.StartTime - startOffset,
            multiplier = sv.Multiplier
        }
        table.insert(menuVars.copied.SVs[menuVars.curSlot], copiedSV)
    end
    ::continue2::
    if (not menuVars.copyTable[3]) then goto continue3 end
    for k23 = 1, #ssfs do
        local ssf = ssfs[k23]
        local copiedSSF = {
            relativeOffset = ssf.StartTime - startOffset,
            multiplier = ssf.Multiplier
        }
        table.insert(menuVars.copied.SSFs[menuVars.curSlot], copiedSSF)
    end
    ::continue3::
    if (not menuVars.copyTable[4]) then goto continue4 end
    for k24 = 1, #bms do
        local bm = bms[k24]
        local copiedBM = {
            relativeOffset = bm.StartTime - startOffset,
            note = bm.Note
        }
        table.insert(menuVars.copied.BMs[menuVars.curSlot], copiedBM)
    end
    ::continue4::
    if (#menuVars.copied.BMs[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            table.concat({"Copied ", #menuVars.copied.BMs[menuVars.curSlot], " Bookmarks."}))
    end
    if (#menuVars.copied.SSFs[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            table.concat({"Copied ", #menuVars.copied.SSFs[menuVars.curSlot], " SSFs."}))
    end
    if (#menuVars.copied.SVs[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            table.concat({"Copied ", #menuVars.copied.SVs[menuVars.curSlot], " SVs."}))
    end
    if (#menuVars.copied.lines[menuVars.curSlot] > 0) then
        toggleablePrint("s!",
            table.concat({"Copied ", #menuVars.copied.lines[menuVars.curSlot], " Lines."}))
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
    if (lastCopiedValue == nil) then
        lastCopiedValue = lastCopiedSSF or lastCopiedLine or lastCopiedBM or { relativeOffset = 0 }
    end
    local endRemoveOffset = endOffset + lastCopiedValue.relativeOffset + 1 / 128
    local linesToRemove = menuVars.copyTable[1] and game.getLinesBetweenOffsets(startOffset, endRemoveOffset) or {}
    local svsToRemove = menuVars.copyTable[2] and game.getSVsBetweenOffsets(startOffset, endRemoveOffset) or {}
    local ssfsToRemove = menuVars.copyTable[3] and game.getSSFsBetweenOffsets(startOffset, endRemoveOffset) or {}
    local bmsToRemove = menuVars.copyTable[4] and game.getBookmarksBetweenOffsets(startOffset, endRemoveOffset) or {}
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
    local hitObjectTimes = table.property(map.HitObjects, "StartTime")
    for i = 1, #offsets do
        local pasteOffset = offsets[i]
        local nextOffset = offsets[math.clamp(i + 1, 1, #offsets)]
        local ignoranceTolerance = 0.01
        for _, line in ipairs(menuVars.copied.lines[menuVars.curSlot]) do
            local timeToPasteLine = pasteOffset + line.relativeOffset
            if (math.abs(timeToPasteLine - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip1
            end
            table.insert(linesToAdd, utils.CreateTimingPoint(timeToPasteLine, line.bpm, line.signature, line.hidden))
            ::skip1::
        end
        for _, sv in ipairs(menuVars.copied.SVs[menuVars.curSlot]) do
            local timeToPasteSV = pasteOffset + sv.relativeOffset
            if (math.abs(timeToPasteSV - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip2
            end
            if menuVars.tryAlign then
                timeToPasteSV = tryAlignToHitObjects(timeToPasteSV, hitObjectTimes, menuVars.alignWindow)
            end
            table.insert(svsToAdd, createSV(timeToPasteSV, sv.multiplier))
            ::skip2::
        end
        for _, ssf in ipairs(menuVars.copied.SSFs[menuVars.curSlot]) do
            local timeToPasteSSF = pasteOffset + ssf.relativeOffset
            if (math.abs(timeToPasteSSF - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip3
            end
            table.insert(ssfsToAdd, createSSF(timeToPasteSSF, ssf.multiplier))
            ::skip3::
        end
        for _, bm in ipairs(menuVars.copied.BMs[menuVars.curSlot]) do
            local timeToPasteBM = pasteOffset + bm.relativeOffset
            if (math.abs(timeToPasteBM - nextOffset) < ignoranceTolerance and i ~= #offsets) then
                goto skip4
            end
            table.insert(bmsToAdd, utils.CreateBookmark(timeToPasteBM, bm.note))
            ::skip4::
        end
    end
    actions.PerformBatch({
        utils.CreateEditorAction(action_type.RemoveTimingPointBatch, linesToRemove),
        utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove),
        utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        utils.CreateEditorAction(action_type.RemoveBookmarkBatch, bmsToRemove),
        utils.CreateEditorAction(action_type.AddTimingPointBatch, linesToAdd),
        utils.CreateEditorAction(action_type.AddScrollVelocityBatch, svsToAdd),
        utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfsToAdd),
        utils.CreateEditorAction(action_type.AddBookmarkBatch, bmsToAdd),
    })
    if (truthy(#linesToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #linesToRemove, pluralize(" timing point.", #linesToRemove, -2)}))
    end
    if (truthy(#svsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #svsToRemove .. pluralize(" scroll velocity.", #svsToRemove, -2))
    end
    if (truthy(#ssfsToRemove)) then
        toggleablePrint("e!",
            "Deleted " .. #ssfsToRemove .. pluralize(" scroll speed factor.", #ssfsToRemove, -2))
    end
    if (truthy(#bmsToRemove)) then
        toggleablePrint("e!", table.concat({"Deleted ", #bmsToRemove, pluralize(" bookmark.", #bmsToRemove, -2)}))
    end
    if (truthy(#linesToAdd)) then
        toggleablePrint("s!", table.concat({"Created ", #linesToAdd, pluralize(" timing point.", #linesToAdd, -2)}))
    end
    if (truthy(#svsToAdd)) then
        toggleablePrint("s!",
            "Created " .. #svsToAdd .. pluralize(" scroll velocity.", #svsToAdd, -2))
    end
    if (truthy(#ssfsToAdd)) then
        toggleablePrint("s!",
            "Created " .. #ssfsToAdd .. pluralize(" scroll speed factor.", #ssfsToAdd, -2))
    end
    if (truthy(#bmsToAdd)) then
        toggleablePrint("s!", table.concat({"Created ", #bmsToAdd, pluralize(" bookmark.", #bmsToAdd, -2)}))
    end
end
function tryAlignToHitObjects(time, hitObjectTimes, alignWindow)
    if not truthy(#hitObjectTimes) then
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
    if (not menuVars.linearlyChange) then
        displaceNoteSVs(menuVars)
        return
    end
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local svsToRemove = {}
    local svsToAdd = {}
    for k25 = 1, #offsets do
        local offset = offsets[k25]
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
    if (place == false) then offsets = { optionalOffset } end
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
    if (place ~= false) then
        removeAndAddSVs(svsToRemove, svsToAdd)
        return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
    end
    return { svsToRemove = svsToRemove, svsToAdd = svsToAdd }
end
function displaceViewSVs(menuVars)
    local svsToAdd = {}
    local svsToRemove = {}
    local svTimeIsAdded = {}
    local offsets = game.uniqueNoteOffsetsBetweenSelected()
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
        for k26 = 1, #svsBetweenOffsets do
            local sv = svsBetweenOffsets[k26]
            local newSVMultiplier = scalingFactor * sv.Multiplier
            addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
        end
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
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
    local type = "s!"
    if (fixedLNEndsCount == 0) then type = "!" end
    print(type, table.concat({"Fixed ", fixedLNEndsCount, " flipped LN ends"}))
end
function flickerSVs(menuVars)
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
            if (t % 2 == 1) then goto continueTeleport end
            pushFactor = (2 * menuVars.flickerPosition - 1) * flickerDuration
            teleportOffsets[t] = teleportOffsets[t] + pushFactor
            ::continueTeleport::
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
    local notes = game.uniqueNotesBetweenSelected()
    for k27 = 1, #notes do
        local ho = notes[k27]
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
            utils.CreateEditorAction(action_type.CreateLayer, layer))
        table.insert(moveNoteQueue, utils.CreateEditorAction(action_type.MoveToLayer, layer, layerData.hos))
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
        if (not hoLayer.Name:find("plumoguSV")) then goto continue end
        color = hoLayer.Name:match("-([a-zA-Z]+)$")
        snap = REVERSE_COLOR_MAP[color]
        mostRecentTP = game.getTimingPointAt(ho.StartTime)
        if (snap == 1) then
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
        originalLayerName = hoLayer.Name:match("^([^-]+)-")
        table.insert(moveNoteActions,
            utils.CreateEditorAction(action_type.MoveToLayer,
                map.EditorLayers[table.indexOf(table.property(map.EditorLayers, "Name"), originalLayerName)], { ho }))
        table.insert(removeLayerActions,
            utils.CreateEditorAction(action_type.RemoveLayer, hoLayer))
        ::continue::
    end
    actions.PerformBatch(moveNoteActions)
    if (#normalTpsToAdd + #snapTpsToAdd + #tpsToRemove == 0) then
        print("w!", "There were no generated layers you nonce")
        return
    end
    actions.PerformBatch({
        utils.CreateEditorAction(action_type.AddTimingPointBatch, normalTpsToAdd),
        utils.CreateEditorAction(action_type.AddTimingPointBatch, snapTpsToAdd),
        utils.CreateEditorAction(action_type.RemoveTimingPointBatch, tpsToRemove),
    })
end
function clearSnappedLayers()
    local removeLayerActions = {}
    for _, layer in ipairs(map.EditorLayers) do
        if layer.Name:find("plumoguSV") then
            table.insert(removeLayerActions, utils.CreateEditorAction(action_type.RemoveLayer, layer))
        end
    end
    if (#removeLayerActions == 0) then
        print("w!", "There were no generated layers you nonce")
        return
    end
    actions.PerformBatch(removeLayerActions)
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
function mergeSVs()
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local svTimeDict = {}
    local svsToRemove = {}
    for _, sv in ipairs(table.reverse(game.getSVsBetweenOffsets(startOffset, endOffset, true, true))) do
        if (svTimeDict[sv.StartTime]) then
            svsToRemove[#svsToRemove + 1] = sv
        else
            svTimeDict[sv.StartTime] = true
        end
    end
    actions.Perform(utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove))
end
function reverseScrollSVs(menuVars)
    local offsets = game.uniqueNoteOffsetsBetweenSelected()
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
    for k28 = 1, #svsBetweenOffsets do
        local sv = svsBetweenOffsets[k28]
        if (not svTimeIsAdded[sv.StartTime]) then
            almostSVsToAdd[#almostSVsToAdd + 1] = sv
        end
    end
    for k29 = 1, #almostSVsToAdd do
        local sv = almostSVsToAdd[k29]
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
        local currentDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset,
            endOffset)
        local scalingDistance
        if scaleType == "Average SV" then
            local targetDistance = menuVars.avgSV * (note2Offset - note1Offset)
            scalingDistance = targetDistance - currentDistance
        elseif scaleType == "Absolute Distance" then
            scalingDistance = menuVars.distance - currentDistance
        elseif scaleType == "Relative Ratio" then
            scalingDistance = (menuVars.ratio - 1) * currentDistance
        end
        if isStartDisplace then
            local atDisplacement = scalingDistance
            local afterDisplacement = 0
            prepareDisplacingSVs(note1Offset, svsToAdd, svTimeIsAdded, nil, atDisplacement,
                afterDisplacement)
        else
            local beforeDisplacement = scalingDistance
            local atDisplacement = 0
            prepareDisplacingSVs(note2Offset, svsToAdd, svTimeIsAdded, beforeDisplacement,
                atDisplacement, nil)
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
        for k30 = 1, #svsBetweenOffsets do
            local sv = svsBetweenOffsets[k30]
            local newSVMultiplier = scalingFactor * sv.Multiplier
            addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
        end
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function swapNoteSVs()
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
    for k31 = 1, #svsBetweenOffsets do
        local sv = svsBetweenOffsets[k31]
        local newSVMultiplier = sv.Multiplier + menuVars.verticalShift
        addSVToList(svsToAdd, sv.StartTime, newSVMultiplier, true)
    end
    removeAndAddSVs(svsToRemove, svsToAdd)
end
function changeNoteLockMode()
    local mode = state.GetValue("note-lock-mode", 0)
    mode = (mode + 1) % 4
    if (mode == 0) then
        print("s", "Notes have been unlocked.")
    end
    if (mode == 1) then
        print("e", "Notes have been fully locked. To change the lock mode, press " .. globalVars.hotkeyList[10])
    end
    if (mode == 2) then
        print("w",
            "Notes can no longer be placed, only moved. To change the lock mode, press " .. globalVars.hotkeyList[10])
    end
    if (mode == 3) then
        print("w",
            "Notes can no longer be moved, only placed and deleted. To change the lock mode, press " ..
            globalVars.hotkeyList[10])
    end
    state.SetValue("note-lock-mode", mode)
end
function initializeNoteLockMode()
    state.SetValue("note-lock-mode", 0)
    listen(function(action, type, fromLua)
        if (fromLua) then return end
        local actionIndex = tonumber(action.Type) ---@cast actionIndex EditorActionType
        local mode = state.GetValue("note-lock-mode", 0)
        if (mode == 1) then
            if (actionIndex > 9) then return end
            actions.Undo()
        end
        if (mode == 2) then
            local allowedIndices = { 0, 1, 3, 4, 8, 9 }
            if (not table.contains(allowedIndices, actionIndex)) then return end
            actions.Undo()
        end
        if (mode == 3) then
            local allowedIndices = { 2, 5, 6, 7 }
            if (not table.contains(allowedIndices, actionIndex)) then return end
            actions.Undo()
        end
    end)
end
function jumpToTg()
    if (not truthy(#state.SelectedHitObjects)) then return end
    local tgId = state.SelectedHitObjects[1].TimingGroup
    for _, ho in pairs(state.SelectedHitObjects) do
        if (ho.TimingGroup ~= tgId) then return end
    end
    state.SelectedScrollGroupId = tgId
end
function checkForGlobalHotkeys()
    if (kb.pressedKeyCombo(globalVars.hotkeyList[9])) then jumpToTg() end
    if (kb.pressedKeyCombo(globalVars.hotkeyList[10])) then changeNoteLockMode() end
end
function getMapStats()
    local currentTg = state.SelectedScrollGroupId
    local tgList = map.GetTimingGroupIds()
    local svSum = 0
    local ssfSum = 0
    for k32 = 1, #tgList do
        local tg = tgList[k32]
        state.SelectedScrollGroupId = tg
        svSum = svSum + #map.ScrollVelocities
        ssfSum = ssfSum + #map.ScrollSpeedFactors
    end
    print("s!",
        "That's an average of " ..
        math.round(svSum * 1000 / map.TrackLength, 2) ..
        table.concat({" SVs per second, or ", math.round(ssfSum * 1000 / map.TrackLength, 2), " SSFs per second."}))
    print("s!", table.concat({"This map also contains ", #map.TimingPoints, " timing points."}))
    print("s!",
        table.concat({"This map has ", svSum .. " SVs and " .. ssfSum .. " SSFs across " .. #tgList, " timing groups."}))
    print("w!",
        "Remember that the quality of map has no correlation with the object count! Try to be optimal in your object usage.")
    state.SelectedScrollGroupId = currentTg
end
function selectAlternating(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local notes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then notes = state.SelectedHitObjects end
    local times = {}
    for k33 = 1, #notes do
        local ho = notes[k33]
        times[#times + 1] = ho.StartTime
    end
    times = table.dedupe(times)
    local allowedTimes = {}
    for i, time in pairs(times) do
        if ((i - 2 + menuVars.offset) % menuVars.every == 0) then
            allowedTimes[#allowedTimes + 1] = time
        end
    end
    local notesToSelect = {}
    local currentTime = allowedTimes[1]
    local index = 2
    for k34 = 1, #notes do
        local note = notes[k34]
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
    for k35 = 1, #notes do
        local note = notes[k35]
        noteTimeTable[#noteTimeTable + 1] = note.StartTime
    end
    noteTimeTable = table.dedupe(noteTimeTable)
    local sizeDict = {}
    for idx = 1, keyCount do
        sizeDict[#sizeDict + 1] = {}
    end
    for k36 = 1, #noteTimeTable do
        local time = noteTimeTable[k36]
        local size = 0
        local curLane = 0
        local totalNotes = {}
        for k37 = 1, #notes do
            local note = notes[k37]
            if (math.abs(note.StartTime - time) < 3) then
                size = size + 1
                curLane = curLane + 1
                totalNotes[#totalNotes + 1] = note
            end
        end
        sizeDict[size] = table.combine(sizeDict[size], totalNotes)
    end
    local notesToSelect = {}
    for idx = 1, keyCount do
        if (menuVars["select" .. idx]) then
            notesToSelect = table.combine(notesToSelect, sizeDict[idx])
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
function selectByNoteType(menuVars)
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local startOffset = offsets[1]
    local endOffset = offsets[#offsets]
    local totalNotes = game.getNotesBetweenOffsets(startOffset, endOffset)
    if (globalVars.comboizeSelect) then totalNotes = state.SelectedHitObjects end
    local notesToSelect = {}
    for k38 = 1, #totalNotes do
        local note = totalNotes[k38]
        if (note.EndTime == 0 and menuVars.rice) then notesToSelect[#notesToSelect + 1] = note end
        if (note.EndTime ~= 0 and menuVars.ln) then notesToSelect[#notesToSelect + 1] = note end
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
    local timingPoint = game.getTimingPointAt(startOffset)
    local bpm = timingPoint.Bpm
    local times = {}
    local disallowedTimes = {}
    local pointer = timingPoint.StartTime
    local counter = 0
    local factors = {}
    for i = 2, (menuVars.snap - 1) do
        if (menuVars.snap % i == 0) then factors[#factors + 1] = i end
    end
    for k39 = 1, #factors do
        local factor = factors[k39]
        while (pointer <= endOffset + 10) do
            if ((counter ~= 0 or factor == 1) and pointer >= startOffset) then disallowedTimes[#disallowedTimes + 1] = pointer end
            counter = (counter + 1) % factor
            pointer = pointer + (60000 / bpm) / (factor)
        end
        pointer = timingPoint.StartTime
        counter = 0
    end
    while (pointer <= endOffset + 10) do
        if ((counter ~= 0 or menuVars.snap == 1) and pointer >= startOffset) then times[#times + 1] = pointer end
        counter = (counter + 1) % menuVars.snap
        pointer = pointer + (60000 / bpm) / (menuVars.snap)
    end
    for k40 = 1, #disallowedTimes do
        local bannedTime = disallowedTimes[k40]
        for idx, time in pairs(times) do
            if (math.abs(time - bannedTime) < 10) then table.remove(times, idx) end
        end
    end
    local notesToSelect = {}
    local currentTime = times[1]
    local index = 2
    for k41 = 1, #notes do
        local note = notes[k41]
        if (note.StartTime > currentTime + 10 and index <= #times) then
            currentTime = times[index]
            index = index + 1
        end
        if (math.abs(note.StartTime - currentTime) < 10) then
            notesToSelect[#notesToSelect + 1] = note
        end
    end
    actions.SetHitObjectSelection(notesToSelect)
    print(truthy(notesToSelect) and "s!" or "w!", #notesToSelect .. " notes selected")
end
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
    local xList = state.GetValue("singularity_xList", {})
    local yList = state.GetValue("singularity_yList", {})
    local vxList = state.GetValue("singularity_vxList", {})
    local vyList = state.GetValue("singularity_vyList", {})
    local axList = state.GetValue("singularity_axList", {})
    local ayList = state.GetValue("singularity_ayList", {})
    local pulseStatus = state.GetValue("cache_pulseValue", 0)
    local slowSpeedR = 89
    local slowSpeedG = 0
    local slowSpeedB = 255
    local fastSpeedR = 255
    local fastSpeedG = 165
    local fastSpeedB = 117
    local speed = clamp(math.abs(multiplier), 0, 4)
    if (dimX < 100 or imgui.GetTime() < 0.3) then return end
    createParticle(xList, yList, vxList, vyList, axList, ayList, dimX, dimY, 150)
    updateParticles(xList, yList, vxList, vyList, axList, ayList, dimX, dimY,
        state.DeltaTime * speed, multiplier)
    local lerp = function(w, l, h)
        return w * h + (1 - w) * l
    end
    for i = 1, #xList do
        local x = xList[i]
        local y = yList[i]
        local vx = vxList[i]
        local vy = vyList[i]
        local s = sqrt(vx ^ 2 + vy ^ 2)
        local clampedSpeed = clamp(s / 5, 0, 1)
        local r = lerp(clampedSpeed, slowSpeedR, fastSpeedR)
        local g = lerp(clampedSpeed, slowSpeedG, fastSpeedG)
        local b = lerp(clampedSpeed, slowSpeedB, fastSpeedB)
        local pos = { x + topLeft.x, y + topLeft.y }
        ctx.AddCircleFilled(pos, 2,
            rgbaToUint(r, g, b, 55 + pulseStatus * 200))
    end
    ctx.AddCircleFilled(dim / 2 + topLeft, 15, 4278190080)
    ctx.AddCircle(dim / 2 + topLeft, 16, 4294967295 - math.floor(pulseStatus * 120) * 16777216)
    ctx.AddCircle(dim / 2 + topLeft, 24 - pulseStatus * 8, 16777215 + math.floor(pulseStatus * 255) * 16777216)
    state.SetValue("singularity_xList", xList)
    state.SetValue("singularity_yList", yList)
    state.SetValue("singularity_vxList", vxList)
    state.SetValue("singularity_vyList", vyList)
    state.SetValue("singularity_axList", axList)
    state.SetValue("singularity_ayList", ayList)
end
function createParticle(x, y, vx, vy, ax, ay, dimX, dimY, n)
    if (#x >= n) then return end
    x[#x + 1] = math.random() * dimX
    y[#y + 1] = math.random() * dimY
    vx[#vx + 1] = 0
    vy[#vy + 1] = 0
    ax[#ax + 1] = 0
    ay[#ay + 1] = 0
end
function updateParticles(xl, yl, vxl, vyl, axl, ayl, dimX, dimY, dt, multiplier)
    local sqrt = math.sqrt
    local clamp = math.clamp
    local spinDir = math.sign(multiplier)
    local movementSpeed = 0.1
    local bounceCoefficient = 0.8
    for i = 1, #xl do
        local x = xl[i]
        local y = yl[i]
        local vx = vxl[i]
        local vy = vyl[i]
        local ax = axl[i]
        local ay = ayl[i]
        local sgPosx = bit32.rshift(dimX, 1)
        local sgPosy = bit32.rshift(dimY, 1)
        local xDist = sgPosx - x
        local yDist = sgPosy - y
        local dist = sqrt(xDist ^ 2 + yDist ^ 2)
        if (dist < 10) then dist = 10 end
        local gravityFactor = bit32.rshift(dist ^ 3, 9)
        local gx = xDist / gravityFactor
        local gy = yDist / gravityFactor
        local spinFactor = 10 * spinDir / sqrt(dist)
        axl[i] = gx + gy * spinFactor
        ayl[i] = gy - gx * spinFactor
        local movementDist = dt * movementSpeed
        vxl[i] = vx + ax * movementDist
        vyl[i] = vy + ay * movementDist
        xl[i] = x + vx * movementDist
        yl[i] = y + vy * movementDist
        if (x < 0 or x > dimX) then
            vxl[i] = -vxl[i] * bounceCoefficient
            xl[i] = clamp(xl[i], 1, dimX - 1)
        end
        if (y < 0 or y > dimY) then
            vyl[i] = -vyl[i] * bounceCoefficient
            yl[i] = clamp(yl[i], 1, dimY - 1)
        end
        local dragFactor = 1 - dt / 500
        vxl[i] = clamp(vxl[i] * dragFactor, -5, 5)
        vyl[i] = clamp(vyl[i] * dragFactor, -5, 5)
    end
end
function renderReactiveStars()
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    local dimX = dim.x
    local dimY = dim.y
    local clamp = math.clamp
    local xList = state.GetValue("stars_xList", {})
    local yList = state.GetValue("stars_yList", {})
    local vxList = state.GetValue("stars_vxList", {})
    local szList = state.GetValue("stars_szList", {})
    if (dimX < 100 or imgui.GetTime() < 0.3) then return end
    createStar(xList, yList, vxList, szList, dimX, dimY, 100)
    updateStars(xList, yList, vxList, szList, dimX, dimY, state.DeltaTime)
    for i = 1, #xList do
        local x = xList[i]
        local y = yList[i]
        local sz = szList[i]
        local progress = x / dimX
        local brightness = clamp(-8 * progress * (progress - 1), 0, 1)
        local pos = { x + topLeft.x, y + topLeft.y }
        ctx.AddCircleFilled(pos, sz, rgbaToUint(255, 255, 255, brightness * 255))
    end
    state.SetValue("stars_xList", xList)
    state.SetValue("stars_yList", yList)
    state.SetValue("stars_vxList", vxList)
    state.SetValue("stars_szList", szList)
end
function createStar(x, y, vx, sz, dimX, dimY, n)
    if (#x >= n) then return end
    x[#x + 1] = math.random() * dimX
    y[#y + 1] = math.random() * dimY
    vx[#vx + 1] = math.random() * 3 + 1
    sz[#sz + 1] = math.random(3) * 0.5
end
function updateStars(xl, yl, vxl, szl, dimX, dimY, dt)
    local random = math.random
    local clamp = math.clamp
    local m = game.getSVMultiplierAt(state.SongTime)
    for i = 1, #xl do
        local starWrapped = false
        local x = xl[i]
        local y = yl[i]
        local vx = vxl[i]
        while (x > dimX + 10) do
            starWrapped = true
            x = x - dimX - 20
        end
        while (x < -10) do
            starWrapped = true
            x = x + dimX + 20
        end
        xl[i] = x
        if (starWrapped) then
            yl[i] = random() * dimY
            vxl[i] = random() * 3 + 1
            szl[i] = random(3) * 0.5
        else
            xl[i] = x + vx * dt * 0.05 *
                clamp(2 * m, -50, 50)
        end
    end
end
local RGB_SNAP_MAP = {
    [1] = { 255, 0, 0 },
    [2] = { 0, 0, 255 },
    [3] = { 120, 0, 255 },
    [4] = { 255, 255, 0 },
    [5] = { 255, 255, 255 },
    [6] = { 255, 0, 255 },
    [8] = { 255, 120, 0 },
    [12] = { 0, 120, 255 },
    [16] = { 0, 255, 0 },
}
function renderSynthesis()
    local bgVars = {
        snapTable = {},
        pulseCount = 0,
        snapOffset = 0,
        lastDifference = 0
    }
    getVariables("synthesis", bgVars)
    local circleSize = 10
    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()
    local maxDim = math.sqrt(dim.x ^ 2 + dim.y ^ 2)
    local curTime = state.SongTime
    local tl = game.getTimingPointAt(curTime)
    local msptl = 60000 / tl.Bpm * math.toNumber(tl.Signature)
    local snapTable = bgVars.snapTable
    local pulseCount = bgVars.pulseCount
    local mostRecentStart = game.getNoteOffsetAt(curTime)
    local nearestBar = map.GetNearestSnapTimeFromTime(false, 1, curTime)
    if (#snapTable >= (maxDim / 1.6) / circleSize) then
        bgVars.snapOffset = circleSize
        table.remove(snapTable, 1)
    end
    if (bgVars.snapOffset > 0.001) then
        bgVars.snapOffset = bgVars.snapOffset * 0.99 ^ state.DeltaTime
    end
    if (curTime - mostRecentStart < bgVars.lastDifference) then
        table.insert(snapTable, game.getSnapAt(mostRecentStart, true))
    end
    bgVars.lastDifference = curTime - mostRecentStart
    for idx, snap in pairs(snapTable) do
        local colTbl = RGB_SNAP_MAP[snap]
        ctx.AddCircle(dim / 2 + topLeft, circleSize * (idx - 1) + bgVars.snapOffset,
            rgbaToUint(colTbl[1] * 4 / 5 + 51, colTbl[2] * 4 / 5 + 51, colTbl[3] * 4 / 5 + 51, 100))
    end
    saveVariables("synthesis", bgVars)
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
    local bodyColor = rgbaToUint(122, 70, 212, 255)
    local eyeColor = rgbaToUint(30, 20, 35, 255)
    local earColor = rgbaToUint(62, 10, 145, 255)
    local stemColor = rgbaToUint(0, 255, 0, 255)
    o.AddCircleFilled(earCoords, earRadius, earColor)
    drawHorizontalPillShape(o, headCoords1, headCoords2, headRadius, bodyColor, 12)
    drawHorizontalPillShape(o, eyeCoords1, eyeCoords2, eyeRadius, eyeColor, 12)
    o.AddRectFilled(sz, headCoords1, bodyColor)
    o.AddRectFilled(vector.New(stemCoords[1], stemCoords[2]), vector.New(stemCoords[1] + 10, stemCoords[2] + 20),
        stemColor)
    o.AddRectFilled(vector.New(stemCoords[1] - 10, stemCoords[2]), vector.New(stemCoords[1] + 20, stemCoords[2] - 5),
        stemColor)
end
function drawCapybara2()
    if not globalVars.drawCapybara2 then return end
    local o = imgui.GetForegroundDrawList()
    local sz = state.WindowSize
    local topLeftCapyPoint = { 0, sz[2] - 165 }
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
    local color1 = rgbaToUint(250, 250, 225, 255)
    local color2 = rgbaToUint(240, 180, 140, 255)
    local color3 = rgbaToUint(195, 90, 120, 255)
    local color4 = rgbaToUint(115, 5, 65, 255)
    local color5 = rgbaToUint(100, 5, 45, 255)
    local color6 = rgbaToUint(200, 115, 135, 255)
    local color7 = rgbaToUint(175, 10, 70, 255)
    local color8 = rgbaToUint(200, 90, 110, 255)
    local color9 = rgbaToUint(125, 10, 75, 255)
    local color10 = rgbaToUint(220, 130, 125, 255)
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
    local outlineColor = rgbaToUint(rgbColors.red, rgbColors.green, rgbColors.blue, 255)
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
function drawCursorTrail()
    local o = imgui.GetForegroundDrawList()
    local m = imgui.GetMousePos()
    local t = imgui.GetTime()
    local sz = state.WindowSize
    local cursorTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if cursorTrail ~= "Dust" then state.SetValue("initializeDustParticles", false) end
    if cursorTrail ~= "Sparkle" then state.SetValue("initializeSparkleParticles", false) end
    if cursorTrail == "None" then return end
    if cursorTrail == "Snake" then drawSnakeTrail(o, m, t) end
    if cursorTrail == "Dust" then drawDustTrail(o, m, t, sz) end
    if cursorTrail == "Sparkle" then drawSparkleTrail(o, m, t, sz) end
end
function drawSnakeTrail(o, m, t)
    local trailPoints = globalVars.cursorTrailPoints
    local snakeTrailPoints = {}
    initializeSnakeTrailPoints(snakeTrailPoints, m, MAX_CURSOR_TRAIL_POINTS)
    getVariables("snakeTrailPoints", snakeTrailPoints)
    local needTrailUpdate = clock.listen("snakeTrail", 1000 / globalVars.effectFPS)
    updateSnakeTrailPoints(snakeTrailPoints, needTrailUpdate, m, trailPoints,
        globalVars.snakeSpringConstant)
    saveVariables("snakeTrailPoints", snakeTrailPoints)
    local trailShape = TRAIL_SHAPES[globalVars.cursorTrailShapeIndex]
    renderSnakeTrailPoints(o, m, snakeTrailPoints, trailPoints, globalVars.cursorTrailSize,
        globalVars.cursorTrailGhost, trailShape)
end
function initializeSnakeTrailPoints(snakeTrailPoints, m, trailPoints)
    if (state.GetValue("initializeSnakeTrail")) then
        for i = 1, trailPoints do
            snakeTrailPoints[i] = {}
        end
        return
    end
    for i = 1, trailPoints do
        snakeTrailPoints[i] = m
    end
    state.SetValue("initializeSnakeTrail", true)
    saveVariables("snakeTrailPoints", snakeTrailPoints)
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
        local color = rgbaToUint(255, 255, 255, alpha)
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
    getVariables("dustParticles", dustParticles)
    updateDustParticles(t, m, dustParticles, dustDuration, dustSize)
    saveVariables("dustParticles", dustParticles)
    renderDustParticles(globalVars.rgbPeriod, o, t, dustParticles, dustDuration, dustSize)
end
function initializeDustParticles(_, t, dustParticles, numDustParticles, dustDuration)
    if state.GetValue("initializeDustParticles") then
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
    state.SetValue("initializeDustParticles", true)
    saveVariables("dustParticles", dustParticles)
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
            local dustColor = rgbaToUint(currentRGBColors.red, currentRGBColors.green, currentRGBColors.blue, alpha)
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
    getVariables("sparkleParticles", sparkleParticles)
    updateSparkleParticles(t, m, sparkleParticles, sparkleDuration, sparkleSize)
    saveVariables("sparkleParticles", sparkleParticles)
    renderSparkleParticles(o, t, sparkleParticles, sparkleDuration, sparkleSize)
end
function initializeSparkleParticles(_, t, sparkleParticles, numSparkleParticles, sparkleDuration)
    if state.GetValue("initializeSparkleParticles") then
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
    state.SetValue("initializeSparkleParticles", true)
    saveVariables("sparkleParticles", sparkleParticles)
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
            local white = rgbaToUint(255, 255, 255, 255)
            local actualSize = sparkleSize * (1 - math.quadraticBezier(0, time))
            local sparkleColor = rgbaToUint(255, 255, 100, 30)
            drawGlare(o, sparkleCoords, actualSize, white, sparkleColor)
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
    oldMousePosition = state.GetValue("oldMousePosition", vector2(0))
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
    getVariables("pulseController", pulseVars)
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
    pulseVars.pulseStatus = math.max(pulseVars.pulseStatus, 0) * (globalVars.pulseCoefficient or 0)
    local borderColor = state.GetValue("baseBorderColor") or vector4(1)
    local negatedBorderColor = vector4(1) - borderColor
    local pulseColor = globalVars.useCustomPulseColor and globalVars.pulseColor or negatedBorderColor
    imgui.PushStyleColor(imgui_col.Border, pulseColor * pulseVars.pulseStatus + borderColor * (1 - pulseVars.pulseStatus))
    saveVariables("pulseController", pulseVars)
    state.SetValue("cache_pulseValue", pulseVars.pulseStatus)
    state.SetValue("cache_pulseStatus", pulseVars.pulsedThisFrame)
end
---@class PhysicsObject
---@field pos Vector2
---@field v Vector2
---@field a Vector2
---@class Particle: PhysicsObject
---@field col Vector4
---@field size integer
function renderBackground()
    if (DYNAMIC_BACKGROUND_TYPES[globalVars.dynamicBackgroundIndex] == "Reactive Stars") then
        renderReactiveStars()
    end
    if (DYNAMIC_BACKGROUND_TYPES[globalVars.dynamicBackgroundIndex] == "Reactive Singularity") then
        renderReactiveSingularities()
    end
    if (DYNAMIC_BACKGROUND_TYPES[globalVars.dynamicBackgroundIndex] == "Synthesis") then
        renderSynthesis()
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
    local borderSize = (styleTheme == "Rounded + Border" or
        styleTheme == "Boxed + Border") and 1 or 0
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
function setPluginAppearanceColors(colorTheme)
    local borderColor = vector4(1)
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
    if colorTheme == "BGR + otingocnI" then borderColor = setInvertedIncognitoRGBColors(globalVars.rgbPeriod) end
    if colorTheme == "otingocnI" then borderColor = setInvertedIncognitoColors() end
    if colorTheme == "CUSTOM" then borderColor = setCustomColors() end
    state.SetValue("baseBorderColor", borderColor)
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
    return borderColor
end
function setBarbieColors()
    local pink = vector.New(0.79, 0.31, 0.55, 1.00)
    local white = vector.New(0.95, 0.85, 0.87, 1.00)
    local blue = vector.New(0.37, 0.64, 0.84, 1.00)
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
    imgui.PushStyleColor(imgui_col.PlotLines, pink)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, pinkTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, pink)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, pinkTint)
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
    imgui.PushStyleColor(imgui_col.SliderGrab, grey)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, whiteTint)
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
    return frameColor
end
function setTobiRGBGlassColors(rgbPeriod)
    local transparent = vector.New(0.00, 0.00, 0.00, 0.85)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local colorTint = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.3)
    imgui.PushStyleColor(imgui_col.WindowBg, transparent)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparent)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, colorTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, colorTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparent)
    imgui.PushStyleColor(imgui_col.CheckMark, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrab, colorTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Button, transparent)
    imgui.PushStyleColor(imgui_col.ButtonHovered, colorTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, colorTint)
    imgui.PushStyleColor(imgui_col.Tab, transparent)
    imgui.PushStyleColor(imgui_col.TabHovered, colorTint)
    imgui.PushStyleColor(imgui_col.TabActive, colorTint)
    imgui.PushStyleColor(imgui_col.Header, transparent)
    imgui.PushStyleColor(imgui_col.HeaderHovered, colorTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, colorTint)
    imgui.PushStyleColor(imgui_col.Separator, colorTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, colorTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, activeColor)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, colorTint)
    return activeColor
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
    return transparentWhite
end
function setGlassRGBColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local colorTint = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.3)
    local transparent = vector.New(0.00, 0.00, 0.00, 0.25)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, transparent)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, transparent)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, colorTint)
    imgui.PushStyleColor(imgui_col.FrameBgActive, colorTint)
    imgui.PushStyleColor(imgui_col.TitleBg, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgActive, transparent)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, transparent)
    imgui.PushStyleColor(imgui_col.CheckMark, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrab, colorTint)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Button, transparent)
    imgui.PushStyleColor(imgui_col.ButtonHovered, colorTint)
    imgui.PushStyleColor(imgui_col.ButtonActive, colorTint)
    imgui.PushStyleColor(imgui_col.Tab, transparent)
    imgui.PushStyleColor(imgui_col.TabHovered, colorTint)
    imgui.PushStyleColor(imgui_col.TabActive, colorTint)
    imgui.PushStyleColor(imgui_col.Header, transparent)
    imgui.PushStyleColor(imgui_col.HeaderHovered, colorTint)
    imgui.PushStyleColor(imgui_col.HeaderActive, colorTint)
    imgui.PushStyleColor(imgui_col.Separator, colorTint)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, colorTint)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, colorTint)
    imgui.PushStyleColor(imgui_col.PlotHistogram, activeColor)
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, colorTint)
    return activeColor
end
function setRGBGamerColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local inactiveColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.5)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearWhite = vector.New(1.00, 1.00, 1.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, black)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.08, 0.08, 0.08, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, activeColor)
    imgui.PushStyleColor(imgui_col.FrameBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, inactiveColor)
    imgui.PushStyleColor(imgui_col.CheckMark, white)
    imgui.PushStyleColor(imgui_col.SliderGrab, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, white)
    imgui.PushStyleColor(imgui_col.Button, inactiveColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ButtonActive, activeColor)
    imgui.PushStyleColor(imgui_col.Tab, inactiveColor)
    imgui.PushStyleColor(imgui_col.TabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.TabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Header, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderHovered, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderActive, activeColor)
    imgui.PushStyleColor(imgui_col.Separator, inactiveColor)
    imgui.PushStyleColor(imgui_col.Text, white)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, clearWhite)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, inactiveColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.61, 0.61, 0.61, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(1.00, 0.43, 0.35, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.90, 0.70, 0.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(1.00, 0.60, 0.00, 1.00))
    return inactiveColor
end
function setInvertedRGBGamerColors(rgbPeriod)
    local currentRGB = getCurrentRGBColors(rgbPeriod)
    local activeColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.8)
    local inactiveColor = vector.New(currentRGB.red, currentRGB.green, currentRGB.blue, 0.5)
    local white = vector.New(1.00, 1.00, 1.00, 1.00)
    local clearBlack = vector.New(0.00, 0.00, 0.00, 0.40)
    local black = vector.New(0.00, 0.00, 0.00, 1.00)
    imgui.PushStyleColor(imgui_col.WindowBg, white)
    imgui.PushStyleColor(imgui_col.PopupBg, vector.New(0.92, 0.92, 0.92, 0.94))
    imgui.PushStyleColor(imgui_col.FrameBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.FrameBgHovered, activeColor)
    imgui.PushStyleColor(imgui_col.FrameBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBg, inactiveColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, activeColor)
    imgui.PushStyleColor(imgui_col.TitleBgCollapsed, inactiveColor)
    imgui.PushStyleColor(imgui_col.CheckMark, black)
    imgui.PushStyleColor(imgui_col.SliderGrab, activeColor)
    imgui.PushStyleColor(imgui_col.SliderGrabActive, black)
    imgui.PushStyleColor(imgui_col.Button, inactiveColor)
    imgui.PushStyleColor(imgui_col.ButtonHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ButtonActive, activeColor)
    imgui.PushStyleColor(imgui_col.Tab, inactiveColor)
    imgui.PushStyleColor(imgui_col.TabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.TabActive, activeColor)
    imgui.PushStyleColor(imgui_col.Header, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderHovered, inactiveColor)
    imgui.PushStyleColor(imgui_col.HeaderActive, activeColor)
    imgui.PushStyleColor(imgui_col.Separator, inactiveColor)
    imgui.PushStyleColor(imgui_col.Text, black)
    imgui.PushStyleColor(imgui_col.TextSelectedBg, clearBlack)
    imgui.PushStyleColor(imgui_col.ScrollbarGrab, inactiveColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabHovered, activeColor)
    imgui.PushStyleColor(imgui_col.ScrollbarGrabActive, activeColor)
    imgui.PushStyleColor(imgui_col.PlotLines, vector.New(0.39, 0.39, 0.39, 1.00))
    imgui.PushStyleColor(imgui_col.PlotLinesHovered, vector.New(0.00, 0.57, 0.65, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogram, vector.New(0.10, 0.30, 1.00, 1.00))
    imgui.PushStyleColor(imgui_col.PlotHistogramHovered, vector.New(0.00, 0.40, 1.00, 1.00))
    return inactiveColor
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
    return rgbColor
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
    return blackTint
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
    return borderColor
end
function getCurrentRGBColors(rgbPeriod)
    local currentTime = imgui.GetTime()
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
    ToolTip("View presets and export/import them.")
    KeepSameLine()
    if not buttonPressed then return end
    globalVars.showPresetMenu = not globalVars.showPresetMenu
end
---Creates a checkbox that directly saves to globalVars and the universal `.yaml` file.
---@param varsTable { [string]: any }The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicCheckbox(varsTable, parameterName, label, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.Checkbox(label, oldValue)
    if (tooltipText) then HelpMarker(tooltipText) end
    return oldValue ~= varsTable[parameterName]
end
---Creates a checkbox that directly saves to globalVars and the universal `.yaml` file.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
function GlobalCheckbox(parameterName, label, tooltipText)
    local oldValue = globalVars[parameterName] ---@cast oldValue boolean
    _, globalVars[parameterName] = imgui.Checkbox(label, oldValue)
    if (tooltipText) then ToolTip(tooltipText) end
    if (oldValue ~= globalVars[parameterName]) then write(globalVars) end
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
    if (tooltipText) then ToolTip(tooltipText) end
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
    if (tooltipText) then ToolTip(tooltipText) end
    return oldCode ~= customStyle[parameterName]
end
---Creates a combo element.
---@param label string The label for the combo.
---@param list string[] The list of elements the combo should use.
---@param listIndex integer The currently selected combo index.
---@param colorList? string[] An optional list containing an array of colors to use for each item.
---@param hiddenGroups? string[] An optional list, where if any items in list show up here, they will not be shown on the dropdown.
---@return number newListIndex The new combo index.
function Combo(label, list, listIndex, colorList, hiddenGroups)
    local newListIndex = math.clamp(listIndex, 1, #list)
    local currentComboItem = list[listIndex]
    local comboFlag = imgui_combo_flags.HeightLarge
    rgb = {}
    hiddenGroups = hiddenGroups or {}
    if (colorList) then
        colorList[newListIndex]:gsub("(%d+)", function(c)
            rgb[#rgb + 1] = c
        end)
        local alpha = math.floor(imgui.GetColorU32(imgui_col.Text) / 16777216) / 255 or 1
        imgui.PushStyleColor(imgui_col.Text,
            vector.New(rgb[1] / 255, rgb[2] / 255, rgb[3] / 255, alpha))
    end
    if not imgui.BeginCombo(label, currentComboItem, comboFlag) then
        if (colorList) then imgui.PopStyleColor() end
        return newListIndex
    end
    if (colorList) then imgui.PopStyleColor() end
    for i = 1, #list do
        rgb = {}
        if (colorList) then
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
        ::skipRender::
        if (colorList) then imgui.PopStyleColor() end
    end
    imgui.EndCombo()
    return newListIndex
end
function BasicInputFloat(label, var, decimalPlaces, suffix, step)
end
function ComputableInputFloat(label, var, decimalPlaces, suffix)
    local computableStateIndex = state.GetValue("ComputableInputFloatIndex") or 1
    local previousValue = var
    local fmt = table.concat({"%.", decimalPlaces, "f"})
    if (suffix) then fmt = fmt .. suffix end
    _, var = imgui.InputText(label,
        string.format(fmt,
            math.toNumber(tostring(var):match("%d*[%-]?%d+[%.]?%d+") or tostring(var):match("%d*[%-]?%d+")) or 0),
        4096,
        imgui_input_text_flags.AutoSelectAll)
    if (not imgui.IsItemActive() and state.GetValue("previouslyActiveImguiFloat" .. computableStateIndex, false)) then
        local desiredComp = tostring(var):gsub(" ", "")
        var = expr(desiredComp)
    end
    state.SetValue("previouslyActiveImguiFloat" .. computableStateIndex, imgui.IsItemActive())
    state.SetValue("ComputableInputFloatIndex", computableStateIndex + 1)
    return math.toNumber(tostring(var):match("%d*[%-]?%d+[%.]?%d+") or tostring(var):match("%d*[%-]?%d+")),
        previousValue ~= var
end
function NegatableComputableInputFloat(label, var, decimalPlaces, suffix)
    local oldValue = var
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("Neg.", SECONDARY_BUTTON_SIZE)
    ToolTip("Negate SV value")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local newValue = ComputableInputFloat(label, var, decimalPlaces, suffix)
    imgui.PopItemWidth()
    if ((negateButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[4])) and newValue ~= 0) then
        newValue = -newValue
    end
    return newValue, oldValue ~= newValue
end
function SwappableNegatableInputFloat2(varsTable, lowerName, higherName, label, suffix, digits, widthFactor)
    digits = digits or 2
    suffix = suffix or "x"
    widthFactor = widthFactor or 0.7
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local swapButtonPressed = imgui.Button("S##" .. lowerName, TERTIARY_BUTTON_SIZE)
    ToolTip("Swap start/end values")
    local oldValues = vector.New(varsTable[lowerName], varsTable[higherName])
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N##" .. higherName, TERTIARY_BUTTON_SIZE)
    ToolTip("Negate start/end values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * widthFactor - SAMELINE_SPACING)
    local _, newValues = imgui.InputFloat2(label, oldValues, table.concat({"%.", digits, "f"}) .. suffix)
    imgui.PopItemWidth()
    varsTable[lowerName] = newValues.x
    varsTable[higherName] = newValues.y
    if (swapButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[3])) then
        varsTable[lowerName] = oldValues.y
        varsTable[higherName] = oldValues.x
    end
    if (negateButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[4])) then
        varsTable[lowerName] = -oldValues.x
        varsTable[higherName] = -oldValues.y
    end
    return swapButtonPressed or negateButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[3]) or
        kb.pressedKeyCombo(globalVars.hotkeyList[4]) or
        oldValues ~= newValues
end
---Creates an `imgui.inputInt` element.
---@param varsTable { [string]: any }The table that is meant to be modified.
---@param parameterName string The key of globalVars that will be used for data storage.
---@param label string The label for the input.
---@param bounds? [number, number] A tuple representing the minimum and maximum bounds this input should have.
---@param tooltipText? string Optional text for a tooltip that is shown when the element is hovered.
---@return boolean changed Whether or not the checkbox has changed this frame.
function BasicInputInt(varsTable, parameterName, label, bounds, tooltipText)
    local oldValue = varsTable[parameterName]
    _, varsTable[parameterName] = imgui.InputInt(label, oldValue, 1, 1)
    if (tooltipText) then HelpMarker(tooltipText) end
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
    if (tooltipText) then ToolTip(tooltipText) end
    for idx, option in pairs(options) do
        imgui.SameLine(0, RADIO_BUTTON_SPACING)
        if imgui.RadioButton(option, value == optionValues[idx]) then
            value = optionValues[idx]
        end
    end
    return value
end
---Creates a big button that runs a function when clicked. If the number of notes selected is less than `minimumNotes`, returns a textual placeholder instead.
---@param buttonText string The text that should be rendered on the button.
---@param minimumNotes integer The minimum number of notes that are required to select berfore the button appears.
---@param actionfunc fun(...): any The function to run on button press.
---@param menuVars? { [string]: any } Optional menu variable parameter.
---@param hideNoteReq? boolean Whether or not to hide the textual placeholder if the selected note requirement isn't met.
---@param disableKeyInput? boolean Whether or not to disallow keyboard inputs as a substitution to pressing the button.
---@param optionalKeyOverride? string (Assumes `disableKeyInput` is false) Optional string to change the activation keybind.
function simpleActionMenu(buttonText, minimumNotes, actionfunc, menuVars, hideNoteReq, disableKeyInput,
                          optionalKeyOverride)
    local enoughSelectedNotes = checkEnoughSelectedNotes(minimumNotes)
    local infoText = table.concat({"Select ", minimumNotes, " or more notes"})
    if (not enoughSelectedNotes) then
        if (not hideNoteReq) then imgui.Text(infoText) end
        return
    end
    FunctionButton(buttonText, ACTION_BUTTON_SIZE, actionfunc, menuVars)
    if (disableKeyInput) then return end
    local keyCombo = optionalKeyOverride or globalVars.hotkeyList[1 + math.toNumber(hideNoteReq)]
    local tooltip = ToolTip("Press \'" .. keyCombo ..
        "\' on your keyboard to do the same thing as this button")
    executeFunctionIfTrue(kb.pressedKeyCombo(keyCombo), actionfunc, menuVars)
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
function StatedInputText(label, input)
    local statedInputTextIndex = state.GetValue("StatedInputTextIndex", 1)
    local _, out = imgui.InputText(table.concat({ label, "##", statedInputTextIndex }), input, 4096)
    state.SetValue("StatedInputTextIndex", statedInputTextIndex + 1)
    return out, input ~= out
end
function KeepSameLine()
    return imgui.SameLine(0, SAMELINE_SPACING)
end
function AddPadding()
    imgui.Dummy(vector.New(0, 0))
end
function AddSeparator()
    AddPadding()
    imgui.Separator()
    AddPadding()
end
function ToolTip(text)
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
    ToolTip(text)
end
function checkEnoughSelectedNotes(minimumNotes)
    if minimumNotes == 0 then return true end
    local selectedNotes = state.SelectedHitObjects
    local numSelectedNotes = #selectedNotes
    if numSelectedNotes == 0 then return false end
    if minimumNotes == 1 then return true end
    if numSelectedNotes > map.GetKeyCount() then return true end
    return selectedNotes[1].StartTime ~= selectedNotes[numSelectedNotes].StartTime
end
function showSettingsMenu(currentSVType, settingVars, skipFinalSV, svPointsForce)
    if currentSVType == "Linear" then
        return linearSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Exponential" then
        return exponentialSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    elseif currentSVType == "Bezier" then
        return bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce)
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
    return { point[1] + xChange, point[2] + yChange }
end
CREATE_TYPES = {
    "Standard",
    "Special",
    "Still",
    "Vibrato",
}
function createSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    chooseCreateTool()
    local placeType = CREATE_TYPES[globalVars.placeTypeIndex]
    if placeType == "Standard" then placeStandardSVMenu() end
    if placeType == "Special" then placeSpecialSVMenu() end
    if placeType == "Still" then placeStillSVMenu() end
    if placeType == "Vibrato" then placeVibratoSVMenu(false) end
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
        table.insert(globalVars.presets, table.parse(importCustomPreset))
        importCustomPreset = ""
        write(globalVars)
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
            saveVariables(preset.menu .. preset.type .. "Settings", data.settingVars)
            saveVariables(table.concat({"place", preset.type, "Menu"}), data.menuVars)
            globalVars.showPresetMenu = false
        end
        if (imgui.IsItemClicked("Right")) then
            imgui.SetClipboardText(table.stringify(preset))
            print("i!", "Exported preset to your clipboard.")
        end
        ToolTip("Left-click to select this preset. Right-click to copy this preset to your clipboard.")
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
        local invisibleButtonSize = { 2 * (ACTION_BUTTON_SIZE.x + 1.5 * SAMELINE_SPACING), 1 }
        imgui.InvisibleButton("sv isnt a real skill", invisibleButtonSize)
    else
        KeepSameLine()
        imgui.Text("Place SVs")
        AddSeparator()
        if #settingVars.frameTimes == 0 then
            imgui.Text("No notes added in Step 2, so can't place SVs yet")
            return
        end
        HelpMarker("This tool displaces notes into frames after the (first) selected note")
        HelpMarker("Works with pre-existing SVs or no SVs in the map")
        HelpMarker("This is technically an edit SV tool, but it replaces the old animate function")
        HelpMarker("Make sure to prepare an empty area for the frames after the note you select")
        HelpMarker("Note: frame positions and viewing them will break if SV distances change")
        AddSeparator()
        local label = "Setup frames after selected note"
        simpleActionMenu(label, 1, displaceNotesForAnimationFrames, settingVars)
    end
end
function removeSelectedFrameTimeButton(settingVars)
    if #settingVars.frameTimes == 0 then return end
    if not imgui.Button("Removed currently selected time", BEEG_BUTTON_SIZE) then return end
    table.remove(settingVars.frameTimes, settingVars.selectedTimeIndex)
    local maxIndex = math.max(1, #settingVars.frameTimes)
    settingVars.selectedTimeIndex = math.clamp(settingVars.selectedTimeIndex, 1, maxIndex)
end
function addFrameTimes(settingVars)
    if not imgui.Button("Add selected notes to use for frames", ACTION_BUTTON_SIZE) then return end
    local hasAlreadyAddedLaneTime = {}
    for _ = 1, map.GetKeyCount() do
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
    if #settingVars.frameTimes == 0 then
        imgui.Text("Add notes to fill the selection box below")
    else
        imgui.Text("time | lanes | frame # | position")
    end
    HelpMarker("Make sure to select ALL lanes from a chord with multiple notes, not just one lane")
    AddPadding()
    local frameTimeSelectionArea = { ACTION_BUTTON_SIZE.x, 120 }
    imgui.BeginChild("FrameTimes", frameTimeSelectionArea, 1)
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
    local mapKeyCount = map.GetKeyCount()
    local noteWidth = 200 / mapKeyCount
    local noteSpacing = 5
    local barNoteHeight = math.round(2 * noteWidth / 5, 0)
    local noteColor = rgbaToUint(117, 117, 117, 255)
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
function animationPaletteMenu(settingVars)
    CodeInput(settingVars, "instructions", "", "Write instructions here.")
end
function automateSVMenu(settingVars)
    local copiedSVCount = #settingVars.copiedSVs
    if (copiedSVCount == 0) then
        simpleActionMenu("Copy SVs between selected notes", 2, automateCopySVs, settingVars)
        return
    end
    FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearAutomateSVs, settingVars)
    AddSeparator()
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
    AddSeparator()
    simpleActionMenu("Automate SVs for selected notes", 2, automateSVs, settingVars)
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
    local labelText = currentSVType .. "Special"
    saveVariables(labelText .. "Settings", settingVars)
    saveVariables("placeSpecialMenu", menuVars)
end
function penisMenu(settingVars)
    _, settingVars.bWidth = imgui.InputInt("Ball Width", math.floor(settingVars.bWidth))
    _, settingVars.sWidth = imgui.InputInt("Shaft Width", math.floor(settingVars.sWidth))
    _, settingVars.sCurvature = imgui.SliderInt("S Curvature", settingVars.sCurvature, 1, 100,
        settingVars.sCurvature .. "%%")
    _, settingVars.bCurvature = imgui.SliderInt("B Curvature", settingVars.bCurvature, 1, 100,
        settingVars.bCurvature .. "%%")
    simpleActionMenu("Place SVs", 1, placePenisSV, settingVars)
end
function stutterMenu(settingVars)
    local settingsChanged = #settingVars.svMultipliers == 0
    settingsChanged = chooseControlSecondSV(settingVars) or settingsChanged
    settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
    settingsChanged = chooseStutterDuration(settingVars) or settingsChanged
    settingsChanged = BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time") or settingsChanged
    AddSeparator()
    settingsChanged = BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 }) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, false) or settingsChanged
    if settingsChanged then updateStutterMenuSVs(settingVars) end
    displayStutterSVWindows(settingVars)
    AddSeparator()
    simpleActionMenu("Place SVs between selected notes", 2, placeStutterSVs, settingVars)
    simpleActionMenu("Place SSFs between selected notes", 2, placeStutterSSFs, settingVars, true)
end
function teleportStutterMenu(settingVars)
    if settingVars.useDistance then
        chooseDistance(settingVars)
        HelpMarker("Start SV teleport distance")
    else
        chooseStartSVPercent(settingVars)
    end
    chooseMainSV(settingVars)
    chooseAverageSV(settingVars)
    chooseFinalSV(settingVars, false)
    BasicCheckbox(settingVars, "useDistance", "Use distance for start SV")
    BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time")
    AddSeparator()
    simpleActionMenu("Place SVs between selected notes", 2, placeTeleportStutterSVs, settingVars)
    simpleActionMenu("Place SSFs between selected notes", 2, placeTeleportStutterSSFs, settingVars, true)
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
    local needSVUpdate = #menuVars.svMultipliers == 0
    needSVUpdate = chooseStandardSVType(menuVars, false) or needSVUpdate
    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType, "Standard")
    if globalVars.showPresetMenu then
        renderPresetMenu("Standard", menuVars, settingVars)
        return
    end
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil) or needSVUpdate
    AddSeparator()
    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end
    startNextWindowNotCollapsed("svInfoAutoOpen")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)
    menuVars.settingVars = settingVars
    AddSeparator()
    if (STANDARD_SVS[menuVars.svTypeIndex] == "Exponential" and settingVars.distanceMode == 2) then
        simpleActionMenu("Place SVs between selected notes##Exponential", 2, placeExponentialSpecialSVs, menuVars)
    else
        simpleActionMenu("Place SVs between selected notes", 2, placeSVs, menuVars)
    end
    simpleActionMenu("Place SSFs between selected notes", 2, placeSSFs, menuVars, true)
    saveVariables(currentSVType .. "StandardSettings", settingVars)
    saveVariables("placeStandardMenu", menuVars)
end
function placeStillSVMenu()
    PresetButton()
    local menuVars = getMenuVars("placeStill")
    local needSVUpdate = #menuVars.svMultipliers == 0
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
    menuVars.stillBehavior = Combo("Still Behavior", STILL_BEHAVIOR_TYPES, menuVars.stillBehavior)
    chooseStillType(menuVars)
    AddSeparator()
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, false, nil) or needSVUpdate
    AddSeparator()
    needSVUpdate = chooseInterlace(menuVars) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, false) end
    startNextWindowNotCollapsed("svInfoAutoOpen")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, false)
    AddSeparator()
    menuVars.settingVars = settingVars
    simpleActionMenu("Place SVs between selected notes", 2, placeStillSVsParent, menuVars)
    saveVariables(currentSVType .. "StillSettings", settingVars)
    saveVariables("placeStillMenu", menuVars)
end
function customVibratoMenu(menuVars, settingVars, separateWindow)
    local typingCode = false
    if (menuVars.vibratoMode == 1) then
        typingCode = CodeInput(settingVars, "code", "##code",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        local func = eval(settingVars.code)
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, typingCode, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        typingCode = CodeInput(settingVars, "code1", "##code1",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        typingCode = CodeInput(settingVars, "code2", "##code2",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.") or
        typingCode
        local func1 = eval(settingVars.code1)
        local func2 = eval(settingVars.code2)
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v)
            ssfVibrato(v, func1, func2)
        end, menuVars, false, typingCode, separateWindow and globalVars.hotkeyList[8] or nil)
    end
end
function exponentialVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func = function(t)
            t = math.clamp(t, 0, 1)
            if (curvature < 10) then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.endMsx * t +
                settingVars.startMsx * (1 - t)
        end
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func1 = function(t)
            t = math.clamp(t, 0, 1)
            if (curvature < 10) then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            t = math.clamp(t, 0, 1)
            if (curvature < 10) then
                t = 1 - (1 - t) ^ (1 / curvature)
            else
                t = t ^ curvature
            end
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[8] or nil)
    end
end
function linearVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 0.875)
        local func = function(t)
            return settingVars.endMsx * t + settingVars.startMsx * (1 - t)
        end
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        local func1 = function(t)
            return settingVars.lowerStart + t * (settingVars.lowerEnd - settingVars.lowerStart)
        end
        local func2 = function(t)
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[8] or nil)
    end
end
VIBRATO_SVS = {
    "Linear##Vibrato",
    "Exponential##Vibrato",
    "Sinusoidal##Vibrato",
    "Sigmoidal##Vibrato",
    "Custom##Vibrato"
}
function placeVibratoSVMenu(separateWindow)
    PresetButton()
    local menuVars = getMenuVars("placeVibrato")
    chooseVibratoSVType(menuVars)
    AddSeparator()
    imgui.Text("Vibrato Settings:")
    menuVars.vibratoMode = Combo("Vibrato Mode", VIBRATO_TYPES, menuVars.vibratoMode)
    chooseVibratoQuality(menuVars)
    if (menuVars.vibratoMode ~= 2) then
        chooseVibratoSides(menuVars)
    end
    local currentSVType = VIBRATO_SVS[menuVars.svTypeIndex]
    local settingVars = getSettingVars(currentSVType .. (menuVars.vibratoMode == 1 and "SV" or "SSF"), "Vibrato")
    if globalVars.showPresetMenu then
        renderPresetMenu("Vibrato", menuVars, settingVars)
        return
    end
    AddSeparator()
    if currentSVType == "Linear##Vibrato" then linearVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Exponential##Vibrato" then exponentialVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Sinusoidal##Vibrato" then sinusoidalVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Sigmoidal##Vibrato" then sigmoidalVibratoMenu(menuVars, settingVars, separateWindow) end
    if currentSVType == "Custom##Vibrato" then customVibratoMenu(menuVars, settingVars, separateWindow) end
    local labelText = currentSVType .. (menuVars.vibratoMode == 1 and "SV" or "SSF") .. "Vibrato"
    saveVariables(labelText .. "Settings", settingVars)
    saveVariables("placeVibratoMenu", menuVars)
end
function sigmoidalVibratoMenu(menuVars, settingVars, separateWindow)
    if (menuVars.vibratoMode == 1) then
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End##Vibrato", " msx", 0, 7 / 8)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func = function(t)
            t = math.clamp(t, 0, 1) * 2
            if (curvature >= 1) then
                if (t <= 1) then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if (t <= 1) then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.startMsx + t * (settingVars.endMsx - settingVars.startMsx)
        end
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
    else
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs##Vibrato", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs##Vibrato", "x")
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        local curvature = VIBRATO_CURVATURES[settingVars.curvatureIndex]
        local func1 = function(t)
            t = math.clamp(t, 0, 1) * 2
            if (curvature >= 1) then
                if (t <= 1) then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if (t <= 1) then
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
            if (curvature >= 1) then
                if (t <= 1) then
                    t = t ^ curvature
                else
                    t = 2 - (2 - t) ^ curvature
                end
            else
                if (t <= 1) then
                    t = (1 - (1 - t) ^ (1 / curvature))
                else
                    t = (t - 1) ^ (1 / curvature) + 1
                end
            end
            t = t * 0.5
            return settingVars.higherStart + t * (settingVars.higherEnd - settingVars.higherStart)
        end
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[8] or nil)
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
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v)
            svVibrato(v, func)
        end, menuVars, false, false, separateWindow and globalVars.hotkeyList[8] or nil)
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
        AddSeparator()
        simpleActionMenu("Vibrate", 2, function(v) ssfVibrato(v, func1, func2) end, menuVars, false, false,
            separateWindow and globalVars.hotkeyList[8] or nil)
    end
end
function deleteTab()
    local menuVars = getMenuVars("delete")
    _, menuVars.deleteTable[1] = imgui.Checkbox("Delete Lines", menuVars.deleteTable[1])
    KeepSameLine()
    _, menuVars.deleteTable[2] = imgui.Checkbox("Delete SVs", menuVars.deleteTable[2])
    _, menuVars.deleteTable[3] = imgui.Checkbox("Delete SSFs", menuVars.deleteTable[3])
    imgui.SameLine(0, SAMELINE_SPACING + 3.5)
    _, menuVars.deleteTable[4] = imgui.Checkbox("Delete Bookmarks", menuVars.deleteTable[4])
    saveVariables("deleteMenu", menuVars)
    for i = 1, 4 do
        if (menuVars.deleteTable[i]) then goto continue end
    end
    do return 69 end
    ::continue::
    simpleActionMenu("Delete items between selected notes", 2, deleteItems, menuVars)
end
function addTeleportMenu()
    local menuVars = getMenuVars("addTeleport")
    chooseDistance(menuVars)
    BasicCheckbox(menuVars, "teleportBeforeHand", "Add teleport before note")
    saveVariables("addTeleportMenu", menuVars)
    AddSeparator()
    simpleActionMenu("Add teleport SVs at selected notes", 1, addTeleportSVs, menuVars)
end
function alignTimingLinesMenu()
    simpleActionMenu("Align Timing Lines In This Region", 0, alignTimingLines, nil)
end
function changeGroupsMenu()
    local menuVars = getMenuVars("changeGroups")
    imgui.AlignTextToFramePadding()
    imgui.Text("  Move to: ")
    KeepSameLine()
    local groups = { "$Default", "$Global" }
    local cols = { map.TimingGroups["$Default"].ColorRgb or "86,253,110", map.TimingGroups["$Global"].ColorRgb or
    "255,255,255" }
    local hiddenGroups = {}
    for tgId, tg in pairs(map.TimingGroups) do
        if string.find(tgId, "%$") then goto cont end
        if (globalVars.hideAutomatic and string.find(tgId, "automate_")) then
            table.insert(hiddenGroups,
                tgId)
        end
        groups[#groups + 1] = tgId
        table.insert(cols, tg.ColorRgb or "255,255,255")
        ::cont::
    end
    local prevIndex = table.indexOf(groups, menuVars.designatedTimingGroup)
    imgui.PushItemWidth(155)
    local newIndex = Combo("##changingScrollGroup", groups, prevIndex, cols, hiddenGroups)
    imgui.PopItemWidth()
    imgui.Dummy(vector.New(0, 2))
    menuVars.designatedTimingGroup = groups[newIndex]
    _, menuVars.changeSVs = imgui.Checkbox("Change SVs?", menuVars.changeSVs)
    KeepSameLine()
    _, menuVars.changeSSFs = imgui.Checkbox("Change SSFs?", menuVars.changeSSFs)
    AddSeparator()
    saveVariables("changeGroupsMenu", menuVars)
    simpleActionMenu("Move items to " .. menuVars.designatedTimingGroup, 2, changeGroups, menuVars)
end
function convertSVSSFMenu()
    local menuVars = getMenuVars("convertSVSSF")
    chooseConvertSVSSFDirection(menuVars)
    saveVariables("convertSVSSFMenu", menuVars)
    simpleActionMenu(menuVars.conversionDirection and "Convert SVs -> SSFs" or "Convert SSFs -> SVs", 2, convertSVSSF,
        menuVars, false, false)
end
function copyNPasteMenu()
    local menuVars = getMenuVars("copy")
    _, menuVars.copyTable[1] = imgui.Checkbox("Copy Lines", menuVars.copyTable[1])
    KeepSameLine()
    _, menuVars.copyTable[2] = imgui.Checkbox("Copy SVs", menuVars.copyTable[2])
    _, menuVars.copyTable[3] = imgui.Checkbox("Copy SSFs", menuVars.copyTable[3])
    imgui.SameLine(0, SAMELINE_SPACING + 3.5)
    _, menuVars.copyTable[4] = imgui.Checkbox("Copy Bookmarks", menuVars.copyTable[4])
    AddSeparator()
    local _ = BasicInputInt(menuVars, "curSlot", "Current slot", { 1, 999 })
    if #menuVars.copied.lines < menuVars.curSlot then
        local newCopied = table.duplicate(menuVars.copied)
        while #newCopied.lines < menuVars.curSlot do
            table.insert(newCopied.lines, {})
            table.insert(newCopied.SVs, {})
            table.insert(newCopied.SSFs, {})
            table.insert(newCopied.BMs, {})
        end
        menuVars.copied = newCopied
    end
    AddSeparator()
    local copiedItemCount = #menuVars.copied.lines[menuVars.curSlot] + #menuVars.copied.SVs[menuVars.curSlot] +
    #menuVars.copied.SSFs[menuVars.curSlot] + #menuVars.copied.BMs[menuVars.curSlot]
    if (copiedItemCount == 0) then
        simpleActionMenu("Copy items between selected notes", 2, copyItems, menuVars)
    else
        FunctionButton("Clear copied items", ACTION_BUTTON_SIZE, clearCopiedItems, menuVars)
    end
    if copiedItemCount == 0 then
        saveVariables("copyMenu", menuVars)
        return
    end
    AddSeparator()
    _, menuVars.tryAlign = imgui.Checkbox("Try to fix misalignments", menuVars.tryAlign)
    saveVariables("copyMenu", menuVars)
    simpleActionMenu("Paste items at selected notes", 1, pasteItems, menuVars)
end
function updateDirectEdit()
    local offsets = game.uniqueSelectedNoteOffsets()
    if (not truthy(offsets)) then return end
    local firstOffset = offsets[1]
    local lastOffset = offsets[#offsets]
    if (#offsets < 2) then
        state.SetValue("directSVList", {})
        return
    end
    local svs = game.getSVsBetweenOffsets(firstOffset, lastOffset)
    state.SetValue("directSVList", svs)
end
function directSVMenu()
    local menuVars = getMenuVars("directSV")
    local clockTime = 0.2
    if ((state.UnixTime or 0) - (state.GetValue("lastRecordedTime") or 0) >= clockTime) then
        state.SetValue("lastRecordedTime", state.UnixTime or 0)
        updateDirectEdit()
    end
    local svs = state.GetValue("directSVList") or {}
    if (#svs == 0) then
        menuVars.selectableIndex = 1
        imgui.TextWrapped("Select two notes to view SVs.")
        return
    end
    if (menuVars.selectableIndex > #svs) then menuVars.selectableIndex = #svs end
    local oldStartTime = svs[menuVars.selectableIndex].StartTime
    local oldMultiplier = svs[menuVars.selectableIndex].Multiplier
    local primeStartTime = state.GetValue("primeStartTime") or false
    local primeMultiplier = state.GetValue("primeMultiplier") or false
    _, menuVars.startTime = imgui.InputFloat("Start Time", oldStartTime)
    _, menuVars.multiplier = imgui.InputFloat("Multiplier", oldMultiplier)
    if (oldStartTime ~= menuVars.startTime) then
        primeStartTime = true
    else
        if (not primeStartTime) then goto continue1 end
        primeStartTime = false
        local newSV = createSV(state.GetValue("savedStartTime") or 0, menuVars.multiplier)
        actions.PerformBatch({ utils.CreateEditorAction(action_type.RemoveScrollVelocity, svs[menuVars.selectableIndex]),
            utils.CreateEditorAction(action_type.AddScrollVelocity, newSV) })
    end
    ::continue1::
    if (oldMultiplier ~= menuVars.multiplier) then
        primeMultiplier = true
    else
        if (not primeMultiplier) then goto continue2 end
        primeMultiplier = false
        local newSV = createSV(menuVars.startTime, state.GetValue("savedMultiplier") or 1)
        actions.PerformBatch({ utils.CreateEditorAction(action_type.RemoveScrollVelocity, svs[menuVars.selectableIndex]),
            utils.CreateEditorAction(action_type.AddScrollVelocity, newSV) })
    end
    ::continue2::
    state.SetValue("primeStartTime", primeStartTime)
    state.SetValue("primeMultiplier", primeMultiplier)
    state.SetValue("savedStartTime", menuVars.startTime)
    state.SetValue("savedMultiplier", menuVars.multiplier)
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
    for idx, v in pairs({ table.unpack(svs, startingPoint + 1, startingPoint + 10) }) do
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
    saveVariables("directSVMenu", menuVars)
end
function displaceNoteMenu()
    local menuVars = getMenuVars("displaceNote")
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
    saveVariables("displaceNoteMenu", menuVars)
    AddSeparator()
    simpleActionMenu("Displace selected notes", 1, displaceNoteSVsParent, menuVars)
end
function displaceViewMenu()
    local menuVars = getMenuVars("displaceView")
    chooseDistance(menuVars)
    saveVariables("displaceViewMenu", menuVars)
    AddSeparator()
    simpleActionMenu("Displace view between selected notes", 2, displaceViewSVs, menuVars)
end
function dynamicScaleMenu()
    local menuVars = getMenuVars("dynamicScale")
    local numNoteTimes = #menuVars.noteTimes
    imgui.Text(#menuVars.noteTimes .. " note times assigned to scale SVs between")
    addNoteTimesToDynamicScaleButton(menuVars)
    if numNoteTimes == 0 then
        saveVariables("dynamicScaleMenu", menuVars)
        return
    else
        clearNoteTimesButton(menuVars)
    end
    AddSeparator()
    if #menuVars.noteTimes < 3 then
        imgui.Text("Not enough note times assigned")
        imgui.Text("Assign 3 or more note times instead")
        saveVariables("dynamicScaleMenu", menuVars)
        return
    end
    local numSVPoints = numNoteTimes - 1
    local needSVUpdate = #menuVars.svMultipliers == 0 or (#menuVars.svMultipliers ~= numSVPoints)
    imgui.AlignTextToFramePadding()
    imgui.Text("Shape:")
    KeepSameLine()
    needSVUpdate = chooseStandardSVType(menuVars, true) or needSVUpdate
    AddSeparator()
    local currentSVType = STANDARD_SVS[menuVars.svTypeIndex]
    if currentSVType == "Sinusoidal" then
        imgui.Text("Import sinusoidal values using 'Custom' instead")
        saveVariables("dynamicScaleMenu", menuVars)
        return
    end
    local settingVars = getSettingVars(currentSVType, "DynamicScale")
    needSVUpdate = showSettingsMenu(currentSVType, settingVars, true, numSVPoints) or needSVUpdate
    if needSVUpdate then updateMenuSVs(currentSVType, menuVars, settingVars, true) end
    startNextWindowNotCollapsed("svInfoAutoOpen")
    makeSVInfoWindow("SV Info", menuVars.svGraphStats, menuVars.svStats, menuVars.svDistances,
        menuVars.svMultipliers, nil, true)
    local labelText = currentSVType .. "DynamicScale"
    saveVariables(labelText .. "Settings", settingVars)
    saveVariables("dynamicScaleMenu", menuVars)
    AddSeparator()
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
function fixLNEndsMenu()
    imgui.TextWrapped(
        "If there is a negative SV at an LN end, the LN end will be flipped. This is noticable especially for arrow skins and is jarring. This tool will fix that.")
    AddSeparator()
    simpleActionMenu("Fix flipped LN ends", 0, fixFlippedLNEnds, nil)
end
function flickerMenu()
    local menuVars = getMenuVars("flicker")
    menuVars.flickerTypeIndex = Combo("Flicker Type", FLICKER_TYPES, menuVars.flickerTypeIndex)
    chooseVaryingDistance(menuVars)
    BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
    BasicInputInt(menuVars, "numFlickers", "Flickers", { 1, 9999 })
    if (globalVars.advancedMode) then chooseFlickerPosition(menuVars) end
    saveVariables("flickerMenu", menuVars)
    AddSeparator()
    simpleActionMenu("Add flicker SVs between selected notes", 2, flickerSVs, menuVars)
end
function layerSnapMenu()
    simpleActionMenu("Layer snaps between selection", 2, layerSnaps, nil)
    AddSeparator()
    simpleActionMenu("Collapse snap layers", 0, collapseSnaps, nil)
    simpleActionMenu("Clear unused snap layers", 0, clearSnappedLayers, nil)
end
EDIT_SV_TOOLS = {
    "Add Teleport",
    "Align Timing Lines",
    "Change Groups",
    "Convert SV <-> SSF",
    "Copy & Paste",
    "Direct SV",
    "Displace Note",
    "Displace View",
    "Dynamic Scale",
    "Fix LN Ends",
    "Flicker",
    "Layer Snaps",
    "Measure",
    "Merge",
    "Reverse Scroll",
    "Scale (Displace)",
    "Scale (Multiply)",
    "Swap Notes",
    "Vertical Shift"
}
function editSVTab()
    if (globalVars.advancedMode) then chooseCurrentScrollGroup() end
    chooseEditTool()
    AddSeparator()
    local toolName = EDIT_SV_TOOLS[globalVars.editToolIndex]
    if toolName == "Add Teleport" then addTeleportMenu() end
    if toolName == "Align Timing Lines" then alignTimingLinesMenu() end
    if toolName == "Change Groups" then changeGroupsMenu() end
    if toolName == "Convert SV <-> SSF" then convertSVSSFMenu() end
    if toolName == "Copy & Paste" then copyNPasteMenu() end
    if toolName == "Direct SV" then directSVMenu() end
    if toolName == "Displace Note" then displaceNoteMenu() end
    if toolName == "Displace View" then displaceViewMenu() end
    if toolName == "Dynamic Scale" then dynamicScaleMenu() end
    if toolName == "Fix LN Ends" then fixLNEndsMenu() end
    if toolName == "Flicker" then flickerMenu() end
    if toolName == "Layer Snaps" then layerSnapMenu() end
    if toolName == "Measure" then measureMenu() end
    if toolName == "Merge" then mergeMenu() end
    if toolName == "Reverse Scroll" then reverseScrollMenu() end
    if toolName == "Scale (Displace)" then scaleDisplaceMenu() end
    if toolName == "Scale (Multiply)" then scaleMultiplyMenu() end
    if toolName == "Swap Notes" then swapNotesMenu() end
    if toolName == "Vertical Shift" then verticalShiftMenu() end
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
    ToolTip("Measured values might not be 100%% accurate & may not work on older maps")
    AddSeparator()
    simpleActionMenu("Measure SVs between selected notes", 2, measureSVs, menuVars)
    saveVariables("measureMenu", menuVars)
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
function mergeMenu()
    simpleActionMenu("Merge duplicate SVs between selected notes", 2, mergeSVs, nil)
end
function reverseScrollMenu()
    local menuVars = getMenuVars("reverseScroll")
    chooseDistance(menuVars)
    HelpMarker("Height at which reverse scroll notes are hit")
    saveVariables("reverseScrollMenu", menuVars)
    AddSeparator()
    local buttonText = "Reverse scroll between selected notes"
    simpleActionMenu(buttonText, 2, reverseScrollSVs, menuVars)
end
function scaleDisplaceMenu()
    local menuVars = getMenuVars("scaleDisplace")
    menuVars.scaleSpotIndex = Combo("Displace Spot", DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
    chooseScaleType(menuVars)
    saveVariables("scaleDisplaceMenu", menuVars)
    AddSeparator()
    local buttonText = "Scale SVs between selected notes##displace"
    simpleActionMenu(buttonText, 2, scaleDisplaceSVs, menuVars)
end
function scaleMultiplyMenu()
    local menuVars = getMenuVars("scaleMultiply")
    chooseScaleType(menuVars)
    saveVariables("scaleMultiplyMenu", menuVars)
    AddSeparator()
    local buttonText = "Scale SVs between selected notes##multiply"
    simpleActionMenu(buttonText, 2, scaleMultiplySVs, menuVars)
end
function swapNotesMenu()
    simpleActionMenu("Swap selected notes using SVs", 2, swapNoteSVs, nil)
end
function verticalShiftMenu()
    local menuVars = getMenuVars("verticalShift")
    chooseConstantShift(menuVars, 0)
    saveVariables("verticalShiftMenu", menuVars)
    AddSeparator()
    local buttonText = "Vertically shift SVs between selected notes"
    simpleActionMenu(buttonText, 2, verticalShiftSVs, menuVars)
end
function infoTab()
    imgui.SeparatorText("Welcome to plumoguSV!")
    imgui.TextWrapped("This plugin is your one-stop shop for all of \nyour SV needs. Using it is quick and easy:")
    AddPadding()
    imgui.BulletText("Choose an SV tool in the Create tab.")
    imgui.BulletText("Adjust the tool's settings to your liking.")
    imgui.BulletText("Select notes to use the tool at.")
    imgui.BulletText(table.concat({"Press the '", globalVars.hotkeyList[1], "' hotkey."}))
    AddPadding()
    imgui.SeparatorText("Special thanks to:")
    AddPadding()
    imgui.BulletText("kloi34, for being the original dev.")
    imgui.BulletText("kusa, for some handy widgets.")
    imgui.BulletText("7xbi + nethen for some useful PRs.")
    imgui.BulletText("Emik + William for plugin help.")
    imgui.BulletText("ESV members for constant support.")
    AddPadding()
    AddPadding()
    if (imgui.Button("Click Here to Edit Settings", ACTION_BUTTON_SIZE)) then
        state.SetValue("showSettingsWindow", true)
        local windowDim = state.WindowSize
        local pluginDim = imgui.GetWindowSize()
        local centeringX = (windowDim[1] - pluginDim.x) * 0.5
        local centeringY = (windowDim[2] - pluginDim.y) * 0.5
        local coordinatesToCenter = vector.New(centeringX, centeringY)
        imgui.SetWindowPos("plumoguSV Settings", coordinatesToCenter)
    end
    if (state.GetValue("showSettingsWindow")) then
        showPluginSettingsWindow()
    end
    if (imgui.Button("Get Map Stats", HALF_ACTION_BUTTON_SIZE)) then
        getMapStats()
    end
    KeepSameLine()
    if (imgui.Button("View Tutorials", HALF_ACTION_BUTTON_SIZE)) then
        state.SetValue("showTutorialWindow", true)
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
    if tabName == "Info" then
        infoTab()
    else
        state.SetValue("showSettingsWindow", false)
    end
    if tabName == "Select" then selectTab() end
    if tabName == "Create" then createSVTab() end
    if tabName == "Edit" then editSVTab() end
    if tabName == "Delete" then deleteTab() end
    imgui.EndTabItem()
end
function selectAlternatingMenu()
    local menuVars = getMenuVars("selectAlternating")
    BasicInputInt(menuVars, "every", "Every __ notes", { 1, MAX_SV_POINTS })
    BasicInputInt(menuVars, "offset", "From note #__", { 1, menuVars.every })
    saveVariables("selectAlternatingMenu", menuVars)
    AddSeparator()
    simpleActionMenu(
        "Select a note every " ..
        menuVars.every .. pluralize(" note, from note #", menuVars.every, 5) .. menuVars.offset,
        2,
        selectAlternating, menuVars)
end
function selectBookmarkMenu()
    local bookmarks = map.bookmarks
    local selectedIndex = state.GetValue("selectedIndex") or 0
    local searchTerm = state.GetValue("searchTerm") or ""
    local filterTerm = state.GetValue("filterTerm") or ""
    local times = {}
    if (#bookmarks == 0) then
        imgui.TextWrapped("There are no bookmarks! Add one to navigate.")
    else
        imgui.PushItemWidth(70)
        _, searchTerm = imgui.InputText("Search", searchTerm, 4096)
        KeepSameLine()
        _, filterTerm = imgui.InputText("Ignore", filterTerm, 4096)
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
        for idx, bm in pairs(bookmarks) do
            if (bm.StartTime < 0) then
                skippedBookmarks = skippedBookmarks + 1
                skippedIndices = skippedIndices + 1
                goto continue
            end
            if (searchTerm:len() > 0) and (not bm.Note:find(searchTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto continue
            end
            if (filterTerm:len() > 0) and (bm.Note:find(filterTerm)) then
                skippedBookmarks = skippedBookmarks + 1
                goto continue
            end
            vPos = 126.5 + (idx - skippedBookmarks) * 32
            imgui.SetCursorPosY(vPos)
            times[#times + 1] = bm.StartTime
            imgui.Text(bm.StartTime)
            imgui.NextColumn()
            imgui.SetCursorPosY(vPos)
            bm.Note = bm.Note:fixToSize(110)
            imgui.NextColumn()
            if (imgui.Button("Go to #" .. idx - skippedIndices, vector.New(65, 24))) then
                actions.GoToObjects(bm.StartTime)
            end
            imgui.NextColumn()
            if (idx ~= #bookmarks) then imgui.Separator() end
            ::continue::
        end
        local maxTimeLength = #tostring(math.max(table.unpack(times) or 0))
        imgui.SetColumnWidth(0, maxTimeLength * 10.25)
        imgui.SetColumnWidth(1, 110)
        imgui.SetColumnWidth(2, 80)
        imgui.PopItemWidth()
        imgui.Columns(1)
    end
    state.SetValue("selectedIndex", selectedIndex)
    state.SetValue("searchTerm", searchTerm)
    state.SetValue("filterTerm", filterTerm)
end
function selectChordSizeMenu()
    local menuVars = getMenuVars("selectChordSize")
    for idx = 1, keyCount do
        local varLabel = "select" .. idx
        local label = table.concat({ table.concat({"Size ", idx, " Chord"}) })
        _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
        if (idx % 2 == 1) then KeepSameLine() end
    end
    simpleActionMenu("Select chords within region", 2, selectByChordSizes, menuVars)
    saveVariables("selectChordSizeMenu", menuVars)
end
SELECT_TOOLS = {
    "Alternating",
    "By Snap",
    "Chord Size",
    "Note Type",
    "Bookmark",
}
function selectTab()
    chooseSelectTool()
    AddSeparator()
    local toolName = SELECT_TOOLS[globalVars.selectTypeIndex]
    if toolName == "Alternating" then selectAlternatingMenu() end
    if toolName == "By Snap" then selectBySnapMenu() end
    if toolName == "Bookmark" then selectBookmarkMenu() end
    if toolName == "Chord Size" then selectChordSizeMenu() end
    if toolName == "Note Type" then selectNoteTypeMenu() end
end
function selectNoteTypeMenu()
    local menuVars = getMenuVars("selectNoteType")
    _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
    KeepSameLine()
    _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)
    simpleActionMenu("Select notes within region", 2, selectByNoteType, menuVars)
    saveVariables("selectNoteTypeMenu", menuVars)
end
function selectBySnapMenu()
    local menuVars = getMenuVars("selectBySnap")
    BasicInputInt(menuVars, "snap", "Snap", { 1, 100 })
    saveVariables("selectBySnapMenu", menuVars)
    AddSeparator()
    simpleActionMenu(
        table.concat({"Select notes with 1/", menuVars.snap, " snap"}),
        2,
        selectBySnap, menuVars)
end
function showAppearanceSettings()
    imgui.PushItemWidth(150)
    chooseStyleTheme()
    chooseColorTheme()
    AddSeparator()
    chooseCursorTrail()
    chooseCursorTrailShape()
    chooseEffectFPS()
    chooseCursorTrailPoints()
    chooseCursorShapeSize()
    chooseSnakeSpringConstant()
    chooseCursorTrailGhost()
    AddSeparator()
    imgui.PopItemWidth()
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
        state.SetValue("showColorPicker", true)
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
    if (oldDynamicBgIndex ~= globalVars.dynamicBackgroundIndex) then write(globalVars) end
end
local customStyleIds = {
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
    "Plot Histogram\n(Hovered)"
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
        state.SetValue("importingCustomTheme", true)
    end
    KeepSameLine()
    if (imgui.Button("Export")) then
        local str = stringifyCustomStyle(globalVars.customStyle)
        imgui.SetClipboardText(str)
        print("i!", "Exported custom theme to your clipboard.")
    end
    if (state.GetValue("importingCustomTheme")) then
        local input = state.GetValue("importingCustomThemeInput", "")
        _, input = imgui.InputText("##customThemeStr", input, 69420)
        state.SetValue("importingCustomThemeInput", input)
        KeepSameLine()
        if (imgui.Button("Send")) then
            setCustomStyleString(input)
            settingsChanged = true
            state.SetValue("importingCustomTheme", false)
            state.SetValue("importingCustomThemeInput", "")
        end
        KeepSameLine()
        if (imgui.Button("X")) then
            state.SetValue("importingCustomTheme", false)
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
        if (not name:lower():find(searchText:lower())) then goto skip end
        settingsChanged = ColorInput(globalVars.customStyle, id, name) or settingsChanged
        ::skip::
    end
    if (settingsChanged) then
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
        local r = math.floor(value.x * 255)
        local g = math.floor(value.y * 255)
        local b = math.floor(value.z * 255)
        local a = math.floor(value.w * 255)
        resultStr = resultStr .. keyId .. "" .. rgbaToNdua(r, g, b, a) .. " "
    end
    return resultStr:sub(1, -2)
end
function setCustomStyleString(str)
    local keyIdDict = {}
    for _, key in ipairs(table.keys(DEFAULT_STYLE)) do
        keyIdDict[key] = convertStrToShort(key)
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
        local keyId = nil
        local keyValue = nil
        if (kvPair:len() == 8) then
            keyId = kvPair:sub(1, 3)
            keyValue = kvPair:sub(4)
        else
            keyId = kvPair:sub(1, 2)
            keyValue = kvPair:sub(3)
        end
        local key = table.indexOf(keyIdDict, keyId)
        if (not keyId or key == -1) then goto skip end
        customStyle[key] = nduaToRgba(keyValue) / 255
        ::skip::
    end
    globalVars.customStyle = table.duplicate(customStyle)
end
function parseCustomStyleV1(str, keyIdDict)
    local customStyle = {}
    for kvPair in str:gmatch("[0-9#:a-zA-Z]+") do -- Equivalent to validate, no need to change
        local keyId = kvPair:match("[a-zA-Z]+:"):sub(1, -2)
        local hexa = kvPair:match(":[a-f0-9]+"):sub(2)
        local key = table.indexOf(keyIdDict, keyId)
        if (key ~= -1) then customStyle[key] = hexaToRgba(hexa) / 255 end
    end
    globalVars.customStyle = table.duplicate(customStyle)
end
function saveSettingPropertiesButton(settingVars, label)
    local saveButtonClicked = imgui.Button("Save##setting" .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:charAt(1):lower() .. label:sub(2)
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.settings) then globalVars.defaultProperties.settings = {} end
    globalVars.defaultProperties.settings[label] = settingVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)
    print("i!",
        table.concat({"Default setting properties for ", label, " have been set. Changes will be shown on the next plugin refresh."}))
end
function saveMenuPropertiesButton(menuVars, label)
    local saveButtonClicked = imgui.Button("Save##menu" .. label)
    imgui.Separator()
    if (not saveButtonClicked) then return end
    label = label:charAt(1):lower() .. label:sub(2)
    if (not globalVars.defaultProperties) then globalVars.defaultProperties = {} end
    if (not globalVars.defaultProperties.menu) then globalVars.defaultProperties.menu = {} end
    globalVars.defaultProperties.menu[label] = menuVars
    loadDefaultProperties(globalVars.defaultProperties)
    write(globalVars)
    print("i!",
        table.concat({"Default menu properties for ", label, " have been set. Changes will be shown on the next plugin refresh."}))
end
function showDefaultPropertiesSettings()
    imgui.SeparatorText("Create Tab Settings")
    if (imgui.CollapsingHeader("General Standard Settings")) then
        local menuVars = getMenuVars("placeStandard", "Property")
        chooseStandardSVType(menuVars, false)
        AddSeparator()
        chooseInterlace(menuVars)
        saveMenuPropertiesButton(menuVars, "placeStandard")
        saveVariables("placeStandardPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("General Special Settings")) then
        local menuVars = getMenuVars("placeSpecial", "Property")
        chooseSpecialSVType(menuVars)
        saveMenuPropertiesButton(menuVars, "placeSpecial")
        saveVariables("placeSpecialPropertyMenu", menuVars)
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
        saveVariables("placeStillPropertyMenu", menuVars)
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
        saveVariables("placeVibratoPropertyMenu", menuVars)
    end
    imgui.SeparatorText("Edit Tab Settings")
    if (imgui.CollapsingHeader("Add Teleport Settings")) then
        local menuVars = getMenuVars("addTeleport", "Property")
        chooseDistance(menuVars)
        BasicCheckbox(menuVars, "teleportBeforeHand", "Add teleport before note")
        saveMenuPropertiesButton(menuVars, "addTeleport")
        saveVariables("addTeleportPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Change Group Settings")) then
        local menuVars = getMenuVars("changeGroups", "Property")
        _, menuVars.changeSVs = imgui.Checkbox("Change SVs?", menuVars.changeSVs)
        KeepSameLine()
        _, menuVars.changeSSFs = imgui.Checkbox("Change SSFs?", menuVars.changeSSFs)
        saveMenuPropertiesButton(menuVars, "changeGroups")
        saveVariables("changeGroupsPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Convert SV <-> SSF Settings")) then
        local menuVars = getMenuVars("convertSVSSF", "Property")
        chooseConvertSVSSFDirection(menuVars)
        saveMenuPropertiesButton(menuVars, "convertSVSSF")
        saveVariables("convertSVSSFPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Copy Settings")) then
        local menuVars = getMenuVars("copy", "Property")
        _, menuVars.copyTable[1] = imgui.Checkbox("Copy Lines", menuVars.copyTable[1])
        KeepSameLine()
        _, menuVars.copyTable[2] = imgui.Checkbox("Copy SVs", menuVars.copyTable[2])
        _, menuVars.copyTable[3] = imgui.Checkbox("Copy SSFs", menuVars.copyTable[3])
        imgui.SameLine(0, SAMELINE_SPACING + 3.5)
        _, menuVars.copyTable[4] = imgui.Checkbox("Copy Bookmarks", menuVars.copyTable[4])
        _, menuVars.tryAlign = imgui.Checkbox("Try to fix misalignments", menuVars.tryAlign)
        imgui.PushItemWidth(100)
        _, menuVars.alignWindow = imgui.SliderInt("Alignment window (ms)", menuVars.alignWindow, 1, 10)
        imgui.PopItemWidth()
        saveMenuPropertiesButton(menuVars, "copy")
        saveVariables("copyPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Displace Note Settings")) then
        local menuVars = getMenuVars("displaceNote", "Property")
        chooseVaryingDistance(menuVars)
        BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
        saveMenuPropertiesButton(menuVars, "displaceNote")
        saveVariables("displaceNotePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Displace View Settings")) then
        local menuVars = getMenuVars("displaceView", "Property")
        chooseDistance(menuVars)
        saveMenuPropertiesButton(menuVars, "displaceView")
        saveVariables("displaceViewPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Flicker Settings")) then
        local menuVars = getMenuVars("flicker", "Property")
        menuVars.flickerTypeIndex = Combo("Flicker Type", FLICKER_TYPES, menuVars.flickerTypeIndex)
        chooseVaryingDistance(menuVars)
        BasicCheckbox(menuVars, "linearlyChange", "Change distance over time")
        BasicInputInt(menuVars, "numFlickers", "Flickers", { 1, 9999 })
        if (globalVars.advancedMode) then chooseFlickerPosition(menuVars) end
        saveMenuPropertiesButton(menuVars, "flicker")
        saveVariables("flickerPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Reverse Scroll Settings")) then
        local menuVars = getMenuVars("reverseScroll", "Property")
        chooseDistance(menuVars)
        HelpMarker("Height at which reverse scroll notes are hit")
        saveMenuPropertiesButton(menuVars, "reverseScroll")
        saveVariables("reverseScrollPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Scale (Displace) Settings")) then
        local menuVars = getMenuVars("scaleDisplace", "Property")
        menuVars.scaleSpotIndex = Combo("Displace Spot", DISPLACE_SCALE_SPOTS, menuVars.scaleSpotIndex)
        chooseScaleType(menuVars)
        saveMenuPropertiesButton(menuVars, "scaleDisplace")
        saveVariables("scaleDisplacePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Scale (Multiply) Settings")) then
        local menuVars = getMenuVars("scaleMultiply", "Property")
        chooseScaleType(menuVars)
        saveMenuPropertiesButton(menuVars, "scaleMultiply")
        saveVariables("scaleMultiplyPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Vertical Shift Settings")) then
        local menuVars = getMenuVars("verticalShift", "Property")
        chooseConstantShift(menuVars, 0)
        saveMenuPropertiesButton(menuVars, "verticalShift")
        saveVariables("verticalShiftPropertyMenu", menuVars)
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
        saveVariables("deletePropertyMenu", menuVars)
    end
    imgui.SeparatorText("Select Tab Settings")
    if (imgui.CollapsingHeader("Select Alternating Settings")) then
        local menuVars = getMenuVars("selectAlternating", "Property")
        BasicInputInt(menuVars, "every", "Every __ notes", { 1, MAX_SV_POINTS })
        BasicInputInt(menuVars, "offset", "From note #__", { 1, menuVars.every })
        saveMenuPropertiesButton(menuVars, "selectAlternating")
        saveVariables("selectAlternatingPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select By Snap Settings")) then
        local menuVars = getMenuVars("selectBySnap", "Property")
        BasicInputInt(menuVars, "snap", "Snap", { 1, 100 })
        saveMenuPropertiesButton(menuVars, "selectBySnap")
        saveVariables("selectBySnapPropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select Chord Size Settings")) then
        local menuVars = getMenuVars("selectChordSize", "Property")
        for idx = 1, keyCount do
            local varLabel = "select" .. idx
            local label = table.concat({ table.concat({"Size ", idx, " Chord"}) })
            _, menuVars[varLabel] = imgui.Checkbox(label, menuVars[varLabel])
            if (idx % 2 == 1) then KeepSameLine() end
        end
        saveMenuPropertiesButton(menuVars, "selectChordSize")
        saveVariables("selectChordSizePropertyMenu", menuVars)
    end
    if (imgui.CollapsingHeader("Select Note Type Settings")) then
        local menuVars = getMenuVars("selectNoteType", "Property")
        _, menuVars.rice = imgui.Checkbox("Select Rice Notes", menuVars.rice)
        KeepSameLine()
        _, menuVars.ln = imgui.Checkbox("Select LNs", menuVars.ln)
        saveMenuPropertiesButton(menuVars, "selectNoteType")
        saveVariables("selectNoteTypePropertyMenu", menuVars)
    end
    imgui.SeparatorText("Standard/Still Settings")
    if (imgui.CollapsingHeader("Linear Settings")) then
        local settingVars = getSettingVars("Linear", "Property")
        chooseStartEndSVs(settingVars)
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Linear")
        saveVariables("LinearPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Settings")) then
        local settingVars = getSettingVars("Exponential", "Property")
        chooseSVBehavior(settingVars)
        chooseIntensity(settingVars)
        if (globalVars.advancedMode) then
            chooseDistanceMode(settingVars)
        end
        if (settingVars.distanceMode ~= 3) then
            chooseConstantShift(settingVars, 0)
        end
        if (settingVars.distanceMode == 1) then
            chooseAverageSV(settingVars)
        elseif (settingVars.distanceMode == 2) then
            chooseDistance(settingVars)
        else
            chooseStartEndSVs(settingVars)
        end
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Exponential")
        saveVariables("ExponentialPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Bezier Settings")) then
        local settingVars = getSettingVars("Bezier", "Property")
        provideBezierWebsiteLink(settingVars)
        chooseBezierPoints(settingVars)
        chooseConstantShift(settingVars, 0)
        chooseAverageSV(settingVars)
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Bezier")
        saveVariables("BezierPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Hermite Settings")) then
        local settingVars = getSettingVars("Hermite", "Property")
        chooseStartEndSVs(settingVars)
        chooseConstantShift(settingVars, 0)
        chooseAverageSV(settingVars)
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Hermite")
        saveVariables("HermitePropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Settings")) then
        local settingVars = getSettingVars("Sinusoidal", "Property")
        imgui.Text("Amplitude:")
        chooseStartEndSVs(settingVars)
        chooseCurveSharpness(settingVars)
        chooseConstantShift(settingVars, 1)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        chooseSVPerQuarterPeriod(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Sinusoidal")
        saveVariables("SinusoidalPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Circular Settings")) then
        local settingVars = getSettingVars("Circular", "Property")
        chooseSVBehavior(settingVars)
        chooseArcPercent(settingVars)
        chooseAverageSV(settingVars)
        chooseConstantShift(settingVars, 0)
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        chooseNoNormalize(settingVars)
        saveSettingPropertiesButton(settingVars, "Circular")
        saveVariables("CircularPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Random Settings")) then
        local settingVars = getSettingVars("Random", "Property")
        chooseRandomType(settingVars)
        chooseRandomScale(settingVars)
        chooseSVPoints(settingVars)
        AddSeparator()
        chooseConstantShift(settingVars, 0)
        if not settingVars.dontNormalize then
            chooseAverageSV(settingVars)
        end
        chooseFinalSV(settingVars)
        chooseNoNormalize(settingVars)
        saveSettingPropertiesButton(settingVars, "Random")
        saveVariables("RandomPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Chinchilla Settings")) then
        local settingVars = getSettingVars("Chinchilla", "Property")
        chooseSVBehavior(settingVars)
        chooseChinchillaType(settingVars)
        chooseChinchillaIntensity(settingVars)
        chooseAverageSV(settingVars)
        chooseConstantShift(settingVars, 0)
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Chinchilla")
        saveVariables("ChinchillaPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Code Settings")) then
        local settingVars = getSettingVars("Code", "Property")
        CodeInput(settingVars, "code", "##code",
            "This input should return a function that takes in a number t=[0-1], and returns a value corresponding to the msx value of the vibrato at (100t)% of the way through the first and last selected note times.")
        imgui.Separator()
        chooseSVPoints(settingVars)
        chooseFinalSV(settingVars)
        saveSettingPropertiesButton(settingVars, "Code")
        saveVariables("CodePropertySettings", settingVars)
    end
    imgui.SeparatorText("Special Settings")
    if (imgui.CollapsingHeader("Stutter Settings")) then
        local settingVars = getSettingVars("Stutter", "Property")
        settingsChanged = chooseControlSecondSV(settingVars) or settingsChanged
        settingsChanged = chooseStartEndSVs(settingVars) or settingsChanged
        settingsChanged = chooseStutterDuration(settingVars) or settingsChanged
        settingsChanged = BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time") or settingsChanged
        AddSeparator()
        settingsChanged = BasicInputInt(settingVars, "stuttersPerSection", "Stutters", { 1, 1000 }) or settingsChanged
        settingsChanged = chooseAverageSV(settingVars) or settingsChanged
        settingsChanged = chooseFinalSV(settingVars, false) or settingsChanged
        saveSettingPropertiesButton(settingVars, "Stutter")
        saveVariables("StutterPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Teleport Stutter Settings")) then
        local settingVars = getSettingVars("TeleportStutter", "Property")
        if settingVars.useDistance then
            chooseDistance(settingVars)
            HelpMarker("Start SV teleport distance")
        else
            chooseStartSVPercent(settingVars)
        end
        chooseMainSV(settingVars)
        chooseAverageSV(settingVars)
        chooseFinalSV(settingVars, false)
        BasicCheckbox(settingVars, "useDistance", "Use distance for start SV")
        BasicCheckbox(settingVars, "linearlyChange", "Change stutter over time")
        saveSettingPropertiesButton(settingVars, "TeleportStutter")
        saveVariables("TeleportStutterPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Automate Settings")) then
        local settingVars = getSettingVars("Automate", "Property")
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
        saveSettingPropertiesButton(settingVars, "Automate")
        saveVariables("AutomatePropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Penis Settings")) then
        local settingVars = getSettingVars("Penis", "Property")
        _, settingVars.bWidth = imgui.InputInt("Ball Width", math.floor(settingVars.bWidth))
        _, settingVars.sWidth = imgui.InputInt("Shaft Width", math.floor(settingVars.sWidth))
        _, settingVars.sCurvature = imgui.SliderInt("S Curvature", settingVars.sCurvature, 1, 100,
            settingVars.sCurvature .. "%%")
        _, settingVars.bCurvature = imgui.SliderInt("B Curvature", settingVars.bCurvature, 1, 100,
            settingVars.bCurvature .. "%%")
        saveSettingPropertiesButton(settingVars, "Penis")
        saveVariables("PenisPropertySettings", settingVars)
    end
    imgui.SeparatorText("SV Vibrato Settings")
    if (imgui.CollapsingHeader("Linear Vibrato SV Settings")) then
        local settingVars = getSettingVars("LinearVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        saveSettingPropertiesButton(settingVars, "LinearVibratoSV")
        saveVariables("LinearVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Vibrato SV Settings")) then
        local settingVars = getSettingVars("ExponentialVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        saveSettingPropertiesButton(settingVars, "ExponentialVibratoSV")
        saveVariables("ExponentialVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Vibrato SV Settings")) then
        local settingVars = getSettingVars("SinusoidalVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseMsxVerticalShift(settingVars, 0)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        saveSettingPropertiesButton(settingVars, "SinusoidalVibratoSV")
        saveVariables("SinusoidalVibratoSVPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sigmoidal Vibrato SV Settings")) then
        local settingVars = getSettingVars("SigmoidalVibratoSV", "Property")
        SwappableNegatableInputFloat2(settingVars, "startMsx", "endMsx", "Start/End", " msx", 0, 0.875)
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        saveSettingPropertiesButton(settingVars, "SigmoidalVibratoSV")
        saveVariables("SigmoidalVibratoSVPropertySettings", settingVars)
    end
    imgui.SeparatorText("SSF Vibrato Settings")
    if (imgui.CollapsingHeader("Linear Vibrato SSF Settings")) then
        local settingVars = getSettingVars("LinearVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        saveSettingPropertiesButton(settingVars, "LinearVibratoSSF")
        saveVariables("LinearVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Exponential Vibrato SSF Settings")) then
        local settingVars = getSettingVars("ExponentialVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseCurvatureCoefficient(settingVars, plotExponentialCurvature)
        saveSettingPropertiesButton(settingVars, "ExponentialVibratoSSF")
        saveVariables("ExponentialVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sinusoidal Vibrato SSF Settings")) then
        local settingVars = getSettingVars("SinusoidalVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseConstantShift(settingVars)
        chooseNumPeriods(settingVars)
        choosePeriodShift(settingVars)
        saveSettingPropertiesButton(settingVars, "SinusoidalVibratoSSF")
        saveVariables("SinusoidalVibratoSSFPropertySettings", settingVars)
    end
    if (imgui.CollapsingHeader("Sigmoidal Vibrato SSF Settings")) then
        local settingVars = getSettingVars("SigmoidalVibratoSSF", "Property")
        SwappableNegatableInputFloat2(settingVars, "lowerStart", "lowerEnd", "Lower S/E SSFs", "x")
        SwappableNegatableInputFloat2(settingVars, "higherStart", "higherEnd", "Higher S/E SSFs", "x")
        chooseCurvatureCoefficient(settingVars, plotSigmoidalCurvature)
        saveSettingPropertiesButton(settingVars, "SigmoidalVibratoSSF")
        saveVariables("SigmoidalVibratoSSFPropertySettings", settingVars)
    end
end
function showGeneralSettings()
    GlobalCheckbox("advancedMode", "Enable Advanced Mode",
        "Advanced mode enables a few features that simplify SV creation, at the cost of making the plugin more cluttered.")
    if (not globalVars.advancedMode) then imgui.BeginDisabled() end
    GlobalCheckbox("hideAutomatic", "Hide Automatically Placed TGs",
        'Timing groups placed by the "Automatic" feature will not be shown in the plumoguSV timing group selector.')
    if (not globalVars.advancedMode) then imgui.EndDisabled() end
    AddSeparator()
    chooseUpscroll()
    AddSeparator()
    GlobalCheckbox("dontReplaceSV", "Don't Replace Existing SVs",
        "Self-explanatory, but applies only to base SVs made with Standard, Special, or Still. Highly recommended to keep this setting disabled.")
    GlobalCheckbox("ignoreNotesOutsideTg", "Ignore Notes Not In Current Timing Group",
        "Notes that are in a timing group outside of the current one will be ignored by stills, selection checks, etc.")
    chooseStepSize()
    GlobalCheckbox("dontPrintCreation", "Don't Print SV Creation Messages",
        'Disables printing "Created __ SVs" messages.')
    GlobalCheckbox("equalizeLinear", "Equalize Linear SV",
        "Forces the standard > linear option to have an average sv of 0 if the start and end SVs are equal. For beginners, this should be enabled.")
    GlobalCheckbox("comboizeSelect", "Select Using Already Selected Notes",
        "Changes the behavior of the SELECT tab to select notes that are already selected, instead of all notes between the start/end selection.")
end
function chooseUpscroll()
    local oldUpscroll = globalVars.upscroll
    globalVars.upscroll = RadioButtons("Scroll Direction:", globalVars.upscroll, { "Down", "Up" }, { false, true },
        "Orientation for distance graphs and visuals")
    if (oldUpscroll ~= globalVars.upscroll) then
        write(globalVars)
    end
end
function showKeybindSettings()
    local awaitingIndex = state.GetValue("hotkey_awaitingIndex", 0)
    for hotkeyIndex, hotkeyCombo in pairs(globalVars.hotkeyList) do
        if imgui.Button(awaitingIndex == hotkeyIndex and "Listening...##listening" or hotkeyCombo .. "##" .. hotkeyIndex) then
            if (awaitingIndex == hotkeyIndex) then
                awaitingIndex = 0
            else
                awaitingIndex = hotkeyIndex
            end
        end
        KeepSameLine()
        imgui.SetCursorPosX(111)
        imgui.Text("" .. HOTKEY_LABELS[hotkeyIndex])
    end
    AddSeparator()
    simpleActionMenu("Reset Hotkey Settings", 0, function()
        globalVars.hotkeyList = table.duplicate(DEFAULT_HOTKEY_LIST)
        write(globalVars)
        awaitingIndex = 0
    end, nil, true, true)
    state.SetValue("hotkey_awaitingIndex", awaitingIndex)
    if (awaitingIndex == 0) then return end
    local prefixes, key = kb.listenForAnyKeyPressed()
    if (key == -1) then return end
    globalVars.hotkeyList[awaitingIndex] = table.concat(prefixes, "+") ..
        (truthy(prefixes) and "+" or "") .. kb.numToKey(key)
    awaitingIndex = 0
    write(globalVars)
    state.SetValue("hotkey_awaitingIndex", awaitingIndex)
end
SETTING_TYPES = {
    "General",
    "Default Properties",
    "Appearance",
    "Custom Theme",
    "Windows + Widgets",
    "Keybinds",
}
function showPluginSettingsWindow()
    local bgColor = vector.New(0.2, 0.2, 0.2, 1)
    imgui.PopStyleColor(20)
    setIncognitoColors()
    setPluginAppearanceStyles("Rounded + Border")
    imgui.PushStyleColor(imgui_col.WindowBg, bgColor)
    imgui.PushStyleColor(imgui_col.TitleBg, bgColor)
    imgui.PushStyleColor(imgui_col.TitleBgActive, bgColor)
    imgui.PushStyleColor(imgui_col.Border, vector4(1))
    imgui.SetNextWindowCollapsed(false)
    _, settingsOpened = imgui.Begin("plumoguSV Settings", true, 42)
    imgui.SetWindowSize("plumoguSV Settings", vector.New(433, 400))
    local typeIndex = state.GetValue("settings_typeIndex", 1)
    imgui.Columns(2, "settings_columnList", true)
    imgui.SetColumnWidth(0, 150)
    imgui.SetColumnWidth(1, 283)
    imgui.BeginChild(420)
    imgui.Text("Setting Type")
    imgui.Separator()
    for idx, v in pairs(SETTING_TYPES) do
        if (v == "Custom Theme" and COLOR_THEMES[globalVars.colorThemeIndex] ~= "CUSTOM") then goto skip end
        if (imgui.Selectable(v, typeIndex == idx)) then
            typeIndex = idx
        end
        ::skip::
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
    imgui.BeginChild(69)
    if (SETTING_TYPES[typeIndex] == "General") then
        showGeneralSettings()
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
    if (SETTING_TYPES[typeIndex] == "Custom Theme" and COLOR_THEMES[globalVars.colorThemeIndex] == "CUSTOM") then
        showCustomThemeSettings()
    end
    if (SETTING_TYPES[typeIndex] == "Keybinds") then
        showKeybindSettings()
    end
    imgui.EndChild()
    imgui.Columns(1)
    state.SetValue("settings_typeIndex", typeIndex)
    if (not settingsOpened) then
        state.SetValue("showSettingsWindow", false)
        state.SetValue("settings_typeIndex", 1)
        state.SetValue("crazy", "Crazy?")
        state.SetValue("activateCrazy", false)
        state.SetValue("crazyIdx", 1)
    end
    imgui.PopStyleColor(41)
    setPluginAppearanceColors(COLOR_THEMES[globalVars.colorThemeIndex])
    setPluginAppearanceStyles(STYLE_THEMES[globalVars.styleThemeIndex])
    imgui.End()
end
function renderMemeButtons()
    if (imgui.Button("show me the quzz (quaver huzz)")) then
        ---@diagnostic disable-next-line: param-type-mismatch
        imgui.Text(nil)
    end
    local text = state.GetValue("crazy", "Crazy?")
    local full =
    " I was crazy once. They put me in a map. A ranked map. A ranked map with no SV. And no SV makes me crazy. Crazy?"
    if (imgui.Button(text)) then
        state.SetValue("activateCrazy", true)
    end
    if (state.GetValue("activateCrazy")) then
        imgui.TextWrapped(text)
        if (clock.listen("crazy", 10 * math.exp(- #text / 100))) then
            local curIdx = state.GetValue("crazyIdx", 1)
            if (curIdx > #full) then curIdx = curIdx - #full end
            text = text .. full:charAt(curIdx)
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
function chooseBezierPoints(settingVars)
    local oldFirstPoint = settingVars.p1
    local oldSecondPoint = settingVars.p2
    local _, newFirstPoint = imgui.SliderFloat2("(x1, y1)", oldFirstPoint, 0, 1, "%.2f")
    HelpMarker("Coordinates of the first point of the cubic bezier")
    local _, newSecondPoint = imgui.SliderFloat2("(x2, y2)", oldSecondPoint, 0, 1, "%.2f")
    HelpMarker("Coordinates of the second point of the cubic bezier")
    settingVars.p1 = newFirstPoint
    settingVars.p2 = newSecondPoint
    return settingVars.p1 ~= oldFirstPoint or settingVars.p2 ~= oldSecondPoint
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
    if (resetButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[5])) then
        settingVars.verticalShift = defaultShift
    end
    ToolTip("Reset vertical shift to initial values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N", TERTIARY_BUTTON_SIZE)
    if negateButtonPressed and settingVars.verticalShift ~= 0 then
        settingVars.verticalShift = -settingVars.verticalShift
    end
    ToolTip("Negate vertical shift")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local inputText = "Vertical Shift"
    _, settingVars.verticalShift = imgui.InputFloat(inputText, settingVars.verticalShift, 0, 0, "%.3fx")
    imgui.PopItemWidth()
    return oldShift ~= settingVars.verticalShift
end
function chooseMsxVerticalShift(settingVars, defaultShift)
    local oldShift = settingVars.verticalShift
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(7, 4))
    local resetButtonPressed = imgui.Button("R", TERTIARY_BUTTON_SIZE)
    if (resetButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[5])) then
        settingVars.verticalShift = defaultShift or 0
    end
    ToolTip("Reset vertical shift to initial values")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(6.5, 4))
    local negateButtonPressed = imgui.Button("N", TERTIARY_BUTTON_SIZE)
    if negateButtonPressed and settingVars.verticalShift ~= 0 then
        settingVars.verticalShift = -settingVars.verticalShift
    end
    ToolTip("Negate vertical shift")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local inputText = "Vertical Shift"
    _, settingVars.verticalShift = imgui.InputFloat(inputText, settingVars.verticalShift, 0, 0, "%.0f msx")
    imgui.PopItemWidth()
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
    if (settingChanged) then
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
    if (settingChanged) then
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
        settingVars.distance = ComputableInputFloat("Distance", settingVars.distance, 3, " msx")
        return
    end
    return SwappableNegatableInputFloat2(settingVars, "distance1", "distance2", "Dist.", "msx", 2)
end
function chooseSelectTool()
    imgui.AlignTextToFramePadding()
    imgui.Text("Current Type:")
    KeepSameLine()
    globalVars.selectTypeIndex = Combo("##selecttool", SELECT_TOOLS, globalVars.selectTypeIndex)
    local selectTool = SELECT_TOOLS[globalVars.selectTypeIndex]
    if selectTool == "Alternating" then ToolTip("Skip over notes then select one, and repeat") end
    if selectTool == "By Snap" then ToolTip("Select all notes with a certain snap color") end
    if selectTool == "Bookmark" then ToolTip("Jump to a bookmark") end
    if selectTool == "Chord Size" then ToolTip("Select all notes with a certain chord size") end
    if selectTool == "Note Type" then ToolTip("Select rice/ln notes") end
end
function chooseEditTool()
    imgui.AlignTextToFramePadding()
    imgui.Text("  Current Tool:")
    KeepSameLine()
    globalVars.editToolIndex = Combo("##edittool", EDIT_SV_TOOLS, globalVars.editToolIndex)
    local svTool = EDIT_SV_TOOLS[globalVars.editToolIndex]
    if svTool == "Add Teleport" then ToolTip("Add a large teleport SV to move far away") end
    if svTool == "Align Timing Lines" then ToolTip("Create timing lines at notes to avoid desync") end
    if svTool == "Change Timing Group" then ToolTip("Moves SVs and SSFs to a designated timing group.") end
    if svTool == "Convert SV <-> SSF" then ToolTip("Convert multipliers between SV/SSF") end
    if svTool == "Copy & Paste" then ToolTip("Copy SVs and SSFs and paste them somewhere else") end
    if svTool == "Direct SV" then ToolTip("Directly update SVs within your selection") end
    if svTool == "Displace Note" then ToolTip("Move where notes are hit on the screen") end
    if svTool == "Displace View" then ToolTip("Temporarily displace the playfield view") end
    if svTool == "Dynamic Scale" then ToolTip("Dynamically scale SVs across notes") end
    if svTool == "Fix LN Ends" then ToolTip("Fix flipped LN ends") end
    if svTool == "Flicker" then ToolTip("Flash notes on and off the screen") end
    if svTool == "Layer Snaps" then ToolTip("Transfer snap colors into layers, to be loaded later") end
    if svTool == "Measure" then ToolTip("Get stats about SVs in a section") end
    if svTool == "Merge" then ToolTip("Combine SVs that overlap") end
    if svTool == "Reverse Scroll" then ToolTip("Reverse the scroll direction using SVs") end
    if svTool == "Scale (Multiply)" then ToolTip("Scale SV values by multiplying") end
    if svTool == "Scale (Displace)" then ToolTip("Scale SV values by adding teleport SVs") end
    if svTool == "Swap Notes" then ToolTip("Swap positions of notes using SVs") end
    if svTool == "Vertical Shift" then ToolTip("Adds a constant value to SVs in a range") end
end
function chooseEffectFPS()
    local currentTrail = CURSOR_TRAILS[globalVars.cursorTrailIndex]
    if currentTrail ~= "Snake" then return end
    local settingChanged = BasicInputInt(globalVars, "effectFPS", "Effect FPS", { 2, 1000 },
        "Set this to a multiple of UPS or FPS to make cursor effects smooth")
    if (settingChanged) then
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
    if #settingVars.frameTimes == 0 then return end
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
function chooseStepSize()
    imgui.PushItemWidth(40)
    local oldStepSize = globalVars.stepSize
    local _, tempStepSize = imgui.InputFloat("Exponential Intensity Step Size", oldStepSize, 0, 0, "%.0f%%")
    globalVars.stepSize = math.clamp(tempStepSize, 1, 100)
    imgui.PopItemWidth()
    if (oldStepSize ~= globalVars.stepSize) then
        write(globalVars)
    end
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
    newShift = math.quarter(newShift)
    newShift = math.wrappedClamp(newShift, -0.75, 1)
    settingVars.periodsShift = newShift
    return oldShift ~= newShift
end
function chooseCreateTool()
    imgui.AlignTextToFramePadding()
    imgui.Text("  Type:  ")
    KeepSameLine()
    globalVars.placeTypeIndex = Combo("##placeType", CREATE_TYPES, globalVars.placeTypeIndex)
    local placeType = CREATE_TYPES[globalVars.placeTypeIndex]
    if placeType == "Still" then ToolTip("Still keeps notes normal distance/spacing apart") end
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
        if string.find(tgId, "%$") then goto cont end
        if (globalVars.hideAutomatic and string.find(tgId, "automate_")) then hiddenGroups[#hiddenGroups + 1] = tgId end
        groups[#groups + 1] = tgId
        table.insert(cols, tg.ColorRgb or "255,255,255")
        ::cont::
    end
    local prevIndex = globalVars.scrollGroupIndex
    imgui.PushItemWidth(155)
    globalVars.scrollGroupIndex = Combo("##scrollGroup", groups, globalVars.scrollGroupIndex, cols, hiddenGroups)
    imgui.PopItemWidth()
    if (kb.pressedKeyCombo(globalVars.hotkeyList[6])) then
        globalVars.scrollGroupIndex = math.clamp(globalVars.scrollGroupIndex - 1, 1, #groups)
    end
    if (kb.pressedKeyCombo(globalVars.hotkeyList[7])) then
        globalVars.scrollGroupIndex = math.clamp(globalVars.scrollGroupIndex + 1, 1, #groups)
    end
    AddSeparator()
    if (prevIndex ~= globalVars.scrollGroupIndex) then
        state.SelectedScrollGroupId = groups[globalVars.scrollGroupIndex]
    end
    if (state.SelectedScrollGroupId ~= groups[globalVars.scrollGroupIndex]) then
        globalVars.scrollGroupIndex = table.indexOf(groups, state.SelectedScrollGroupId)
    end
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
        "%.0f seconds")
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
    if scaleType == "Relative Ratio" then ComputableInputFloat("Ratio", menuVars.ratio, 3) end
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
    ToolTip("Note that higher FPS will look worse on lower refresh rate monitors.")
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
    local stillType = STILL_TYPES[menuVars.stillTypeIndex]
    local dontChooseDistance = stillType == "No" or
        stillType == "Auto" or
        stillType == "Otua"
    local indentWidth = DEFAULT_WIDGET_WIDTH * 0.5 + 16
    if dontChooseDistance then
        imgui.Indent(indentWidth)
    else
        imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.6 - 5)
        _, menuVars.stillDistance = imgui.InputFloat("##still", menuVars.stillDistance, 0, 0,
            "%.2f msx")
        KeepSameLine()
        imgui.PopItemWidth()
    end
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.4)
    menuVars.stillTypeIndex = Combo("Displacement", STILL_TYPES, menuVars.stillTypeIndex)
    if stillType == "No" then ToolTip("Don't use an initial or end displacement") end
    if stillType == "Start" then ToolTip("Use an initial starting displacement for the still") end
    if stillType == "End" then ToolTip("Have a displacement to end at for the still") end
    if stillType == "Auto" then ToolTip("Use last displacement of the previous still to start") end
    if stillType == "Otua" then ToolTip("Use next displacement of the next still to end at") end
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
    ToolTip("Switch between slow down/speed up")
    KeepSameLine()
    imgui.PushStyleVar(imgui_style_var.FramePadding, vector.New(PADDING_WIDTH, 5))
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH * 0.7 - SAMELINE_SPACING)
    local oldBehaviorIndex = settingVars.behaviorIndex
    settingVars.behaviorIndex = Combo("Behavior", SV_BEHAVIORS, oldBehaviorIndex)
    imgui.PopItemWidth()
    if (swapButtonPressed or kb.pressedKeyCombo(globalVars.hotkeyList[3])) then
        settingVars.behaviorIndex = oldBehaviorIndex == 1 and 2 or 1
    end
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
HEXADECIMAL = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" }
NONDUA = { "!", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f",
    "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "{", "|", "}",
    "~" }
function rgbaToUint(r, g, b, a)
    local flr = math.floor
    return flr(a) * 16 ^ 6 + flr(b) * 16 ^ 4 + flr(g) * 16 ^ 2 + flr(r)
end
function uintToRgba(n)
    local tbl = {}
    for i = 0, 3 do
        tbl[#tbl + 1] = math.floor(n / 256 ^ i) % 256
    end
    return table.vectorize4(tbl)
end
function rgbaToHexa(r, g, b, a)
    local flr = math.floor
    local hexaStr = ""
    for _, col in ipairs({ r, g, b, a }) do
        hexaStr = hexaStr .. HEXADECIMAL[math.floor(col / 16) + 1] .. HEXADECIMAL[flr(col) % 16 + 1]
    end
    return hexaStr
end
function hexaToRgba(hexa)
    local rgbaTable = {}
    for i = 1, 8, 2 do
        table.insert(rgbaTable,
            table.indexOf(HEXADECIMAL, hexa:charAt(i)) * 16 + table.indexOf(HEXADECIMAL, hexa:charAt(i + 1)) - 17)
    end
    return table.vectorize4(rgbaTable)
end
function rgbaToNdua(r, g, b, a)
    local uint = rgbaToUint(r, g, b, a)
    local str = ""
    for i = 0, 4 do
        str = str .. NONDUA[math.floor(uint / (92 ^ i)) % 92 + 1]
    end
    return str:reverse()
end
function nduaToRgba(ndua)
    local num = 0
    for i = 1, 5 do
        local idx = table.indexOf(NONDUA, ndua:charAt(i))
        if (idx == -1) then goto skip end
        num = num + (idx - 1) * 92 ^ (5 - i)
        ::skip::
    end
    return uintToRgba(num)
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
    local exponent = 23 - math.floor(math.log(math.abs(offset) + 1) / math.log(2))
    if exponent >= 6 then return 64 end
    return 2 ^ exponent
end
function prepareDisplacingSV(svsToAdd, svTimeIsAdded, svTime, displacement, displacementMultiplier, hypothetical, svs)
    svTimeIsAdded[svTime] = true
    local currentSVMultiplier = game.getSVMultiplierAt(svTime)
    if (hypothetical == true) then
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
    for i = 1, numValues do
        timeGuesses[#timeGuesses + 1] = startingTimeGuess
        targetXPositions[#targetXPositions + 1] = i / numValues
    end
    for i = 1, iterations do
        local timeIncrement = 0.5 ^ (i + 1)
        for j = 1, numValues do
            local xPositionGuess = math.cubicBezier(p1.x, p1.y, timeGuesses[j])
            if xPositionGuess < targetXPositions[j] then
                timeGuesses[j] = timeGuesses[j] + timeIncrement
            elseif xPositionGuess > targetXPositions[j] then
                timeGuesses[j] = timeGuesses[j] - timeIncrement
            end
        end
    end
    local yPositions = { 0 }
    for i = 1, #timeGuesses do
        local yPosition = math.cubicBezier(p2.x, p2.y, timeGuesses[i])
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
        if #comboValues == 0 then comboValues[#comboValues + 1] = 1 end
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
        local temp = startValue
        startValue = endValue
        endValue = temp
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
    if (globalVars.equalizeLinear and placingSV) then
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
        if #settingVars.svMultipliers == 0 then
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
        saveVariables(labelText1 .. "Settings", settingVars1)
        local svType2 = STANDARD_SVS[settingVars.svType2Index]
        local settingVars2 = getSettingVars(svType2, "Combo2")
        local multipliers2 = generateSVMultipliers(svType2, settingVars2, nil)
        local labelText2 = svType2 .. "Combo2"
        saveVariables(labelText2 .. "Settings", settingVars2)
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
function createSV(startTime, multiplier)
    return utils.CreateScrollVelocity(startTime, multiplier)
end
function createSSF(startTime, multiplier)
    return utils.CreateScrollSpeedFactor(startTime, multiplier)
end
function createEA(actionType, ...)
    return utils.CreateEditorAction(actionType, ...)
end
---Removes and adds SVs.
---@param svsToRemove ScrollVelocity[]
---@param svsToAdd ScrollVelocity[]
function removeAndAddSVs(svsToRemove, svsToAdd)
    local tolerance = 0.035
    if #svsToAdd == 0 then return end
    for idx, sv in pairs(svsToRemove) do
        local baseSV = game.getSVStartTimeAt(sv.StartTime)
        if (math.abs(baseSV - sv.StartTime) > tolerance) then
            table.remove(svsToRemove, idx)
        end
    end
    local editorActions = {
        utils.CreateEditorAction(action_type.RemoveScrollVelocityBatch, svsToRemove),
        utils.CreateEditorAction(action_type.AddScrollVelocityBatch, svsToAdd)
    }
    actions.PerformBatch(editorActions)
    toggleablePrint("s!", table.concat({"Created ", #svsToAdd, pluralize(" SV.", #svsToAdd, -2)}))
end
function removeAndAddSSFs(ssfsToRemove, ssfsToAdd)
    if #ssfsToAdd == 0 then return end
    local editorActions = {
        utils.CreateEditorAction(action_type.RemoveScrollSpeedFactorBatch, ssfsToRemove),
        utils.CreateEditorAction(action_type.AddScrollSpeedFactorBatch, ssfsToAdd)
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
    if (ssf == nil) then return end
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
    table.remove(svMultipliersNoEndSV)
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
        if (curvature >= 1) then
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
        if (curvature >= 1) then
            if (t <= 1) then
                value = t ^ curvature
            else
                value = 2 - (2 - t) ^ curvature
            end
        else
            if (t <= 1) then
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
    if (globalVars.showSVInfoVisualizer) then
        local ctx = imgui.GetWindowDrawList()
        local topLeft = imgui.GetWindowPos()
        local dim = imgui.GetWindowSize()
        local simTime = 120000 / game.getTimingPointAt(state.SongTime).Bpm
        local curTime = (state.UnixTime) % simTime
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
        for i = 1, 4 do
            ctx.AddRectFilled(vector.New(topLeft.x + (i - 1) * dim.x / 4 + 5, heightValue),
                vector.New(topLeft.x + i * dim.x / 4 - 5, heightValue + 20),
                imgui.GetColorU32(imgui_col.Header, (1 - (1 - progress) ^ 10)))
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
        startNextWindowNotCollapsed("svInfo2AutoOpen")
        makeSVInfoWindow("SV Info (Starting first SV)", settingVars.svGraphStats, nil,
            settingVars.svDistances, settingVars.svMultipliers,
            settingVars.stutterDuration, false)
        startNextWindowNotCollapsed("svInfo3AutoOpen")
        makeSVInfoWindow("SV Info (Ending first SV)", settingVars.svGraph2Stats, nil,
            settingVars.svDistances2, settingVars.svMultipliers2,
            settingVars.stutterDuration, false)
    else
        startNextWindowNotCollapsed("svInfo1AutoOpen")
        makeSVInfoWindow("SV Info", settingVars.svGraphStats, nil, settingVars.svDistances,
            settingVars.svMultipliers, settingVars.stutterDuration, false)
    end
end
function bezierSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = provideBezierWebsiteLink(settingVars) or settingsChanged
    settingsChanged = chooseBezierPoints(settingVars) or settingsChanged
    settingsChanged = chooseConstantShift(settingVars, 0) or settingsChanged
    settingsChanged = chooseAverageSV(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    settingsChanged = chooseFinalSV(settingVars, skipFinalSV) or settingsChanged
    return settingsChanged
end
function provideBezierWebsiteLink(settingVars)
    local coordinateParsed = false
    local bezierText = state.GetValue("bezier_text") or "https://cubic-bezier.com/"
    _, bezierText = imgui.InputText("##bezierWebsite", bezierText, 100, imgui_input_text_flags.AutoSelectAll)
    KeepSameLine()
    if imgui.Button("Parse##bezierValues", SECONDARY_BUTTON_SIZE) then
        local regex = "(-?%d*%.?%d+)"
        local values = {}
        for value, _ in string.gmatch(bezierText, regex) do
            values[#values + 1] = math.toNumber(value)
        end
        if #values >= 4 then
            settingVars.p1 = vector.New(values[1], values[2])
            settingVars.p2 = vector.New(values[3], values[4])
            coordinateParsed = true
        end
        bezierText = "https://cubic-bezier.com/"
    end
    state.SetValue("bezier_text", bezierText)
    HelpMarker(
        "This site lets you play around with a cubic bezier whose graph represents the motion/path of notes. After finding a good shape for note motion, paste the resulting url into the input box and hit the parse button to import the coordinate values. Alternatively, enter 4 numbers to use as the coordinates using the given inputs.")
    return coordinateParsed
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
function comboSettingsMenu(settingVars)
    local settingsChanged = false
    startNextWindowNotCollapsed("svType1AutoOpen")
    imgui.Begin("SV Type 1 Settings", imgui_window_flags.AlwaysAutoResize)
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    local svType1 = STANDARD_SVS[settingVars.svType1Index]
    local settingVars1 = getSettingVars(svType1, "Combo1")
    settingsChanged = showSettingsMenu(svType1, settingVars1, true, nil) or settingsChanged
    local labelText1 = svType1 .. "Combo1"
    saveVariables(labelText1 .. "Settings", settingVars1)
    imgui.End()
    startNextWindowNotCollapsed("svType2AutoOpen")
    imgui.Begin("SV Type 2 Settings", imgui_window_flags.AlwaysAutoResize)
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    local svType2 = STANDARD_SVS[settingVars.svType2Index]
    local settingVars2 = getSettingVars(svType2, "Combo2")
    settingsChanged = showSettingsMenu(svType2, settingVars2, true, nil) or settingsChanged
    local labelText2 = svType2 .. "Combo2"
    saveVariables(labelText2 .. "Settings", settingVars2)
    imgui.End()
    local maxComboPhase = settingVars1.svPoints + settingVars2.svPoints
    settingsChanged = chooseStandardSVTypes(settingVars) or settingsChanged
    settingsChanged = chooseComboSVOption(settingVars, maxComboPhase) or settingsChanged
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
            values[#values + 1] = math.toNumber(value)
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
function randomSettingsMenu(settingVars, skipFinalSV, svPointsForce)
    local settingsChanged = false
    settingsChanged = chooseRandomType(settingVars) or settingsChanged
    settingsChanged = chooseRandomScale(settingVars) or settingsChanged
    settingsChanged = chooseSVPoints(settingVars, svPointsForce) or settingsChanged
    if imgui.Button("Generate New Random Set", BEEG_BUTTON_SIZE) then
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
function awake()
    local tempGlobalVars = read()
    if (not tempGlobalVars) then
        write(globalVars)
        print("w!",
            'This seems to be your first time using plumoguSV. If you need any help, please press the button labelled "View Tutorials" in the "Info" tab.')
        setPresets({})
    else
        setGlobalVars(tempGlobalVars)
        loadDefaultProperties(tempGlobalVars.defaultProperties)
        setPresets(tempGlobalVars.presets or {})
    end
    initializeNoteLockMode()
    listenForHitObjectChanges()
    keyCount = map.GetKeyCount(false)
    state.SelectedScrollGroupId = "$Default" or map.GetTimingGroupIds()[1]
end
function listenForHitObjectChanges()
    state.SetValue("hoStartTimes", table.dedupe(table.property(map.HitObjects, "StartTime")))
    listen(function(action, type, fromLua)
        if (tonumber(action.Type) > 9) then return end
        state.SetValue("hoStartTimes", table.dedupe(table.property(map.HitObjects, "StartTime")))
    end)
end
function draw()
    state.SetValue("ComputableInputFloatIndex", 1)
    state.SetValue("StatedInputTextIndex", 1)
    state.IsWindowHovered = imgui.IsWindowHovered()
    drawCapybaraParent()
    drawCursorTrail()
    setPluginAppearance()
    startNextWindowNotCollapsed("plumoguSV-autoOpen")
    imgui.Begin("plumoguSV-dev", imgui_window_flags.AlwaysAutoResize)
    renderBackground()
    imgui.PushItemWidth(DEFAULT_WIDGET_WIDTH)
    imgui.BeginTabBar("SV tabs")
    for i = 1, #TAB_MENUS do
        createMenuTab(TAB_MENUS[i])
    end
    imgui.EndTabBar()
    if (globalVars.showVibratoWidget) then
        imgui.Begin("plumoguSV-Vibrato", imgui_window_flags.AlwaysAutoResize)
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
    imgui.End()
    pulseController()
    checkForGlobalHotkeys()
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
function renderMeasureDataWidget()
    local widgetVars = {
        oldStartOffset = -69,
        oldEndOffset = -69,
        nsvDistance = 0,
        roundedSVDistance = 0,
        roundedAvgSV = 0
    }
    getVariables("measureWidget", widgetVars)
    if #state.SelectedHitObjects < 2 then return end
    local uniqueDict = {}
    for _, ho in ipairs(state.SelectedHitObjects) do
        if (not table.contains(uniqueDict, ho.StartTime)) then
            uniqueDict[#uniqueDict + 1] = ho.StartTime
        end
        if (#uniqueDict > 2) then return end
    end
    uniqueDict = sort(uniqueDict, sortAscending) ---@type number[]
    local startOffset = uniqueDict[1]
    local endOffset = uniqueDict[2] or uniqueDict[1]
    if (math.abs(endOffset - startOffset) < 1e-10) then return end
    if (endOffset ~= widgetVars.oldEndOffset or startOffset ~= widgetVars.oldStartOffset) then
        svsBetweenOffsets = game.getSVsBetweenOffsets(startOffset, endOffset)
        widgetVars.nsvDistance = endOffset - startOffset
        addStartSVIfMissing(svsBetweenOffsets, startOffset)
        totalDistance = calculateDisplacementFromSVs(svsBetweenOffsets, startOffset, endOffset)
        widgetVars.roundedSVDistance = math.round(totalDistance, 3)
        avgSV = totalDistance / (endOffset - startOffset)
        widgetVars.roundedAvgSV = math.round(avgSV, 3)
    end
    imgui.BeginTooltip()
    imgui.Text("Measure Info:")
    imgui.Text(table.concat({"NSV Distance = ", widgetVars.nsvDistance, " ms"}))
    imgui.Text(table.concat({"SV Distance = ", widgetVars.roundedSVDistance, " msx"}))
    imgui.Text(table.concat({"Avg SV = ", widgetVars.roundedAvgSV, "x"}))
    imgui.EndTooltip()
    widgetVars.oldStartOffset = startOffset
    widgetVars.oldEndOffset = endOffset
    saveVariables("measureWidget", widgetVars)
end