local event = {}
event.name = "fog"
event.sky = {
	type = "regular",
	clouds = true,
	sky_color = {
		day_sky = "#B5B6B6",
		day_horizon = "#bcbdbd",
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
	color = "#FFFFFFD0",
	density = 1,
	height = 2.1,
	thickness = 256,
	speed = {x=0, z=0}
}
event.darken = 1
event.eventChain = {
    {"overcast",0.05},
    {"overcast_light_rain",0.05}
}
weather.register_event(event)