function swapNotesMenu()
    imgui.TextWrapped("Doesn't swap note temporal positions; instead, swaps their spatial positions with two displaces.")
    simpleActionMenu('Swap selected notes using SVs', 2, swapNoteSVs, nil)
end
