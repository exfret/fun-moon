local constants = require("lib.constants")

local dens = {}

dens.do_den_spawns = function(event)
    -- First, check that this is the right surface
    if event.surface.valid and event.surface.planet ~= nil and event.surface.planet.name == "fun-moon" then
        -- Second, check sufficiently far away
        if math.abs(event.position.x) >= 5 or math.abs(event.position.y) >= 5 then
            -- Next, roll random number (one in thirty chunks have a cheeseman den)
            if math.random(40) == 1 then
                local position_for_den = event.surface.find_non_colliding_position_in_box(
                    "cheeseman-den",
                    {
                        { 32 * event.position.x, 32 * event.position.y },
                        { 32 * event.position.x + 31, 32 * event.position.y + 31}
                    },
                    1,
                    true
                )
                if position_for_den ~= nil then
                    local den = event.surface.create_entity({
                        name = "cheeseman-den",
                        position = position_for_den,
                        force = "enemy"
                    })
                    local bots_inventory = den.get_inventory(defines.inventory.roboport_robot)
                    bots_inventory.insert({ name = "cheeseman-bot", amount = 1 })
                    local signal_pos = event.surface.find_non_colliding_position(
                        "huge-rock",
                        position_for_den,
                        0,
                        1,
                        true
                    )
                    local signal = event.surface.create_entity({
                        name = "huge-rock",
                        position = signal_pos,
                        force = "neutral"
                    })
                    table.insert(storage.cheeseman_dens, {
                        den = den,
                        signal = signal,
                        activated = false
                    })
                end
            end
        end
    end
end

dens.update = function(event)
    -- TODO: Optimize dens; with a large map this could be quite a few!
    for _, den_info in pairs(storage.cheeseman_dens) do
        local den = den_info.den
        if den.valid then
            if not den_info.activated then
                for _, player in pairs(game.players) do
                    if player.character ~= nil and player.character.valid then
                        local character = player.character
                        if character.surface.name == den.surface.name then
                            -- Use logistic area as the "wakeup" zone
                            if math.abs(den.position.x - character.position.x) <= constants.cheeseman_logistic_radius and math.abs(den.position.y - character.position.y) <= constants.cheeseman_logistic_radius then
                                if den_info.signal.valid then
                                    den_info.activated = true
                                    den_info.signal.order_deconstruction("enemy")
                                end
                            end
                        end
                    end
                end
            end
            -- Turn any cheeseman bots into cheesemen
            if den.logistic_network ~= nil and den.logistic_network.valid then
                for _, bot in pairs(den.logistic_network.construction_robots) do
                    if bot.valid then
                        if storage.cheesemen[bot.unit_number] == nil then
                            storage.cheesemen[bot.unit_number] = {
                                entity = bot,
                                bot = true,
                                time_alive = 0,
                            }
                        elseif storage.cheesemen[bot.unit_number].time_alive > 110 then
                            local cheeseman = bot.surface.create_entity({
                                name = "cheeseman",
                                -- Spawn a little further up since bots float a bit, so otherwise there would be a jolt
                                position = {bot.position.x, bot.position.y - 1.5},
                                force = "enemy"
                            })
                            storage.cheesemen[bot.unit_number] = nil
                            storage.cheesemen[cheeseman.unit_number] = {
                                entity = cheeseman,
                                bot = false,
                                time_alive = 0,
                                den = den,
                            }
                            bot.destroy()
                        end
                    end
                end
            end
        end
    end
end

return dens