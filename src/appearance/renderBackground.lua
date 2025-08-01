---@class PhysicsObject
---@field pos Vector2
---@field v Vector2
---@field a Vector2

---@class Particle: PhysicsObject
---@field col Vector4
---@field size integer

function renderBackground()
    if (DYNAMIC_BACKGROUND_TYPES[globalVars.dynamicBackgroundIndex] == "Reactive Stars") then
        renderReactiveStars()
    end
    if (DYNAMIC_BACKGROUND_TYPES[globalVars.dynamicBackgroundIndex] == "Reactive Singularity") then
        renderReactiveSingularities()
    end
    if (DYNAMIC_BACKGROUND_TYPES[globalVars.dynamicBackgroundIndex] == "Synthesis") then
        renderSynthesis()
    end
end
