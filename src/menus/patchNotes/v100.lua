function showPatchNotesV100(lc, rc)
    local bugFixes = {
        'Fix LN Ends feature now flips LN ends, even if the corresponding ending SV is 0.',
        'Allowed Still to treat LN ends as displacement markers.',
    }

    local newFeatures = {
        'Added the Select tab, which allows users to quickly select desired notes based on\na variety of conditions. Currently, there is the Alternate option and the Snap option.',
    }

        local hueDegreeAdjust = (state.UnixTime % 7200) / 20 + 67
    local colFn = |x| color.vrgbaToUint(color.hslaToRgba(x + hueDegreeAdjust, 1, 0.7, 1))

    showPatchNotesElement('v1.0.0', 135, {rect = {lc,rc}, colFn = colFn}, {bugFixes = bugFixes, newFeatures = newFeatures})
end
