local cheeseman_animation = {
    filename = "__fun-moon__/graphics/cheeseman.png",
    size = 156,
    direction_count = 1,
}

local cheeseman_bot = table.deepcopy(data.raw["construction-robot"]["construction-robot"])
cheeseman_bot.name = "cheeseman-bot"
-- Make bot slow so that we can replace it with a real cheeseman before it gets anywhere
cheeseman_bot.speed = 0.01
cheeseman_bot.hidden = true
cheeseman_bot.hidden_in_factoriopedia = true
for _, anim_type in pairs({"working", "idle", "in_motion"}) do
    cheeseman_bot[anim_type] = table.deepcopy(cheeseman_animation)
end
for _, shadow in pairs({"shadow_working", "shadow_idle", "shadow_in_motion"}) do
    -- Make shadows invisible
    cheeseman_bot[shadow] = util.empty_sprite()
end

local cheeseman_item = {
    type = "item",
    name = "cheeseman-bot",
    icon = cheeseman_animation.filename,
    icon_size = cheeseman_animation.size,
    place_result = "cheeseman-bot",
    stack_size = 1,
    hidden = true,
    hidden_in_factoriopedia = true,
}

local cheeseman = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
cheeseman.name = "cheeseman"
cheeseman.energy_source = {type = "void"}
cheeseman.icon = cheeseman_animation.filename
cheeseman.icon_size = cheeseman_animation.size
cheeseman.hidden = true
cheeseman.hidden_in_factoriopedia = true
-- Graphics/sounds
cheeseman.folded_animation = table.deepcopy(cheeseman_animation)
cheeseman.folding_sound = nil
cheeseman.folding_animation = table.deepcopy(cheeseman_animation)
cheeseman.prepared_animation = table.deepcopy(cheeseman_animation)
cheeseman.preparing_animation = table.deepcopy(cheeseman_animation)
cheeseman.preparing_sound = nil
cheeseman.water_reflection = nil
cheeseman.base_picture = nil
cheeseman.resource_indicator_animation = nil
cheeseman.graphics_set = {
    base_visualisation = {
        render_layer = "explosion",
        animation = table.deepcopy(cheeseman_animation)
    }
}
-- Misc
cheeseman.selection_box = {{-3, -3}, {3, 3}}
cheeseman.minable = nil
cheeseman.corpse = "construction-robot-remnants"
cheeseman.collision_mask = {layers = {}}
cheeseman.max_health = 2000
table.insert(cheeseman.flags, "placeable-off-grid")
-- Attacks
cheeseman.attack_parameters.damage_modifier = 0.2
cheeseman.attack_parameters.range = 19
cheeseman.attack_parameters.ammo_category = "cheese"
cheeseman.attack_parameters.ammo_type.action.action_delivery.beam = "cheese-beam"
cheeseman.attack_parameters.ammo_type.action.action_delivery.max_length = 19

local cheese_ammo_cat = {
    type = "ammo-category",
    name = "cheese",
    hidden = true,
    hidden_in_factoriopedia = true,
}

local cheese_beam = table.deepcopy(data.raw.beam["laser-beam"])
cheese_beam.name = "cheese-beam"
cheese_beam.damage_interval = 1
cheese_beam.action_triggered_automatically = true

data:extend({
    cheeseman_bot,
    cheeseman_item,
    cheeseman,
    cheese_ammo_cat,
    cheese_beam
})