DEFAULT_STARTING_MENU_VARS = {
    placeStandard = {
        svTypeIndex = 1,
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svStats = createSVStats(),
        interlace = false,
        interlaceRatio = -0.5,
        overrideFinal = false
    },
    placeSpecial = { svTypeIndex = 1 },
    placeStill = {
        svTypeIndex = 1,
        noteSpacing = 1,
        stillTypeIndex = 1,
        stillDistance = 0,
        stillBehavior = 1,
        prePlaceDistances = {},
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svStats = createSVStats(),
        interlace = false,
        interlaceRatio = -0.5,
        overrideFinal = false
    },
    placeVibrato = {
        svTypeIndex = 1,
        vibratoMode = 1,
        vibratoQuality = 3,
        sides = 2
    },
    delete = {
        deleteTable = { true, true, true, true }
    },
    addTeleport = {
        distance = 10727,
        teleportBeforeHand = false
    },
    changeGroups = {
        designatedTimingGroup = "$Default",
        changeSVs = true,
        changeSSFs = true,
        clone = false,
    },
    completeDuplicate = {
        objects = {},
        svTbl = {},
        ssfTbl = {},
        msOffset = 0
    },
    convertSVSSF = {
        conversionDirection = true
    },
    copy = {
        copyTable = { true, true, true, true }, -- 1: timing lines, 2: svs, 3: ssfs, 4: bookmarks
        copied = {
            lines = { {} },
            SVs = { {} },
            SSFs = { {} },
            BMs = { {} },
        },
        tryAlign = true,
        alignWindow = 3,
        curSlot = 1,
    },
    directSV = {
        selectableIndex = 1,
        startTime = 0,
        multiplier = 0,
        pageNumber = 1
    },
    displaceNote = {
        distance = 200,
        distance1 = 0,
        distance2 = 200,
        linearlyChange = false
    },
    displaceView = {
        distance = 200
    },
    dynamicScale = {
        noteTimes = {},
        svTypeIndex = 1,
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svStats = createSVStats()
    },
    flicker = {
        flickerTypeIndex = 1,
        distance = -69420.727,
        distance1 = 0,
        distance2 = -69420.727,
        numFlickers = 1,
        linearlyChange = false,
        flickerPosition = 0.5
    },
    measure = {
        unrounded = false,
        nsvDistance = "",
        svDistance = "",
        avgSV = "",
        startDisplacement = "",
        endDisplacement = "",
        avgSVDisplaceless = "",
        roundedNSVDistance = 0,
        roundedSVDistance = 0,
        roundedAvgSV = 0,
        roundedStartDisplacement = 0,
        roundedEndDisplacement = 0,
        roundedAvgSVDisplaceless = 0
    },
    reverseScroll = {
        distance = 400
    },
    scaleBookmark = {
        searchTerm = "",
        filterTerm = ""
    },
    scaleDisplace = {
        scaleSpotIndex = 1,
        scaleTypeIndex = 1,
        avgSV = 0.6,
        distance = 100,
        ratio = 0.6,
    },
    scaleMultiply = {
        scaleTypeIndex = 1,
        avgSV = 0.6,
        distance = 100,
        ratio = 0.6
    },
    verticalShift = {
        verticalShift = 1
    },
    selectAlternating = {
        every = 1,
        offset = 0
    },
    selectBookmark = {
        searchTerm = "",
        filterTerm = "",
    },
    selectByTimingGroup = {
        designatedTimingGroup = "$Default",
    },
    selectChordSize = {
        select1 = true,
        select2 = false,
        select3 = false,
        select4 = false,
        select5 = false,
        select6 = false,
        select7 = false,
        select8 = false,
        select9 = false,
        select10 = false,
        laneSelector = 1
    },
    selectNoteType = {
        rice = true,
        ln = false
    },
    selectBySnap = {
        snap = 1
    }
}

---Gets the current menu's variables.
---@param menuType string The menu type.
---@return table
function getMenuVars(menuType, optionalLabel)
    optionalLabel = optionalLabel or ""
    local menuVars = table.duplicate(DEFAULT_STARTING_MENU_VARS[menuType])

    local labelText = menuType .. optionalLabel .. "Menu"
    cache.loadTable(labelText, menuVars)

    return menuVars
end
