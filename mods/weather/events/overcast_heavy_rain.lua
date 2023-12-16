local event = {}
event.name = "overcast_heavy_rain"
event.sky = {
	type = "regular",
	clouds = true,
	sky_color = {
		day_sky = "#656D7C",
		day_horizon = "#747b89",
		dawn_sky = "#CBC0D6",
		dawn_horizon ="#d5ccde",
		night_sky = "#4B3C5A",
		night_horizon = "#6e627a",
		indoors = "#2B2B2B",
		--fog_sun_tint = "#FB7F55",
		--fog_moon_tint = "#C5C9C9",
		--fog_tint_type = "custom"
	}
}
event.moon = {
	visible = false,
	texture = "moon.png",
	tonemap = "moon_tonemap.png",
	scale = 0.5
}
event.sun = {
	visible = false,
	texture = "sun.png",
	tonemap = "sun_tonemap.png",
	sunrise = "sunrisebg.png",
	sunrise_visible = false,
	scale = 0.4
}
event.stars = {
	visible = false,
	count = 1000,
	color = "#80FCFEFF"
}
event.clouds = {
    color = "#494B54",
    density = 0.65,
    height = 300-76,
    thickness = 76,
}
event.darken = 4
event.particle_delay = 0
event.particle = function(player)
    local p=player:get_pos()
    if minetest.get_node_light({x=p.x, y=p.y+15, z=p.z}, 0.5) == 15 then
        local minpos = weather.addvec(player:get_pos(), {x = -15, y = 15, z = -15})
        local maxpos = weather.addvec(player:get_pos(), {x = 15, y = 10, z = 15})
        minetest.add_particlespawner(
        {
            amount = 15,
            time = 0.5,
            minpos = minpos,
            maxpos = maxpos,
            minvel = {x = 0, y = -10, z = 0},
            maxvel = {x = 0, y = -10, z = 0},
            minexptime = 6.0,
            maxexptime = 6.0,
            minsize = 20,
            maxsize = 20,
            collisiondetection = true,
            collision_removal = true,
            vertical = true,
            texture = "weather_heavy_raindrops.png",
            playername = player:get_player_name(),
            glow = 5
        }
        )
    end
end
event.loop = "heavy_rain_loop"
event.eventChain = {
    {"overcast_medium_rain",0.5},
    {"thunderstorm",0.5}
}
weather.register_event(event)