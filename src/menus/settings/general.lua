function showGeneralSettings()
    GlobalCheckbox("performanceMode", "Enable Performance Mode",
        "Disables some visual enhancement to boost performance.")
    GlobalCheckbox("advancedMode", "Enable Advanced Mode",
        "Advanced mode enables a few features that simplify SV creation, at the cost of making the plugin more cluttered.")
    GlobalCheckbox("disableKofiMessage", "Disable Ko-Fi Message",
        "Removes the text at the bottom of the 'Info' section requesting a donation.")
    AddSeparator()
    chooseUpscroll()
    AddSeparator()
    GlobalCheckbox("dontReplaceSV", "Don't Replace Existing SVs",
        "Self-explanatory, but applies only to base SVs made with Standard, Special, or Still. Highly recommended to keep this setting disabled.")
    chooseStepSize()
    GlobalCheckbox("dontPrintCreation", "Don't Print SV Creation Messages",
        'Disables printing "Created __ SVs" messages.')
    GlobalCheckbox("equalizeLinear", "Equalize Linear SV",
        "Forces the standard > linear option to have an average sv of 0 if the start and end SVs are equal. For beginners, this should be enabled.")
    GlobalCheckbox("restrictSinusoidalPeriod", "Restrict Sinusoidal Period",
        "If true, restricts the sinusoidal period shift parameter to be the nearest 4th.")
    GlobalCheckbox("comboizeSelect", "Select Using Already Selected Notes",
        "Changes the behavior of the SELECT tab to select notes that are already selected, instead of all notes between the start/end selection.")
    GlobalCheckbox("printLegacyLNMessage", "Print Legacy LN Recommendation",
        "When true, prints a warning to enable legacy LN when the following conditions are met:\n1. Legacy LN Rendering is currently turned off.\n2: When placing stills, or using certain features that can displace, such as flicker, displace note, and displace view.")
end

function chooseUpscroll()
    local oldUpscroll = globalVars.upscroll
    globalVars.upscroll = RadioButtons("Scroll Direction:", globalVars.upscroll, { "Down", "Up" }, { false, true },
        "Orientation for distance graphs and visuals.")
    if (oldUpscroll ~= globalVars.upscroll) then
        write(globalVars)
    end
end

function chooseStepSize()
    imgui.PushItemWidth(40)
    local oldStepSize = globalVars.stepSize
    local _, tempStepSize = imgui.InputFloat(("Exponential Intensity Step Size"):obfuscate(), oldStepSize, 0, 0, "%.0f%%")
    HoverToolTip(
        "Changes what the exponential intensity slider will round the nearest to. Recommended to keep this as a factor of 100 (1, 2, 5, 10, etc).")
    globalVars.stepSize = math.clamp(tempStepSize, 1, 100)
    imgui.PopItemWidth()
    if (oldStepSize ~= globalVars.stepSize) then
        write(globalVars)
    end
end
