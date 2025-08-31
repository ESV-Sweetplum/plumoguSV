function showPatchNotesWindow()
    startNextWindowNotCollapsed("plumoguSV Patch Notes")
    _, patchNotesOpened = imgui.Begin("plumoguSV Patch Notes", true, 42)
    imgui.SetWindowSize("plumoguSV Patch Notes", vector.New(433, 400))

    imgui.End()
end
