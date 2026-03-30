function capybaraModeWindow()
    startNextWindowNotCollapsed(PLUGIN_NAME)
    imgui.Begin(PLUGIN_NAME, imgui_window_flags.AlwaysAutoResize)

    GlobalCheckbox('drawCapybara', 'Capybara', 'Draws a capybara at the bottom right of the screen')
    imgui.SameLine(0, RADIO_BUTTON_SPACING)
    GlobalCheckbox('drawCapybara2', 'Capybara 2', 'Draws a capybara at the bottom left of the screen')
    GlobalCheckbox('drawCapybara312', 'Capybara 312', 'Draws a capybara???!?!??!!!!? AGAIN?!?!')
    imgui.SameLine(0, RADIO_BUTTON_SPACING)
    GlobalCheckbox('capybaraMode', 'Capybara Mode',
        'Capybara mode disables all other plugin features except the drawn capybaras.')
    imgui.End()

    drawCapybara()
    drawCapybara2()
    drawCapybara312()
end
