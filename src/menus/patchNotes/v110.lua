function showPatchNotesV110(lc, rc)
    local bugFixes = {
        'Fixed issues where stills would incorrectly displace notes.',
        'Fixed swap/negate buttons not working properly.',
    }

    local newFeatures = {
        'Added Select by Chord Size.',
        'Now allows displace note/flicker to be linearly interpolated.',
        'Stills now only require one undo instead of two.',
        'New Still mode: still per note group, which drastically speeds up still production.',
        'Two new exponential modes: start/end and distance-based algorithms.',
        'Added hotkeys to quickly swap, negate, and reset certain parameters.',
        'Added notifications to all features.',
        'Copy and paste now supports bookmarks and timing lines.',
        'New setting was added to allow you to ignore notes outside the current TG.',
    }

    local lightnessAdjust = (state.UnixTime % 2400) / 1200 * math.pi
    local colFn = |x| color.vrgbaToUint(color.hslaToRgba(x + 200, 1, math.sin(lightnessAdjust + x / 20) / 5 + 0.67, 1))

    showPatchNotesElement('v1.1.0', 126, {rect = {lc,rc}, colFn = colFn}, {bugFixes = bugFixes, newFeatures = newFeatures})
end
