function showYourSecondEffectTutorial()
    imgui.SeparatorText("Making your second SV effect")
    imgui.TextWrapped(
        "Stutters are cool and all, but there's another type of stutter that's more versatile: teleport stutters. Usually, these would not be possible in engines like osu, but since Quaver has no limitations on SV size, we can do it here. Take a look at the difference between normal stutter and teleport stutter:")

    imgui.Dummy(vector.New(0, 10))
    imgui.SetCursorPosX(40)
    gpsim("Your Second Effect Stutter Example", vctr2(0.5), function(t)
        local highT = math.frac(t * 4)
        local reductionIdx = math.floor(t * 4)

        if (highT < 0.05) then
            return highT + reductionIdx / 4
        elseif (highT < 0.25) then
            return 0.05 + reductionIdx / 4
        else
            return (highT + reductionIdx) / 4
        end
    end, { { 1, 2 }, { 3 }, { 4 }, { 3 } }, 4000, true)
    KeepSameLine()
    imgui.SetCursorPosX(200)
    gpsim("Your Second Effect Teleport Stutter Example", vctr2(0.5), function(t)
        local highT = math.frac(t * 4)
        local reductionIdx = math.floor(t * 4)

        return (0.5 * highT + 0.5 + reductionIdx) / 4
    end, { { 1, 2 }, { 3 }, { 4 }, { 3 } }, 4000, true)
    imgui.Dummy(vector.New(0, 10))
    imgui.TextWrapped(
        "Notice how on the left, the stutter makes the notes visibly move down, but on the right, the teleport stutter (for self-explanatory reasons) makes the notes teleport. Let's try using teleport stutter now.")
    imgui.TextColored(INSTRUCTION_COLOR,
        'Select "SPECIAL" under the "TYPE" dropdown.')
    if (globalVars.placeTypeIndex ~= 2) then return end
    imgui.TextColored(INSTRUCTION_COLOR,
        'Now, under the "SPECIAL" tab, make sure that the effect\n"TELEPORT STUTTER" is selected.')
    local menuVars = getMenuVars("placeSpecial")
    if (menuVars.svTypeIndex ~= 2) then return end
    imgui.TextWrapped(
        "Teleport Stutter differs from normal stutter, in that you don't control the speed at which the note moves, but rather how far down the note teleports. For example, if your start SV is 75%%, then your note will start 75%% of the way down. If you want the note to land on the receptor, you must make the start SV %% (in decimal form, not percent) and the main SV add up to the average SV.")
    imgui.TextColored(INSTRUCTION_COLOR,
        "Set the main SV to 0.2x. Then, set the start SV %% to be the\npercentage required to have the notes land on the receptor.\nHINT: 1.00x - 0.20x = ??%%")
    local settingVars = getSettingVars("Teleport Stutter", "Special")
    ForceHeight(490)
    if (not settingVars.linearlyChange and (math.abs(settingVars.mainSV - 0.2) > 0.001 or settingVars.svPercent ~= 80)) then return end
    ForceHeight(450)
    imgui.TextColored(GUIDELINE_COLOR,
        'Similarly, select a note representing a strong sound, and\nthe note after it. Either hit the "T" button on your keyboard or click\nthe "Place SVs between selected notes" button. Alternatively,\nyou can try selecting all the notes which you want to have SV.')
    imgui.SeparatorText("Experimenting with Teleport Stutter")
    imgui.TextWrapped(
        'It would be kind of boring if the teleport stutter remained the same throughout. You can adjust how the teleport stutter acts over time by enabling the "Change Stutter Over Time" option.')
    imgui.TextColored(INSTRUCTION_COLOR,
        'Enable "Change Stutter Over Time".')
    ForceHeight(640)
    if (not settingVars.linearlyChange) then return end
    ForceHeight(610)
    imgui.TextWrapped(
        "You\'ll now notice that we have two options for both start SV %% and main SV value; one for start, and one for end. The way this works is that when you select more than two notes (obviously with different times), the teleport stutter for that note will change linearly according to the start/end values. For example, if your start SV %% (start) is 100%%, and your start SV %% (end) is 0%%, then a note in the very middle of your selection would have a teleport stutter with start SV %% of 50%%. We will use this to create some dynamic effects.")
    imgui.TextColored(INSTRUCTION_COLOR,
        "Set the Start SV %% (start) to 100%%, the main SV (start) to 0.00x,\nand main SV (end) to whichever value it must be such that the\nnote lines up with the receptor. HINT: 0%% + ?.??x = 1.00x")
    ForceHeight(820)
    if (math.abs(settingVars.mainSV) > 0.001 or math.abs(settingVars.mainSV2 - 1) > 0.001 or settingVars.svPercent ~= 100 or settingVars.svPercent2 ~= 0) then return end
    ForceHeight(800)
    imgui.TextWrapped(
        "What we have set up here is a teleport stutter that initially has a very strong teleporting strength (start SV 100%%, main SV 0.00x, so the notes don't appear to move at all) to an extremely weak strength (start SV 0%%, main SV 1.00x, so it's as if they haven't even teleported). All of the notes between will lie somewhere within its boundary.")
    imgui.TextColored(GUIDELINE_COLOR,
        'Select a large group of notes and either hit the "T" button on\nyour keyboard or click the Place SV button.')
    ForceHeight(920)
    imgui.TextWrapped(
        "Now that you're hopefully feeling familiar with teleport stutter, try playing around with some of the parameters. Here are some ideas to try. All the effects below will be presented as a list of four numbers, where the first two are the start SV %% (start and end), while the last two are the main SV (start and end).")
    imgui.BulletText("0%%, 100%%, 1.00x, 0.00x")
    imgui.BulletText("100%%, 100%%, -1.00x, 0.00x")
    imgui.BulletText("100%%, 0%%, -1.00x, 1.00x")
    imgui.TextWrapped("Fun fact: the above effect is used in the popular SV map Hypnotizer.")
    ForceHeight(1120)
end
