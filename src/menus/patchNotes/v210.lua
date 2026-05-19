function showPatchNotesV210(lc, rc)
    local bugFixes = {
        'Fixed jump to TG crashing the plugin when not selecting anything.',
        'Fixed importing themes not working properly.',
        'Edit > Lint Map > Merge now merges all TGs simultaneously.',
        'Edit > Lint Map > Fix Flipped LNs now works on all notes in all TGs.',
        'Fixed custom theming tooltip being shown even when already in a custom theme.',
        'Added an option to disable the ko-fi message at the bottom of the info page.',
        'Fixed Still > Per Note Group forcefully overriding final SV.',
        'Added some hints to text inputs.',
        'Fixed niche bug where border color would become a table on hot-reload.',
        'Fixed interactive bezier guide lines not reaching the orbs.',
        'Slightly changed the color of the bezier blue orb.',
        'Set max displacement exponent supremum to 6.',
        'Fixed relative ratio throwing an error when changed.',
        'Fixed the draw function being in the plugin file twice.',
        "Added aster's theme to the theming menu.",
    }

    local newFeatures = {
        'Added a deviation parameter to all vibrato functions.',
        'Reworked theming, allowing you to save infinite custom themes.',
        'Added gradients to major version updates.',
        'Now uses displacement exponent supremum as the default.',
        'Added new buttons to the SV Point selector.',
        'Added the ability to clone and delete SVs from the Direct SV menu.',
    }

    local lightnessAdjust = (state.UnixTime % 2400) / 1200 * math.pi
    local colFn = |x| color.vrgbaToUint(color.hslaToRgba(x + 200, 1, math.sin(lightnessAdjust + x / 20) / 5 + 0.67, 1))

    showPatchNotesElement('v2.1.0', 134, {rect = {lc,rc}, colFn = colFn}, {bugFixes = bugFixes, newFeatures = newFeatures})
end
