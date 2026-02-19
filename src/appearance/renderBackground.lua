function renderBackground()
    local idx = globalVars.dynamicBackgroundIndex
    if (DYNAMIC_BACKGROUND_TYPES[idx] == 'Reactive Stars') then
        renderReactiveStars()
    end
    if (DYNAMIC_BACKGROUND_TYPES[idx] == 'Reactive Singularity') then
        renderReactiveSingularities()
    end
    if (DYNAMIC_BACKGROUND_TYPES[idx] == 'Dynamic Connection') then
        renderDynamicConnection()
    end
    if (DYNAMIC_BACKGROUND_TYPES[idx] == 'SV Spectrogram') then
        renderSVSpectrogram()
    end
end
