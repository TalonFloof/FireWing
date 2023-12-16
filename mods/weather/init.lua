weather = {}

weather.previous_condition = nil
weather.active_condition = nil
weather.particle_time_left = 0
weather.time_left = 0.2
weather.transition_left = 0
weather.events = {}
weather.sounds = {}
weather.sounds_event = {}

local path = minetest.get_modpath("weather")

function weather.register_event(event)
    weather.events[event.name] = event
end

function weather.addvec(v1, v2)
    return {x = v1.x + v2.x, y = v1.y + v2.y, z = v1.z + v2.z}
end

dofile(path.."/events/clear.lua")
dofile(path.."/events/light_clouds.lua")
dofile(path.."/events/medium_clouds.lua")
dofile(path.."/events/sprinkle.lua")
dofile(path.."/events/light_rain.lua")
dofile(path.."/events/overcast.lua")
dofile(path.."/events/overcast_light_rain.lua")
dofile(path.."/events/overcast_medium_rain.lua")
dofile(path.."/events/overcast_heavy_rain.lua")
dofile(path.."/events/thunderstorm.lua")
dofile(path.."/events/superstorm.lua")

local function lerp(a,b,t)
    return (b-a)*math.min(1.0,t)+a
end

minetest.register_globalstep(function(t)
    weather.time_left = weather.time_left - t
    if weather.time_left <= 0 then
        if weather.active_condition == nil then
            weather.previous_condition = weather.events["medium_clouds"]
            weather.active_condition = weather.events["medium_clouds"]
            weather.time_left = 90 + math.random(-30,30)
        else
            weather.previous_condition = weather.active_condition
            for _,i in ipairs(weather.active_condition.eventChain) do
                if math.random() <= i[2] then
                    weather.active_condition = weather.events[i[1]]
                    break
                end
            end
            weather.time_left = 90 + math.random(-30,30)
        end
        weather.transition_left = 5
        minetest.chat_send_all("New Weather Event is "..weather.active_condition.name.." for "..weather.time_left.."s")
        if weather.active_condition.loop ~= nil then
            for _,player in ipairs(minetest.get_connected_players()) do
                if weather.sounds[player:get_player_name()] ~= nil and weather.sounds_event[player:get_player_name()] ~= weather.active_condition.name then
                    minetest.sound_fade(weather.sounds[player:get_player_name()],2,0)
                    weather.sounds[player:get_player_name()] = nil
                    weather.sounds_event[player:get_player_name()] = nil
                end
            end
        end
    end
    for _,player in ipairs(minetest.get_connected_players()) do
        if weather.transition_left >= 0 then
            weather.transition_left = weather.transition_left - t
            local final = {
                color = weather.active_condition.clouds.color,
                density = lerp(weather.previous_condition.clouds.density,weather.active_condition.clouds.density,(5.0-weather.transition_left)/5.0),
                height = (lerp(weather.previous_condition.clouds.height,weather.active_condition.clouds.height,(5.0-weather.transition_left)/5.0)),
                thickness = (lerp(weather.previous_condition.clouds.thickness,weather.active_condition.clouds.thickness,(5.0-weather.transition_left)/5.0))
            }
            player:set_clouds(final)
            player:set_sky(weather.active_condition.sky)
            player:set_sun(weather.active_condition.sun)
            player:set_moon(weather.active_condition.moon)
            player:set_stars(weather.active_condition.stars)
            if not weather.active_condition.darken then
                player:override_day_night_ratio(nil)
            end
        end
        if weather.active_condition ~= nil then
            if weather.active_condition.darken ~= nil and weather.active_condition.darken > 0 then
                local light = (minetest.get_timeofday() * 2)

                if light > 1 then
                light = 1 - (light - 1)
                end

                light = (light * lerp(0.5,0.1,(weather.active_condition.darken-1.0)/4.0)) + 0.15
                player:override_day_night_ratio(light)
            end
            if weather.active_condition.particle ~= nil then
                weather.particle_time_left = weather.particle_time_left - t
                if weather.particle_time_left <= 0 then
                    weather.active_condition.particle(player)
                    weather.particle_time_left = weather.active_condition.particle_delay
                end
            end
            if weather.active_condition.loop == nil and weather.sounds[player:get_player_name()] ~= nil then
                minetest.sound_stop(weather.sounds[player:get_player_name()])
                weather.sounds[player:get_player_name()] = nil
                weather.sounds_event[player:get_player_name()] = nil
            elseif weather.active_condition.loop ~= nil and weather.sounds[player:get_player_name()] == nil then
                weather.sounds[player:get_player_name()] = minetest.sound_play(weather.active_condition.loop, {to_player = player:get_player_name(), loop = true, gain = 0.0})
                minetest.sound_fade(weather.sounds[player:get_player_name()],2,1)
                weather.sounds_event[player:get_player_name()] = weather.active_condition.name
            end
        end
    end
end)

minetest.register_chatcommand("progress_weather", {
    description = "Progresses to the next Weather Event within the Markov Chain",
    func = function(name)
        weather.time_left = 0
    end
})