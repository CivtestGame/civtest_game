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
                        damage_texture_modifier = "^[colorize:#ff1d1d:100"
		})
		player_api.set_animation(player, "stand")
	else
		player:set_properties({
			textures = {"player.png", "player_back.png"},
			visual = "upright_sprite",
			visual_size = {x = 1, y = 2},
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

-- Prevent knockback for attached players
local old_calculate_knockback = minetest.calculate_knockback
function minetest.calculate_knockback(player, ...)
	if player_attached[player:get_player_name()] then
		return 0
	end
	return old_calculate_knockback(player, ...)
end

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
      -- First, look for a pre-existing stack
      if item:get_name() == stack:get_name() then
         if (item:get_count() - 1) ~= item:get_stack_max() then
            return i
         end
      end
   end

   -- If no pre-existing stack found, look for the earliest empty one
   for i, item in ipairs(list) do
      if item:is_empty() then
         return i
      end
   end
end

local function call_inv_action(player, inv, listname, stack, left)
   local index = retroactively_find_empty_index(inv:get_list(listname), stack)

   if not index then
      local pname = player:get_player_name()
      minetest.log(
         "warning",
         "Couldn't retroactively find suitable index for inv '" .. listname
         .. "' of " .. pname .. " when looking for " .. stack:get_name() .. "."
      )
   end

   local diff = ItemStack(stack)
   diff:set_count(stack:get_count() - left:get_count())

   for _,f in ipairs(core.registered_on_player_inventory_actions) do
      f(player, "put", player:get_inventory(), {
           listname = listname, index = index, stack = diff
      })
   end
end


local function find_merge_candidate_list(list, stack)
   for i, item in ipairs(list) do
      if item:get_name() == stack:get_name() then
         local free_space = item:get_free_space()
         if free_space > 0 then
            return free_space
         end
      end
   end
end

local function find_merge_candidate(inv, stack)
   local invlists = {
      ["main"] = inv:get_list("main"),
      ["main2"] = inv:get_list("main2")
   }

   if not stack or stack:is_empty() then
      return
   end

   for listname, list in pairs(invlists) do
      local amount = find_merge_candidate_list(list, stack)
      if amount then
         return listname, amount
      end
   end
end

local function get_fake_inventory(pname)
   local fake_inv_name = "player_api:fakeinv_"..pname

   local fake_inv = minetest.create_detached_inventory(
      fake_inv_name,
      {
         allow_move = function() return 0 end,
         allow_put = function() return 0 end,
         allow_take = function() return 0 end
      },
      "_")

   return fake_inv
end

function player_api.give_item(player, _itemstack, should_call_action, dry_run)

   local itemstack = ItemStack(_itemstack)

   if not itemstack or itemstack:is_empty() then
      return ItemStack()
   end

   local inv = player:get_inventory()

   local fake_inv
   if dry_run then
      -- A hack, but dry-runs can be quite useful. Clone the player's inventory
      -- into an inaccessible and uninteractable detached inventory, and operate
      -- on that instead.
      local pname = player:get_player_name()
      fake_inv = get_fake_inventory(pname)

      fake_inv:set_list("main", inv:get_list("main"))
      fake_inv:set_list("main2", inv:get_list("main2"))

      inv = fake_inv
      -- Never ever ever ever call handlers for this fake inventory.
      should_call_action = false
   end

   -- Repeatedly try to merge input itemstack with existing one of the same
   -- type. Bail when there are no more candidates.
   while true do
      local listname, amount = find_merge_candidate(inv, itemstack)
      if not (listname and amount) then
         break
      end

      local taken = itemstack:take_item(amount)
      local merged_leftover = inv:add_item(listname, taken)
      assert(merged_leftover == nil or merged_leftover:is_empty())

      -- Successful merges should call relevant callbacks
      if should_call_action then
         call_inv_action(player, inv, listname, itemstack, merged_leftover)
      end
   end

   -- Now, add whatever's left over from the merges.
   -- Prioritise the hotbar (main), and then the rest of the inventory (main2).

   local left = inv:add_item("main", itemstack)
   if should_call_action then
      -- Only call the handler if the leftover isn't the same as itemstack
      if left and left:to_string() ~= itemstack:to_string() then
         call_inv_action(player, inv, "main", itemstack, left)
      end
   end

   itemstack:take_item(itemstack:get_count() - left:get_count())

   if not itemstack:is_empty() then
      local left2 = inv:add_item("main2", itemstack)
      if should_call_action then
         -- Again, only call the handler if the leftover isn't the same as the
         -- input itemstack.
         if left2 and left2:to_string() ~= itemstack:to_string() then
            call_inv_action(player, inv, "main2", itemstack, left2)
         end
      end

      itemstack:take_item(itemstack:get_count() - left2:get_count())
   end

   if dry_run then
      -- Reset the fake inventory's contents.
      fake_inv:set_list("main", {})
      fake_inv:set_list("main2", {})
   end

   return itemstack
end


minetest.register_allow_player_inventory_action(
   function(player, action, inventory, inv_info)
      if not (action == "put" or action == "move") then
         return
      end
      if not (inv_info.listname == "router"
                 or inv_info.to_list == "router")
      then
         return
      end

      -- We're trying to allow a "put" to the "router".

      local stack = inv_info.stack
         or inventory:get_stack(inv_info.from_list, inv_info.from_index)

      -- Dry-run the inventory action (fourth param).
      local leftover = player_api.give_item(player, stack, false, true)

      local leftover_count = (leftover and leftover:get_count()) or 0

      local take_amount = stack:get_count() - leftover_count

      return take_amount
   end
)

minetest.register_on_player_inventory_action(
   function(player, action, inventory, inv_info)
      if not (action == "put" or action == "move") then
         return
      end
      if not (inv_info.listname == "router"
                 or inv_info.to_list == "router")
      then
         return
      end

      -- Pull out the stack from the router.
      local stack = inventory:get_stack("router", 1)
      -- XXX: this could also, more verbosely, be written as:
      --
      -- local stack = inv_info.stack
      --    or inventory:get_stack(inv_info.to_list, inv_info.to_index)
      --
      -- ...but in this case, we always know the target is "router", and the
      -- stack is the (only) item in the router.

      local leftover = player_api.give_item(player, stack, true)

      -- When a "put"/"move" to the router is allowed:
      --
      --   * The player will now have as much as they can take.
      --   * The chest will retain what the player didn't take.
      --   * The difference in the above items remain in the router inventory
      --     (as they've been essentially duplicated by the handler above).
      --
      -- So, we need to nuke what has been duplicated. Hence:

      inventory:set_list("router", {})
   end
)

minetest.register_on_joinplayer(function(player)
      local inv = player:get_inventory()

      -- Shouldn't ever get to this point, yet paranoia prevails...
      local stack = inv:get_stack("router", 1)
      if stack and not stack:is_empty() then
         local pname = player:get_player_name()
         minetest.log(
            "warning", pname.." had a lingering item in their \"router\"!"
         )
      end

      inv:set_list("router", {})
end)
