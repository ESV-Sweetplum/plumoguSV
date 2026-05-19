function showPatchNotesV202(c)
    local bugFixes = {
        'Steam builds now have a warning to save their config file because workshop poopoo.',
        'Fixed some backgrounds incorrectly displaying.',
        'Fixed hit object lag.',
        'Fixed measure not updating properly when applying sv (bug from v2.0.1).',
        'Cleaned up the lint map screen and added \"Remove Unnecessary SSF\" function.',
        'Did quite a large amount of work on the backend like renaming stuff to be more clear, etc.',
        'Align timing lines now properly hides timing lines if the first one was hidden.',
        'Now allows sinusoidal movement in dynamic scale.',
        'Upgraded computableinputfloat to now allow for infinite precision and much more anti-cheese entries.',
    }

    local newFeatures = {
        'Added text to give me money like mr krabs.',
    }

    showPatchNotesElement('v2.0.2', 147, { rect = c }, { bugFixes = bugFixes, newFeatures = newFeatures })
end
