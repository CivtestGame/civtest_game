minetest.override_item("default:dirt", {
	soil = {
		base = "default:dirt",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	on_dig = farming.dirt_on_dig
})

minetest.override_item("default:dirt_with_grass", {
	soil = {
		base = "default:dirt_with_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	on_dig = farming.dirt_on_dig
})

minetest.override_item("default:dirt_with_dry_grass", {
	soil = {
		base = "default:dirt_with_dry_grass",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	on_dig = farming.dirt_on_dig
})

minetest.override_item("default:dirt_with_rainforest_litter", {
	soil = {
		base = "default:dirt_with_rainforest_litter",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	on_dig = farming.dirt_on_dig
})

minetest.override_item("default:dirt_with_coniferous_litter", {
	soil = {
		base = "default:dirt_with_coniferous_litter",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	on_dig = farming.dirt_on_dig
})

minetest.override_item("default:dirt_with_snow", {
	soil = {
		base = "default:dirt_with_coniferous_snow",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	on_dig = farming.dirt_on_dig
})

minetest.register_node("farming:soil", {
	description = "Soil",
	tiles = {"default_dirt.png^farming_soil.png", "default_dirt.png"},
	drop = "default:dirt",
	groups = {crumbly=2, not_in_creative_inventory=1, soil=2, grassland = 1, field = 1},
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "default:dirt",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.register_node("farming:soil_wet", {
	description = "Wet Soil",
	tiles = {"default_dirt.png^farming_soil_wet.png", "default_dirt.png^farming_soil_wet_side.png"},
	drop = "default:dirt",
	groups = {crumbly=2, not_in_creative_inventory=1, soil=3, wet = 1, grassland = 1, field = 1},
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "default:dirt",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	}
})

minetest.override_item("default:desert_sand", {
	groups = {crumbly=3, falling_node=1, sand=1, soil = 1},
	soil = {
		base = "default:desert_sand",
		dry = "farming:desert_sand_soil",
		wet = "farming:desert_sand_soil_wet"
	},
	on_dig = farming.dirt_on_dig
})
minetest.register_node("farming:desert_sand_soil", {
	description = "Desert Sand Soil",
	drop = "default:desert_sand",
	tiles = {"farming_desert_sand_soil.png", "default_desert_sand.png"},
	groups = {crumbly=3, not_in_creative_inventory = 1, falling_node=1, sand=1, soil = 2, desert = 1, field = 1},
	sounds = default.node_sound_sand_defaults(),
	soil = {
		base = "default:desert_sand",
		dry = "farming:desert_sand_soil",
		wet = "farming:desert_sand_soil_wet"
	}
})

minetest.register_node("farming:desert_sand_soil_wet", {
	description = "Wet Desert Sand Soil",
	drop = "default:desert_sand",
	tiles = {"farming_desert_sand_soil_wet.png", "farming_desert_sand_soil_wet_side.png"},
	groups = {crumbly=3, falling_node=1, sand=1, not_in_creative_inventory=1, soil=3, wet = 1, desert = 1, field = 1},
	sounds = default.node_sound_sand_defaults(),
	soil = {
		base = "default:desert_sand",
		dry = "farming:desert_sand_soil",
		wet = "farming:desert_sand_soil_wet"
	}
})

minetest.register_node("farming:straw", {
	description = "Straw",
	tiles = {"farming_straw.png"},
	is_ground_content = false,
	groups = {snappy=3, flammable=4, fall_damage_add_percent=-30},
	sounds = default.node_sound_leaves_defaults(),
})

stairs.register_stair_and_slab(
	"straw",
	"farming:straw",
	{snappy = 3, flammable = 4},
	{"farming_straw.png"},
	"Straw Stair",
	"Straw Slab",
	default.node_sound_leaves_defaults(),
	true
)

minetest.register_abm({
	label = "Farming soil",
	nodenames = {"group:field"},
	interval = 15,
	chance = 4,
	action = function(pos, node)
		local n_def = minetest.registered_nodes[node.name] or nil
		local wet = n_def.soil.wet or nil
		local base = n_def.soil.base or nil
		local dry = n_def.soil.dry or nil
		if not n_def or not n_def.soil or not wet or not base or not dry then
			return
		end

		pos.y = pos.y + 1
		local nn = minetest.get_node_or_nil(pos)
		if not nn or not nn.name then
			return
		end
		local nn_def = minetest.registered_nodes[nn.name] or nil
		pos.y = pos.y - 1

		if nn_def and nn_def.walkable and minetest.get_item_group(nn.name, "plant") == 0 then
			minetest.set_node(pos, {name = base})
			return
		end
		-- check if there is water nearby
		local wet_lvl = minetest.get_item_group(node.name, "wet")
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			-- if it is dry soil and not base node, turn it into wet soil
			if wet_lvl == 0 then
				minetest.set_node(pos, {name = wet})
			end
		else
			-- only turn back if there are no unloaded blocks (and therefore
			-- possible water sources) nearby
			if not minetest.find_node_near(pos, 3, {"ignore"}) then
				-- turn it back into base if it is already dry
				if wet_lvl == 0 then
					-- only turn it back if there is no plant/seed on top of it
					if minetest.get_item_group(nn.name, "plant") == 0 and minetest.get_item_group(nn.name, "seed") == 0 then
						minetest.set_node(pos, {name = base})
					end

				-- if its wet turn it back into dry soil
				elseif wet_lvl == 1 then
					minetest.set_node(pos, {name = dry})
				end
			end
		end
	end,
})


for i = 1, 5 do
	minetest.override_item("default:grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_wheat'},rarity = 10},
            {items = {'farming:seed_potato'}, rarity = 20},
			{items = {'farming:seed_rice'},rarity = 20},
			{items = {'farming:seed_canola'},rarity = 20},
			{items = {'farming:seed_flax'},rarity = 20},
			{items = {'farming:seed_tomato'},rarity = 20},
			{items = {'farming:seed_lettuce'},rarity = 20},
			{items = {'farming:seed_spice_leaf'},rarity = 20},
			{items = {'farming:seed_grape'},rarity = 20},
			{items = {'farming:seed_soybean'},rarity = 20},
			{items = {'farming:seed_corn'},rarity = 60},
			{items = {'farming:seed_rye'},rarity = 60},
			{items = {'default:grass_1'}},
		}
	}})
end

minetest.override_item("default:junglegrass", {drop = {
	max_items = 1,
	items = {
		{items = {'farming:seed_cotton'},rarity = 40},
		{items = {'farming:seed_rice'},rarity = 20},
		{items = {'farming:seed_spice_leaf'},rarity = 20},
		{items = {'default:junglegrass'}},
	}
}})

for i = 1, 5 do
	minetest.override_item("default:dry_grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_agave'},rarity = 40},
			{items = {'farming:seed_canola'},rarity = 40},
			{items = {'farming:seed_cotton'},rarity = 20},
			{items = {'farming:seed_corn'},rarity = 10},
			{items = {'farming:seed_sorghum'},rarity = 10},
			{items = {'farming:seed_tomato'},rarity = 20},
			{items = {'default:dry_grass_1'}},
		}
	}})
end

for i = 1, 3 do
	minetest.override_item("default:fern_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_rhubarb'},rarity = 20},
			{items = {'farming:seed_rice'},rarity = 20},
			{items = {'farming:seed_potato'}, rarity = 10},
			{items = {'farming:seed_rye'}, rarity = 10},
			{items = {'farming:seed_lettuce'},rarity = 20},
			{items = {'farming:seed_beet'},rarity = 20},
			{items = {'farming:seed_soybean'},rarity = 60},
			{items = {'default:fern_1'}},
		}
	}})
