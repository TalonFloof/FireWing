local recipes = {}
local default_groups = {
    ["tree"] = "default:tree 1"
}
local row = {}

local function generateFormspec(row)
    local s = "size[8.5,9]"
    s = s .. "bgcolor[#00000000]"
    s = s .. "background[0,0;8.5,9;ui_bg_tall.png]"
    s = s .. "background[0,0;8.5,4.5;ui_bg_short.png]"
    s = s .. "list[current_player;main;0.25,4.75;8,4;]"
    s = s .. "list[current_player;craft_in;0.25,0.25;1,4;]"
    s = s .. "listring[current_player;main]"
    s = s .. "listring[current_player;craft_in]"
    s = s .. "listring[current_player;main]"
    s = s .. "tablecolumns[text,align=left,width=2;text,align=left,width=40]"
    s = s .. default.ui_button(7.25, 1.25, 1, 1, "do_craft_1", "1", nil, "Craft once")
    s = s .. default.ui_button(7.25, 2.25, 1, 1, "do_craft_10", "10", nil, "Craft 10 times")
    -- Find Available Recipes
    local craft_list = ""
    for _,i in pairs(recipes) do
        if craft_list ~= "" then
            craft_list = craft_list .. ","
         end
         craft_list = craft_list .. minetest.formspec_escape(ItemStack(i.output):get_description())
    end
    if row ~= 0 then
        for i,j in ipairs(recipes[row].input) do
            local stack = j
            if string.match(j, "group:(.*)") ~= nil then
                local group = string.match(ItemStack(j):get_name(), "group:(.*)")
                if default_groups[group] then
                    stack = default_groups[group]
                else
                    for itemn, _ in pairs(minetest.registered_items) do
                        if minetest.get_item_group(itemn, group) ~= 0 then
                            stack = itemn .. " " .. ItemStack(j):get_count()
                        end
                    end
                end
            end
            s = s .. "item_image[1.25,"..(0.25+(i-1))..";1,1;"..stack.."]"
        end
    end
    s = s .. "table[2.25,0.25;4.75,3.75;craft_list;" .. craft_list .. ";"..row.."]"
    return s
end

function default.register_recipe(input,output)
    table.insert(recipes,{input=input,output=output})
end

minetest.register_on_joinplayer(function(player)
    row[player:get_player_name()] = 0
    local inv = player:get_inventory()
    if inv:get_size("craft_in") ~= 4 then
        inv:set_size("craft_in", 4)
     end
    -- Move items out of input and output slots
    local items_moved = false
    local pos = player:get_pos()
    local lists = { "craft_in" }
    for l = 1, #lists do
        local list = lists[l]
        for i = 1, inv:get_size(list) do
            local itemstack = inv:get_stack(list, i)
            if not itemstack:is_empty() then
                if inv:room_for_item("main", itemstack) then
                    inv:add_item("main", itemstack)
                else
                    minetest.drop_item(player, pos, itemstack)
                end

                itemstack:clear()
                inv:set_stack(list, i, itemstack)

                items_moved = true
            end
        end
    end
    player:set_inventory_formspec(generateFormspec(0))
end)

minetest.register_on_player_receive_fields(function(player, form_name, fields)
    local inv = player:get_inventory()
    if fields.craft_list then
        local selection = minetest.explode_table_event(fields.craft_list)
        if selection.type == "CHG" then
            row[player:get_player_name()] = selection.row
            player:set_inventory_formspec(generateFormspec(selection.row))
        end
    end
    if fields.do_craft_1 or fields.do_craft_10 then
        local count = 1
        if fields.do_craft_10 then count = 10 end
        local recipe = recipes[row[player:get_player_name()]]
        for i=1,count do
            local canCraft = true
            for slot,item in ipairs(recipe.input) do
                local stack = inv:get_stack("craft_in",slot)
                if stack:get_count() >= ItemStack(item):get_count() then
                    if string.match(item, "group:(.*)") ~= nil then
                        local group = string.match(ItemStack(item):get_name(), "group:(.*)")
                        if minetest.get_item_group(stack:get_name(), group) == 0 then
                            canCraft = false
                        end
                    else
                        if stack:get_name() ~= ItemStack(item):get_name() then
                            canCraft = false
                        end
                    end
                else
                    canCraft = false
                end
            end
            if not inv:room_for_item("main", ItemStack(recipe.output)) then
                canCraft = false
            end
            if canCraft then
                for slot,item in ipairs(recipe.input) do
                    local stack = inv:get_stack("craft_in",slot)
                    stack:take_item(ItemStack(item):get_count())
                    inv:set_stack("craft_in",slot,stack)
                end
                inv:add_item("main",ItemStack(recipe.output))
            else
                break
            end
        end
    end
end)