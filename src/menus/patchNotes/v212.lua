function showPatchNotesV212(lc, rc)
    local bugFixes = {
        'Fixed the preset menu incorerctly rendering.',
        'Fixed the preset menu being unable to receive negative numbers.',
        'Fixed recompilation bug with the aho-corasick algorithm.',
        'Now correctly seeds the math module to ensure purely random results.',
        'Fixed the dust trail being entirely white.',
    }

    local newFeatures = {
        'Added an error protector against faulty table parse attempts.',
        'Drastically reduced the size of the repository with sparse checkouts.',
        'Added a link to the plugin Discord.',
        'Updated the preset menu to use the imgui tabular API.',
        'Added the ability to use average SV targets for linear SV/SSF.',
        'Added a NONE option to final SV, which will omit the final SV/SSF no matter what.',
        'Added an alert when conflicting hotkeys are bound.',
    }

    showPatchNotesElement('v2.1.2', drawV211, 135, lc, bugFixes, newFeatures)
end
