weather = {}

weather.active_condition = nil
weather.time_left = 0
weather.events = {}

minetest.register_globalstep(function(t)
    weather.time_left = weather.time_left - t
    
end)

function weather.register_event(event)
    
end