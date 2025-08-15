function pulseController()
    local pulseVars = {
        previousBar = 0,
        pulseStatus = 0,
        pulsedThisFrame = false
    }

    cache.loadTable("pulseController", pulseVars)

    local timeOffset = 50 -- [`state.SongTime`](lua://state.SongTime) isn't entirely accurate while the song is playing, so this aims to correct that.

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

    local borderColor = cache.borderColor or vctr4(1)
    local negatedBorderColor = vctr4(1) - borderColor

    local pulseColor = globalVars.useCustomPulseColor and globalVars.pulseColor or negatedBorderColor

    imgui.PushStyleColor(imgui_col.Border, pulseColor * pulseVars.pulseStatus + borderColor * (1 - pulseVars.pulseStatus))

    cache.saveTable("pulseController", pulseVars)
    cache.pulseValue = pulseVars.pulseStatus
    cache.pulsedThisFrame = pulseVars.pulsedThisFrame
end
