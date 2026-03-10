local fun_moon = table.deepcopy(data.raw.planet.nauvis)
local aquilo = data.raw.planet.aquilo
fun_moon.name = "fun-moon"
fun_moon.distance = aquilo.distance + 1
fun_moon.orientation = aquilo.orientation - 0.015
fun_moon.magnitude = 0.5
fun_moon.draw_orbit = false

fun_moon_conn = table.deepcopy(data.raw["space-connection"]["gleba-aquilo"])
fun_moon_conn.from = "aquilo"
fun_moon_conn.to = "fun-moon"
fun_moon_conn.length = 420

data:extend({
    fun_moon,
    fun_moon_conn
})