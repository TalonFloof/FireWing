function default.ui_button(x, y, w, h, name, label, noclip, tooltip)
    local nc = "false"
 
    if noclip then
       nc = "true"
    end
 
    local tt = ""
    if tooltip then
       tt = "tooltip["..name..";"..minetest.formspec_escape(tooltip).."]"
    end
 
    if w == 1 then
       return "image_button["..x..","..y..";"..w..","..h
          ..";ui_button_1w_inactive.png;"..name..";"..minetest.formspec_escape(label)..";"
          ..nc..";false;ui_button_1w_active.png]"
          ..tt
    end
 end