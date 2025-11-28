COLOR_MAP = {
    [1] = "Red",
    [2] = "Blue",
    [3] = "Purple",
    [4] = "Yellow",
    [5] = "White",
    [6] = "Pink",
    [8] =
    "Orange",
    [12] = "Cyan",
    [16] = "Green"
}

REVERSE_COLOR_MAP = {
    Red = 1,
    Blue = 2,
    Purple = 3,
    Yellow = 4,
    White = 5,
    Pink = 6,
    Orange = 8,
    Cyan = 12,
    Green = 16
}

function layerSnaps()
    local layerDict = {}
    local originalLayerNames = table.property(map.EditorLayers, "Name")
    local layerNames = table.duplicate(originalLayerNames)
    local notes = game.uniqueNotesBetweenSelected()
    for _, ho in ipairs(notes) do
        local color = COLOR_MAP[game.getSnapAt(ho.StartTime)]
        if (ho.EditorLayer == 0) then
            layer = { Name = "Default", ColorRgb = "255,255,255", Hidden = false }
        else
            layer = map.EditorLayers[ho.EditorLayer]
        end
        local newLayerName = layer.Name .. "-plumoguSV-snap-" .. color
        if (table.contains(layerNames, newLayerName)) then
            if (table.contains(originalLayerNames, newLayerName)) then
                print("e!",
                    "Existing plumoguSV snap layers have been detected. Please remove them before trying to layer snaps again.")
                return
            end
            table.insert(layerDict[newLayerName].hos, ho)
        else
            layerDict[newLayerName] = { hos = { ho }, ColorRgb = layer.ColorRgb, Hidden = layer.Hidden }
            table.insert(layerNames, newLayerName)
        end
    end

    local createLayerQueue = {}
    local moveNoteQueue = {}

    for layerName, layerData in pairs(layerDict) do
        local layer = utils.CreateEditorLayer(layerName, layerData.Hidden, layerData.ColorRgb)
        table.insert(createLayerQueue,
            createEA(action_type.CreateLayer, layer))
        table.insert(moveNoteQueue, createEA(action_type.MoveToLayer, layer, layerData.hos))
    end
    actions.PerformBatch(createLayerQueue)
    actions.PerformBatch(moveNoteQueue)
end

function collapseSnaps()
    local normalTpsToAdd = {}
    local snapTpsToAdd = {}
    local tpsToRemove = {}
    local snapInterval = 0.69
    local baseBpm = 60000 / snapInterval
    local moveNoteActions = {}
    local removeLayerActions = {}

    for _, ho in ipairs(map.HitObjects) do
        for _, tp in ipairs(map.TimingPoints) do
            if ho.StartTime - snapInterval <= tp.StartTime and tp.StartTime <= ho.StartTime + snapInterval then
                table.insert(tpsToRemove, tp)
            end

            if tp.StartTime > ho.StartTime + snapInterval then break end
        end
        if (ho.EditorLayer == 0) then
            hoLayer = { Name = "Default", ColorRgb = "255,255,255", Hidden = false }
        else
            hoLayer = map.EditorLayers[ho.EditorLayer]
        end
        if (not hoLayer.Name:find("plumoguSV")) then goto continue end
        do
            local color = hoLayer.Name:match("-([a-zA-Z]+)$")
            local snap = REVERSE_COLOR_MAP[color]
            local mostRecentTP = game.getTimingPointAt(ho.StartTime)
            if (snap == 1) then
                table.insert(snapTpsToAdd,
                    utils.CreateTimingPoint(ho.StartTime, mostRecentTP.Bpm, mostRecentTP.Signature, true))
            else
                table.insert(snapTpsToAdd,
                    utils.CreateTimingPoint(ho.StartTime - snapInterval,
                        baseBpm / snap, mostRecentTP.Signature, true))
                table.insert(normalTpsToAdd,
                    utils.CreateTimingPoint(ho.StartTime + snapInterval,
                        mostRecentTP.Bpm, mostRecentTP.Signature, true))
            end
            local originalLayerName = hoLayer.Name:match("^([^-]+)-")

            table.insert(moveNoteActions,
                createEA(action_type.MoveToLayer,
                    map.EditorLayers[table.indexOf(table.property(map.EditorLayers, "Name"), originalLayerName)], { ho }))
            table.insert(removeLayerActions,
                createEA(action_type.RemoveLayer, hoLayer))
        end
        ::continue::
    end
    actions.PerformBatch(moveNoteActions)
    if (not truthy(#normalTpsToAdd + #snapTpsToAdd + #tpsToRemove)) then
        print("w!", "There were no generated layers you nonce")
        return
    end
    actions.PerformBatch({
        createEA(action_type.AddTimingPointBatch, normalTpsToAdd),
        createEA(action_type.AddTimingPointBatch, snapTpsToAdd),
        createEA(action_type.RemoveTimingPointBatch, tpsToRemove),
    })
end

function clearSnappedLayers()
    local removeLayerActions = {}
    for _, layer in ipairs(map.EditorLayers) do
        if layer.Name:find("plumoguSV") then
            table.insert(removeLayerActions, createEA(action_type.RemoveLayer, layer))
        end
    end
    if (not truthy(removeLayerActions)) then
        print("w!", "There were no generated layers you nonce")
        return
    end
    actions.PerformBatch(removeLayerActions)
end
