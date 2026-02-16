function selectBySnapMenu()
    local menuVars = getMenuVars('selectBySnap')
    BasicInputInt(menuVars, 'snap', 'Snap', { 1, 100 })
    cache.saveTable('selectBySnapMenu', menuVars)

    simpleActionMenu(
        'Select notes with 1/' .. menuVars.snap .. ' snap',
        2,
        selectBySnap, menuVars)
end
