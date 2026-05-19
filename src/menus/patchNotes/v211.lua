function showPatchNotesV211(lc, rc)
    local bugFixes = {
        'Fixed the x2 and /2 buttons not working.',
        "Fixed the preset menu's columns not correctly rendering.",
    }

    local newFeatures = {
        'Added a new dynamic background, the SV Spectrogram.',
        'Added the "none" type to the final SV selector.',
        'Reworked the DELETE menu, now having multiple buttons. An option was added\nto switch back to the checkbox mode seen in previous versions.',
    }

    showPatchNotesElement('v2.1.1', 128, { rect = lc }, { bugFixes = bugFixes, newFeatures = newFeatures })
end
