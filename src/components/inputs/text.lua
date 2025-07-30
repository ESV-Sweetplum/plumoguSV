function StatedInputText(label, input)
    local statedInputTextIndex = state.GetValue("StatedInputTextIndex", 1)
    local _, out = imgui.InputText(table.concat({ label, "##", statedInputTextIndex }), input, 4096)

    state.SetValue("StatedInputTextIndex", statedInputTextIndex + 1)
    return out, input ~= out
end
