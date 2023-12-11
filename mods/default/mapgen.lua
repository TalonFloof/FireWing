minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_water_source", "default:water_source")
--minetest.register_alias("mapgen_lava_source", "default:lava_source")
--minetest.register_alias("mapgen_gravel", "default:gravel")

minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
--minetest.register_alias("mapgen_apple", "default:apple")
--minetest.register_alias("mapgen_junglegrass", "default:junglegrass")

--minetest.register_alias("mapgen_cobble", "default:cobble")
--minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
--minetest.register_alias("mapgen_mossycobble", "default:mossycobble")

minetest.clear_registered_biomes()
minetest.clear_registered_decorations()

minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:mud",
	wherein         = {"default:mud_with_wet_grass"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 16,
	y_max           = 31000,
	y_min           = -31000,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = -316,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_biome({
	name = "Grasslands",
	--node_dust = "",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 1,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = 2,
	y_max = 31000,
	heat_point = 50,
	humidity_point = 35,
})
minetest.register_biome({
	name = "Grasslands Ocean",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = -31000,
	y_max = 2,
	heat_point = 50,
	humidity_point = 35,
})

minetest.register_biome({
	name = "Rainforest",
	--node_dust = "",
	node_top = "default:mud_with_wet_grass",
	depth_top = 1,
	node_filler = "default:mud",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = 1,
	y_max = 20,
	heat_point = 80,
	humidity_point = 88,
})
minetest.register_biome({
	name = "Submurged Rainforest",
	--node_dust = "",
	node_top = "default:mud",
	depth_top = 1,
	node_filler = "default:mud",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = -2,
	y_max = 0,
	heat_point = 80,
	humidity_point = 88,
})

minetest.register_biome({
	name = "Deciduous Forest",
	--node_dust = "",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = 2,
	y_max = 31000,
	heat_point = 60,
	humidity_point = 68,
})
minetest.register_biome({
	name = "Deciduous Forest Ocean",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = -31000,
	y_max = 2,
	heat_point = 60,
	humidity_point = 68,
})

minetest.register_biome({
	name = "Desert",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 3,
	y_max = 31000,
	y_min = 2,
	heat_point = 92,
	humidity_point = 16,
})
minetest.register_biome({
	name = "Desert Ocean",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = -31000,
	y_max = 2,
	heat_point = 92,
	humidity_point = 16,
})

minetest.register_biome({
	name = "Tundra",
	node_top = "default:dirt_with_snow",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 1,
	node_riverbed = "default:sand",
	depth_riverbed = 2,
	y_max = 31000,
	y_min = 2,
	heat_point = 20,
	humidity_point = 35,
})
minetest.register_biome({
	name = "Tundra Ocean",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = -31000,
	y_max = 2,
	heat_point = 20,
	humidity_point = 35,
})

minetest.register_biome({
	name = "Taiga",
	node_top = "default:dirt_with_snow",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_riverbed = "default:sand",
	depth_riverbed = 2,
	y_max = 31000,
	y_min = 2,
	heat_point = 25,
	humidity_point = 70,
})
minetest.register_biome({
	name = "Taiga Ocean",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	y_min = -31000,
	y_max = 2,
	heat_point = 25,
	humidity_point = 70,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass"},
      sidelen = 16,
      noise_params = {
		offset = 0.024,
		scale = 0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
		},
      biomes = {"Deciduous Forest"},
      flags = "place_center_x, place_center_z, force_placement",
      schematic = minetest.get_modpath("default")
         .. "/schematics/Tree2.mts",
      y_min = default.GLOBAL_Y_MIN,
      y_max = default.GLOBAL_Y_MAX,
})

minetest.register_decoration(
   {
      deco_type = "schematic",
      place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
      sidelen = 16,
      noise_params = {
		offset = 0.0,
		scale = -0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
      biomes = {"Deciduous Forest"},
      flags = "place_center_x, place_center_z, force_placement",
      schematic = minetest.get_modpath("default")
         .. "/schematics/Tree1.mts",
      y_min = default.GLOBAL_Y_MIN,
      y_max = default.GLOBAL_Y_MAX,
})

minetest.register_decoration({
	name = "default:bush",
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.006,
	biomes = {"Grasslands", "Deciduous Forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("default") .. "/schematics/Bush1.mts",
	flags = "place_center_x, place_center_z, force_placement",
})

minetest.register_decoration(
   {
      deco_type = "simple",
      place_on = "default:dirt_with_grass",
      sidelen = 16,
      fill_ratio = 0.18,
      decoration = {"default:grass"},
      y_min = 0,
      y_max = default.GLOBAL_Y_MAX,
})

minetest.register_decoration({
	name = "default:rainforest_tree",
	deco_type = "schematic",
	place_on = {"default:mud_with_wet_grass","default:mud"},
	sidelen = 16,
	fill_ratio = 0.08,
	biomes = {"Rainforest", "Submurged Rainforest"},
	y_max = 31000,
	y_min = -31000,
	schematic = minetest.get_modpath("default") .. "/schematics/RainforestTree.mts",
	replacements = {["default:tree"]="default:mangrove_tree",["default:leaves"]="default:mangrove_leaves"},
	flags = "place_center_x, place_center_z",
})