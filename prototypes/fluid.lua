local water2 = table.deepcopy(data.raw.fluid.water)
water2.name = "water2"

data:extend({
    water2
})