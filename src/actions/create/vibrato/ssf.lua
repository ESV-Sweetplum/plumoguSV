function ssfVibrato(menuVars, func1, func2)
    printLegacyLNMessage()
    local offsets = game.get.uniqueSelectedNoteOffsets()
    if (not isTruthy(offsets)) then return end
    local startTime = offsets[1]
    local endTime = offsets[#offsets]
    local fps = VIBRATO_FRAME_RATES[menuVars.vibratoQuality]
    local delta = 1000 / fps
    local time = startTime
    local ssfs = { createSSF(startTime - 1 / getUsableDisplacementMultiplier(startTime),
        game.get.ssfMultiplierAt(time)) }
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

    addFinalSSF(ssfs, endTime, game.get.ssfMultiplierAt(endTime))

    actions.PerformBatch({
        createEA(action_type.AddScrollSpeedFactorBatch, ssfs),
    })
    toggleablePrint("s!", "Created " .. #ssfs .. pluralize(" SSF.", #ssfs, -2))
end
