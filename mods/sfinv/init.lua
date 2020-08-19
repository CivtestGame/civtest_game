dofile(minetest.get_modpath("sfinv") .. "/api.lua")

local minecraft_style_crafting = [[
   list[current_player;craft;1.75,0.5;3,3;]
   list[current_player;craftpreview;5.75,1.5;1,1;]
   image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]
   image[0,7.85;1,1;gui_hb_bg.png]
   image[1,7.85;1,1;gui_hb_bg.png]
   image[2,7.85;1,1;gui_hb_bg.png]
   image[3,7.85;1,1;gui_hb_bg.png]
   image[4,7.85;1,1;gui_hb_bg.png]
   image[5,7.85;1,1;gui_hb_bg.png]
   image[6,7.85;1,1;gui_hb_bg.png]
   image[7,7.85;1,1;gui_hb_bg.png]
   listring[current_player;craft]
   listring[current_player;router]
   listring[current_player;main2]
   listring[current_player;main]
   listring[current_player;main2]
]]

local minetest_style_crafting = [[
   list[current_player;craft;1.75,0.5;3,3;]
   list[current_player;craftpreview;5.75,1.5;1,1;]
   image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]
   image[0,7.85;1,1;gui_hb_bg.png]
   image[1,7.85;1,1;gui_hb_bg.png]
   image[2,7.85;1,1;gui_hb_bg.png]
   image[3,7.85;1,1;gui_hb_bg.png]
   image[4,7.85;1,1;gui_hb_bg.png]
   image[5,7.85;1,1;gui_hb_bg.png]
   image[6,7.85;1,1;gui_hb_bg.png]
   image[7,7.85;1,1;gui_hb_bg.png]
   listring[current_player;craft]
   listring[current_player;router]
   listring[current_player;main2]
   listring[current_player;craft]
   listring[current_player;main]
   listring[current_player;craft]
]]

sfinv.register_page("sfinv:crafting", {
	title = "Main",
	get = function(self, player, context)
           local meta = player:get_meta()
           if meta:get_string("sfinv:inventory_type") == "minetest" then
              return sfinv.make_formspec(
                 player, context, minetest_style_crafting, true
              )
           else
              return sfinv.make_formspec(
                 player, context, minecraft_style_crafting, true
              )
           end
	end
})

minetest.register_chatcommand("inventory_mode", {
   params = "",
   description
      = "Toggles between Minetest and Minecraft style crafting inventory UI.",
   func = function(name, param)
      local player = minetest.get_player_by_name(name)
      if not player then
         return
      end
      local meta = player:get_meta()
      local mode = meta:get_string("sfinv:inventory_type")
      local new_mode = "minecraft"
      if mode ~= "minetest" then
         new_mode = "minetest"
      end
      meta:set_string("sfinv:inventory_type", new_mode)
      sfinv.set_player_inventory_formspec(player)
      minetest.chat_send_player(
         name, "Inventory mode switched to: " .. new_mode:upper()
      )
   end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
      if not fields.quit then
         return
      end
      local inv = player:get_inventory()
      local craft = inv:get_list("craft")
      for n, item in ipairs(craft) do
         local leftover = player_api.give_item(player, item)
         if leftover and not leftover:is_empty() then
            minetest.add_item(player:get_pos(), item)
         end
      end
      inv:set_list("craft", {})
end)
