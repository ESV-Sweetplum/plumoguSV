function showWorkingWithShapesTutorial()
    imgui.SeparatorText("Working with different shapes")
    imgui.TextWrapped(
        'So far, we\'ve only been working with stutters, but the core of SV is being able to make cohesive and/or fluid movement. We do this by working with particular shapes in the "STANDARD" tab.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "STANDARD" under the "TYPE" dropdown.')
    if (globalVars.placeTypeIndex ~= 1) then return end
    imgui.Dummy(vector.New(0, 10))
    if (globalVars.hideSVInfo) then
        imgui.TextColored(INSTRUCTION_COLOR, 'Please disable the "HIDE SV INFO" option in settings to continue.')
        return
    end
    imgui.TextWrapped(
        'In the tab below the type dropdown, you\'ll notice a plethora of different options to choose from. Don\'t get overwhelmed; most experienced SV mappers usually limit themselves to using 3-5 of these shapes. Most commonly seen, we have the exponential shape, which makes the notes go towards the receptor at an exponential rate.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Under the "STANDARD" tab, select "EXPONENTIAL".')
    local menuVars = getMenuVars("placeStandard")
    if (menuVars.svTypeIndex ~= 2 and not state.GetValue("workingWithShapes_pg")) then return end
    imgui.Dummy(vector.New(0, 10))
    state.SetValue("workingWithShapes_pg", true)
    imgui.TextWrapped(
        "If you are unfamiliar with any of the SV shapes, the SV Info window will be your best friend. Behind the SV Info window is a slightly visible set of 4 notes, which show you (in advance) how the notes will move if you use this particular effect. Notice how if you change the intensity, the speed at which the notes decelerate increases, and vice versa. The SV Info visualizer is particularly noticable when you change a drastic part of the shape's behavior.")
    local settingVars = getSettingVars("Exponential", "Standard")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Change the exponential type to "SPEED UP", either via\nthe dropdown or by pressing "S" on your keyboard. Note that\nany parameter with a button next to it labelled "SWAP" or "S"\ncan be changed with this keybind. Hotkeys will be reviewed later.')
    if (settingVars.behaviorIndex ~= 2) then return end
    imgui.Dummy(vector.New(0, 10))

    imgui.TextWrapped(
        'Now, the SV Info visualizer is showing a more "rain drop" like appearance than a sudden approach. Feel free to experiment with all the shapes and see what you can come up with. Let\'s try making a fun bouncy effect using linear.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select the "LINEAR" shape. Set the start SV to -1.5x,\nand the end SV to 1.5x. Don\'t worry about SV points or final SV.')
    settingVars = getSettingVars("Linear", "Standard")
    ForceHeight(520)
    if (menuVars.svTypeIndex ~= 1 or math.abs(settingVars.startSV + 1.5) > 0.001 or math.abs(settingVars.endSV - 1.5) > 0.001) then return end
    ForceHeight(490)
    imgui.TextWrapped(
        "Take a look at the SV info window, and notice how the notes are jumping. This is exactly what the effect will look like when placed in game:")
    gpsim("Working With Shapes Jumping", vector2(1), function(t)
        return 0.9 - 2 * (t - t ^ 2)
    end, { { 1, 2, 3, 4 }, {}, {}, {} }, 500)
    imgui.TextColored(GUIDELINE_COLOR,
        'Select more than 2 chords (at least 3 notes with different times),\nand place the SV using an aforementioned method.')
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "If your notes are in different columns, you may have noticed that all the notes have combined into one large chord. Looking at the SV Info window, the reasoning becomes clear; the average SV is 0.00x, meaning the notes are always going to be next to each other. We can remedy this by adding a teleport to each set of notes, so they no longer line up with each other.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Head to the "EDIT" tab, select "ADD TELEPORT",\nthen select your notes and place the SV.')
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "Hopefully you should now have an effect that resembles individual jumping notes! You might recognize this effect from the old SV map PARTY. Now that you're more familiar with the SV info window and shapes, play around and see what you can make. Trial and error is the best way to learn SV.")
    ForceHeight(1010)
end
