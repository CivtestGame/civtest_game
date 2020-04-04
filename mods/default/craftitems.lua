-- mods/default/craftitems.lua

-- support for MT game translation.
local S = default.get_translator

local lpp = 14 -- Lines per book's page
local function book_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local meta = itemstack:get_meta()
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	-- Backwards compatibility
	local old_data = minetest.deserialize(itemstack:get_metadata())
	if old_data then
		meta:from_table({ fields = old_data })
	end

	local data = meta:to_table().fields

	if data.owner then
		title = data.title
		text = data.text
		owner = data.owner

		for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
			lines[#lines+1] = str
		end

		if data.page then
			page = data.page
			page_max = data.page_max

			for i = ((lpp * page) - lpp) + 1, lpp * page do
				if not lines[i] then break end
				string = string .. lines[i] .. "\n"
			end
		end
	end

	local formspec
	local esc = minetest.formspec_escape
	if owner == player_name then
		formspec = "size[8,8]" ..
			"field[0.5,1;7.5,0;title;" .. esc(S("Title:")) .. ";" ..
				esc(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;text;" .. esc(S("Contents:")) .. ";" ..
				esc(text) .. "]" ..
			"button_exit[2.5,7.5;3,1;save;" .. esc(S("Save")) .. "]"
	else
		formspec = "size[8,8]" ..
			"label[0.5,0.5;" .. esc(S("by @1", owner)) .. "]" ..
			"tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[0.4,0;7,0.5;title;#FFFF00," .. esc(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;;" ..
				minetest.formspec_escape(string ~= "" and string or text) .. ";]" ..
			"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
			"label[3.2,7.7;" .. esc(S("Page @1 of @2", page, page_max)) .. "]" ..
			"button[4.9,7.6;0.8,0.8;book_next;>]"
	end

	minetest.show_formspec(player_name, "default:book", formspec)
	return itemstack
end

local max_text_size = 10000
local max_title_size = 80
local short_title_size = 35
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "default:book" then return end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

	if fields.save and fields.title and fields.text
			and fields.title ~= "" and fields.text ~= "" then
		local new_stack, data
		if stack:get_name() ~= "default:book_written" then
			local count = stack:get_count()
			if count == 1 then
				stack:set_name("default:book_written")
			else
				stack:set_count(count - 1)
				new_stack = ItemStack("default:book_written")
			end
		else
			data = stack:get_meta():to_table().fields
		end

		if data and data.owner and data.owner ~= player:get_player_name() then
			return
		end

		if not data then data = {} end
		data.title = fields.title:sub(1, max_title_size)
		data.owner = player:get_player_name()
		local short_title = data.title
		-- Don't bother triming the title if the trailing dots would make it longer
		if #short_title > short_title_size + 3 then
			short_title = short_title:sub(1, short_title_size) .. "..."
		end
		data.description = S("\"@1\" by @2", short_title, data.owner)
		data.text = fields.text:sub(1, max_text_size)
		data.text = data.text:gsub("\r\n", "\n"):gsub("\r", "\n")
		data.page = 1
		data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)

		if new_stack then
			new_stack:get_meta():from_table({ fields = data })
			local left = player_api.give_item(player, new_stack)
			if left and not left:is_empty() then
				minetest.add_item(player:get_pos(), new_stack)
			end
		else
			stack:get_meta():from_table({ fields = data })
		end

	elseif fields.book_next or fields.book_prev then
		local data = stack:get_meta():to_table().fields
		if not data or not data.page then
			return
		end

		data.page = tonumber(data.page)
		data.page_max = tonumber(data.page_max)

		if fields.book_next then
			data.page = data.page + 1
			if data.page > data.page_max then
				data.page = 1
			end
		else
			data.page = data.page - 1
			if data.page == 0 then
				data.page = data.page_max
			end
		end

		stack:get_meta():from_table({fields = data})
		stack = book_on_use(stack, player)
	end

	-- Update stack
	player:set_wielded_item(stack)
end)

minetest.register_craftitem("default:book", {
	description = "Book",
	inventory_image = "default_book.png",
	groups = {book = 1, flammable = 3},
	on_use = book_on_use,
})

minetest.register_craftitem("default:book_written", {
	description = "Book With Text",
	inventory_image = "default_book_written.png",
	groups = {book = 1, not_in_creative_inventory = 1, flammable = 3},
	stack_max = 1,
	on_use = book_on_use,
})

minetest.register_craft({
	type = "shapeless",
	output = "default:book_written",
	recipe = {"default:book", "default:book_written"}
})

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
	if itemstack:get_name() ~= "default:book_written" then
		return
	end

	local original
	local index
	for i = 1, player:get_inventory():get_size("craft") do
		if old_craft_grid[i]:get_name() == "default:book_written" then
			original = old_craft_grid[i]
			index = i
		end
	end
	if not original then
		return
	end
	local copymeta = original:get_meta():to_table()
	-- copy of the book held by player's mouse cursor
	itemstack:get_meta():from_table(copymeta)
	-- put the book with metadata back in the craft grid
	craft_inv:set_stack("craft", index, original)
end)


