-- Taken from [kusa's BeatSnapColorOverride plugin](https://github.com/Illuminati-CRAZ/BeatSnapColorOverride), with minor changes to integrate into this codebase. All credits go to them. All credits go to them.
-- The function below is licensed under the MIT license. All other functions in this file retain the same license as plumoguSV.
function kusaGeneralColor(n)
    if (not truthy(state.SelectedHitObjects)) then
        print('e!', 'You are not selecting any notes.')
        return false
    end

    local starttimes = game.get.uniqueSelectedNoteOffsets()

    --Timing point influencing beat snap color will be placed using builtin displacement exponent.
    SNAP_INTERVAL = math.max(1 / 8, 16 / getUsableDisplacementMultiplier(math.max(table.unpack(starttimes))))
    --Timing point returning timing to "normal" will be placed using builtin displacement exponent.
    NORMAL_INTERVAL = SNAP_INTERVAL
    BIG_NUMBER = 60000 / SNAP_INTERVAL --60k beats per minutes = 1k beats per second = 1 beat per ms

    local thisTl = game.get.timingPointAt(state.SongTime)
    local bpm = thisTl.Bpm
    local signature = thisTl.Signature

    local snaptimingpoints = {}
    local normaltimingpoints = {}
    local currenttimingpoints = {}

    for _, starttime in pairs(starttimes) do
        --remove timing points within time interval of new timing points
        for _, tp in pairs(map.TimingPoints) do
            if starttime - SNAP_INTERVAL <= tp.StartTime and tp.StartTime <= starttime + NORMAL_INTERVAL then
                table.insert(currenttimingpoints, tp)
            end

            if tp.StartTime > starttime + NORMAL_INTERVAL then break end
        end

        if (n == 1) then
            table.insert(snaptimingpoints, utils.CreateTimingPoint(starttime, bpm, signature, false))
        else
            table.insert(snaptimingpoints,
                utils.CreateTimingPoint(starttime - SNAP_INTERVAL, BIG_NUMBER / n, signature, true))
            table.insert(normaltimingpoints,
                utils.CreateTimingPoint(starttime + NORMAL_INTERVAL, bpm, signature, true))
        end
    end

    --remove any timing points from a previous override
    if #currenttimingpoints ~= 0 then
        actions.RemoveTimingPointBatch(currenttimingpoints)
    end

    local queue = {}
    --place normal timing points first so that game doesn't lag like hell from 60000 BPM timing points
    --actions.PlaceTimingPointBatch(normaltimingpoints)
    table.insert(queue, utils.CreateEditorAction(action_type.AddTimingPointBatch, normaltimingpoints))

    --actions.PlaceTimingPointBatch(snaptimingpoints)
    table.insert(queue, utils.CreateEditorAction(action_type.AddTimingPointBatch, snaptimingpoints))

    actions.PerformBatch(queue)
    return true
end

function kusaColorRed()
    local success = kusaGeneralColor(1)
    if success then print('s!', 'Set selected note colors to red.') end
end

function kusaColorOrange()
    local success = kusaGeneralColor(8)
    if success then print('s!', 'Set selected note colors to orange.') end
end

function kusaColorYellow()
    local success = kusaGeneralColor(4)
    if success then print('s!', 'Set selected note colors to yellow.') end
end

function kusaColorGreen()
    local success = kusaGeneralColor(16)
    if success then print('s!', 'Set selected note colors to green.') end
end

function kusaColorCyan()
    local success = kusaGeneralColor(12)
    if success then print('s!', 'Set selected note colors to cyan.') end
end

function kusaColorBlue()
    local success = kusaGeneralColor(2)
    if success then print('s!', 'Set selected note colors to blue.') end
end

function kusaColorPurple()
    local success = kusaGeneralColor(3)
    if success then print('s!', 'Set selected note colors to purple.') end
end

function kusaColorPink()
    local success = kusaGeneralColor(6)
    if success then print('s!', 'Set selected note colors to pink.') end
end

function kusaColorWhite()
    local success = kusaGeneralColor(5)
    if success then print('s!', 'Set selected note colors to white.') end
end
