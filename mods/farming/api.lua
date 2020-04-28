-- Wear out hoes, place soil
-- TODO Ignore group:flower
farming.registered_plants = {}
farming.registered_sickles = {}

farming.greenhouse_effect = 1.2

function farming.get_biome_data(pos)
	local biome = minetest.get_biome_data(pos)
	-- test for greenhouse effect
	for i=1,3 do
	  local node = minetest.get_node({x = pos.x, y = pos.y + i, z = pos.z})
	  if minetest.get_node_group(node.name, "glass") ~= 0 then
	  	biome.heat = biome.heat * farming.greenhouse_effect
	  	break
	  end
	end
	return biome
end

function farming.dirt_on_dig(pos, node, digger)
	local digger_name = (digger and digger:get_player_name()) or ""
	-- check protection
	if minetest.is_protected(pos, digger_name) then
		minetest.record_protection_violation(pt.under, digger_name)
	end

	local regN = minetest.registered_nodes
	local regT = minetest.registered_tools

	-- check if digger is non-nil
	if digger == nil then
		return minetest.node_dig(pos, node, digger)
	end

	-- check if using a hoe
	local wielded_item = digger:get_wielded_item()

	if wielded_item == nil or wielded_item:get_name() == ""  -- Yeah, I know
	   or regT[wielded_item:get_name()] == nil               -- This is ugly
	   or regT[wielded_item:get_name()].groups["hoe"] == nil -- But life is ugly, man
	   then
		return minetest.node_dig(pos, node, digger)
	end

	-- check if (wet) soil defined
	local regN = minetest.registered_nodes
	if regN[node.name].soil == nil or regN[node.name].soil.wet == nil or regN[node.name].soil.dry == nil then
		return
	end

	-- replace
	minetest.set_node(pos, {name = regN[node.name].soil.dry})

	if not (creative and creative.is_enabled_for
			and creative.is_enabled_for(digger:get_player_name())) then
		-- wear tool
		local wdef = wielded_item:get_definition()
		wielded_item:add_wear(65535/(wdef.max_uses-1))
		digger:set_wielded_item(wielded_item)

		-- tool break sound
		if wielded_item:get_count() == 0 and wdef.sound and wdef.sound.breaks then
			minetest.sound_play(wdef.sound.breaks, {pos = pos, gain = 0.5})
			digger:set_wielded_item(nil)
		end
	end

	-- play sound
	minetest.sound_play("default_dig_crumbly", {
		pos = pos,
		gain = 0.5,
	})
end

function farming.compute_growth_interval(pos, growth, again)
   --default values
   local lower_bound = 166
   local higher_bound = 286
   if again == true then
      lower_bound = 40
      higher_bound = 80
   end

   if growth then
      local biome = farming.get_biome_data(pos)

      local grow_time = -1

      if growth.heat_scaling then
         local heat_diff = math.abs(biome.heat-growth.optimum_heat)
         if growth.heat_scaling == "linear" then
            grow_time = growth.heat_a * heat_diff + growth.heat_base_speed
         elseif growth.heat_scaling == "exponential" then
            grow_time = (growth.heat_a * growth.heat_b^heat_diff) + growth.heat_base_speed
         end
      end

      if growth.humidity_scaling then
         local humidity_diff = math.abs(biome.humidity-growth.optimum_humidity)
         if growth.humidity_scaling == "linear" then
            grow_time = grow_time + growth.humidity_a * humidity_diff + growth.humidity_base_speed
         elseif growth.humidity_scaling == "exponential" then
            grow_time = grow_time + (growth.humidity_a * growth.humidity_b^humidity_diff) + growth.humidity_base_speed
         end
      end

      -- If the grow time wasn't changed we change it to a default value
      if grow_time == -1 then grow_time = 200 end

      lower_bound = grow_time - growth.variance
      higher_bound = grow_time + growth.variance

      if again == true then
         lower_bound = lower_bound / 4
         higher_bound = higher_bound / 4
      end
   end

   --minetest.log("Lower bound:" .. lower_bound .. " upper:" .. higher_bound)
   return lower_bound, higher_bound
