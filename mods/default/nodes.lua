function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="", gain=1.0}
	table.dug = table.dug or
			{name="default_dug_node", gain=1.0}
	table.place = table.place or {name="default_place_node"}
	return table
end

function default.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.8}
	table.place = table.place or {name="default_place_node_hard"}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_dirt_footstep", gain=1.0}
	table.dig = table.dig or
			{name="default_dig_crumbly", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_grass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_grass_footstep", gain=1.0}
	table.dig = table.dig or
		{name="default_dig_crumbly", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_sand_footstep", gain=0.5}
	table.dig = table.dig or
		{name="default_sand_footstep", gain=0.5}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_water_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
	   {name="default_water_footstep", gain=0.10}
	table.dug = table.dug or
	   {name="default_dug_water", gain=0.5}
	table.place = table.place or
	   {name="default_place_node_water", gain=0.5}
	default.node_sound_defaults(table)
	return table
 end

 function default.node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.3}
	table.dig = table.dig or {name="default_dig_choppy", gain = 1.0}
	table.place = table.place or {name="default_place_node_hard"}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_grass_footstep", gain=0.25}
	table.dig = table.dig or
			{name="default_dig_crumbly", gain=1.0}
	table.dug = table.dug or
			{name="", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_small_defaults(table)
	table = table or {}
	table.place = table.place or {name="default_place_smallnode", gain=1.0}
	table.dig = table.dig or {name="default_dig_smallnode", gain=1.0}
	table.dug = table.dug or {name="default_dug_smallnode", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

minetest.register_node("default:stone", {
	description = "Stone",
	tiles ={"default_stone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults({}),
	drop = 'default:cobble'
})

minetest.register_node("default:dirt", {
	description = "Dirt",
	tiles ={"default_dirt.png"},
	sounds = default.node_sound_dirt_defaults({}),
	groups = {crumbly=3, soil=1},
})

minetest.register_node("default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles ={"default_grass.png", "default_dirt.png",
		{name = "default_dirt.png^default_grass_side.png",
		tileable_vertical = false}},
	groups = {crumbly=3, soil=1, grass=1},
	sounds = default.node_sound_grass_defaults({}),
	drop = 'default:dirt',
})

minetest.register_node("default:mud_with_wet_grass", {
	description = "Mud with Wet Grass",
	tiles ={"default_wet_grass.png", "default_mud.png",
		{name = "default_mud.png^default_wet_grass_side.png",
		tileable_vertical = false}},
	groups = {crumbly=3, soil=1},
	sounds = default.node_sound_grass_defaults({}),
	drop = 'default:mud_with_wet_grass',
})

minetest.register_node("default:mud", {
	description = "Mud",
	tiles ={"default_mud.png"},
	groups = {crumbly=3, soil=1},
	sounds = default.node_sound_dirt_defaults({}),
	drop = 'default:mud',
})

minetest.register_node("default:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles ={"default_snow.png", "default_dirt.png",
		{name = "default_dirt.png^default_snow_side.png",
		tileable_vertical = false}},
	groups = {crumbly=3, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_snow_footstep", gain = 0.2},
	}),
	drop = 'default:dirt',
})

minetest.register_node("default:sand", {
	description = "Sand",
	tiles ={"default_sand.png"},
	groups = {crumbly=3, falling_node=1},
	sounds = default.node_sound_sand_defaults({}),
})

minetest.register_node("default:gravel", {
	description = "Gravel",
	tiles ={"default_gravel.png"},
	groups = {crumbly=3, falling_node=1},
	sounds = default.node_sound_sand_defaults({}),
})

minetest.register_node(
   "default:water_flowing",
   {
      description = "Flowing Water",
      drawtype = "flowingliquid",
      tiles = {"default_water.png"},
      special_tiles = {
	 {
	    name = "default_water_animated.png",
	    backface_culling = false,
	    animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.8}
	 },
	 {
	    name = "default_water_animated.png",
	    backface_culling = true,
	    animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.8}
	 },
      },
      use_texture_alpha = "blend",
      drop = "",
      paramtype = "light",
      sunlight_propagates = false,
      walkable = false,
      pointable = false,
      diggable = false,
      buildable_to = true,
      drowning = 1,
	  waving = 3,
      is_ground_content = false,
      liquidtype = "flowing",
      liquid_alternative_flowing = "default:water_flowing",
      liquid_alternative_source = "default:water_source",
      liquid_viscosity = default.WATER_VISC,
      post_effect_color = {a = 90, r = 40, g = 40, b = 100},
      groups = {water = 1, flowing_water = 1, liquid = 1, not_in_creative_inventory=1,},
	  sounds = default.node_sound_water_defaults(),
})

