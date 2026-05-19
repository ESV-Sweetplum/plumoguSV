function showPatchNotesV111(c)
    local bugFixes = {
        'Fixed more bugs involving stills.',
    }

    local newFeatures = {
        'Added a new hotkey to quickly place SSFs.',
        'Added a new TG selector.',
    }

    showPatchNotesElement('v1.1.1', 116, { rect = c }, { bugFixes = bugFixes, newFeatures = newFeatures })
end
