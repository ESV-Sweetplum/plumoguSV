-- Adds the final SV to the "svsToAdd" list if there isn't an SV at the end offset already
-- Parameters
--    svsToAdd     : list of SVs to add [Table]
--    endOffset    : millisecond time of the final SV [Int]
--    svMultiplier : the final SV's multiplier [Int/Float]
function addFinalSV(svsToAdd, endOffset, svMultiplier, force)
    local sv = map.GetScrollVelocityAt(endOffset)
    local svExistsAtEndOffset = sv and (sv.StartTime == endOffset)
    if svExistsAtEndOffset and not force then return end

    addSVToList(svsToAdd, endOffset, svMultiplier, true)
end

function addFinalSSF(ssfsToAdd, endOffset, ssfMultiplier, force)
    local ssf = map.GetScrollSpeedFactorAt(endOffset)
    local ssfExistsAtEndOffset = ssf and (ssf.StartTime == endOffset)
    if ssfExistsAtEndOffset and not force then return end

    addSSFToList(ssfsToAdd, endOffset, ssfMultiplier, true)
end

function addInitialSSF(ssfsToAdd, startOffset)
    local ssf = map.GetScrollSpeedFactorAt(startOffset)
    if (ssf == nil) then return end
    local ssfExistsAtStartOffset = ssf and (ssf.StartTime == startOffset)
    if ssfExistsAtStartOffset then return end

    addSSFToList(ssfsToAdd, startOffset, ssf.Multiplier, true)
end

-- Adds an SV with the start offset into the list if there isn't an SV there already
-- Parameters
--    svs         : list of SVs [Table]
--    startOffset : start offset in milliseconds for the list of SVs [Int]
function addStartSVIfMissing(svs, startOffset)
    if #svs ~= 0 and svs[1].StartTime == startOffset then return end
    addSVToList(svs, startOffset, game.getSVMultiplierAt(startOffset), false)
end

-- Creates and adds a new SV to an existing list of SVs
-- Parameters
--    svList     : list of SVs [Table]
--    offset     : offset in milliseconds for the new SV [Int/Float]
--    multiplier : multiplier for the new SV [Int/Float]
--    endOfList  : whether or not to add the SV to the end of the list (else, the front) [Boolean]
function addSVToList(svList, offset, multiplier, endOfList)
    local newSV = createSV(offset, multiplier)
    if endOfList then
        table.insert(svList, newSV)
        return
    end
    table.insert(svList, 1, newSV)
end

function addSSFToList(ssfList, offset, multiplier, endOfList)
    local newSSF = createSSF(offset, multiplier)
    if endOfList then
        table.insert(ssfList, newSSF)
        return
    end
    table.insert(ssfList, 1, newSSF)
end
