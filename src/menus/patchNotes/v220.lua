function showPatchNotesV220(lc, rc)
    local bugFixes = {
        'Fixed the preset menu incorerctly rendering.',
        'Fixed the preset menu being unable to receive negative numbers.',
        'Fixed recompilation bug with the aho-corasick algorithm.',
        'Now correctly seeds the math module to ensure purely random results.',
        'Fixed the dust trail being entirely white.',
        'Fixed the plugin executing actions accidentally while an input is being edited.',
        'Fixed some custom theme parameters not correctly saving.',
        'Fixed some tabs not being openable when the preset menu was opened.',
        'Fixed scientific notation not being supported in the table parser.',
        'Fixed several hot-reload fails due to nonexistent globals.',
        'Updated timing group listener to correctly listen to batch arguments.',
    }

    local newFeatures = {
        'Added an error protector against faulty table parse attempts.',
        'Drastically reduced the size of the repository with sparse checkouts.',
        'Added a link to the plugin Discord.',
        'Updated the preset menu to use the imgui tabular API.',
        'Added the ability to use average SV targets for linear SV/SSF.',
        'Added a NONE option to final SV, which will omit the final SV/SSF no matter what.',
        'Added an alert when conflicting hotkeys are bound.',
        'Updated the keybinds settings menu to be more organized.',
        'Added the ability to have preset keybinds.',
        "Added capybara mode for those who don't make SV.",
    }

    local devUpdates = {
        'Moved the entire plugin over to Luaver2.',
        'Migrated from TypeScript 5 to TypeScript 6.',
        'Introduced several new packages to facilitate string processors.',
        'Moved packages folder to separate qua specific submodule.',
        'Changed a bit of naming to make things more clear.',
        'Finalized QParcel submodule.',
    }

    local lightnessAdjust = (state.UnixTime % 2400) / 1200 * math.pi
    local colFn = |x| color.vrgbaToUint(color.hslaToRgba(x + 200, 1, math.sin(lightnessAdjust + x / 20) / 5 + 0.67, 1))

    showPatchNotesElement('v2.2.0', 144, {rect = {lc,rc}, colFn = colFn}, {bugFixes = bugFixes, newFeatures = newFeatures, devUpdates = devUpdates})
end