function showPatchNotesV101(c)
    local bugFixes = {
        'Fixed game occasionally crashing when using the Select tab.',
    }

    local newFeatures = {
        'Added Select Bookmark feature (from BookmarkLeaper).',
        'Added Edit > Align Timing Lines feature (from SmartAlign).',
        'Added notifications for more features when executed.',
        'Added tooltips for Select features and swap/negate buttons.',
        'Changed the Delete menu to allow deleting SVs or SSFs.',
    }

    showPatchNotesElement('v1.0.1', 127, { rect = c }, { bugFixes = bugFixes, newFeatures = newFeatures })
end
