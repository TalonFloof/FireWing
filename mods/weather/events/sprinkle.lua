local event = {}
event.name = "sprinkle"
event.clouds = {
    density = 0.4,
    height = 300-20,
    thickness = 36,
}
event.sky = {
	type = "regular",
	clouds = true,
	sky_color = {
		day_sky = "#A5D4F6",
		day_horizon = "#b7dcf7",
		dawn_sky = "#9EADFF",
		dawn_horizon ="#b1bdff",
		night_sky = "#020042",
		night_horizon = "#343267",
		indoors = "#2B2B2B",
		--fog_sun_tint = "#FB7F55",
		--fog_moon_tint = "#C5C9C9",
		--fog_tint_type = "custom"
	}
}
event.eventChain = {
    {"overcast",0.06},
    {"light_rain",0.5},
    {"medium_clouds",0.5},
}
event.darken = 0
event.particle_delay = 0.1
event.particle = function(player)
    local p=player:get_pos()
    if minetest.get_node_light({x=p.x, y=p.y+15, z=p.z}, 0.5) == 15 then
        local minpos = weather.addvec(player:get_pos(), {x = -15, y = 15, z = -15})
        local maxpos = weather.addvec(player:get_pos(), {x = 15, y = 10, z = 15})
        minetest.add_particlespawner(
        {
            amount = 1,
            time = 0.5,
            minpos = minpos,
            maxpos = maxpos,
            minvel = {x = 0, y = -20, z = 0},
            maxvel = {x = 0, y = -20, z = 0},
            minexptime = 0.9,
            maxexptime = 1.1,
            minsize = 2,
            maxsize = 3,
            collisiondetection = true,
            collision_removal = true,
            vertical = true,
            texture = "weather_raindrop.png",
            playername = player:get_player_name(),
            glow = 5
        }
        )
    end
end
event.loop = "light_rain_loop"
weather.register_event(event)