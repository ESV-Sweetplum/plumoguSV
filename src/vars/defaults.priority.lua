function loadDefaultProperties(defaultProperties)
    if (not defaultProperties) then return end
    if (not defaultProperties.menu) then goto skipMenu end
    for label, tbl in pairs(defaultProperties.menu) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_MENU_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseProperty(settingValue, defaultTable[settingName])
            if (not defaultSetting) then
                goto skipSetting
            end
            DEFAULT_STARTING_MENU_VARS[label][settingName] = defaultSetting
            ::skipSetting::
        end
    end
    ::skipMenu::
    for label, tbl in pairs(defaultProperties.settings) do
        for settingName, settingValue in pairs(tbl) do
            local defaultTable = DEFAULT_STARTING_SETTING_VARS[label]
            if (not defaultTable) then break end
            local defaultSetting = parseProperty(settingValue, defaultTable[settingName])
            if (not defaultSetting) then
                goto skipSetting
            end
            DEFAULT_STARTING_SETTING_VARS[label][settingName] = defaultSetting
            ::skipSetting::
        end
    end
    globalVars.defaultProperties = { settings = DEFAULT_STARTING_SETTING_VARS, menu = DEFAULT_STARTING_MENU_VARS }
end

function parseProperty(v, default)
    if (not default or type(default) == "table" or type(default) == "userdata") then
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
