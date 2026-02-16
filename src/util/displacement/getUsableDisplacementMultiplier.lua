-- Returns a usable displacement multiplier for a given offset [Int/Float]
--
-- Current implementation:
-- ...
-- 64 until 2^18 = 262144 ms ~4.3 min, then —>
-- 32 until 2^19 = 524288 ms ~8.7 min, then —>
-- 16 until 2^20 = 1048576 ms ~17.4 min, then —>
-- 8 until 2^21 = 2097152 ms ~34.9 min, then —>
-- 4 until 2^22 = 4194304 ms ~69.9 min, then —>
-- 2 until 2^23 = 8388608 ms ~139.8 min, then —> 1
--
-- Parameters
--    offset: time in milliseconds [Int]
function getUsableDisplacementMultiplier(offset)
    local exponent
    if (globalVars.useMinDisplacementMultiplier) then
        if (not cache.displacementExponent) then
            initializeDisplacementExponentCache()
        end
        return 2 ^ cache.displacementExponent
    else
        exponent = math.clamp(23 - math.floor(math.log(math.abs(offset) + 1, 2)), 0,
            globalVars.maxDisplacementMultiplierExponent)
        return 2 ^ exponent
    end
end

function initializeDisplacementExponentCache()
    cache.displacementExponent = math.clamp(23 - math.floor(math.log(math.abs(map.TrackLength) + 1, 2)), 0, 6)
end
