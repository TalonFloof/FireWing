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

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
      local finds_per_second = 5000
      default.leafdecay_trunk_find_allow_accumulator =
         math.floor(dtime * finds_per_second)
end)

local GRAVITY = tonumber(minetest.settings:get("movement_gravity") or 9.81)

minetest.register_abm( -- leaf decay
   {

      label = "Leaf Decay",
      nodenames = {"group:leafdecay"},
      neighbors = {"air", "group:liquid"},
      -- A low interval and a high inverse chance spreads the load
      interval = 2,
      chance = 3,

      action = function(p0, node, _, _)
         local do_preserve = false
         local d = minetest.registered_nodes[node.name].groups.leafdecay
         if not d or d == 0 then
            return
         end
         local n0 = minetest.get_node(p0)
         if n0.param2 ~= 0 then
            return
         end
         local p0_hash = nil
         if default.leafdecay_enable_cache then
            p0_hash = minetest.hash_node_position(p0)
            local trunkp = default.leafdecay_trunk_cache[p0_hash]
            if trunkp then
               local n = minetest.get_node(trunkp)
               local reg = minetest.registered_nodes[n.name]
               -- Assume ignore is a trunk, to make the thing work at the border of the active area
               if n.name == "ignore" or (reg and reg.groups.tree and reg.groups.tree ~= 0) then
                  return
               end
               -- Cache is invalid
               table.remove(default.leafdecay_trunk_cache, p0_hash)
            end
         end
         if default.leafdecay_trunk_find_allow_accumulator <= 0 then
            return
         end
         default.leafdecay_trunk_find_allow_accumulator =
            default.leafdecay_trunk_find_allow_accumulator - 1
         -- Assume ignore is a trunk, to make the thing work at the border of the active area
         local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
         if p1 then
            do_preserve = true
            if default.leafdecay_enable_cache then
               -- Cache the trunk
               default.leafdecay_trunk_cache[p0_hash] = p1
            end
         end
         if not do_preserve then
            -- Drop stuff other than the node itself
            local itemstacks = minetest.get_node_drops(n0.name)
            local leafdecay_drop = minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0
            for _, itemname in ipairs(itemstacks) do
               if leafdecay_drop or itemname ~= n0.name then
                  local p_drop = {
                     x = p0.x - 0.5 + math.random(),
                     y = p0.y - 0.5 + math.random(),
                     z = p0.z - 0.5 + math.random(),
                  }
                  minetest.add_item(p_drop, itemname)
               end
            end
            -- Remove node
            minetest.remove_node(p0)
            -- Trigger fall
            local above = {x=p0.x, y=p0.y+1, z=p0.z}
            minetest.check_for_falling(above)
            -- Particles
	    if not leafdecay_drop then
               minetest.add_particlespawner({
                  amount = math.random(10, 20),
                  time = 0.1,
                  minpos = vector.add(p0, {x=-0.4, y=-0.4, z=-0.4}),
                  maxpos = vector.add(p0, {x=0.4, y=0.4, z=0.4}),
                  minvel = {x=-0.2, y=-0.2, z=-0.2},
                  maxvel = {x=0.2, y=0.1, z=0.2},
                  minacc = {x=0, y=-GRAVITY, z=0},
                  maxacc = {x=0, y=-GRAVITY, z=0},
                  minexptime = 0.1,
                  maxexptime = 0.5,
                  minsize = 0.5,
                  maxsize = 1.5,
                  collisiondetection = true,
                  vertical = false,
                  node = n0,
               })
            end
         end
      end
})