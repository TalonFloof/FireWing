default = {}

default.LIGHT_MAX = 14

local defaultPath = minetest.get_modpath("default")

dofile(defaultPath.."/abm.lua")
dofile(defaultPath.."/ui.lua")
dofile(defaultPath.."/crafting.lua")
dofile(defaultPath.."/tools.lua")
dofile(defaultPath.."/nodes.lua")
dofile(defaultPath.."/torch.lua")
dofile(defaultPath.."/mapgen.lua")