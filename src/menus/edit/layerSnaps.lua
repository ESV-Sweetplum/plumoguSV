function layerSnapMenu()
    simpleActionMenu("Layer snaps throughout map", 0, layerSnaps, nil, true, true)
    AddSeparator()
    simpleActionMenu("Collapse snap layers", 0, collapseSnaps, nil, true, true)
    simpleActionMenu("Clear unused snap layers", 0, clearSnappedLayers, nil, true, true)
end
