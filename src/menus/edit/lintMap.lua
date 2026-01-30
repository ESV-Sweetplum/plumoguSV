function lintMapMenu()
    simpleActionMenu("Align timing lines in this region", 0, alignTimingLines, nil, true, true)
    HoverToolTip(
        "Sometimes, due to rounding errors with BPMs, timing lines don't show up where 1/1 snapped notes should be. This will fix that within the entire timing line region you are currently in.")
    simpleActionMenu("Fix flipped LN ends", 0, fixFlippedLNEnds, nil, false, true)
    HoverToolTip(
        "If there is a negative SV at an LN end, the LN end will be flipped. This is noticable especially for arrow skins and is jarring. This tool will fix that.")
    simpleActionMenu("Merge duplicate SVs/SSFs", 0, mergeSVsAndSSFs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) removes SVs/SSFs that are on the same time as others within their timing group. Note that Quaver always renders the second SV/SSF in the internal SV/SSF list, and this tool will only ever remove the first duplicate SV/SSF, so nothing in the map should change. If something does change, please message @kvrosakura on Discord with the map.")
    simpleActionMenu("Remove unnecessary SVs/SSFs", 0, removeUnnecessarySVsAndSSFs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) If two consecutive SVs have the same multiplier, removes the second SV. If three consecutive SSFs have the same multiplier, removes the middle SSF.")
    simpleActionMenu("Remove SVs/SSFs after all TG notes", 0, removePostTGSVsAndSSFs, nil, false, true)
    HoverToolTip(
        "(DOESN'T VISUALLY AFFECT MAP) (ONLY APPLY AFTER MAP IS FINISHED) For all TGs, removes all SVs/SSFs after the last note and places a teleport in their place (except for the default and global groups).")
    simpleActionMenu("Remove duplicate notes", 0, mergeNotes, nil, false, true)
    HoverToolTip("Removes stacked notes.")
    simpleActionMenu("Remove all hitsounds in selection", 0, removeAllHitSounds, nil, true, true)
    HoverToolTip("Self-explanatory.")
    -- simpleActionMenu("DO IT ALLLLL", 0, DOITALL, nil, false, true)
    -- HoverToolTip("RAHHHHHH")
end
