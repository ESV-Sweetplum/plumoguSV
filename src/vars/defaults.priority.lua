function loadDefaultProperties(defaultProperties)
    if (not defaultProperties) then return end
    if (not defaultProperties.menu) then goto skipMenu end
    for label, tbl in pairs(defaultProperties.menu) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_MENU_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseDefaultProperty(settingValue, defaultTable[settingName])
            if (defaultSetting == nil) then
                goto skipSetting
            end
            DEFAULT_STARTING_MENU_VARS[label][settingName] = defaultSetting
            ::skipSetting::
        end
    end
    ::skipMenu::
    if (not defaultProperties.settings) then goto skipSettings end
    for label, tbl in pairs(defaultProperties.settings) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_SETTING_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseDefaultProperty(settingValue, defaultTable[settingName])
            if (defaultSetting == nil) then
                goto skipSetting
            end
            DEFAULT_STARTING_SETTING_VARS[label][settingName] = defaultSetting
            ::skipSetting::
        end
    end
    ::skipSettings::
    globalVars.defaultProperties = { settings = DEFAULT_STARTING_SETTING_VARS, menu = DEFAULT_STARTING_MENU_VARS }
end

function parseDefaultProperty(v, default)
    if (default == nil or type(default) == "table" or type(default) == "userdata") then
        return nil
    end
    if (type(default) == "number") then
        return math.toNumber(v)
    end
    if (type(default) == "boolean") then
        return truthy(v)
    end
    if (type(default) == "string") then
        return v
    end
    return v
end
