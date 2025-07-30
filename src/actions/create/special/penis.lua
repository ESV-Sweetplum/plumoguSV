function placePenisSV(settingVars)
    local startTime = uniqueNoteOffsetsBetweenSelected()[1]

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
