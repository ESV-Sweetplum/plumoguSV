function lintMapMenu()
    simpleActionMenu("Align timing lines in this region", 0, alignTimingLines, nil, false, true)
    HoverToolTip(
        "Sometimes, due to rounding errors with BPMs, timing lines don't show up where 1/1 snapped notes should be. This will fix that within the entire timing line region you are currently in.")
    AddSeparator()
    simpleActionMenu("Fix flipped LN ends", 0, fixFlippedLNEnds, nil, false, true)
    HoverToolTip(
        "If there is a negative SV at an LN end, the LN end will be flipped. This is noticable especially for arrow skins and is jarring. This tool will fix that.")
    AddSeparator()
    simpleActionMenu("Merge duplicate SVs", 0, mergeSVs, nil, false, true)
    simpleActionMenu("Merge duplicate SSFs", 0, mergeSSFs, nil, false, true)
    simpleActionMenu("Remove unnecessary SVs", 0, removeUnnecessarySVs, nil, false, true)
    simpleActionMenu("Remove duplicate notes", 0, mergeNotes, nil, false, true)
end
