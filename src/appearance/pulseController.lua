function pulseController()
    local pulseVars = {
        previousBar = 0,
        pulseStatus = 0,
        pulsedThisFrame = false
    }

    getVariables("pulseController", pulseVars)

    local timeOffset = 50 -- [`state.SongTime`](lua://state.SongTime) isn't entirely accurate while the song is playing, so this aims to correct that.

    local timeSinceLastBar = ((state.SongTime + timeOffset) - getTimingPointAt(state.SongTime).StartTime) %
        ((60000 / getTimingPointAt(state.SongTime).Bpm))


    pulseVars.pulsedThisFrame = false

    if ((timeSinceLastBar < pulseVars.previousBar)) then
        pulseVars.pulseStatus = 1
        pulseVars.pulsedThisFrame = true
    else
        pulseVars.pulseStatus = (pulseVars.pulseStatus - state.DeltaTime / (60000 / getTimingPointAt(state.SongTime).Bpm) * 1.2)
    end

    pulseVars.previousBar = timeSinceLastBar

    local futureTime = state.SongTime + state.DeltaTime * 2 + timeOffset

    if ((futureTime - getTimingPointAt(futureTime).StartTime) < 0) then
        pulseVars.pulseStatus = 0
    end

    pulseVars.pulseStatus = math.max(pulseVars.pulseStatus, 0) * (globalVars.pulseCoefficient or 0)

    local borderColor = state.GetValue("baseBorderColor") or vector4(1)
    local negatedBorderColor = vector4(1) - borderColor

    local pulseColor = globalVars.useCustomPulseColor and globalVars.pulseColor or negatedBorderColor

    imgui.PushStyleColor(imgui_col.Border, pulseColor * pulseVars.pulseStatus + borderColor * (1 - pulseVars.pulseStatus))

    saveVariables("pulseController", pulseVars)
end
