function drawCapybaraParent()
    drawCapybara()
    drawCapybara2()
    drawCapybara312()
end

function drawCapybara()
    if not globalVars.drawCapybara then return end
    local o = imgui.GetForegroundDrawList()
    local sz = state.WindowSize
    local headWidth = 50
    local headRadius = 20
    local eyeWidth = 10
    local eyeRadius = 3
    local earRadius = 12
    local headCoords1 = relativePoint(sz, -100, -100)
    local headCoords2 = relativePoint(headCoords1, -headWidth, 0)
    local eyeCoords1 = relativePoint(headCoords1, -10, -10)
    local eyeCoords2 = relativePoint(eyeCoords1, -eyeWidth, 0)
    local earCoords = relativePoint(headCoords1, 12, -headRadius + 5)
    local stemCoords = relativePoint(headCoords1, 50, -headRadius + 5)
    local bodyColor = color.rgbaToUint(122, 70, 212, 255)
    local eyeColor = color.rgbaToUint(30, 20, 35, 255)
    local earColor = color.rgbaToUint(62, 10, 145, 255)
    local stemColor = color.rgbaToUint(0, 255, 0, 255)
    -- draws capybara ear
    o.AddCircleFilled(earCoords, earRadius, earColor)
    -- draws capybara head
    drawHorizontalPillShape(o, headCoords1, headCoords2, headRadius, bodyColor, 12)
    -- draw capybara eyes
    drawHorizontalPillShape(o, eyeCoords1, eyeCoords2, eyeRadius, eyeColor, 12)
    -- draws capybara body
    o.AddRectFilled(table.vectorize2(sz), headCoords1, bodyColor)

    -- draws capybara stem
    o.AddRectFilled(vector.New(stemCoords.x, stemCoords.y), vector.New(stemCoords.x + 10, stemCoords.y + 20),
        stemColor)
    o.AddRectFilled(vector.New(stemCoords.x - 10, stemCoords.y), vector.New(stemCoords.x + 20, stemCoords.y - 5),
        stemColor)
end