end

function farming.plant_from_node_name(name)
   local plant_name = minetest.registered_nodes[name].plant_name
   return farming.registered_plants[plant_name]
end

local function growth_timescale(time)
   local divisor = 1
   local unit = "seconds"
   local over_three_months = false
   if time > (60 * 60 * 24 * 7 * 4 * 3) then
      over_three_months = true
      divisor = (60 * 60 * 24 * 7 * 4)
      unit =  "months"
   elseif time > (60 * 60 * 24 * 7) then
      divisor = (60 * 60 * 24 * 7)
      unit = "weeks"
   elseif time > (60 * 60 * 24) then
      divisor = (60 * 60 * 24)
      unit = "days"
   elseif time > (60 * 60) then
      divisor = (60 * 60)
      unit = "hours"
   elseif time > 60 then
      divisor = 60
      unit = "minutes"
   end
   return divisor, unit, over_three_months
end

function farming.start_growth_cycle(pos, node_name)
   local meta = minetest.get_meta(pos)
   local time = os.time(os.date("!*t"))

   local plant = farming.plant_from_node_name(node_name)
   local growth = plant.custom_growth
   local lower_bound, higher_bound = farming.compute_growth_interval(
      pos, growth, false
   )
   local average_bound = round((lower_bound + higher_bound) / 2)

   local node_timer = minetest.get_node_timer(pos)
   node_timer:start(average_bound)

   meta:set_string("last_crop_name", node_name)
   meta:set_string("last_grow", time)
end

farming.describe_biome = function(player_name, pos)
      local biome_data = farming.get_biome_data(pos)

      local biome_name = minetest.get_biome_name(biome_data.biome)
	  local msg = string.format("Biome: %s, temperature: %.2f, humidity %.2f", biome_name, biome_data.heat, biome_data.humidity)
      minetest.chat_send_player(
         player_name,
		 msg
      )
end

farming.hoe_on_place = function(itemstack, user, pointed_thing)

   if pointed_thing
      and pointed_thing.type == "nothing"
   then
      local name = user:get_player_name()
      if not name then
         return
      end
      local pos = user:get_pos()
	  farming.describe_biome(name, pos)
   end

   if pointed_thing
      and pointed_thing.type == "node"
   then
      local pos = pointed_thing.under
      local node = minetest.get_node(pos)

      local plant = farming.plant_from_node_name(node.name)

      if (not plant) or (not plant.custom_growth) then
	  	 farming.describe_biome(user:get_player_name(), pos)
         return
      end

      local growth = plant.custom_growth

      local lower_bound, higher_bound = farming.compute_growth_interval(
         pos, growth, false
      )

      -- The above are per-stage, so multiply
      local full_lower_bound = lower_bound * plant.steps
      local full_higher_bound = higher_bound * plant.steps

      local flb_divisor, flb_unit, flb_over_three_months = growth_timescale(full_lower_bound)
      local fhb_divisor, fhb_unit, fhb_over_three_months = growth_timescale(full_higher_bound)

      if flb_over_three_months and fhb_over_three_months then
         minetest.chat_send_player(
            user:get_player_name(),
            "A " .. plant.description .. " will take over three months to fully grow here."
         )
      else
         local pretty_full_lower_bound = string.format("%.2f", full_lower_bound / flb_divisor)
         if flb_over_three_months then
            pretty_full_lower_bound = "3+"
         end

         local pretty_full_higher_bound = string.format("%.2f", full_higher_bound / fhb_divisor)
         if fhb_over_three_months then
            pretty_full_higher_bound = "3+"
         end

         local average_bound = math.floor((lower_bound + higher_bound) / 2)
         local elapsed = minetest.get_node_timer(pos):get_elapsed()

         local growth_step = core.registered_nodes[node.name].growth_step

         local total_growth = (growth_step * average_bound) + elapsed
         local total_divisor, total_unit = growth_timescale(total_growth)

         local pretty_total_growth = string.format(
            "%.2f", total_growth / total_divisor
         )

         minetest.chat_send_player(
            user:get_player_name(),
            "This " .. plant.description
            .. " has been growing for "..pretty_total_growth.." "..total_unit
               .. ", and is on growth stage " .. growth_step
               .. " of ".. plant.steps .. ".\n"
               .. "It will take from " .. pretty_full_lower_bound
               .. " " .. flb_unit .. " to " .. pretty_full_higher_bound .. " "
               .. fhb_unit .. " to fully grow here. "
         )
      end
   end
   return itemstack
