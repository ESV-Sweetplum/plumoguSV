function splitMenu()
    local menuVars = getMenuVars('split')

    splitSettingsMenu(menuVars)
    cache.saveTable('splitMenu', menuVars)

    simpleActionMenu('Split selected notes into TGs', 1, splitNotes, menuVars, false)
end

function splitSettingsMenu(menuVars)
    menuVars.modeIndex = Combo('Split Mode', SPLIT_MODES, menuVars.modeIndex, nil, nil, {
        'Split notes via column; either with individual TGs or a certain transformation of such columns.',
        'Split notes via time; each time has its own TG.',
        'Split all notes into their own TG regardless of any properties they have.',
    })

    BasicCheckbox(menuVars, 'cloneSVs', 'Clone SVs?',
        'If enabled, each note will clone the SVs around it in the current timing group.')
    if (menuVars.cloneSVs) then
        BasicInputInt(menuVars, 'cloneRadius', 'Clone Radius', { 0, 69420 },
            'SVs that are further than THIS amount of ms away will be ignored.')
    end
end
