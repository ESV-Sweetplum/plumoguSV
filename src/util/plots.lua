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
        table.insert(distancesBackwards, distance)
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
    -- as the default, set the plot range to +- the absolute max value
    local minScale = -absMax
    local maxScale = absMax
    -- restrict the plot range to non-positive values when all values are non-positive
    if max <= 0 then maxScale = 0 end
    -- restrict the plot range to non-negative values when all values are non-negative
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
        table.insert(distancesBackwards, distance)
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

-- Updates stats for the current menu's SVs
-- Parameters
--    svGraphStats         : list of stats for the SV graphs [Table]
--    svStats              : list of stats for the current menu's SVs [Table]
--    svMultipliers        : list of sv multipliers [Table]
--    svMultipliersNoEndSV : list of sv multipliers, no end multiplier [Table]
--    svDistances          : list of distances calculated from SV multipliers [Table]
function updateSVStats(svGraphStats, svStats, svMultipliers, svMultipliersNoEndSV, svDistances)
    updateGraphStats(svGraphStats, svMultipliers, svDistances)
    svStats.minSV = math.round(math.min(table.unpack(svMultipliersNoEndSV)), 2)
    svStats.maxSV = math.round(math.max(table.unpack(svMultipliersNoEndSV)), 2)
    svStats.avgSV = math.round(table.average(svMultipliersNoEndSV, true), 3)
end

-- Updates scale stats for SV graphs
-- Parameters
--    graphStats : list of graph scale numbers [Table]
--    svMultipliers : list of SV multipliers[Table]
--    svDistances : list of SV distances [Table]
function updateGraphStats(graphStats, svMultipliers, svDistances)
    graphStats.minScale, graphStats.maxScale = calculatePlotScale(svMultipliers)
    graphStats.distMinScale, graphStats.distMaxScale = calculatePlotScale(svDistances)
end

-- Creates a new window with plots/graphs and stats of the current menu's SVs
-- Parameters
--    windowText      : name of the window [String]
--    svGraphStats    : stats of the SV graphs [Table]
--    svStats         : stats of the SV multipliers [Table]
--    svDistances     : distance vs time list [Table]
--    svMultipliers   : multiplier values of the SVs [Table]
--    stutterDuration : percent duration of first stutter (nil if not stutter SV) [Int]
--    skipDistGraph   : whether or not to skip showing the distance graph [Boolean]
function makeSVInfoWindow(windowText, svGraphStats, svStats, svDistances, svMultipliers,
                          stutterDuration, skipDistGraph)
    if (globalVars.hideSVInfo) then return end
    imgui.Begin(windowText, imgui_window_flags.AlwaysAutoResize)
    if (globalVars.showSVInfoVisualizer and not globalVars.performanceMode) then
        local ctx = imgui.GetWindowDrawList()
        local topLeft = imgui.GetWindowPos()
        local dim = imgui.GetWindowSize()

        local simTime = math.expoClamp(120000 / game.get.timingPointAt(state.SongTime).Bpm, 600, 1200, 2)
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
        imgui.Text(("Projected Note Motion:"):obfuscate())
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
    imgui.Text(projectedText:obfuscate())
    plotSVs(svMultipliers, svGraphStats.minScale, svGraphStats.maxScale)
    if stutterDuration then
        displayStutterSVStats(svMultipliers, stutterDuration)
    else
        displaySVStats(svStats)
    end

    imgui.End()
end

-- Displays stats for stutter SVs
-- Parameters
--    svMultipliers   : stutter multipliers [Table]
--    stutterDuration : duration of the stutter (out of 100) [Int]
function displayStutterSVStats(svMultipliers, stutterDuration)
    local firstSV = math.round(svMultipliers[1], 3)
    local secondSV = math.round(svMultipliers[2], 3)
    local firstDuration = stutterDuration
    local secondDuration = 100 - stutterDuration
    imgui.Columns(2, "SV Stutter Stats", false)
    imgui.Text(("First SV:"):obfuscate())
    imgui.Text(("Second SV:"):obfuscate())
    imgui.NextColumn()
    imgui.Text(firstSV .. "x  (" .. firstDuration .. "%% duration)")
    imgui.Text(secondSV .. "x  (" .. secondDuration .. "%% duration)")
    imgui.Columns(1)
end

-- Displays stats for the current menu's SVs
-- Parameters
--    svStats : list of stats for the current menu [Table]
function displaySVStats(svStats)
    imgui.Columns(2, "SV Stats", false)
    imgui.Text(("Max SV:"):obfuscate())
    imgui.Text(("Min SV:"):obfuscate())
    imgui.Text(("Average SV:"):obfuscate())
    imgui.NextColumn()
    imgui.Text(svStats.maxSV .. "x")
    imgui.Text(svStats.minSV .. "x")
    imgui.Text(svStats.avgSV .. "x")
    HelpMarker("Rounded to 3 decimal places")
    imgui.Columns(1)
end

-- Makes the next plugin window not collapsed on startup
-- Parameters
--    windowName : key name for the next plugin window that opens [String]
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
