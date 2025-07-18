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
    local RESOLUTION = 16
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
