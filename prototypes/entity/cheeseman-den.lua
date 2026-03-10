local constants = require("lib.constants")

local den = table.deepcopy(data.raw.roboport.roboport)
local silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])
den.name = "cheeseman-den"
den.max_health = 50000
-- A bit smaller
den.logistics_radius = constants.cheeseman_logistic_radius
den.construction_radius = constants.cheeseman_construction_radius
-- TODO: Corpse and stuff
den.base = silo.base_day_sprite
den.base_patch = nil
den.base_animation = nil
den.door_animation_up.scale = 4 * den.door_animation_up.scale
den.door_animation_up.shift[2] = den.door_animation_up.shift[2] + 0.8
den.door_animation_down.scale = 4 * den.door_animation_down.scale
den.door_animation_down.shift[2] = den.door_animation_down.shift[2] + 2.5
den.collision_box = silo.collision_box
den.selection_box = silo.selection_box
den.energy_source = {type = "void"}

data:extend({
    den
})