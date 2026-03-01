DEFAULT_STARTING_SETTING_VARS = {
    linearVibratoSV = {
        startMsx = 100,
        endMsx = 0,
    },
    polynomialVibratoSV = {
        startMsx = 0,
        endMsx = 100,
        controlPointCount = 3,
        controlPoints = { vector.New(0.25, 0.25), vector.New(0.5, 0), vector.New(0.75, 0.25) },
        plotPoints = {},
        plotCoefficients = {},
    },
    exponentialVibratoSV = {
        startMsx = 100,
        endMsx = 0,
        curvatureIndex = 5,
    },
    sinusoidalVibratoSV = {
        startMsx = 100,
        endMsx = 0,
        verticalShift = 0,
        periods = 1,
        periodsShift = 0.25,
    },
    sigmoidalVibratoSV = {
        startMsx = 100,
        endMsx = 0,
        curvatureIndex = 5,
    },
    customVibratoSV = {
        code = [[return function (x)
    local maxHeight = 150

    heightFactor = maxHeight * math.exp((1 - math.sqrt(17)) * 0.5) / (31 - 7 * math.sqrt(17)) * 16
    primaryCoefficient = (x^2 - x^3) * math.exp(2 * x)
    sinusoidalCoefficient = math.sin(8 * math.pi * x)
    return heightFactor * primaryCoefficient * sinusoidalCoefficient
end]],
    },
    linearVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
    },
    exponentialVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
        curvatureIndex = 5,
    },
    sinusoidalVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
        verticalShift = 0,
        periods = 1,
        periodsShift = 0.25,
        applyToHigher = false,
    },
    sigmoidalVibratoSSF = {
        lowerStart = 0.5,
        lowerEnd = 0.5,
        higherStart = 1,
        higherEnd = 1,
        curvatureIndex = 5,
    },
    customVibratoSSF = {
        code1 = 'return function (x) return 0.69 end',
        code2 = 'return function (x) return 1.420 end',
    },
    linear = {
        startSV = 1.5,
        endSV = 0.5,
        avgSV = 0,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        distanceMode = 1,
    },
    exponential = {
        behaviorIndex = 1,
        intensity = 20,
        verticalShift = 0,
        distance = 100,
        startSV = 0.01,
        endSV = 1,
        avgSV = 1,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        distanceMode = 1,
    },
    bezier = {
        p1 = vector.New(0.1, 0.9),
        p2 = vector.New(0.9, 0.1),
        verticalShift = 0,
        freeMode = false,
        manualMode = false,
        avgSV = 1,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
    },
    hermite = {
        startSV = 0,
        endSV = 0,
        verticalShift = 0,
        avgSV = 1,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
    },
    sinusoidal = {
        startSV = 2,
        endSV = 2,
        curveSharpness = 50,
        verticalShift = 1,
        periods = 1,
        periodsShift = 0.25,
        svsPerQuarterPeriod = 8,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
    },
    circular = {
        behaviorIndex = 1,
        arcPercent = 50,
        avgSV = 1,
        verticalShift = 0,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        dontNormalize = false,
    },
    random = {
        svMultipliers = {},
        randomTypeIndex = 1,
        randomScale = 2,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
        dontNormalize = false,
        avgSV = 1,
        verticalShift = 0,
    },
    custom = {
        svMultipliers = { 0 },
        selectedMultiplierIndex = 1,
        svPoints = 1,
        finalSVIndex = 2,
        customSV = 1,
    },
    chinchilla = {
        behaviorIndex = 1,
        chinchillaTypeIndex = 1,
        chinchillaIntensity = 0.5,
        avgSV = 1,
        verticalShift = 0,
        svPoints = 16,
        finalSVIndex = 2,
        customSV = 1,
    },
    combo = {
        svType1Index = 1,
        svType2Index = 2,
        comboPhase = 0,
        comboTypeIndex = 1,
        comboMultiplier1 = 1,
        comboMultiplier2 = 1,
        finalSVIndex = 2,
        customSV = 1,
        dontNormalize = false,
        avgSV = 1,
        verticalShift = 0,
    },
    code = {
        code = [[return function (x)
    local startPeriod = 4
    local endPeriod = -1
    local height = 1.5

    return height * math.sin(2 * math.pi * (startPeriod * x + (endPeriod - startPeriod) * 0.5 * x^2))
end]],
        svPoints = 64,
        finalSVIndex = 2,
        customSV = 1,
    },
    stutter = {
        startSV = 1.5,
        endSV = 0.5,
        stutterDuration = 50,
        stutterDuration2 = 0,
        stuttersPerSection = 1,
        avgSV = 1,
        finalSVIndex = 2,
        customSV = 1,
        linearlyChange = false,
        controlLastSV = false,
        svMultipliers = {},
        svDistances = {},
        svGraphStats = createSVGraphStats(),
        svMultipliers2 = {},
        svDistances2 = {},
        svGraph2Stats = createSVGraphStats(),
    },
    teleportStutter = {
        svPercent = 50,
        svPercent2 = 0,
        distance = 50,
        mainSV = 0.5,
        mainSV2 = 0,
        useDistance = false,
        linearlyChange = false,
        avgSV = 1,
        finalSVIndex = 2,
        customSV = 1,
        stuttersPerSection = 1,
    },
    framesSetup = {
        menuStep = 1,
        numFrames = 5,
        frameDistance = 2000,
        distance = 2000,
        reverseFrameOrder = false,
        noteSkinTypeIndex = 1,
        frameTimes = {},
        selectedTimeIndex = 1,
        currentFrame = 1,
    },
    penis = {
        bWidth = 50,
        sWidth = 100,
        sCurvature = 100,
        bCurvature = 100,
    },
    automate = {
        copiedSVs = {},
        deleteCopiedSVs = true,
        maintainMs = true,
        ms = 1000,
        scaleSVs = false,
        initialSV = 1,
        optimizeTGs = true,
    },
    animationPalette = {
        instructions = '',
    },
}

---Gets the current menu's setting variables.
---@param svType string The SV type - that is, the shape of the SV once plotted.
---@param label string A delineator to separate two categories with similar SV types (Standard/Still, etc).
---@return table
function getSettingVars(svType, label)
    menuKey = svType:identify()
    local settingVars = table.duplicate(DEFAULT_STARTING_SETTING_VARS[menuKey])

    local labelText = svType .. label .. 'Settings'
    cache.loadTable(labelText, settingVars)
    return settingVars
end
