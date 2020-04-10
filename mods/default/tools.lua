-- mods/default/tools.lua

-- The hand
minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=20.0, [2]=10.00, [3]=2.00}, uses=0, maxlevel=4},
			snappy = {times={[1]=20.0, [2]=10.00, [3]=2.00}, uses=0, maxlevel=4},
                        cracky = {times={[1]=20.0, [2]=10.00, [3]=2.00}, uses=0, maxlevel=4},
                        choppy = {times={[1]=20.0, [2]=10.00, [3]=2.00}, uses=0, maxlevel=4},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0}
		},
		damage_groups = {fleshy=1 * default.HEALTH_MULTIPLIER},
	}
})

--
-- Picks
--

minetest.register_tool("default:pick_wood", {
	description = "Wooden Pickaxe",
	inventory_image = "default_tool_woodpick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[2]=7.0, [3]=1.5}, uses=10, maxlevel=4},
		},
		damage_groups = {fleshy=1 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_stone", {
	description = "Stone Pickaxe",
	inventory_image = "default_tool_stonepick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[2]=4.0, [3]=1.5}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=2 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_copper", {
	description = "Copper Pickaxe",
	inventory_image = "default_tool_copperpick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[2]=3.0, [3]=1.0}, uses=400, maxlevel=4},
		},
		damage_groups = {fleshy=3 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_bronze", {
	description = "Bronze Pickaxe",
	inventory_image = "default_tool_bronzepick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			cracky = {times={[2]=2.5, [3]=0.90}, uses=1000, maxlevel=4},
		},
		damage_groups = {fleshy=3 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_iron", {
	description = "Iron Pickaxe",
	inventory_image = "default_tool_ironpick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=8.00, [2]=2.5, [3]=0.90}, uses=750, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_steel", {
	description = "Brittle Steel Pickaxe",
	inventory_image = "default_tool_steelpick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=2500, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

--
-- Shovels
--

minetest.register_tool("default:shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "default_tool_woodshovel.png",
	wield_image = "default_tool_woodshovel.png",
	groups = { shovel = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=5.00, [2]=2.50, [3]=0.60}, uses=10, maxlevel=4},
		},
		damage_groups = {fleshy=2 * default.HEALTH_MULTIPLIER},
	},
	groups = {flammable = 2},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "default_tool_stoneshovel.png",
	wield_image = "default_tool_stoneshovel.png",
	groups = { shovel = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=4.50, [2]=2.30, [3]=0.50}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=2 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_copper", {
	description = "Copper Shovel",
	inventory_image = "default_tool_coppershovel.png",
	wield_image = "default_tool_coppershovel.png",
	groups = { shovel = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			crumbly = {times={[1]=3.00, [2]=1.70, [3]=0.45}, uses=400, maxlevel=4},
		},
		damage_groups = {fleshy=3 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_bronze", {
	description = "Bronze Shovel",
	inventory_image = "default_tool_bronzeshovel.png",
	wield_image = "default_tool_bronzeshovel.png",
	groups = { shovel = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			crumbly = {times={[1]=2.75, [2]=1.50, [3]=0.40}, uses=1000, maxlevel=4},
		},
		damage_groups = {fleshy=3 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_iron", {
	description = "Iron Shovel",
	inventory_image = "default_tool_ironshovel.png",
	wield_image = "default_tool_ironshovel.png",
	groups = { shovel = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=2.00, [2]=1.10, [3]=0.35}, uses=750, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_steel", {
	description = "Brittle Steel Shovel",
	inventory_image = "default_tool_steelshovel.png",
	wield_image = "default_tool_steelshovel.png",
	groups = { shovel = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.70, [3]=0.30}, uses=2500, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

--
-- Axes
--

minetest.register_tool("default:axe_wood", {
	description = "Wooden Axe",
	inventory_image = "default_tool_woodaxe.png",
	groups = { axe = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			choppy = {times={[1]=5.00, [2]=3.00, [3]=1.60}, uses=10, maxlevel=4},
		},
		damage_groups = {fleshy=2 * default.HEALTH_MULTIPLIER},
	},
	groups = {flammable = 2},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_stone", {
	description = "Stone Axe",
	inventory_image = "default_tool_stoneaxe.png",
	groups = { axe = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=4.00, [2]=2.00, [3]=1.30}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=3 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_copper", {
	description = "Copper Axe",
	inventory_image = "default_tool_copperaxe.png",
	groups = { axe = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.70, [3]=1.15}, uses=400, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_bronze", {
	description = "Bronze Axe",
	inventory_image = "default_tool_bronzeaxe.png",
	groups = { axe = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.60, [3]=1.00}, uses=1000, maxlevel=4},
		},
		damage_groups = {fleshy=5 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_iron", {
	description = "Iron Axe",
	inventory_image = "default_tool_ironaxe.png",
	groups = { axe = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=1.50, [3]=0.90}, uses=750, maxlevel=4},
		},
		damage_groups = {fleshy=6 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_steel", {
	description = "Brittle Steel Axe",
	inventory_image = "default_tool_steelaxe.png",
	groups = { axe = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=1.50, [2]=1.40, [3]=0.80}, uses=2500, maxlevel=4},
		},
		damage_groups = {fleshy=7 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

--
-- Swords
--

minetest.register_tool("default:sword_wood", {
	description = "Wooden Sword",
	inventory_image = "default_tool_woodsword.png",
	groups = { sword = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=4},
		},
		damage_groups = {fleshy=3 * default.HEALTH_MULTIPLIER},
	},
	groups = {flammable = 2},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_stone", {
	description = "Stone Sword",
	inventory_image = "default_tool_stonesword.png",
	groups = { sword = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=40, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})


minetest.register_tool("default:sword_copper", {
	description = "Copper Sword",
	inventory_image = "default_tool_coppersword.png",
	groups = { sword = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.30, [3]=0.375}, uses=400, maxlevel=4},
		},
		damage_groups = {fleshy=7 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_bronze", {
	description = "Bronze Sword",
	inventory_image = "default_tool_bronzesword.png",
	groups = { sword = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=2,
		groupcaps={
			snappy={times={[1]=2.75, [2]=1.30, [3]=0.375}, uses=1000, maxlevel=4},
		},
		damage_groups = {fleshy=7 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_iron", {
	description = "Iron Sword",
	inventory_image = "default_tool_ironsword.png",
	groups = { sword = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=3,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=750, maxlevel=4},
		},
		damage_groups = {fleshy=8 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_steel", {
	description = "Brittle Steel Sword",
	inventory_image = "default_tool_steelsword.png",
	groups = { sword = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=2500, maxlevel=4},
		},
		damage_groups = {fleshy=10 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

--
-- CivIndustry
--

minetest.register_tool("default:pick_wrought_iron", {
	description = "Wrought Iron Pickaxe",
	inventory_image = "default_tool_wrought_ironpick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=7.00, [2]=2.2, [3]=0.90}, uses=1250, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_wrought_iron_good", {
	description = "Good Wrought Iron Pickaxe",
	inventory_image = "default_tool_wrought_ironpick_good.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=6.75, [2]=2.1, [3]=0.88}, uses=1500, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_wrought_iron_superior", {
	description = "Superior Wrought Iron Pickaxe",
	inventory_image = "default_tool_wrought_ironpick_superior.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=6.50, [2]=2.0, [3]=0.85}, uses=1750, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_steel_good", {
	description = "Good Brittle Steel Pickaxe",
	inventory_image = "default_tool_steelpick_good.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			cracky = {times={[1]=3.90, [2]=1.55, [3]=0.78}, uses=2650, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_steel_superior", {
	description = "Superior Brittle Steel Pickaxe",
	inventory_image = "default_tool_steelpick_superior.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			cracky = {times={[1]=3.80, [2]=1.50, [3]=0.76}, uses=2800, maxlevel=4},
		},
		damage_groups = {fleshy=4 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_fine_steel", {
	description = "Fine Steel Pickaxe",
	inventory_image = "default_tool_fine_steelpick.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			cracky = {times={[1]=3.50, [2]=1.40, [3]=0.72}, uses=3200, maxlevel=5},
		},
		damage_groups = {fleshy=5 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_fine_steel_good", {
	description = "Good Fine Steel Pickaxe",
	inventory_image = "default_tool_fine_steelpick_good.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			cracky = {times={[1]=3.45, [2]=1.37, [3]=0.70}, uses=3600, maxlevel=5},
		},
		damage_groups = {fleshy=5 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_fine_steel_superior", {
	description = "Superior Fine Steel Pickaxe",
	inventory_image = "default_tool_fine_steelpick_superior.png",
	groups = { pick = 1 },
	tool_capabilities = {
		full_punch_interval = default.PUNCH_INTERVAL,
		max_drop_level=4,
		groupcaps={
			cracky = {times={[1]=3.40, [2]=1.35, [3]=0.68}, uses=4000, maxlevel=5},
		},
		damage_groups = {fleshy=5 * default.HEALTH_MULTIPLIER},
	},
	sound = {breaks = "default_tool_breaks"},
})


--

--

--

minetest.register_tool("default:key", {
	description = "Key",
	inventory_image = "default_key.png",
	groups = {key = 1, not_in_creative_inventory = 1},
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
				not (placer and placer:is_player() and
				placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local pos = pointed_thing.under
		node = minetest.get_node(pos)

		if not node or node.name == "ignore" then
			return itemstack
		end

		local ndef = minetest.registered_nodes[node.name]
		if not ndef then
			return itemstack
		end

		local on_key_use = ndef.on_key_use
		if on_key_use then
			on_key_use(pos, placer)
		end

		return nil
	end
})