end

for i = 1, 3 do
	minetest.override_item("default:marram_grass_"..i, {drop = {
		max_items = 1,
		items = {
			{items = {'default:marram_grass_1'}},
		}
	}})
end

minetest.override_item("default:cactus", {drop = {
	max_items = 1,
	items = {
		{items = {'farming:seed_agave'},rarity = 40},
		{items = {'default:cactus'}},
	}
}})

--------------------------------------------------------------------------------
--
-- Blueberry bushes & apples
--
--------------------------------------------------------------------------------

-- TODO: we should eventually do this using the heat scaling for normal crops,
--       but we still need refactor that stuff.

local function blueberry_adjust()
   minetest.registered_nodes["default:blueberry_bush_leaves_with_berries"]
      .after_dig_node = function(pos, oldnode, oldmetadata, digger)
         minetest.set_node(pos, {name = "default:blueberry_bush_leaves"})
         minetest.get_node_timer(pos):start(math.random(60*60*3, 60*60*12))
      end

   minetest.registered_nodes["default:blueberry_bush_leaves"]
      .on_timer = function(pos, elapsed)
         local biome = farming.get_biome_data(pos)
         if biome.heat < 40 or biome.heat > 60 then
            return
         end
         if minetest.get_node_light(pos) < 11
         then
            minetest.get_node_timer(pos):start(300)
         else
            minetest.set_node(pos, {name = "default:blueberry_bush_leaves_with_berries"})
         end
      end
end

local function apple_adjust()
   minetest.registered_nodes["default:apple"]
      .after_dig_node = function(pos, oldnode, oldmetadata, digger)
         local biome = farming.get_biome_data(pos)
         if oldnode.param2 == 0
            and biome.heat > 40
            and biome.heat < 60
         then
            minetest.set_node(pos, {name = "default:apple_mark"})
            minetest.get_node_timer(pos):start(math.random(60*60*3, 60*60*12))
         end
      end

   minetest.registered_nodes["default:apple_mark"]
      .on_timer = function(pos, elapsed)
         if not minetest.find_node_near(pos, 1, "default:leaves") then
            minetest.remove_node(pos)
         elseif minetest.get_node_light(pos) < 11 then
            minetest.get_node_timer(pos):start(300)
         else
            minetest.set_node(pos, {name = "default:apple"})
         end
      end
end

blueberry_adjust()
apple_adjust()