end

farming.hoe_on_secondary_use = function(itemstack,user,pointed_thing)
	farming.describe_biome(user:get_player_name(), user:get_pos())
end

-- Register new hoes
farming.register_hoe = function(name, def)

	-- Check for : prefix (register new hoes in your mod's namespace)
	if name:sub(1,1) ~= ":" then
		name = ":" .. name
	end

	-- Check def table
	if def.description == nil then
		def.description = "Hoe"
	end
	if def.inventory_image == nil then
		def.inventory_image = "unknown_item.png"
	end
	if def.max_uses == nil then
		def.max_uses = 30
	end
	-- Register the tool
	minetest.register_tool(name, {
		max_uses = def.max_uses,
		description = def.description,
		inventory_image = def.inventory_image,

        on_place = function(itemstack, user, pointed_thing)
			return farming.hoe_on_place(itemstack, user, pointed_thing, def.max_uses)
        end,

		on_secondary_use = function(itemstack, user, pointed_thing)
			return farming.hoe_on_secondary_use(itemstack,user,pointed_thing)
		end,

		tool_capabilities = {
			full_punch_interval = default.PUNCH_INTERVAL,
			max_drop_level = 0,
			groupcaps = def.groupcaps
		},
		groups = def.groups,
		sound = {breaks = "default_tool_breaks"},
	})
	-- Register its recipe
	if def.recipe then
		minetest.register_craft({
			output = name:sub(2),
			recipe = def.recipe
		})
	elseif def.material then
		minetest.register_craft({
			output = name:sub(2),
			recipe = {
				{def.material, def.material},
				{"", "group:stick"},
				{"", "group:stick"}
			}
		})
	end
end

-- Register new sickles
farming.register_sickle = function(name, def)

	-- Check def table
	if def.description == nil then
		def.description = "Sickle"
	end

	if def.inventory_image == nil then
		def.inventory_image = "unknown_item.png"
	end

	-- Register the tool
	minetest.register_tool(name, {
		description = def.description,
		inventory_image = def.inventory_image,

		tool_capabilities = {
			full_punch_interval = default.PUNCH_INTERVAL,
			max_drop_level = 0,
			groupcaps = def.groupcaps
		},
		groups = def.groups,
		sound = {breaks = "default_tool_breaks"},
		sapling_chance = def.sapling_chance
	})
	-- Register its recipe
	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe
		})

	elseif def.material then
		minetest.register_craft({
			output = name,
			recipe = {
				{"", def.material, ""},
				{"", "", def.material},
				{"", "group:stick", ""}
			}
		})
	end

	farming.registered_sickles[name] = def
end

farming.override_leaves = function(leaves_name, sapling_name)
	local drop_table = { }

	-- drop chance for saplings
	for sickle_name, sickle_def in pairs(farming.registered_sickles) do
		table.insert(drop_table, {
			tools = { sickle_name },
			rarity = sickle_def.sapling_chance,
			items = {sapling_name}
		})
	end

	local sickles = {}
	for k,v in pairs(farming.registered_sickles) do
		table.insert(sickles, k)
	end

	-- add a chance of 1 to drop a leave with a sickle
	table.insert(drop_table, { tools = sickles, items = {leaves_name} })

	local drop = {
		max_items = 1,
		items = drop_table
	}
	minetest.log("drop_table for '"..leaves_name.."': "..minetest.serialize(drop))


	minetest.override_item(leaves_name, {
		drop = {
			max_items = 1,
			items = drop_table
		}
	})
