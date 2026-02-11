function showStillsAndDisplacementTutorial()
    imgui.SeparatorText(("What are Still effects?"):obfuscate())

    imgui.TextWrapped(
        "So far, all effects have been done by selecting two notes with no notes between them. However, experienced SV mappers often select notes on a consistent beat (such as every 1/1 note). A naive approach would be to use the previous examples, but simply select two notes with notes in between them. This would produce a result such as the following:")
    gpsim("StillsAndDisplacementNaiveApproach", vctr2(1), function(t, idx)
        return t ^ 2 - (4 - idx) ^ 2 / 30
    end, { { 3, 4 }, { 2 }, { 3 }, { 1 } }, 500)
    imgui.TextColored(vctr4(0.8), "The above demonstrates a Standard > Linear 0x - 2x SV.")
    imgui.TextWrapped(
        'Notice how the notes are not the same distance from each other; this is because the SVs between the first two notes have a different average value than the SVs between the second two notes. To fix this, instead of using standard, we will use the "STILL" menu.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "STILL" under the "TYPE" dropdown.')
    if (globalVars.placeTypeIndex ~= 3) then return end
    imgui.TextWrapped(
        'The rest will be the same as before; simply input your desired parameters and click the "Place SVs between selected notes" button. This will make an effect where all notes have the same distance from each other:')
    gpsim("StillsAndDisplacementGoodApproach", vctr2(1), function(t)
        return t ^ 2
    end, { { 3, 4 }, { 2 }, { 3 }, { 1 } }, 500)
    imgui.TextWrapped(
        'You can adjust how far the notes are from each other by altering the "NOTE SPACING" setting. You can also change where the displacement "ends" by changing the "DISPLACEMENT" setting. Note that this is only useful when your average SV and your still note spacing are not equal.')
    imgui.TextColored(GUIDELINE_COLOR,
        "Try using the following settings and place these SVs between\ntwo 1/1 notes in a jumpstream (or any other dense pattern):")
    imgui.PushStyleColor(imgui_col.Text, GUIDELINE_COLOR)
    imgui.BulletText(("Still > Linear"):obfuscate())
    imgui.BulletText(("Still Spacing 1.00x"):obfuscate())
    imgui.BulletText('Displacement "END" 0.00msx')
    imgui.BulletText(("Start/End SV -1.5x to 1.5x"):obfuscate())
    imgui.PopStyleColor()
    imgui.TextWrapped("You should be able to produce a jumping effect with little issues.")
    ForceHeight(860)
end
