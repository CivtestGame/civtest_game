-- Minetest 0.4 mod: player
-- See README.txt for licensing and other information.

player_api = {}

-- Player animation blending
-- Note: This is currently broken due to a bug in Irrlicht, leave at 0
local animation_blend = 0

player_api.registered_models = { }

-- Local for speed.
local models = player_api.registered_models

function player_api.register_model(name, def)
	models[name] = def
end

-- Player stats and animations
local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}
player_api.player_attached = {}

function player_api.get_animation(player)
	local name = player:get_player_name()
	return {
		model = player_model[name],
		textures = player_textures[name],
		animation = player_anim[name],
	}
end

-- Called when a player's appearance needs to be updated
function player_api.set_model(player, model_name)
	local name = player:get_player_name()
	local model = models[model_name]
	if model then
		if player_model[name] == model_name then
			return
		end
		player:set_properties({
			mesh = model_name,
			textures = player_textures[name] or model.textures,
			visual = "mesh",
			visual_size = model.visual_size or {x = 1, y = 1},
			collisionbox = model.collisionbox or {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
			stepheight = model.stepheight or 0.6,
			eye_height = model.eye_height or 1.47,
		})
		player_api.set_animation(player, "stand")
	else
		player:set_properties({
			textures = {"player.png", "player_back.png"},
			visual = "upright_sprite",
			collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
			stepheight = 0.6,
			eye_height = 1.625,
		})
	end
	player_model[name] = model_name
end

function player_api.set_textures(player, textures)
	local name = player:get_player_name()
	local model = models[player_model[name]]
	local model_textures = model and model.textures or nil
	player_textures[name] = textures or model_textures
	player:set_properties({textures = textures or model_textures,})
end

function player_api.set_animation(player, anim_name, speed)
	local name = player:get_player_name()
	if player_anim[name] == anim_name then
		return
	end
	local model = player_model[name] and models[player_model[name]]
	if not (model and model.animations[anim_name]) then
		return
	end
	local anim = model.animations[anim_name]
	player_anim[name] = anim_name
	player:set_animation(anim, speed or model.animation_speed, animation_blend)
end

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_model[name] = nil
	player_anim[name] = nil
	player_textures[name] = nil
end)

-- Localize for better performance.
local player_set_animation = player_api.set_animation
local player_attached = player_api.player_attached

-- Check each player and apply animations
minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local model_name = player_model[name]
		local model = model_name and models[model_name]
		if model and not player_attached[name] then
			local controls = player:get_player_control()
			local walking = false
			local animation_speed_mod = model.animation_speed or 30

			-- Determine if the player is walking
			if controls.up or controls.down or controls.left or controls.right then
				walking = true
			end

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 2
			end

			-- Apply animations based on what the player is doing
			if player:get_hp() == 0 then
				player_set_animation(player, "lay")
			elseif walking then
				if player_sneak[name] ~= controls.sneak then
					player_anim[name] = nil
					player_sneak[name] = controls.sneak
				end
				if controls.LMB then
					player_set_animation(player, "walk_mine", animation_speed_mod)
				else
					player_set_animation(player, "walk", animation_speed_mod)
				end
			elseif controls.LMB then
				player_set_animation(player, "mine")
			else
				player_set_animation(player, "stand", animation_speed_mod)
			end
		end
	end
end)

local function retroactively_find_empty_index(list, stack)
   -- Retroactively find where the stack was put in the list.
   for i, item in ipairs(list) do
      if item:is_empty()
         or (item:to_string() == stack:to_string()
                and (item:get_count() - 1) ~= item:get_stack_max())
      then
         return i
      end
   end
end

local function call_inv_action(player, inv, listname, stack, left)
   local index = retroactively_find_empty_index(inv:get_list(listname), stack)
   if index then
      local diff = ItemStack(stack)
      diff:set_count(stack:get_count() - left:get_count())

      for _,f in ipairs(core.registered_on_player_inventory_actions) do
         f(player, "put", player:get_inventory(), {
              listname = listname, index = index, stack = diff
         })
      end
   else
      minetest.log(
         "warning", "Couldn't retroactively find suitable index for inv "
            .. listname .. " of " .. player:get_player_name() .. "."
      )
   end
end

function player_api.give_item(player, itemstack, should_call_action)
   local inv = player:get_inventory()
   local left = inv:add_item("main", itemstack)

   if should_call_action then
      -- Only call the handler if the leftover isn't the same as itemstack
      if left and left:to_string() ~= itemstack:to_string() then
         call_inv_action(player, inv, "main", itemstack, left)
      end
   end

   if left and not left:is_empty() then
      local left2 = inv:add_item("main2", left)
      if should_call_action then
         -- Again, only call the handler if the leftover isn't the same as the
         -- input itemstack.
         if left2 and left2:to_string() ~= itemstack:to_string() then
            call_inv_action(player, inv, "main2", left, left2)
         end
      end

      if left2 and not left2:is_empty() then
         return left2
      end
   end
end
