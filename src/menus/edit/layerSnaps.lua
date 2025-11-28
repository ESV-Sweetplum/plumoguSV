function layerSnapMenu()
    simpleActionMenu("Layer snaps between selection", 2, layerSnaps, nil, false, true)
    AddSeparator()
    simpleActionMenu("Collapse snap layers", 0, collapseSnaps, nil, false, true)
    simpleActionMenu("Clear unused snap layers", 0, clearSnappedLayers, nil, false, true)
end