minetest.register_craftitem("default:coal_lump", {
	description = S("Coal Lump"),
	inventory_image = "default_coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_craftitem("default:iron_lump", {
	description = "Pig Iron",
	inventory_image = "default_iron_lump.png",
})

minetest.register_craftitem("default:copper_lump", {
	description = S("Copper Lump"),
	inventory_image = "default_copper_lump.png"
})

minetest.register_craftitem("default:diamond", {
	description = S("Diamond"),
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:flint", {
	description = S("Flint"),
	inventory_image = "default_flint.png"
})

minetest.register_craftitem("default:gold_ingot", {
	description = S("Gold Ingot"),
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("default:gold_lump", {
	description = S("Gold Lump"),
	inventory_image = "default_gold_lump.png"
})

minetest.register_craftitem("default:iron_lump", {
	description = S("Iron Lump"),
	inventory_image = "default_iron_lump.png"
})

minetest.register_craftitem("default:mese_crystal", {
	description = S("Mese Crystal"),
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	description = S("Mese Crystal Fragment"),
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "default_obsidian_shard.png",
})

minetest.register_craftitem("default:paper", {
	description = S("Paper"),
	inventory_image = "default_paper.png",
	groups = {flammable = 3},
})

minetest.register_craftitem("default:mithril_ingot", {
	description = "Mithril Ingot",
	inventory_image = "default_mithril_ingot.png",
})

minetest.register_craftitem("default:iron_ingot", {
	description = "Iron Ingot",
	inventory_image = "default_iron_ingot.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "default_steel_ingot.png"
})

minetest.register_craftitem("default:stick", {
	description = S("Stick"),
	inventory_image = "default_stick.png",
	groups = {stick = 1, flammable = 2},
})

minetest.register_craftitem("default:tin_ingot", {
	description = S("Tin Ingot"),
	inventory_image = "default_tin_ingot.png"
})

minetest.register_craftitem("default:tin_lump", {
	description = S("Tin Lump"),
	inventory_image = "default_tin_lump.png"
})

--
-- Crafting recipes
--

minetest.register_craft({
	output = "default:book",
	recipe = {
		{"default:paper"},
		{"default:paper"},
		{"default:paper"},
	}
})

default.register_craft_metadata_copy("default:book", "default:book_written")

minetest.register_craft({
	output = "default:bronze_ingot 9",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:tin_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	}
})

minetest.register_craft({
	output = "default:clay_brick 4",
	recipe = {
		{"default:brick"},
	}
})

minetest.register_craft({
	output = "default:clay_lump 4",
	recipe = {
		{"default:clay"},
	}
})

minetest.register_craft({
	output = "default:coal_lump 9",
	recipe = {
		{"default:coalblock"},
	}
})

minetest.register_craft({
	output = "default:copper_ingot 9",
	recipe = {
		{"default:copperblock"},
	}
})

minetest.register_craft({
	output = "default:diamond 9",
	recipe = {
		{"default:diamondblock"},
	}
})

minetest.register_craft({
	output = "default:gold_ingot 9",
	recipe = {
		{"default:goldblock"},
	}
})

minetest.register_craft({
	output = "default:mese_crystal",
	recipe = {
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment", "default:mese_crystal_fragment", "default:mese_crystal_fragment"},
	}
})

minetest.register_craft({
	output = "default:mese_crystal 9",
	recipe = {
		{"default:mese"},
	}
})

minetest.register_craft({
	output = "default:mese_crystal_fragment 9",
	recipe = {
		{"default:mese_crystal"},
	}
})

minetest.register_craft({
	output = "default:obsidian_shard 9",
	recipe = {
		{"default:obsidian"}
	}
})

minetest.register_craft({
	output = "default:paper",
	recipe = {
		{"default:papyrus", "default:papyrus", "default:papyrus"},
	}
})

minetest.register_craft({
	output = "default:skeleton_key",
	recipe = {
		{"default:gold_ingot"},
	}
})

minetest.register_craft({
	output = "default:steel_ingot 9",
	recipe = {
		{"default:steelblock"},
	}
})

minetest.register_craft({
	output = "default:stick 4",
	recipe = {
		{"group:wood"},
	}
})

minetest.register_craft({
	output = "default:tin_ingot 9",
	recipe = {
		{"default:tinblock"},
	}
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:clay_brick",
	recipe = "default:clay_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "default:copper_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:gold_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:key",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "default:skeleton_key",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "default:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "default:tin_ingot",
	recipe = "default:tin_lump",
})

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "default:book",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:paper",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:stick",
	burntime = 1,
})