function drawCapybara2()
    if not globalVars.drawCapybara2 then return end
    local o = imgui.GetForegroundDrawList()
    local sz = state.WindowSize

    local topLeftCapyPoint = vector.New(0, sz[2] - 165)
    local p1 = relativePoint(topLeftCapyPoint, 0, 95)
    local p2 = relativePoint(topLeftCapyPoint, 0, 165)
    local p3 = relativePoint(topLeftCapyPoint, 58, 82)
    local p3b = relativePoint(topLeftCapyPoint, 108, 82)
    local p4 = relativePoint(topLeftCapyPoint, 58, 165)
    local p5 = relativePoint(topLeftCapyPoint, 66, 29)
    local p6 = relativePoint(topLeftCapyPoint, 105, 10)
    local p7 = relativePoint(topLeftCapyPoint, 122, 126)
    local p7b = relativePoint(topLeftCapyPoint, 133, 107)
    local p8 = relativePoint(topLeftCapyPoint, 138, 11)
    local p9 = relativePoint(topLeftCapyPoint, 145, 82)
    local p10 = relativePoint(topLeftCapyPoint, 167, 82)
    local p10b = relativePoint(topLeftCapyPoint, 172, 80)
    local p11 = relativePoint(topLeftCapyPoint, 172, 50)
    local p12 = relativePoint(topLeftCapyPoint, 179, 76)
    local p12b = relativePoint(topLeftCapyPoint, 176, 78)
    local p12c = relativePoint(topLeftCapyPoint, 176, 70)
    local p13 = relativePoint(topLeftCapyPoint, 185, 50)

    local p14 = relativePoint(topLeftCapyPoint, 113, 10)
    local p15 = relativePoint(topLeftCapyPoint, 116, 0)
    local p16 = relativePoint(topLeftCapyPoint, 125, 2)
    local p17 = relativePoint(topLeftCapyPoint, 129, 11)
    local p17b = relativePoint(topLeftCapyPoint, 125, 11)

    local p18 = relativePoint(topLeftCapyPoint, 91, 0)
    local p19 = relativePoint(topLeftCapyPoint, 97, 0)
    local p20 = relativePoint(topLeftCapyPoint, 102, 1)
    local p21 = relativePoint(topLeftCapyPoint, 107, 11)
    local p22 = relativePoint(topLeftCapyPoint, 107, 19)
    local p23 = relativePoint(topLeftCapyPoint, 103, 24)
    local p24 = relativePoint(topLeftCapyPoint, 94, 17)
    local p25 = relativePoint(topLeftCapyPoint, 88, 9)

    local p26 = relativePoint(topLeftCapyPoint, 123, 33)
    local p27 = relativePoint(topLeftCapyPoint, 132, 30)
    local p28 = relativePoint(topLeftCapyPoint, 138, 38)
    local p29 = relativePoint(topLeftCapyPoint, 128, 40)

    local p30 = relativePoint(topLeftCapyPoint, 102, 133)
    local p31 = relativePoint(topLeftCapyPoint, 105, 165)
    local p32 = relativePoint(topLeftCapyPoint, 113, 165)

    local p33 = relativePoint(topLeftCapyPoint, 102, 131)
    local p34 = relativePoint(topLeftCapyPoint, 82, 138)
    local p35 = relativePoint(topLeftCapyPoint, 85, 165)
    local p36 = relativePoint(topLeftCapyPoint, 93, 165)

    local p37 = relativePoint(topLeftCapyPoint, 50, 80)
    local p38 = relativePoint(topLeftCapyPoint, 80, 40)
    local p39 = relativePoint(topLeftCapyPoint, 115, 30)
    local p40 = relativePoint(topLeftCapyPoint, 40, 92)
    local p41 = relativePoint(topLeftCapyPoint, 80, 53)
    local p42 = relativePoint(topLeftCapyPoint, 107, 43)
    local p43 = relativePoint(topLeftCapyPoint, 40, 104)
    local p44 = relativePoint(topLeftCapyPoint, 70, 56)
    local p45 = relativePoint(topLeftCapyPoint, 100, 53)
    local p46 = relativePoint(topLeftCapyPoint, 45, 134)
    local p47 = relativePoint(topLeftCapyPoint, 50, 80)
    local p48 = relativePoint(topLeftCapyPoint, 70, 87)
    local p49 = relativePoint(topLeftCapyPoint, 54, 104)
    local p50 = relativePoint(topLeftCapyPoint, 50, 156)
    local p51 = relativePoint(topLeftCapyPoint, 79, 113)
    local p52 = relativePoint(topLeftCapyPoint, 55, 24)
    local p53 = relativePoint(topLeftCapyPoint, 85, 25)
    local p54 = relativePoint(topLeftCapyPoint, 91, 16)
    local p55 = relativePoint(topLeftCapyPoint, 45, 33)
    local p56 = relativePoint(topLeftCapyPoint, 75, 36)
    local p57 = relativePoint(topLeftCapyPoint, 81, 22)
    local p58 = relativePoint(topLeftCapyPoint, 45, 43)
    local p59 = relativePoint(topLeftCapyPoint, 73, 38)
    local p60 = relativePoint(topLeftCapyPoint, 61, 32)
    local p61 = relativePoint(topLeftCapyPoint, 33, 55)
    local p62 = relativePoint(topLeftCapyPoint, 73, 45)
    local p63 = relativePoint(topLeftCapyPoint, 55, 36)
    local p64 = relativePoint(topLeftCapyPoint, 32, 95)
    local p65 = relativePoint(topLeftCapyPoint, 53, 42)
    local p66 = relativePoint(topLeftCapyPoint, 15, 75)
    local p67 = relativePoint(topLeftCapyPoint, 0, 125)
    local p68 = relativePoint(topLeftCapyPoint, 53, 62)
    local p69 = relativePoint(topLeftCapyPoint, 0, 85)
    local p70 = relativePoint(topLeftCapyPoint, 0, 165)
    local p71 = relativePoint(topLeftCapyPoint, 29, 112)
    local p72 = relativePoint(topLeftCapyPoint, 0, 105)

    local p73 = relativePoint(topLeftCapyPoint, 73, 70)
    local p74 = relativePoint(topLeftCapyPoint, 80, 74)
    local p75 = relativePoint(topLeftCapyPoint, 92, 64)
    local p76 = relativePoint(topLeftCapyPoint, 60, 103)
    local p77 = relativePoint(topLeftCapyPoint, 67, 83)
    local p78 = relativePoint(topLeftCapyPoint, 89, 74)
    local p79 = relativePoint(topLeftCapyPoint, 53, 138)
    local p80 = relativePoint(topLeftCapyPoint, 48, 120)
    local p81 = relativePoint(topLeftCapyPoint, 73, 120)
    local p82 = relativePoint(topLeftCapyPoint, 46, 128)
    local p83 = relativePoint(topLeftCapyPoint, 48, 165)
    local p84 = relativePoint(topLeftCapyPoint, 74, 150)
    local p85 = relativePoint(topLeftCapyPoint, 61, 128)
    local p86 = relativePoint(topLeftCapyPoint, 83, 100)
    local p87 = relativePoint(topLeftCapyPoint, 90, 143)
    local p88 = relativePoint(topLeftCapyPoint, 73, 143)
    local p89 = relativePoint(topLeftCapyPoint, 120, 107)
    local p90 = relativePoint(topLeftCapyPoint, 116, 133)
    local p91 = relativePoint(topLeftCapyPoint, 106, 63)
    local p92 = relativePoint(topLeftCapyPoint, 126, 73)
    local p93 = relativePoint(topLeftCapyPoint, 127, 53)
    local p94 = relativePoint(topLeftCapyPoint, 91, 98)
    local p95 = relativePoint(topLeftCapyPoint, 101, 76)
    local p96 = relativePoint(topLeftCapyPoint, 114, 99)
    local p97 = relativePoint(topLeftCapyPoint, 126, 63)
    local p98 = relativePoint(topLeftCapyPoint, 156, 73)
    local p99 = relativePoint(topLeftCapyPoint, 127, 53)

    local color1 = color.rgbaToUint(250, 250, 225, 255)
    local color2 = color.rgbaToUint(240, 180, 140, 255)
    local color3 = color.rgbaToUint(195, 90, 120, 255)
    local color4 = color.rgbaToUint(115, 5, 65, 255)

    local color5 = color.rgbaToUint(100, 5, 45, 255)
    local color6 = color.rgbaToUint(200, 115, 135, 255)
    local color7 = color.rgbaToUint(175, 10, 70, 255)
    local color8 = color.rgbaToUint(200, 90, 110, 255)
    local color9 = color.rgbaToUint(125, 10, 75, 255)
    local color10 = color.rgbaToUint(220, 130, 125, 255)

    o.AddQuadFilled(p18, p19, p24, p25, color4)
    o.AddQuadFilled(p19, p20, p21, p22, color1)
    o.AddQuadFilled(p19, p22, p23, p24, color4)

    o.AddQuadFilled(p14, p15, p16, p17, color4)
    o.AddTriangleFilled(p17b, p16, p17, color1)

    o.AddQuadFilled(p1, p2, p4, p3, color3)
    o.AddQuadFilled(p1, p3, p6, p5, color3)
    o.AddQuadFilled(p3, p4, p7, p9, color2)
    o.AddQuadFilled(p3, p6, p11, p10, color2)
    o.AddQuadFilled(p6, p8, p13, p11, color1)
    o.AddQuadFilled(p13, p12, p10, p11, color6)
    o.AddTriangleFilled(p10b, p12b, p12c, color7)

    o.AddTriangleFilled(p9, p7b, p3b, color8)

    o.AddQuadFilled(p26, p27, p28, p29, color5)

    o.AddQuadFilled(p7, p30, p31, p32, color5)
    o.AddQuadFilled(p33, p34, p35, p36, color5)

    o.AddTriangleFilled(p37, p38, p39, color8)
    o.AddTriangleFilled(p40, p41, p42, color8)
    o.AddTriangleFilled(p43, p44, p45, color8)
    o.AddTriangleFilled(p46, p47, p48, color8)
    o.AddTriangleFilled(p49, p50, p51, color2)

    o.AddTriangleFilled(p52, p53, p54, color9)
    o.AddTriangleFilled(p55, p56, p57, color9)
    o.AddTriangleFilled(p58, p59, p60, color9)
    o.AddTriangleFilled(p61, p62, p63, color9)
    o.AddTriangleFilled(p64, p65, p66, color9)
    o.AddTriangleFilled(p67, p68, p69, color9)
    o.AddTriangleFilled(p70, p71, p72, color9)

    o.AddTriangleFilled(p73, p74, p75, color10)
    o.AddTriangleFilled(p76, p77, p78, color10)
    o.AddTriangleFilled(p79, p80, p81, color10)
    o.AddTriangleFilled(p82, p83, p84, color10)
    o.AddTriangleFilled(p85, p86, p87, color10)
    o.AddTriangleFilled(p88, p89, p90, color10)
    o.AddTriangleFilled(p91, p92, p93, color10)
    o.AddTriangleFilled(p94, p95, p96, color10)
    o.AddTriangleFilled(p97, p98, p99, color10)
