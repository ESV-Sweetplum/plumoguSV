stars = {}
function updateStars()
    local dim = imgui.GetWindowSize()

    for _, star in ipairs(stars) do
        local starWrapped = false
        while (star.pos.x > dim.x + 10) do
            starWrapped = true
            star.pos.x = star.pos.x - dim.x - 20
        end
        while (star.pos.x < -10) do
            starWrapped = true
            star.pos.x = star.pos.x + dim.x + 20
        end
        if (starWrapped) then
            star.pos.y = math.random() * dim.y
            star.v.x = math.random() * 3 + 1
            star.size = math.random(3) * 0.5
        else
            star.pos = star.pos + star.v * state.DeltaTime * 0.05 *
                math.clamp(2 * getSVMultiplierAt(state.SongTime), -50, 50)
        end
    end
end

function renderReactiveStars()
    local stars = stars

    local ctx = imgui.GetWindowDrawList()
    local topLeft = imgui.GetWindowPos()
    local dim = imgui.GetWindowSize()

    if (not truthy(#stars)) then
        for _ = 1, 100 do
            table.insert(stars,
                {
                    pos = vector.New(math.random() * 500, math.random() * 500),
                    v = vector.New(math.random() * 3 + 1, 0),
                    size = math.random(3) * 0.5,
                })
        end
    else
        updateStars()
    end

    for _, star in ipairs(stars) do
        local progress = star.pos.x / dim.x
        local brightness = math.clamp(-8 * progress * (progress - 1), 0, 1)
        ctx.AddCircleFilled(star.pos + topLeft, star.size, rgbaToUint(255, 255, 255, brightness * 255))
    end
end
