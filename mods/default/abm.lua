minetest.register_abm({
	label = "Grass Spreading",
	nodenames = {"default:dirt"},
	neighbors = {
		"air",
		"group:grass",
		"default:snow",
	},
	interval = 2,
	chance = 20,
	catch_up = false,
	action = function(pos, node)
		-- Check for darkness: night, shadow or under a light-blocking node
		-- Returns if ignore above
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 13 then
			return
		end

		-- Look for spreading dirt-type neighbours
		local p2 = minetest.find_node_near(pos, 1, "group:grass")
		if p2 then
			local n3 = minetest.get_node(p2)
			minetest.set_node(pos, {name = n3.name})
			return
		end

		-- Else, any seeding nodes on top?
		local name = minetest.get_node(above).name
		-- Snow check is cheapest, so comes first
		if name == "default:snow" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
        end
	end
})

minetest.register_abm({
label = "Leaf Decay for Trees",
nodenames = {"default:leaves"},
interval = 1,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	if minetest.find_node_near(pos, 5, { "default:tree" }) == nil then
		minetest.remove_node(pos)
	end
end
})

minetest.register_abm({
	label = "Leaf Decay for Mangrove Trees",
	nodenames = {"default:mangrove_leaves"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.find_node_near(pos, 5, { "default:mangrove_tree" }) == nil then
			minetest.remove_node(pos)
		end
	end
	})

minetest.register_abm({
	label = "Leaf Decay for Bushes",
	nodenames = {"default:bush_leaves"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.find_node_near(pos, 5, { "default:bush_stem" }) == nil then
			minetest.remove_node(pos)
			if math.random(0,5) == 0 then
				minetest.add_item({
					x = pos.x - 0.5 + math.random(),
					y = pos.y - 0.5 + math.random(),
					z = pos.z - 0.5 + math.random(),
				},"default:bush_sapling")
			end
		end
	end
	})