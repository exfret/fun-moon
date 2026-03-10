local constants = require("lib/constants")

local cheesemen = {}

cheesemen.update = function(event)
    local invalid_cheesemen = {}
    for k, cheeseman in pairs(storage.cheesemen) do
        if not cheeseman.entity.valid then
            table.insert(invalid_cheesemen, k)
        else
            cheeseman.time_alive = cheeseman.time_alive + 1
            if not cheeseman.bot then
                if not cheeseman.den.valid then
                    -- A cheeseman without a den is no man, no cheese, nothing
                    cheeseman.kill()
                else
                    local cheese_pos = cheeseman.entity.position
                    local den_pos = cheeseman.den.position

                    -- Check for players close by in the den
                    local closest_player
                    local closest_player_dist
                    for _, player in pairs(game.players) do
                        if player.character ~= nil and player.character.valid then
                            local character = player.character
                            -- Check in den
                            if math.abs(character.position.x - den_pos.x) <= constants.cheeseman_construction_radius and math.abs(character.position.y - den_pos.y) <= constants.cheeseman_construction_radius then
                                local this_player_dist = (character.position.x - cheese_pos.x) * (character.position.x - cheese_pos.x) + (character.position.y - cheese_pos.y) * (character.position.y - cheese_pos.y)
                                if closest_player_dist == nil or this_player_dist <= closest_player_dist then
                                    closest_player_dist = this_player_dist
                                    closest_player = player
                                end
                            end
                        end
                    end

                    if closest_player ~= nil and closest_player_dist > 5 * 5 then
                        rendering.draw_text({text = "Cheeseman, hunter of " .. closest_player.name, time_to_live = 1, alignment = "center", scale = 2, surface = cheeseman.entity.surface, target = cheeseman.entity, color = {r = 1, g = 1, b = 1}})
                        -- Cheeseman doesn't spawncamp
                        if closest_player.position.x * closest_player.position.x + closest_player.position.y * closest_player.position.y > 10 * 10 then
                            cheeseman.entity.teleport({x = cheese_pos.x - 0.1 * (cheese_pos.x - closest_player.position.x) / math.sqrt(closest_player_dist), y = cheese_pos.y - 0.1 * (cheese_pos.y - closest_player.position.y) / math.sqrt(closest_player_dist)})
                        end
                    else
                        target_pos = {x = cheeseman.den.position.x + constants.cheeseman_circle_radius * math.cos(game.tick * 6.28 / (60 * constants.cheeseman_circle_radius)), y = cheeseman.den.position.y + constants.cheeseman_circle_radius * math.sin(game.tick * 6.28 / (60 * constants.cheeseman_circle_radius))}
                        target_pos_dist = (target_pos.x - cheese_pos.x) * (target_pos.x - cheese_pos.x) + (target_pos.y - cheese_pos.y) * (target_pos.y - cheese_pos.y)
                        cheeseman.entity.teleport({x = cheese_pos.x - 0.1 * (cheese_pos.x - target_pos.x) / math.sqrt(target_pos_dist), y = cheese_pos.y - 0.1 * (cheese_pos.y - target_pos.y) / math.sqrt(target_pos_dist)})
                        rendering.draw_text({text = "Cheeseman", time_to_live = 1, alignment = "center", scale = 2, surface = cheeseman.entity.surface, target = cheeseman.entity, color = {r = 1, g = 1, b = 1}})
                    end
                end
            end
        end
    end
    -- Clean up the dead cheeses
    for _, k in pairs(invalid_cheesemen) do
        storage.cheesemen[k] = nil
    end
end

return cheesemen