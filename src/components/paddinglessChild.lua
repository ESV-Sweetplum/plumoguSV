function BeginPaddinglessChild(label, size, flags)
    PushStyleVar(imgui_style_var.WindowPadding, vctr2(0))
    imgui.BeginChild(label, size, bit32.bor(flags or 2, 2))
end

function EndPaddinglessChild()
    imgui.EndChild()
    PopStyleVar()
end
