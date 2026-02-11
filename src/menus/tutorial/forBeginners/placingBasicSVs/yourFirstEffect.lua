function showYourFirstEffectTutorial()
    imgui.SeparatorText(("Making your first SV effect"):obfuscate())
    imgui.TextWrapped(
        "At the absolute basics of SV are the pulse effects, effects that highlight significant parts of the song, such as a repeating drum. We will apply a very basic stutter SV effect on the drum beat (assuming your song has that), like so:")

    gpsim("Your First Effect Stutter Example", vctr2(1), function(t)
        if (t < 0.05) then
            return 4 * t
        elseif (t < 0.25) then
            return 0.25 * t + 0.19
        else
            return t
        end
    end, { { 1, 2 }, { 3 }, { 4 }, { 3 } }, 500)

    imgui.TextWrapped(
        'To implement this effect, we will need to create some SV. Head to the CREATE tab in your plugin, and locate the dropdown with the word "TYPE" next to it.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "SPECIAL" under the "TYPE" dropdown. The tutorial will\ncontinue when you\'ve done so. In the future, all tutorials will go to\nthe next step when the instructions in RED TEXT are completed.')
    if (globalVars.placeTypeIndex ~= 2) then return end
    imgui.TextColored(INSTRUCTION_COLOR,
        'Now, under the "SPECIAL" tab, make sure "STUTTER" is selected.')
    local menuVars = getMenuVars("placeSpecial")
    if (menuVars.svTypeIndex ~= 1) then return end
    local settingVars = getSettingVars("Stutter", "Special")
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "We want to edit the value of the first SV, and the second SV will be updated accordingly. Note that the default SV for a map is 1x, so we will leave average SV on 1x.")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Set the SV value to 4.00x by clicking on the input and inputting "4".')
    ForceHeight(480)
    if (settingVars.startSV ~= 4) then return end
    ForceHeight(440)
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        'At any time, you can see what your SVs will look like in the "SV INFO" window. Looking inside, we notice one of our SVs is negative. This is because of the relatively large SV we just put in, 4. To counter this, we have two options; either let the second SV be negative, or change how long the first SV lasts. Try playing around with the "Duration" slider.')
    imgui.TextColored(INSTRUCTION_COLOR,
        "Set the duration to be 20%%. Either drag the slider along,\nor hold Ctrl and click to edit the slider directly.")
    ForceHeight(610)
    if (settingVars.stutterDuration ~= 20) then return end
    ForceHeight(570)
    imgui.TextColored(vctr4(0), "penis")
    imgui.TextWrapped(
        'If you want, you can change some of the other settings; try seeing what happens when you increase the stutter count. However, for the sake of this tutorial, you are done.')
    imgui.TextColored(GUIDELINE_COLOR,
        'Now, select a note representing a strong sound, and\nthe note after it. Either hit the "T" button, or click\nthe "Place SVs between selected notes" button.')
    ForceHeight(720)
end
