local cheesemen = require("script.cheesemen")
local dens = require("script.dens")

script.on_init(function()
    storage.cheeseman_dens = {}
    storage.cheesemen = {}
end)

script.on_event(defines.events.on_chunk_generated, function(event)
    dens.do_den_spawns(event)
end)

script.on_nth_tick(20, function(event)
    dens.update(event)
end)

script.on_nth_tick(1, function(event)
    cheesemen.update(event)
end)