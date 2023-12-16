local event = {}
event.name = "clear"
event.clouds = {
    density = 0.2,
    height = 300,
    thickness = 16
}
event.eventChain = {
    {"light_clouds", 1}
}
weather.register_event(event)