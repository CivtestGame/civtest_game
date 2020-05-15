
-- Moved growth-related code from default/trees.lua to here (farming/trees.lua)
--
-- The code remaining in `default` is tree-schematic/generation code.

local random = math.random

--
-- Grow trees from saplings
--

-- 'can grow' function

function farming.sapling_can_grow(pos, name)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})

	if not node_under then

		return false
	end
	local def = minetest.registered_nodes[name]
	local name_under = node_under.name
	local is_soil = minetest.get_item_group(name_under, "soil")

	if is_soil == 0 then

		return false
	end

	local light_level = minetest.get_node_light(pos)
	if not light_level
		or light_level < def.minlight
		or light_level > def.maxlight
	 then

		return false
	end

	local minp_relative = def.tree_min_pos
	local maxp_relative = def.tree_max_pos
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			"",
			1) then
		local description = def.description
		minetest.record_protection_violation(pos, "")
		-- Print extra information to explain
		minetest.log(
			"verbose",
                        description .. " at " .. minetest.pos_to_string(pos)
			.. " will intersect protection on growth."
		)
		return false
	end

	return true
end

local function is_snow_nearby(pos)
	return minetest.find_node_near(pos, 1, {"group:snowy"})
end

local function is_water_nearby(pos)
	return minetest.find_node_near(pos, 2, {"group:water"})
end


-- Grow sapling

function farming.grow_sapling(pos)
	local node = minetest.get_node(pos)

	if not farming.sapling_can_grow(pos, node.name) then
		return
	end

	local mg_name = minetest.get_mapgen_setting("mg_name")

	if node.name == "default:sapling" then
		minetest.log("verbose", "A sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		if mg_name == "v6" then
			default.grow_tree(pos, random(1, 4) == 1)
		else
			default.grow_new_apple_tree(pos)
		end
	elseif node.name == "default:junglesapling" then
		minetest.log("verbose", "A jungle sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		if mg_name == "v6" then
			default.grow_jungle_tree(pos)
		else
			default.grow_new_jungle_tree(pos)
		end
	elseif node.name == "default:pine_sapling" then
		minetest.log("verbose", "A pine sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		local snow = is_snow_nearby(pos)
		if mg_name == "v6" then
			default.grow_pine_tree(pos, snow)
		elseif snow then
			default.grow_new_snowy_pine_tree(pos)
		else
			default.grow_new_pine_tree(pos)
		end
	elseif node.name == "default:acacia_sapling" then
		minetest.log("verbose", "An acacia sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_acacia_tree(pos)
	elseif node.name == "default:aspen_sapling" then
		minetest.log("verbose", "An aspen sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_aspen_tree(pos)
	elseif node.name == "default:bush_sapling" then
		minetest.log("verbose", "A bush sapling grows into a bush at "..
			minetest.pos_to_string(pos))
		default.grow_bush(pos)
	elseif node.name == "default:blueberry_bush_sapling" then
		minetest.log("verbose", "A blueberry bush sapling grows into a bush at "..
			minetest.pos_to_string(pos))
		default.grow_blueberry_bush(pos)
	elseif node.name == "default:acacia_bush_sapling" then
		minetest.log("verbose", "An acacia bush sapling grows into a bush at "..
			minetest.pos_to_string(pos))
		default.grow_acacia_bush(pos)
	elseif node.name == "default:pine_bush_sapling" then
		minetest.log("verbose", "A pine bush sapling grows into a bush at "..
			minetest.pos_to_string(pos))
		default.grow_pine_bush(pos)
	elseif node.name == "default:emergent_jungle_sapling" then
		minetest.log("verbose", "An emergent jungle sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		default.grow_new_emergent_jungle_tree(pos)
	elseif node.name == "default:large_cactus_seedling" then
		minetest.log("verbose", "A cactus seedling grows into a cactus at "..
			minetest.pos_to_string(pos))

		-- Cactus logic
		minetest.set_node(pos, {name = "default:cactus"})

		local pos1 = vector.new(pos.x, pos.y + 1, pos.z)
		local n1 = minetest.get_node(pos1)
		if n1.name ~= "air" or math.random(2) == 1 then
			return
		end
		minetest.set_node(pos1, {name = "default:cactus"})

		local pos2 = vector.new(pos.x, pos.y + 2, pos.z)
		local n2 = minetest.get_node(pos2)
		if n2.name ~= "air" or math.random(2) == 1 then
			return
		end
		minetest.set_node(pos2, {name = "default:cactus"})
	elseif node.name == "farming:papyrus_seedling" and is_water_nearby(pos) == true then
		minetest.log("verbose", "A papyrus grows at "..
			minetest.pos_to_string(pos))

		-- Papyrus logic
		minetest.set_node(pos, {name = "default:papyrus"})

		local pos1 = vector.new(pos.x, pos.y + 1, pos.z)
		local n1 = minetest.get_node(pos1)
		if n1.name ~= "air" or math.random(2) == 1 then
			return
		end
		minetest.set_node(pos1, {name = "default:papyrus"})

		local pos2 = vector.new(pos.x, pos.y + 2, pos.z)
		local n2 = minetest.get_node(pos2)
		if n2.name ~= "air" or math.random(2) == 1 then
			return
		end
		minetest.set_node(pos2, {name = "default:papyrus"})
		
		local pos3 = vector.new(pos.x, pos.y + 3, pos.z)
		local n3 = minetest.get_node(pos3)
		if n3.name ~= "air" or math.random(2) == 1 then
			return
		end
		minetest.set_node(pos3, {name = "default:papyrus"})
	end
end

--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function farming.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			1) then
		local description = itemstack:get_definition().description
		minetest.chat_send_player(
			player_name,
			"It looks like the "..description.." won't be able to"
				.. " grow here (protected blocks above)."
		)
	end

	minetest.log("verbose", player_name .. " places node "
			.. sapling_name .. " at " .. minetest.pos_to_string(pos))

	local take_item = not (creative and creative.is_enabled_for
		and creative.is_enabled_for(player_name))
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

        -- Start the sapling's growth cycle
        farming.start_growth_cycle(pos, sapling_name)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end