minetest.register_craftitem("default:limestone_dust", {
	description = "Limestone Dust",
	inventory_image = "default_limestone.png"
})

minetest.register_craftitem("default:quicklime", {
	description = "Quicklime",
	inventory_image = "default_quicklime.png"
})

minetest.register_craftitem("default:coke", {
	description = "Coke",
	inventory_image = "default_coke.png",
        groups = {coke = 1, coal = 1, flammable = 1}
})

minetest.register_craftitem("default:charcoal", {
	description = "Charcoal",
	inventory_image = "default_charcoal.png",
        groups = {coke = 1, coal = 1, flammable = 1}
})

minetest.register_craftitem("default:comp_hammer", {
	description = "Hammering Component",
	inventory_image = "default_comp_hammer.png",
})

minetest.register_craftitem("default:comp_hammer_adv", {
	description = "Advanced Hammering Component",
	inventory_image = "default_comp_hammer_adv.png",
})

minetest.register_craftitem("default:comp_sharp", {
	description = "Sharpening Component",
	inventory_image = "default_comp_sharp.png",
})

minetest.register_craftitem("default:comp_sharp_adv", {
	description = "Advanced Sharpening Component",
	inventory_image = "default_comp_sharp_adv.png",
})

minetest.register_craftitem("default:comp_toolrod", {
	description = "Tool Rod",
	inventory_image = "default_comp_toolrod.png",
})

minetest.register_craftitem("default:comp_toolrod_strong", {
	description = "Strong Tool Rod",
	inventory_image = "default_comp_toolrod_strong.png",
})

minetest.register_craftitem("default:comp_wrought_iron_pickhead", {
	description = "Wrought Iron Pick Head",
	inventory_image = "default_comp_wrought_iron_pickhead.png",
})

minetest.register_craftitem("default:comp_wrought_iron_pickhead_sharp", {
	description = "Sharp Wrought Iron Pick Head",
	inventory_image = "default_comp_wrought_iron_pickhead_sharp.png",
})

