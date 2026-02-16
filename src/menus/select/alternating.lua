function selectAlternatingMenu()
    local menuVars = getMenuVars('selectAlternating')
    BasicInputInt(menuVars, 'every', 'Note Period', { 1, MAX_SV_POINTS })
    BasicInputInt(menuVars, 'offset', 'Note Offset', { 1, menuVars.every })
    cache.saveTable('selectAlternatingMenu', menuVars)

    simpleActionMenu(
        'Select a note every ' ..
        menuVars.every .. pluralize(' note, from note #', menuVars.every, 5) .. menuVars.offset,
        2,
        selectAlternating, menuVars)
end
