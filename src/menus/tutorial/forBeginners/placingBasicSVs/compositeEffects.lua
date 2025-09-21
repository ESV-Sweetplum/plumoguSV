function showCompositeEffectsTutorial()
    imgui.SeparatorText("Exponential Composition")
    imgui.TextWrapped(
        "All of the previous effects we've seen have been done with just one effect; no changing settings, no different shapes. However, mixing and matching these different effects is what will make your SV map truly unique.")

    gpsim("DoubleExpoExample", vctr2(1), function(t, idx)
        return 2 * (t - 0.5) ^ 3 + 0.5 + t / 2
    end, { { 1, 2 }, {}, { 3, 4 }, {} }, 500)
end
