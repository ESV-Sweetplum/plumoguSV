-- Creates and returns a frameTime object [Table]
-- Parameters
--    thisTime     : time in milliseconds [Int]
--    thisLanes    : note lanes [Table]
--    thisFrame    : frame number [Int]
--    thisPosition : msx position (height) on the frame [Int/Float]
function createFrameTime(thisTime, thisLanes, thisFrame, thisPosition)
    local frameTime = {
        time = thisTime,
        lanes = thisLanes,
        frame = thisFrame,
        position = thisPosition,
    }
    return frameTime
end
