function pulseController()
    local pulseVars = {
        previousBar = 0,
        pulseStatus = 0,
        pulsedThisFrame = false,
    }

    cache.loadTable('pulseController', pulseVars)

    local timeOffset = 50 -- [`state.SongTime`](lua://state.SongTime) isn't entirely accurate while the song is playing, so this aims to correct that.

    local timeSinceLastBar = ((state.SongTime + timeOffset) - game.get.timingPointAt(state.SongTime).StartTime) %
        ((60000 / game.get.timingPointAt(state.SongTime).Bpm))


    pulseVars.pulsedThisFrame = false

    if ((timeSinceLastBar < pulseVars.previousBar)) then
        pulseVars.pulseStatus = 1
        pulseVars.pulsedThisFrame = true
    else
        pulseVars.pulseStatus = (pulseVars.pulseStatus - state.DeltaTime / (60000 / game.get.timingPointAt(state.SongTime).Bpm) * 1.2)
    end

    pulseVars.previousBar = timeSinceLastBar

    local futureTime = state.SongTime + state.DeltaTime * 2 + timeOffset

    if ((futureTime - game.get.timingPointAt(futureTime).StartTime) < 0) then
        pulseVars.pulseStatus = 0
    end

    outputPulseStatus = math.max(pulseVars.pulseStatus, 0) * (globalVars.pulseCoefficient or 0)

    local borderColor = cache.borderColor or vctr4(1)
    if (type(borderColor) == 'table') then borderColor = table.vectorize4(borderColor) end
    local negatedBorderColor = vctr4(1) - borderColor

    local pulseColor = globalVars.useCustomPulseColor and globalVars.pulseColor or negatedBorderColor

    imgui.PushStyleColor(imgui_col.Border, pulseColor * outputPulseStatus + borderColor * (1 - outputPulseStatus))

    cache.saveTable('pulseController', pulseVars)
    cache.pulseValue = math.max(pulseVars.pulseStatus, 0)
    cache.pulsedThisFrame = pulseVars.pulsedThisFrame
end