end

-- Seed placement
farming.place_seed = function(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") < 2 then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name = plantname, param2 = 1})

        -- Start the seed's growth cycle
        farming.start_growth_cycle(pt.above, plantname)

	if not (creative and creative.is_enabled_for
			and creative.is_enabled_for(player_name)) then
		itemstack:take_item()
	end
	return itemstack
end

farming.grow_plant = function(pos, elapsed)
	local node = minetest.get_node(pos)
	local name = node.name
	local def = minetest.registered_nodes[name]

	if not def.next_plant then
		-- disable timer for fully grown plant
		return false
	end

	-- grow seed
	if minetest.get_item_group(node.name, "seed") and def.fertility then
		local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not soil_node then
			return false
		end
		-- omitted is a check for light, we assume seeds can germinate in the dark.
		for _, v in pairs(def.fertility) do
			if minetest.get_item_group(soil_node.name, v) ~= 0 then
				local placenode = {name = def.next_plant}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				minetest.swap_node(pos, placenode)
				if minetest.registered_nodes[def.next_plant].next_plant then
					return true
				end
			end
		end
	end

	-- check if on wet soil
	if def.requires_soil then
		local below = minetest.get_node(
			{x = pos.x, y = pos.y - 1, z = pos.z}
		)
		if minetest.get_item_group(below.name, "soil") < 3 then
			return false
		end
	end

	-- check light
	local light = minetest.get_node_light(pos)
	if not light or (light < def.minlight or light > def.maxlight) then
		return false
	end

	-- grow
        local np_type = type(def.next_plant)
	if np_type == "function" then
		def.next_plant(name, pos)
	else
           local placenode = {name = def.next_plant}
           if def.place_param2 then
              placenode.param2 = def.place_param2
           end
           minetest.swap_node(pos, placenode)
	end

	return true
end

-- Register plants
farming.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	if not def.description then
		def.description = "Seed"
	end
	if not def.inventory_image then
		def.inventory_image = "unknown_item.png"
	end
	if not def.steps then
		return nil
	end
	if not def.minlight then
		def.minlight = 0
	end
	if not def.maxlight then
		def.maxlight = 15
	end
	if not def.fertility then
		def.fertility = {}
	end
	def.name = name
        def.requires_soil = true
	farming.registered_plants[pname] = def

	-- Register seed
	local lbm_nodes = {mname .. ":seed_" .. pname}
	local g = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	for k, v in pairs(def.fertility) do
		g[v] = 1
	end
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {
		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = g,
		paramtype = "light",
		paramtype2 = "wallmounted",
		place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		fertility = def.fertility,
		sounds = default.node_sound_dirt_defaults({
			dig = {name = "", gain = 0},
			dug = {name = "default_grass_footstep", gain = 0.2},
			place = {name = "default_place_node", gain = 0.25},
		}),

		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local udef = minetest.registered_nodes[node.name]
			if udef and udef.on_rightclick and
					not (placer and placer:is_player() and
					placer:get_player_control().sneak) then
				return udef.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			return farming.place_seed(itemstack, placer, pointed_thing, mname .. ":seed_" .. pname)
		end,
                growth_step = 0,
		next_plant = mname .. ":" .. pname .. "_1",
		plant_name = pname,
		minlight = def.minlight,
		maxlight = def.maxlight,
		custom_growth = def.custom_growth,
                on_timer = function(pos, elapsed)
                   local node = minetest.get_node(pos)
                   farming.try_grow_crop(pos, node)
                end
	})

	-- Register harvest
	if not def.drops_seeds then
		minetest.register_craftitem(":" .. mname .. ":" .. pname, {
			description = pname:gsub("^%l", string.upper),
			inventory_image = mname .. "_" .. pname .. ".png",
			groups = def.groups or {flammable = 2},
	})
	end

	-- Register growing steps
	for i = 1, def.steps do
		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end
		local drop = {
			items = {}
		}
		if not def.drops_seeds then
		drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = base_rarity},
				{items = {mname .. ":" .. pname}, rarity = base_rarity * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
			}
		}
		else
		drop = {
			items = {
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 3},
			}
		}
		end
		local nodegroups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
		nodegroups[pname] = i

		local next_plant = nil

		if i < def.steps then
			next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
			lbm_nodes[#lbm_nodes + 1] = mname .. ":" .. pname .. "_" .. i
		end

		minetest.register_node(":" .. mname .. ":" .. pname .. "_" .. i, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2 or nil,
			place_param2 = def.place_param2 or nil,
			walkable = false,
			buildable_to = true,
			drop = drop,
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
			groups = nodegroups,
			sounds = default.node_sound_leaves_defaults(),
			next_plant = next_plant,
			plant_name = pname,
			minlight = def.minlight,
			maxlight = def.maxlight,
			custom_growth = def.custom_growth,
                        on_timer = function(pos, elapsed)
                           local node = minetest.get_node(pos)
                           farming.try_grow_crop(pos, node)
                        end,
                        growth_step = i
		})
	end

        farming.register_growth_lbm(pname, lbm_nodes)

	-- Return
	local r = {
		seed = mname .. ":seed_" .. pname,
		harvest = mname .. ":" .. pname
	}
	return r
