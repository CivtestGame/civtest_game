-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into game_api.txt

-- Load support for MT game translation.
local S = minetest.get_translator("default")

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14
default.get_translator = S

-- TODO: move these to configuration
default.HEALTH_MULTIPLIER = 10
default.PLAYER_MAX_HEALTH = 20 * default.HEALTH_MULTIPLIER
default.PUNCH_INTERVAL = 0.2

-- GUI related stuff
minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend
	local formspec = [[
			bgcolor[#080808BB;true]
			listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF] ]]
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	if info.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;gui_formbg.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;gui_formbg.png;true]"
	end
	player:set_formspec_prepend(formspec)

	-- Set hotbar textures
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)

-- Player health support code

-- minetest.register_on_respawnplayer(function(player)
--       -- Respawn with appropriate health
--       local props = player:get_properties()
--       if props.hp_max ~= default.PLAYER_MAX_HEALTH then
--          player:set_properties({ hp_max = default.PLAYER_MAX_HEALTH })
--          player:set_hp(default.PLAYER_MAX_HEALTH)
--       end
-- end)

-- local storage = minetest.get_mod_storage()

-- minetest.register_on_joinplayer(function(player)
--       -- New players have appropriate amount of health
--       local props = player:get_properties()
--       if props.hp_max ~= default.PLAYER_MAX_HEALTH then
--          player:set_properties({ hp_max = default.PLAYER_MAX_HEALTH })
--       end

--       local pname = player:get_player_name()
--       local pname_oldfriend_key = pname .. "_oldfriend"

--       local player_is_newfriend = storage:get_string(pname_oldfriend_key) == ""
--       if player_is_newfriend then
--          player:set_hp(default.PLAYER_MAX_HEALTH)
--          storage:set_string(pname_oldfriend_key, "true")
--       else
--          local pname_health_key = pname .. "_health"
--          local phealth = storage:get_int(pname_health_key, phealth)
--          player:set_hp(phealth)
--       end
-- end)

-- minetest.register_on_leaveplayer(function(player)
--       local pname = player:get_player_name()
--       local pname_health_key = pname .. "_health"
--       local phealth = player:get_hp()
--       storage:set_int(pname_health_key, phealth)
-- end)

local fall_dmg_blacklist = {
   ["air"] = true,
   ["default:water_source"] = true
}

minetest.register_on_mods_loaded(function()
      for node_name, node_def in pairs(minetest.registered_nodes) do
	 -- Avoid modifying blacklisted nodes, or nodes without groups
	 if fall_dmg_blacklist[node_name]
	    or (not node_def.groups)
	 then
	    goto continue
	 end

	 local fall_dmg_pct = node_def.groups.fall_damage_add_percent or 100

	 local new_fall_dmg = (100 * default.HEALTH_MULTIPLIER)

	 local node_redef = node_def
	 node_redef.groups.fall_damage_add_percent_post = new_fall_dmg

	 minetest.register_node(":" .. node_name, node_redef)

	 ::continue::
      end
end)


function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

default.gui_survival_form = "size[8,8.5]"..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;1.75,0.5;3,3;]"..
			"list[current_player;craftpreview;5.75,1.5;1,1;]"..
			"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

-- Load files
local default_path = minetest.get_modpath("default")

dofile(default_path.."/functions.lua")
dofile(default_path.."/trees.lua")
dofile(default_path.."/nodes.lua")
dofile(default_path.."/chests.lua")
dofile(default_path.."/torch.lua")
dofile(default_path.."/tools.lua")
dofile(default_path.."/item_entity.lua")
dofile(default_path.."/craftitems.lua")
dofile(default_path.."/crafting.lua")
dofile(default_path.."/mapgen.lua")
dofile(default_path.."/aliases.lua")
dofile(default_path.."/legacy.lua")
