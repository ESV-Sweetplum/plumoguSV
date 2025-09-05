require("packages.cache.initialize.priority")

---Returns true every `interval` ms.
---@param id string The unique identifier of the clock.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.listen(id, interval)
    local currentTime = state
        .UnixTime -- Avoid calling state global multiple times, which causes a heavy load on performance
    local prevTime = cache.clock[id]
    if (not prevTime) then
        cache.clock[id] = currentTime
        prevTime = currentTime
    end
    if (currentTime - prevTime > interval) then
        cache.clock[id] = currentTime
        return true
    end

    return false
end

---A temporary clock that can be called multiple times. Should only be used for testing/debugging.
---@param interval integer The interval at which the clock should run.
---@return boolean ev True if the clock has reached its interval time.
function clock.temp(interval)
    tempClockCount = tempClockCount + 1
    return clock.listen("temporary" .. tempClockCount, interval)
end