minetest.register_node(
   "default:water_source",
   {
      description = "Water Source",
      drawtype = "liquid",
      tiles = {
	 {
	    name = "default_water_source_animated.png",
	    backface_culling = false,
	    animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.8}
	 },
	 {
	    name = "default_water_source_animated.png",
	    backface_culling = true,
	    animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.8}
	 },
      },
      use_texture_alpha = "blend",
      sunlight_propagates = false,
      drop = "",
      paramtype = "light",
      walkable = false,
      pointable = false,
      diggable = false,
      buildable_to = true,
      drowning = 1,
	  waving = 3,
      is_ground_content = false,
      liquidtype = "source",
      liquid_alternative_flowing = "default:water_flowing",
      liquid_alternative_source = "default:water_source",
      liquid_viscosity = default.WATER_VISC,
      post_effect_color = {a=90, r=40, g=40, b=100},
      groups = {water=1, liquid=1},
	  sounds = default.node_sound_water_defaults(),
})

minetest.register_node(
   "default:grass",
   {
      description = "Grass Clump",
      drawtype = "plantlike",
      selection_box = {
	 type = "fixed",
	 fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
      },
      visual_scale = 1.15,
      tiles = {"default_grass_clump.png"},
      inventory_image = "default_grass_clump_inventory.png",
      wield_image = "default_grass_clump_inventory.png",
      paramtype = "light",
      sunlight_propagates = true,
      waving = 1,
      walkable = false,
      buildable_to = true,
      floodable = true,
      groups = {snappy = 2, dig_immediate = 3, attached_node = 1, grass = 1, normal_grass = 1, green_grass = 1, plant = 1, spawn_allowed_in = 1}
})

minetest.register_node("default:tree", {
	description = "Tree",
	tiles ={"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=1,tree=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	tiles ={"default_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3,leafdecay=3},
	waving = 1,
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node(
   "default:sapling",
   {
      description = "Sapling",
      drawtype = "plantlike",
      tiles = {"default_sapling.png"},
      inventory_image = "default_sapling_inventory.png",
      wield_image = "default_sapling_inventory.png",
      paramtype = "light",
      sunlight_propagates = true,
      walkable = false,
      floodable = true,
      selection_box = {
	 type = "fixed",
	 fixed = {-0.4, -0.5, -0.4, 0.4, 0.4, 0.4},
      },
      groups = {snappy = 2, dig_immediate = 3, leafdecay_drop=1},
      is_ground_content = false,
      sounds = default.node_sound_wood_defaults({}),

      on_timer = function(pos)
         default.grow_sapling(pos)
      end,

      on_construct = function(pos)
         --default.begin_growing_sapling(pos)
      end,

      node_placement_prediction = "",
      on_place = default.place_sapling,
})

minetest.register_node("default:mangrove_tree", {
	description = "Mangrove Tree",
	tiles ={"default_mangrove_tree_top.png", "default_mangrove_tree_top.png", "default_mangrove_tree.png"},
	is_ground_content = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=1,tree=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:mangrove_leaves", {
	description = "Mangrove Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1,
	tiles ={"default_mangrove_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3,leafdecay=3},
	waving = 1,
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:mangrove_leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:bush_stem", {
	description = "Bush Stem",
	drawtype = "plantlike",
	tiles = {"default_bush_stem.png"},
	is_ground_content = false,
	paramtype = "light",
    sunlight_propagates = true,
	waving = 0,
	walkable = true,
    buildable_to = false,
    floodable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=1,tree=1},
	visual_scale = 1,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:bush_leaves", {
	description = "Bush Leaves",
	drawtype = "allfaces_optional",
	tiles ={"default_bush_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3,leafdecay=2},
	waving = 1,
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'default:bush_sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:bush_leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:wood", {
	description = "Wood",
	tiles ={"default_wood.png"},
	is_ground_content = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
})

default.register_recipe({"group:tree 1"},"default:wood 4")