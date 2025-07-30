function game.getTimingPointAt(offset)
    local line = map.getTimingPointAt(offset)
    if line then return line end
    return { StartTime = -69420, Bpm = 42.69 }
end