minetest.register_craftitem("default:comp_steel_pickhead", {
	description = "Steel Pick Head",
	inventory_image = "default_comp_steel_pickhead.png",
})

minetest.register_craftitem("default:comp_steel_pickhead_sharp", {
	description = "Sharp Steel Pick Head",
	inventory_image = "default_comp_steel_pickhead_sharp.png",
})

minetest.register_craftitem("default:comp_fine_steel_pickhead", {
	description = "Fine Steel Pick Head",
	inventory_image = "default_comp_fine_steel_pickhead.png",
})

minetest.register_craftitem("default:comp_fine_steel_pickhead_sharp", {
	description = "Sharp Fine Steel Pick Head",
	inventory_image = "default_comp_fine_steel_pickhead_sharp.png",
})

minetest.register_craftitem("default:wrought_iron_lump", {
	description = "Wrought Iron Lump",
	inventory_image = "default_wrought_iron_lump.png"
})

minetest.register_craftitem("default:wrought_iron_ingot", {
	description = "Wrought Iron Ingot",
	inventory_image = "default_wrought_iron_ingot.png"
})

minetest.register_craftitem("default:steel_lump", {
	description = "Steel Lump",
	inventory_image = "default_steel_lump.png"
})

minetest.register_craftitem("default:fine_steel_lump", {
	description = "Fine Steel Lump",
	inventory_image = "default_fine_steel_lump.png"
})

minetest.register_craftitem("default:fine_steel_ingot", {
	description = "Fine Steel Ingot",
	inventory_image = "default_fine_steel_ingot.png"
})

minetest.register_craftitem("default:aluminium_ingot", {
	description = "Aluminium Ingot",
	inventory_image = "default_aluminium.png"
})

minetest.register_craftitem("default:elem_chromium", {
	description = "Chromium",
	inventory_image = "default_elem_chromium.png"
})

minetest.register_craftitem("default:lead", {
	description = "Lead",
	inventory_image = "default_elem_lead.png"
})

minetest.register_craftitem("default:elem_manganese", {
	description = "Manganese",
	inventory_image = "default_elem_manganese.png"
})

minetest.register_craftitem("default:elem_nickel", {
	description = "Nickel",
	inventory_image = "default_elem_nickel.png"
})

minetest.register_craftitem("default:elem_pewter", {
	description = "Pewter",
	inventory_image = "default_elem_pewter.png"
})

minetest.register_craftitem("default:elem_sulphur", {
	description = "Sulphur",
	inventory_image = "default_elem_sulphur.png"
})

minetest.register_craftitem("default:elem_zinc", {
	description = "Zinc",
	inventory_image = "default_elem_zinc.png"
})

minetest.register_craftitem("default:brass_ingot", {
	description = "Brass Ingot",
	inventory_image = "default_brass_ingot.png"
})

minetest.register_craftitem("default:alubronze_ingot", {
	description = "Aluminium Bronze Ingot",
	inventory_image = "default_alubronze_ingot.png"
})

minetest.register_craftitem("default:slag", {
	description = "Slag",
	inventory_image = "default_slag.png"
})

minetest.register_craftitem("default:bacon", {
	description = "Bacon",
	inventory_image = "default_bacon.png",
	on_use = minetest.item_eat(4)
})

minetest.register_craftitem("default:pie_meat", {
	description = "Meat Pie",
	inventory_image = "default_pie_meat.png",
	on_use = minetest.item_eat(4)
})

minetest.register_craftitem("default:pie_berry", {
	description = "Berry Pie",
	inventory_image = "default_pie_berry.png",
	on_use = minetest.item_eat(3)
})

minetest.register_craftitem("default:pie_mushroom", {
	description = "Mushroom Pie",
	inventory_image = "default_pie_mushroom.png",
	on_use = minetest.item_eat(4)
})