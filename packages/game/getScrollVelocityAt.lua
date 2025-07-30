function game.getSVStartTimeAt(offset)
    local sv = map.GetScrollVelocityAt(offset)
    if sv then return sv.StartTime end
    return -1
end

function game.getSVMultiplierAt(offset)
    local sv = map.GetScrollVelocityAt(offset)
    if sv then return sv.Multiplier end
    if (map.InitialScrollVelocity == 0) then return 1 end
    return map.InitialScrollVelocity or 1
end