end

--------------------------------------------------------------------------------
--
-- Crop growth ABM + LBM
-- Persists crop growth over time, regardless of mapblock load status.
--
--------------------------------------------------------------------------------

local function round(x)
   return x >= 0
      and math.floor(x + 0.5)
      or math.ceil(x - 0.5)
end

local function crop_location_sanity_check(pos, node)
   -- Sanity: ensure the last crop at the block was of the same type, and we
   -- have the right metadata.
   --
   -- (This is pretty paranoid, I'm not sure if these can ever happen...)

   local meta = minetest.get_meta(pos)
   local last_crop_name = meta:get_string("last_crop_name")

   if last_crop_name == "" then
      minetest.log("warning",
         "Crop at " .. minetest.pos_to_string(pos)
            .. " had glitched \"last_crop_name\" metadata,"
            .. " changed to " .. node.name .. "."
      )
      last_crop_name = node.name
   end

   local last_plant = farming.plant_from_node_name(last_crop_name)
   local plant = farming.plant_from_node_name(node.name)

   if (not last_plant or not plant)
      or last_plant.name ~= plant.name
   then
      local plant_name = (plant and plant.name) or "???"
      minetest.log("warning",
         "Crop at " .. minetest.pos_to_string(pos) .. " changed from "
            .. last_crop_name .. " to " .. plant_name .. " since last lbm run."
      )
   end
   meta:set_string("last_crop_name", node.name)
end

local DEBUG = false

function farming.try_grow_crop(pos, node)
   crop_location_sanity_check(pos, node)

   local meta = minetest.get_meta(pos)
   local time = os.time(os.date("!*t"))

   local plant = farming.plant_from_node_name(node.name)

   local last_growth = meta:get_int("last_grow")

   local growth = plant.custom_growth
   local lower_bound, higher_bound = farming.compute_growth_interval(
      pos, growth, false
   )
   local average_bound = round((lower_bound + higher_bound) / 2)

   local elapsed_since_last_grow = time - last_growth

   local steps = elapsed_since_last_grow / average_bound
   local full_steps = math.floor(steps)
   local next_step_pct = steps - full_steps

   if DEBUG then
      minetest.log("ESLG: " .. tostring(elapsed_since_last_grow))
      minetest.log("AVG: " .. tostring(average_bound))
      minetest.log("STEPS: " .. tostring(steps))
      minetest.log("FULL_STEPS: " .. tostring(full_steps))
      minetest.log("NEXT_STEP_PCT: " .. tostring(next_step_pct))
   end

   local succeeded = false

   if elapsed_since_last_grow >= average_bound then
      for i=1, full_steps, 1 do
         succeeded = farming.grow_plant(pos)
      end
   end

   if succeeded then
      meta:set_int("last_grow", last_growth + round(average_bound * full_steps))
      local node_timer = minetest.get_node_timer(pos)
      node_timer:set(average_bound, average_bound * next_step_pct)
   end

   return succeeded, full_steps, next_step_pct
end

function farming.register_growth_lbm(pname, lbm_nodes)
   local mname = minetest.get_current_modname()
   minetest.register_lbm({
         label = "Crop growth lbm" .. pname,
         name = mname..":crop_catchup_lbm_" .. pname,
         nodenames = lbm_nodes,
         run_at_every_load = true,
         action = function(pos, node)
            local result, full_steps, next_step_pct = farming.try_grow_crop(
               pos, node
            )

            if full_steps > 0 and DEBUG then
               local msg = "grew " .. full_steps .. " steps"

               minetest.log(
                  "Crop at " .. minetest.pos_to_string(pos) .. " " .. msg
                  .. " while unloaded (" .. tostring(round(next_step_pct * 100))
                     .. "% to the next stage)."
               )
            end
         end
   })
   minetest.log("Registered growth LBM for " .. pname)
end

-- Sapling registry

function farming.register_sapling(name, def)
   def.name = name
   def.description = def.description or "Sapling"
   def.drawtype = def.drawtype or "plantlike"
   def.paramtype = def.paramtype or "light"
   def.sounds = def.sounds or default.node_sound_leaves_defaults()
   def.sunlight_propagates = def.sunlight_propagates or true
   def.walkable = def.walkable or false
   def.selection_box = def.selection_box or
      { type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16} }

   def.groups = def.groups or { snappy = 3, flammable = 2,
                                attached_node = 1, sapling = 1 }

   def.tree_minp = def.tree_min_pos
      or error("Sapling " .. name ..
                  " has no tree bounding box tree_min_pos defined.")
   def.tree_maxp = def.tree_max_pos
      or error("Sapling " .. name
                  .. " has no tree bounding box tree_max_pos defined.")

   def.wield_image = def.wield_image
      or def.image
      or error("Sapling " .. name " .. has no image property (wield).")
   def.inventory_image = def.inventory_image
      or def.image
      or error("Sapling " .. name " .. has no image property (inventory).")
   def.tiles = def.tiles
      or (def.image and { def.image })
      or error("Sapling " .. name " .. has no image property (tiles).")

   def.on_place = function(itemstack, placer, pointed_thing)
      itemstack = farming.sapling_on_place(
         itemstack, placer, pointed_thing, name,
         -- minp, maxp to be checked, relative to sapling pos
         -- minp_relative.y = 1 because sapling pos has been checked
         def.tree_min_pos,
         def.tree_max_pos,
         -- maximum interval of interior volume check
         4
      )
      return itemstack
   end

   -- Now to interface with the farming API

   local mname = name:split(":")[1]
   local pname = name:split(":")[2]

   def.steps = 1
   def.minlight = def.minlight or 0
   def.maxlight = def.maxlight or 15
   def.fertility = def.fertility or {}
   def.custom_growth = def.custom_growth
      or error("Sapling " .. name .. " has no custom_growth property.")

   def.next_plant = function(plant_name, pos)
      farming.grow_sapling(pos)
   end

   def.growth_step = 0
   def.plant_name = pname

   farming.registered_plants[pname] = def
   minetest.register_node(":" .. name, def)

   farming.register_growth_lbm(pname, { name })
end
