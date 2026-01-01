---@class PhysicsObject
---@field pos Vector2
---@field v Vector2
---@field a Vector2

---@class Particle: PhysicsObject
---@field col Vector4
---@field size integer

function renderBackground()
    local idx = globalVars.dynamicBackgroundIndex
    if (DYNAMIC_BACKGROUND_TYPES[idx] == "Reactive Stars") then
        renderReactiveStars()
    end
    if (DYNAMIC_BACKGROUND_TYPES[idx] == "Reactive Singularity") then
        renderReactiveSingularities()
    end
end
