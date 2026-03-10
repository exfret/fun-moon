local fun_moon = table.deepcopy(data.raw.planet.nauvis)
local gleba = data.raw.planet.gleba
fun_moon.name = "fun-moon"
fun_moon.distance = gleba.distance + 2
fun_moon.orientation = gleba.orientation - 0.015
fun_moon.magnitude = 0.5
fun_moon.draw_orbit = false
fun_moon.icon = "__fun-moon__/graphics/icons/fun-moon.png"
fun_moon.icon_size = 720
fun_moon.starmap_icon = "__fun-moon__/graphics/icons/fun-moon.png"
fun_moon.starmap_icon_size = 720

fun_moon_conn = table.deepcopy(data.raw["space-connection"]["nauvis-gleba"])
fun_moon_conn.from = "gleba"
fun_moon_conn.to = "fun-moon"
fun_moon_conn.length = 420

data:extend({
    fun_moon,
    fun_moon_conn
})