function lintMapMenu()
    simpleActionMenu("Align timing lines in this region", 0, alignTimingLines, nil, true, true)
    HoverToolTip(
        "Sometimes, due to rounding errors with BPMs, timing lines don't show up where 1/1 snapped notes should be. This will fix that within the entire timing line region you are currently in.")
    AddSeparator()
    simpleActionMenu("Fix flipped LN ends", 0, fixFlippedLNEnds, nil, true, true)
    HoverToolTip(
        "If there is a negative SV at an LN end, the LN end will be flipped. This is noticable especially for arrow skins and is jarring. This tool will fix that.")
    simpleActionMenu("Merge duplicate SVs", 0, mergeSVs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) removes SVs that are on the same time as others. Note that Quaver always renders the second SV in the internal SV list, and this tool will only ever remove the first duplicate SV, so nothing in the map should change. If something does change, please message @kvrosakura on Discord with the map.")
    simpleActionMenu("Merge duplicate SSFs", 0, mergeSSFs, nil, true, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) removes SSFs that are on the same time as others. Note that Quaver always renders the second SSF in the internal SSF list, and this tool will only ever remove the first duplicate SSF, so nothing in the map should change. If something does change, please message @kvrosakura on Discord with the map.")
    simpleActionMenu("Remove unnecessary SVs", 0, removeUnnecessarySVs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) If two consecutive SVs have the same multiplier, removes the second SV.")
    simpleActionMenu("Remove duplicate notes", 0, mergeNotes, nil, true, true)
    HoverToolTip("Removes stacked notes.")
    simpleActionMenu("Remove all hitsounds", 0, removeAllHitSounds, nil, true, true)
    HoverToolTip("Self-explanatory.")
end
