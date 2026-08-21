loadup = {} -- later inserted to via setStyleVars.lua

local tempGlobalVars = read()

if tempGlobalVars and tempGlobalVars.colorThemeIndex then
    print(
        'w!',
        'Due to an internal change, your selected theme may have been reset. Please reselect the theme in the plugin settings.'
    )
end

if not tempGlobalVars and state and map and utils and actions then
    write(DEFAULT_GLOBAL_VARS) -- First time launching plugin
    if DISTRO == 'steam' then
        print(
            'w!',
            "Additionally, Steam Workshop will reset your settings when the plugin is updated. To prevent this, please save your 'config.yaml' file after you're finished configuring settings, and drop it back in when an update comes around."
        )
    end
    print(
        'w!',
        'This seems to be your first time using plumoguSV. If you need any help, please press the button labelled "View Tutorials" in the "Info" tab.'
    )
    setPresets {}
else
    setGlobalVars(tempGlobalVars)
    loadDefaultProperties(tempGlobalVars.defaultProperties)
    setPresets(tempGlobalVars.presets or {})
end

initializeNoteLockMode()
triggerListeners()
setPluginAppearance()

if not truthy(map.TimingPoints) then print('e!', 'Please place a timing point before attempting to use plumoguSV.') end

initializeDisplacementExponentCache()