end

function drawCapybara312()
    if not globalVars.drawCapybara312 then return end
    local o = imgui.GetForegroundDrawList()
    --local sz = state.WindowSize
    local rgbColors = getCurrentRGBColors(globalVars.rgbPeriod)
    local outlineColor = color.rgbaToUint(rgbColors.red, rgbColors.green, rgbColors.blue, 255)

    local p1 = vector.New(42, 32)
    local p2 = vector.New(100, 78)
    local p3 = vector.New(141, 32)
    local p4 = vector.New(83, 63)
    local p5 = vector.New(83, 78)
    local p6 = vector.New(70, 82)
    local p7 = vector.New(85, 88)
    local hairlineThickness = 1
    o.AddTriangleFilled(p1, p2, p3, outlineColor)
    o.AddTriangleFilled(p1, p4, p5, outlineColor)
    o.AddLine(p5, p6, outlineColor, hairlineThickness)
    o.AddLine(p6, p7, outlineColor, hairlineThickness)

    local p8 = vector.New(21, 109)
    local p9 = vector.New(0, 99)
    local p10 = vector.New(16, 121)
    local p11 = vector.New(5, 132)
    local p12 = vector.New(162, 109)
    local p13 = vector.New(183, 99)
    local p14 = vector.New(167, 121)
    local p15 = vector.New(178, 132)
    o.AddTriangleFilled(p1, p8, p9, outlineColor)
    o.AddTriangleFilled(p9, p10, p11, outlineColor)
    o.AddTriangleFilled(p3, p12, p13, outlineColor)
    o.AddTriangleFilled(p13, p14, p15, outlineColor)

    local p16 = vector.New(25, 139)
    local p17 = vector.New(32, 175)
    local p18 = vector.New(158, 139)
    local p19 = vector.New(151, 175)
    local p20 = vector.New(150, 215)
    o.AddTriangleFilled(p11, p16, p17, outlineColor)
    o.AddTriangleFilled(p15, p18, p19, outlineColor)
    o.AddTriangleFilled(p17, p19, p20, outlineColor)

    local p21 = vector.New(84, 148)
    local p22 = vector.New(88, 156)
    local p23 = vector.New(92, 153)
    local p24 = vector.New(96, 156)
    local p25 = vector.New(100, 148)
    local mouthLineThickness = 2
    o.AddLine(p21, p22, outlineColor, mouthLineThickness)
    o.AddLine(p22, p23, outlineColor, mouthLineThickness)
    o.AddLine(p23, p24, outlineColor, mouthLineThickness)
    o.AddLine(p24, p25, outlineColor, mouthLineThickness)

    local p26 = vector.New(61, 126)
    local p27 = vector.New(122, 126)
    local eyeRadius = 9
    local numSements = 16
    o.AddCircleFilled(p26, eyeRadius, outlineColor, numSements)
    o.AddCircleFilled(p27, eyeRadius, outlineColor, numSements)
end

-- Draws a horizontal pill shape
-- Parameters
--    o              : imgui overlay drawlist [imgui.GetForegroundDrawList()]
--    point1         : (x, y) coordiates of the center of the pill's first circle [Table]
--    point2         : (x, y) coordiates of the center of the pill's second circle [Table]
--    radius         : radius of the circle of the pill [Int/Float]
--    color          : color of the pill represented as a uint [Int]
--    circleSegments : number of segments to draw for the circles in the pill [Int]
function drawHorizontalPillShape(o, point1, point2, radius, color, circleSegments)
    o.AddCircleFilled(point1, radius, color, circleSegments)
    o.AddCircleFilled(point2, radius, color, circleSegments)
    local rectangleStartCoords = relativePoint(point1, 0, radius)
    local rectangleEndCoords = relativePoint(point2, 0, -radius)
    o.AddRectFilled(rectangleStartCoords, rectangleEndCoords, color)
end
