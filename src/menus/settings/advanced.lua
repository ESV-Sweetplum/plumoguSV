function showAdvancedSettings()
    GlobalCheckbox("hideAutomatic", "Hide Automatically Placed TGs",
        'Timing groups placed by the "Automatic" feature will not be shown in the plumoguSV timing group selector.')
    GlobalCheckbox("useEndTimeOffsets", "Use LN Ends As Offsets",
        "When true, LN ends will be considered as their own offsets, meaning you don't have to select two notes. All functions which rely on getting note offsets will now additionally include LN ends as their own offsets.")
    GlobalCheckbox("ignoreNotesOutsideTg", "Ignore Notes Not In Current Timing Group",
        "Notes that are in a timing group outside of the current one will be ignored by stills, selection checks, etc.")
    GlobalCheckbox("useMinDisplacementMultiplier", "Use Minimum Displacement Multiplier",
        "Uses the greatest minimum possible displacement multiplier throughout the whole map to ensure that copy-paste is possible while maintaining consistency.")
    if (globalVars.useMinDisplacementMultiplier) then
        imgui.BeginDisabled()
    end
    chooseMaxDisplacementMultiplierExponent()
    if (globalVars.useMinDisplacementMultiplier) then
        imgui.EndDisabled()
    end
end

function chooseMaxDisplacementMultiplierExponent()
    imgui.PushItemWidth(70)
    local oldMaxDisplacementMultiplierExponent = globalVars.maxDisplacementMultiplierExponent
    _, tempMaxDisplacementMultiplierExponent = imgui.SliderInt("Max Displacement Multiplier Exp.",
        oldMaxDisplacementMultiplierExponent, 0, 10)
    HoverToolTip(
        "plumoguSV designs pseudo-instantaneous movement via a very large SV immediately followed by a different SV. To ensure that the movement truly looks instantaneous, the distance between these two SVs is minimal (conventionally, 1/64th of a millisecond). However, as a map progresses over time, this distance is too small for the engine to handle due to floating point errors. This causes issues for SV mappers trying to copy a section from an early part of the map to a later part of a map, where the displacement distance needs to be larger. Lowering this number fixes that, at the cost of potential two-frame teleports during the rendering of the map. In specific, the denominator of the displacement distance (in ms) will be set to 2^{setting}, where ^ denotes exponentiation.")
    globalVars.maxDisplacementMultiplierExponent = math.clamp(tempMaxDisplacementMultiplierExponent, 0, 10)
    imgui.PopItemWidth()
    if (oldMaxDisplacementMultiplierExponent ~= globalVars.maxDisplacementMultiplierExponent) then
        write(globalVars)
    end
end
