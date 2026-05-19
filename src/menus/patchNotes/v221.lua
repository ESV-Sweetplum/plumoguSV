function showPatchNotesV221(lc)
    local bugFixes = {
        'Fixed various menus calling nil function.',
        'Fixed gaussian vibrato crashing the plugin with 0msx deviance.',
        'Fixed old themes not being compatible with new theme parameters.',
    }

    local newFeatures = {}

    local devUpdates = {
        'Changed some anonymous functions to use metalua lambda syntax.',
        'Added back bezier module.',
        'Updated to the latest version of Luaver.',
    }

    showPatchNotesElement('v2.2.1', 137, { rect = lc },
        { bugFixes = bugFixes, newFeatures = newFeatures, devUpdates = devUpdates })
end
