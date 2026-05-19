function showPatchNotesV201(c)
    local bugFixes = {
        'Fixed individual combo settings being able to be saved.',
        'Fixed loadup text color not being properly used in the custom theme.',
        'Changed the barbie theme to be less obnoxious.',
        'Fixed themes not exporting loadup parameters correctly.',
        'Changed some backend features to prevent bugs in the future.',
        'Moved some settings to the new "Advanced" section.',
        'Fixed performance mode not delaying HitObject refresh.',
        'Fixed stutter linear interpolation crashing the plugin.',
        'Now successfully hot-reloads menu data.',
        'Fixed Select > Alternating offset bug.',
        'Fixed loadup animation playing after delay even when it was disabled.',
    }

    local newFeatures = {
        'Now allows you to change the default displacement exponential multiplier.',
        'Added a setting which unrestricts sinusoidal period.',
        'Added mines to the Select > Note Type feature (canary only).',
        'Added a small gradient in the background to enhance appearance.',
    }

    showPatchNotesElement('v2.0.1', 135, { rect = c }, { bugFixes = bugFixes, newFeatures = newFeatures })
end
