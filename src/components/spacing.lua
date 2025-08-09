function AddPadding()
    imgui.Dummy(vector.New(0, 0))
end

function AddSeparator()
    AddPadding()
    imgui.Separator()
    AddPadding()
end
