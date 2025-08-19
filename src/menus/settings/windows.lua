function showWindowSettings()
    GlobalCheckbox("hideSVInfo", "Hide SV Info Window",
        "Disables the window that shows note distances when placing Standard, Special, or Still SVs.")
    if (globalVars.performanceMode) then
        imgui.TextColored(vector.New(1, 0, 0, 1),
            "Performance mode is currently enabled.\nPlease disable it to access widgets and windows.")
        imgui.BeginDisabled()
    end
    if (globalVars.hideSVInfo) then imgui.BeginDisabled() end
    GlobalCheckbox("showSVInfoVisualizer", "Show SV Info Visualizer",
        "Enables a visualizer behind the SV info window that shows the general movement of the notes.")
    if (globalVars.hideSVInfo) then imgui.EndDisabled() end
    GlobalCheckbox("showVibratoWidget", "Separate Vibrato Into New Window",
        "For those who are used to having Vibrato as a separate plugin, this option makes a new, independent window with vibrato only.")
    AddSeparator()
    GlobalCheckbox("showNoteDataWidget", "Show Note Data Of Selection",
        "If one note is selected, shows simple data about that note.")
    GlobalCheckbox("showMeasureDataWidget", "Show Measure Data Of Selection",
        "If two notes are selected, shows measure data within the selected region.")
    if (globalVars.performanceMode) then
        imgui.EndDisabled()
    end
end
