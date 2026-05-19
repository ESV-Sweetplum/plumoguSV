function showPatchNotesV112(c)
    local bugFixes = {
        'Fixed stills placing duplicate SVs that changed order when called.',
        'Fixed stills removing non-existent SVs.',
        'Fixed copy/paste priority problems.',
        'Fixed plugin TG selector overriding editor TG selector.',
    }

    local newFeatures = {
        "Now stores settings so you don't have to edit the plugin file to save them.",
        'Added step size to the exponential intensity bar.',
        'Distance fields now allow mathematical expressions\nthat are automatically evaluated.',
        'Created a new advanced mode, which disabling causes less clutter.',
        'Created Edit > Direct SV, an easier way to edit SVs directly within your selection.',
        'Added colors to the TG selector to easily distinguish groups.',
    }

    showPatchNotesElement('v1.1.2', 127, { rect = c }, { bugFixes = bugFixes, newFeatures = newFeatures })
end
