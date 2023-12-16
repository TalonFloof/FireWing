local event = {}
event.name = "medium_clouds"
event.clouds = {
    density = 0.4,
    height = 300-16,
    thickness = 32,
}
event.eventChain = {
    {"overcast",0.06},
    {"sprinkle",0.3},
    {"light_clouds",0.1},
}
weather.register_event(event)