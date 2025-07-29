function pulseController()
    local previousBar = state.GetValue("pulse_previousBar", 0)
    local pulseStatus = state.GetValue("pulseStatus", 0)

    local timeOffset = 50 -- [`state.SongTime`](lua://state.SongTime) isn't entirely accurate while the song is playing, so this aims to correct that.

    local timeSinceLastBar = ((state.SongTime + timeOffset) - getTimingPointAt(state.SongTime).StartTime) %
        ((60000 / getTimingPointAt(state.SongTime).Bpm))

    state.SetValue("pulsedThisFrame", false)
    if ((timeSinceLastBar < previousBar)) then
        pulseStatus = 1
        state.SetValue("pulsedThisFrame", true)
    else
        pulseStatus = (pulseStatus - state.DeltaTime / (60000 / getTimingPointAt(state.SongTime).Bpm) * 1.2)
    end

    local futureTime = state.SongTime + state.DeltaTime * 2 + timeOffset

    if ((futureTime - getTimingPointAt(futureTime).StartTime) < 0) then
        pulseStatus = 0
    end

    state.SetValue("pulseStatus", math.max(pulseStatus, 0))
    state.SetValue("pulse_previousBar", timeSinceLastBar)

    pulseStatus = pulseStatus * (globalVars.pulseCoefficient or 0)

    local borderColor = state.GetValue("baseBorderColor") or vector4(1)
    local negatedBorderColor = vector4(1) - borderColor

    local pulseColor = globalVars.useCustomPulseColor and globalVars.pulseColor or negatedBorderColor

    imgui.PushStyleColor(imgui_col.Border, pulseColor * pulseStatus + borderColor * (1 - pulseStatus))
end
