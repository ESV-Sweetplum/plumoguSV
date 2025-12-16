function showAdvancedSettings()
    GlobalCheckbox("hideAutomatic", "Hide Automatically Placed TGs",
        'Timing groups placed by the "Automatic" feature will not be shown in the plumoguSV timing group selector.')
    GlobalCheckbox("useEndTimeOffsets", "Use LN Ends As Offsets",
        "When true, LN ends will be considered as their own offsets, meaning you don't have to select two notes. All functions which rely on getting note offsets will now additionally include LN ends as their own offsets.")
    GlobalCheckbox("ignoreNotesOutsideTg", "Ignore Notes Not In Current Timing Group",
        "Notes that are in a timing group outside of the current one will be ignored by stills, selection checks, etc.")
    chooseMaxDisplacementMultiplierExponent()
end

function chooseMaxDisplacementMultiplierExponent()
    imgui.PushItemWidth(70)
    local oldMaxDisplacementMultiplierExponent = globalVars.maxDisplacementMultiplierExponent
    _, tempMaxDisplacementMultiplierExponent = imgui.SliderInt("Max Displacement Multiplier Exp.",
        oldMaxDisplacementMultiplierExponent, 0, 10)
    HoverToolTip(
    "plumoguSV designs pseudo-instantaneous movement via a very large SV immediately followed by a different SV. ")
    globalVars.maxDisplacementMultiplierExponent = math.clamp(tempMaxDisplacementMultiplierExponent, 0, 10)
    imgui.PopItemWidth()
    if (oldMaxDisplacementMultiplierExponent ~= globalVars.maxDisplacementMultiplierExponent) then
        write(globalVars)
    end
end
