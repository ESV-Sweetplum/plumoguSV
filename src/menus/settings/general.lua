function showGeneralSettings()
    GlobalCheckbox("performanceMode", "Enable Performance Mode",
        "Disables some visual enhancement to boost performance.")
    GlobalCheckbox("advancedMode", "Enable Advanced Mode",
        "Advanced mode enables a few features that simplify SV creation, at the cost of making the plugin more cluttered.")
    if (not globalVars.advancedMode) then imgui.BeginDisabled() end
    GlobalCheckbox("hideAutomatic", "Hide Automatically Placed TGs",
        'Timing groups placed by the "Automatic" feature will not be shown in the plumoguSV timing group selector.')
    if (not globalVars.advancedMode) then imgui.EndDisabled() end
    AddSeparator()
    chooseUpscroll()
    AddSeparator()
    GlobalCheckbox("dontReplaceSV", "Don't Replace Existing SVs",
        "Self-explanatory, but applies only to base SVs made with Standard, Special, or Still. Highly recommended to keep this setting disabled.")
    GlobalCheckbox("ignoreNotesOutsideTg", "Ignore Notes Not In Current Timing Group",
        "Notes that are in a timing group outside of the current one will be ignored by stills, selection checks, etc.")
    chooseStepSize()
    GlobalCheckbox("dontPrintCreation", "Don't Print SV Creation Messages",
        'Disables printing "Created __ SVs" messages.')
    GlobalCheckbox("equalizeLinear", "Equalize Linear SV",
        "Forces the standard > linear option to have an average sv of 0 if the start and end SVs are equal. For beginners, this should be enabled.")
    GlobalCheckbox("comboizeSelect", "Select Using Already Selected Notes",
        "Changes the behavior of the SELECT tab to select notes that are already selected, instead of all notes between the start/end selection.")
    GlobalCheckbox("useEndTimeOffsets", "Use LN Ends As Offsets",
        "When true, LN ends will be considered as their own offsets, meaning you don't have to select two notes. All functions which rely on getting note offsets will now additionally include LN ends as their own offsets.")
    GlobalCheckbox("printLegacyLNMessage", "Print Legacy LN Recommendation",
        "When true, prints a warning to enable legacy LN when the following conditions are met:\n1. Legacy LN Rendering is currently turned off.\n2: When placing stills, or using certain features that can displace, such as flicker, displace note, and displace view.")
end

function chooseUpscroll()
    local oldUpscroll = globalVars.upscroll
    globalVars.upscroll = RadioButtons("Scroll Direction:", globalVars.upscroll, { "Down", "Up" }, { false, true },
        "Orientation for distance graphs and visuals")
    if (oldUpscroll ~= globalVars.upscroll) then
        write(globalVars)
    end
end
