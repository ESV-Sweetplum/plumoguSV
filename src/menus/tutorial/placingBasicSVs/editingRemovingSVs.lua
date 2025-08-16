function showEditingRemovingSVTutorial()
    imgui.SeparatorText("Directly Editing SVs")
    imgui.TextWrapped(
        "You may want to occasionally directly edit an SV value, without having to navigate through the slow scroll velocity editor. That's what the direct SV feature is for.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Make sure you\'re in the "EDIT" tab, then go to "DIRECT SV".\nSelect two notes, and if there are SVs between them,\nyou should be able to edit their start time and multiplier.')
    imgui.SeparatorText("Scaling SVs")
    imgui.TextWrapped(
        'Sometimes you want to change how fast an SV is, or increase the intensity of a 0.00x average SV effect. You can scale SVs in several different ways, but the easiest one is to use the "SCALE (MULTIPLY)" feature. For more advanced mappers, you can also use ymulch.')
    imgui.TextColored(GUIDELINE_COLOR,
        'Make sure you\'re in the "EDIT" tab, then go to "SCALE (MULTIPLY)".\nYou can either scale the notes to have a different average SV using\nthe "Average SV" mode, or you can multiply all SVs within your\nselection by a constant factor with the "Relative Ratio" mode.')
    imgui.SeparatorText("Deleting SVs")
    imgui.TextWrapped(
        "As with most things, deleting stuff is easier than creating it. Simply select two notes, and the delete tab will help you delete all desired objects within your selection range. You can also make a standard/special/still effect and the effect will remove any lingering SVs within its selection.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Go to the "DELETE" tab, and ensure that "Delete SVs" is enabled.\nThen, select two notes and click the "Delete" button.')
    imgui.SeparatorText("Reversing Effects")
    imgui.TextWrapped(
        'If you like upscroll, you can take any effect and turn it into upscroll using the "REVERSE SCROLL" feature under "EDIT". Generally, you should use 300-400 msx for your upscroll height, which is how much distance the "receptors" would be from the bottom.')
    imgui.TextColored(GUIDELINE_COLOR, 'Select an existing effect, and hit the "Reverse" button.')
    ForceHeight(540)
end
