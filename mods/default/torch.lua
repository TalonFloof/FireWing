local function register_torch(subname, description, tiles, overlay_tiles, overlay_side_R90, inv_image, light, on_construct, on_timer, next_torch_level, ignite_pitch)
    local on_ignite, on_ignite_wall
    if next_torch_level then
       on_ignite = function(pos, itemstack, user)
          local node = minetest.get_node(pos)
          minetest.set_node(pos, {name="rp_default:"..next_torch_level, param2=node.param2})
          return {pitch=ignite_pitch or 1.0}
       end
       on_ignite_wall = function(pos, itemstack, user)
          local node = minetest.get_node(pos)
          minetest.set_node(pos, {name="rp_default:"..next_torch_level.."_wall", param2=node.param2})
          return {pitch=ignite_pitch or 1.0}
       end
    end
    minetest.register_node(
       "default:"..subname,
       {
          description = description,
          drawtype = "nodebox",
          tiles = tiles,
          use_texture_alpha = "clip",
          overlay_tiles = overlay_tiles,
          inventory_image = inv_image,
          wield_image = inv_image,
          paramtype = "light",
          paramtype2 = "wallmounted",
          light_source = light,
          sunlight_propagates = true,
          walkable = false,
          floodable = true,
          on_flood = function(pos, oldnode, newnode)
             if light and light > 0 then
                minetest.sound_play({name="default_torch_burnout", gain=0.1, max_hear_distance = 8}, {pos=pos}, true)
             end
             minetest.add_item(pos, "default:torch_dead")
          end,
          node_placement_prediction = "",
          node_box = {
         type = "wallmounted",
         wall_top = {-2/16, 0, -2/16, 2/16, 0.5, 2/16},
         wall_bottom = {-2/16, -0.5, -2/16, 2/16, 0, 2/16},
         wall_side = {-0.5, -8/16, -2/16, -0.5+4/16, 0, 2/16},
          },
          groups = {choppy = 2, dig_immediate = 3, attached_node = 1, torch = 1, creative_decoblock = 1},
          is_ground_content = false,
          sounds = default.node_sound_small_defaults(),
      on_construct = on_construct,
      on_timer = on_timer,
          on_place = function(itemstack, placer, pointed_thing)
             if pointed_thing.type ~= "node" then
                return itemstack
             end
             local under = pointed_thing.under
             local node = minetest.get_node(under)
             local def = minetest.registered_nodes[node.name]
             if def and def.on_rightclick and
                   not (placer and placer:is_player() and
                   placer:get_player_control().sneak) then
                return def.on_rightclick(under, node, placer, itemstack, pointed_thing) or itemstack
             end
 
             local above = pointed_thing.above
             if minetest.is_protected(above, placer:get_player_name()) and
                   not minetest.check_player_privs(placer, "protection_bypass") then
                minetest.record_protection_violation(pos, placer:get_player_name())
                return itemstack
             end
 
             local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
             local fakestack = itemstack
             if wdir == 0 or wdir == 1 then
                fakestack:set_name("default:"..subname)
             else
                fakestack:set_name("default:"..subname.."_wall")
             end
 
             local place_pos
             itemstack, place_pos = minetest.item_place(fakestack, placer, pointed_thing, wdir)
             if not place_pos then
                wdir = 1
                fakestack:set_name("default:"..subname)
                itemstack, place_pos = minetest.item_place(fakestack, placer, pointed_thing, wdir)
             end
             if place_pos then
                minetest.sound_play({name="default_place_smallnode", gain=1.0}, {pos=pos}, true)
             end
             itemstack:set_name("default:"..subname)
 
             return itemstack
     end,
 
     _rp_on_ignite = on_ignite,
    })
    local copy, copy_o
    for i=1,6 do
       if tiles[i] ~= nil then
           copy = tiles[i]
       else
           tiles[i] = copy
       end
       if overlay_tiles then
           if overlay_tiles[i] ~= nil then
               copy_o = overlay_tiles[i]
           else
               overlay_tiles[i] = copy_o
           end
       end
    end
    local copy_tile = function(tile)
       if type(tile) == "table" then
          return table.copy(tile)
       else
          return tile
       end
    end
    local overlay_tiles2
    if overlay_tiles then
       overlay_tiles2 = {
           copy_tile(overlay_tiles[3]),
           copy_tile(overlay_tiles[4]),
           copy_tile(overlay_side_R90),
           copy_tile(overlay_side_R90),
           copy_tile(overlay_tiles[1]),
           copy_tile(overlay_tiles[2]),
       }
    end
    local tiles2
    if tiles then
       tiles2 = {
           tiles[3],
           tiles[4],
           tiles[5].."^[transformR90",
           tiles[6].."^[transformR90",
           tiles[1],
           tiles[2],
       }
    end
    minetest.register_node(
       "default:"..subname.."_wall",
       {
          drawtype = "nodebox",
          tiles = tiles2,
          use_texture_alpha = "clip",
          overlay_tiles = overlay_tiles2,
          paramtype = "light",
          paramtype2 = "wallmounted",
          light_source = light,
          sunlight_propagates = true,
          walkable = false,
          floodable = true,
          on_flood = function(pos, oldnode, newnode)
             if light and light > 0 then
                minetest.sound_play({name="default_torch_burnout", gain=0.1, max_hear_distance = 8}, {pos=pos}, true)
             end
             minetest.add_item(pos, "default:torch_dead")
          end,
          node_box = {
         type = "wallmounted",
         wall_top = {-2/16, 0, -2/16, 2/16, 0.5, 2/16},
         wall_bottom = {-2/16, -0.5, -2/16, 2/16, 0, 2/16},
         wall_side = {-0.5, -8/16, -2/16, -0.5+4/16, 0, 2/16},
          },
          drop = "default:"..subname,
          groups = {choppy = 2, dig_immediate = 3, attached_node = 1, not_in_creative_inventory = 1, torch = 2},
          is_ground_content = false,
          sounds = default.node_sound_small_defaults({}),
      on_construct = on_construct,
      on_timer = on_timer,
 
      _rp_on_ignite = on_ignite_wall,
    })
 
 
 
 
 end

 local tiles_base = {"default_torch_ends.png","default_torch_bottom.png","default_torch_base.png"}
 local overlay_tiles_normal = {
    {
        name = "default_torch_ends_overlay.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1.0,
        },
    },
    {
        name = "blank.png",
    },
    {
        name = "default_torch_overlay.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1.0,
        },
    },
}

local overlayR90_weak = {
    name = "default_torch_weak_overlayR90.png",
    animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 1.0,
    },
}
local overlayR90_normal = {
    name = "default_torch_overlayR90.png",
    animation = {
        type = "vertical_frames",
        aspect_w = 16,
        aspect_h = 16,
        length = 1.0,
    },
}
 register_torch("torch", "Torch", {"default_torch_ends.png","default_torch_bottom.png","default_torch_base.png"}, overlay_tiles_normal, overlayR90_normal, "default_torch_inventory.png", default.LIGHT_MAX-1)