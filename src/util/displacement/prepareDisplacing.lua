-- Adds a new displacing SV to a list of SVs to place and adds that SV time to a hash list
-- Parameters
--    svsToAdd               : list of displacing SVs to add to [Table]
--    svTimeIsAdded          : hash list indicating whether an SV time exists already [Table]
--    svTime                 : time to add the displacing SV at [Int/Float]
--    displacement           : amount that the SV will displace [Int/Float]
--    displacementMultiplier : displacement multiplier value [Int/Float]
function prepareDisplacingSV(svsToAdd, svTimeIsAdded, svTime, displacement, displacementMultiplier, hypothetical, svs)
    svTimeIsAdded[svTime] = true
    local currentSVMultiplier = game.get.svMultiplierAt(svTime)
    if hypothetical == true then
        currentSVMultiplier = getHypotheticalSVMultiplierAt(svs, svTime)
    end
    local newSVMultiplier = displacementMultiplier * displacement + currentSVMultiplier
    addSVToList(svsToAdd, svTime, newSVMultiplier, true)
end

-- Adds new displacing SVs to a list of SVs to place and adds removable SV times to another list
-- Parameters
--    offset             : general offset in milliseconds to displace SVs at [Int]
--    svsToAdd           : list of displacing SVs to add to [Table]
--    svTimeIsAdded      : hash list indicating whether an SV time exists already [Table]
--    beforeDisplacement : amount to displace before (nil value if not) [Int/Float]
--    atDisplacement     : amount to displace at (nil value if not) [Int/Float]
--    afterDisplacement  : amount to displace after (nil value if not) [Int/Float]
function prepareDisplacingSVs(offset, svsToAdd, svTimeIsAdded, beforeDisplacement, atDisplacement,
                              afterDisplacement, hypothetical, baseSVs)
    local displacementMultiplier = getUsableDisplacementMultiplier(offset)
    local duration = 1 / displacementMultiplier
    if beforeDisplacement then
        local timeBefore = offset - duration
        prepareDisplacingSV(svsToAdd, svTimeIsAdded, timeBefore, beforeDisplacement,
            displacementMultiplier, hypothetical, baseSVs)
    end
    if atDisplacement then
        local timeAt = offset
        prepareDisplacingSV(svsToAdd, svTimeIsAdded, timeAt, atDisplacement,
            displacementMultiplier, hypothetical, baseSVs)
    end
    if afterDisplacement then
        local timeAfter = offset + duration
        prepareDisplacingSV(svsToAdd, svTimeIsAdded, timeAfter, afterDisplacement,
            displacementMultiplier, hypothetical, baseSVs)
    end
end
