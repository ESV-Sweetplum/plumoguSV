function splitMenu()
    local menuVars = getMenuVars("split")
    menuVars.modeIndex = Combo("Split Mode", SPLIT_MODES, menuVars.modeIndex, nil, nil, {
        "Split notes via column; either with individual TGs or a certain transformation of such columns.",
        "Split notes via time; each time has its own TG.",
        "Split all notes into their own TG regardless of any properties they have."
    })

    cache.saveTable("splitMenu", menuVars)

    simpleActionMenu("Split selected notes into TGs", 1, splitNotes, menuVars, false)
end
