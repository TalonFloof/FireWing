local event = {}
event.name = "light_clouds"
event.clouds = {
    density = 0.25,
    height = 300-16,
    thickness = 32,
}
event.eventChain = {
    {"clear",0.1},
    {"medium_clouds",0.3}
}
weather.register_event(event)