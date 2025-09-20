function clock.getTime()
    return (state.UnixTime - clock.prevTime) / 1000
end
