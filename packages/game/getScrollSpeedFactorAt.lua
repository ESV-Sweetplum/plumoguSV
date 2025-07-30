function getSSFStartTimeAt(offset, tgId)
    local sv = map.GetScrollSpeedFactorAt(offset, tgId)
    if sv then return sv.StartTime end
    return -1
end

function getSSFMultiplierAt(offset)
    local ssf = map.GetScrollSpeedFactorAt(offset)
    if ssf then return ssf.Multiplier end
    return 1
end
