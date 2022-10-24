local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local closestSuns = EntityGetClosestWithTag(x, y, "sun")
local px, py = EntityGetTransform(closestSuns)

local velocitycomp = EntityGetFirstComponent(closestSuns, "VelocityComponent")
if (velocitycomp ~= nil) then
    local distance = math.sqrt( ( x - px ) ^ 2 + ( y - py ) ^ 2 )
    if distance < 12 then
        return 0,0
    end
    local direction = 0 - math.atan( ( y - py ), ( x - px ) )
    local gravity_percent = ( 96 - distance ) / 96
    local gravity_coeff = 196
    local fx = math.cos( direction ) * ( gravity_coeff * gravity_percent )
    local fy = -math.sin( direction ) * ( gravity_coeff * gravity_percent )
    local comp = EntityGetFirstComponent(closestSuns, "VelocityComponent")
    if comp == nil then return end
    ---@diagnostic disable-next-line: assign-type-mismatch
    local vel_x, vel_y = ComponentGetValue2(comp, "mVelocity")

    vel_x = vel_x + fx
    ---@diagnostic disable-next-line: cast-local-type
    vel_y = vel_y + fy

    ComponentSetValue2(comp, "mVelocity", vel_x, vel_y)
end
