data:extend({
    {
        type = "technology",
        name = "planet-discovery-fun-moon",
        icon = "__fun-moon__/graphics/icons/fun-moon.png",
        icon_size = 720,
        essential = true,
        unit = {
            count = 1000,
            time = 60,
            ingredients = {
                {"logistic-science-pack", 1},
                {"agricultural-science-pack", 1},
            },
        },
        prerequisites = {
            "agricultural-science-pack"
        },
        effects = {
            { type = "unlock-space-location", space_location = "fun-moon" }
        },
    },
})