local event = {}
event.name = "overcast"
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
    color = "#777985",
    density = 0.65,
    height = 300-64,
    thickness = 64,
}
event.darken = 1
event.eventChain = {
	{"light_clouds",0.05},
    {"medium_clouds",0.01},
	{"overcast_light_rain",0.5}
}
weather.register_event(event)