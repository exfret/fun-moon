local water2 = table.deepcopy(data.raw.tile.water)
water2.name = "water2"
water2.fluid = "water2"
local deepwater2 = table.deepcopy(data.raw.tile.deepwater)
deepwater2.name = "deepwater2"
deepwater2.fluid = "water2"

data:extend({
    water2,
    deepwater2
})