-- mods/default/craftitems.lua

minetest.register_craftitem("default:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = {stick = 1, flammable = 2},
})

minetest.register_craftitem("default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
	groups = {flammable = 3},
})


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
	if owner == player_name then
		formspec = "size[8,8]" ..
			"field[0.5,1;7.5,0;title;Title:;" ..
				minetest.formspec_escape(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;text;Contents:;" ..
				minetest.formspec_escape(text) .. "]" ..
			"button_exit[2.5,7.5;3,1;save;Save]"
	else
		formspec = "size[8,8]" ..
			"label[0.5,0.5;by " .. owner .. "]" ..
			"tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[0.4,0;7,0.5;title;#FFFF00," .. minetest.formspec_escape(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;;" ..
				minetest.formspec_escape(string ~= "" and string or text) .. ";]" ..
			"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
			"label[3.2,7.7;Page " .. page .. " of " .. page_max .. "]" ..
			"button[4.9,7.6;0.8,0.8;book_next;>]"
	end

	minetest.show_formspec(player_name, "default:book", formspec)
	return itemstack
end

local max_text_size = 100000
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
		data.description = "\""..short_title.."\" by "..data.owner
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

--minetest.register_craft({
--	type = "shapeless",
--	output = "default:book_written",
--	recipe = {"default:book", "default:book_written"}
--})

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
	description = "Coal Lump",
	inventory_image = "default_coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_craftitem("default:iron_lump", {
	description = "Pig Iron",
	inventory_image = "default_iron_lump.png",
})

minetest.register_craftitem("default:copper_lump", {
	description = "Copper Lump",
	inventory_image = "default_copper_lump.png",
})

minetest.register_craftitem("default:tin_lump", {
	description = "Tin Lump",
	inventory_image = "default_tin_lump.png",
})

minetest.register_craftitem("default:mese_crystal", {
	description = "Mese Crystal",
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:gold_lump", {
	description = "Gold Lump",
	inventory_image = "default_gold_lump.png",
})

minetest.register_craftitem("default:diamond", {
	description = "Diamond",
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = "Clay Lump",
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:mithril_ingot", {
	description = "Mithril Ingot",
        groups = {metal_ingot = 1},
	inventory_image = "default_mithril_ingot.png",
})

minetest.register_craftitem("default:iron_ingot", {
	description = "Iron Ingot",
        groups = {metal_ingot = 1,ferrous_ingot = 1},
	inventory_image = "default_iron_ingot.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = "Brittle Steel Ingot",
        groups = {metal_ingot = 1,ferrous_ingot = 1},
	inventory_image = "default_steel_ingot.png",
})

minetest.register_craftitem("default:copper_ingot", {
	description = "Copper Ingot",
        groups = {metal_ingot = 1},
	inventory_image = "default_copper_ingot.png",
})

minetest.register_craftitem("default:tin_ingot", {
	description = "Tin Ingot",
        groups = {metal_ingot = 1},
	inventory_image = "default_tin_ingot.png",
})

minetest.register_craftitem("default:bronze_ingot", {
	description = "Bronze Ingot",
        groups = {metal_ingot = 1},
	inventory_image = "default_bronze_ingot.png",
})

minetest.register_craftitem("default:gold_ingot", {
	description = "Gold Ingot",
        groups = {metal_ingot = 1},
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	description = "Mese Crystal Fragment",
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = "Clay Brick",
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "default_obsidian_shard.png",
})

minetest.register_craftitem("default:flint", {
	description = "Flint",
	inventory_image = "default_flint.png"
})

minetest.register_craftitem("default:blueberries", {
	description = "Blueberries",
	inventory_image = "default_blueberries.png",
	on_use = minetest.item_eat(2),
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
	description = "Brittle Steel Pick Head",
	inventory_image = "default_comp_steel_pickhead.png",
})

minetest.register_craftitem("default:comp_steel_pickhead_sharp", {
	description = "Sharp Brittle Steel Pick Head",
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

minetest.register_craftitem("default:comp_steel_axehead", {
	description = "Brittle Steel Axe Head",
	inventory_image = "default_comp_steel_axehead.png",
})

minetest.register_craftitem("default:comp_steel_axehead_sharp", {
	description = "Sharp Brittle Steel Axe Head",
	inventory_image = "default_comp_steel_axehead_sharp.png",
})

minetest.register_craftitem("default:comp_fine_steel_axehead", {
	description = "Fine Steel Axe Head",
	inventory_image = "default_comp_fine_steel_axehead.png",
})

minetest.register_craftitem("default:comp_fine_steel_axehead_sharp", {
	description = "Sharp Fine Steel Axe Head",
	inventory_image = "default_comp_fine_steel_axehead_sharp.png",
})

minetest.register_craftitem("default:comp_steel_shovelhead", {
	description = "Brittle Steel Shovel Head",
	inventory_image = "default_comp_steel_shovelhead.png",
})

minetest.register_craftitem("default:comp_steel_shovelhead_sharp", {
	description = "Sharp Brittle Steel Shovel Head",
	inventory_image = "default_comp_steel_shovelhead_sharp.png",
})

minetest.register_craftitem("default:comp_fine_steel_shovelhead", {
	description = "Fine Steel Shovel Head",
	inventory_image = "default_comp_fine_steel_shovelhead.png",
})

minetest.register_craftitem("default:comp_fine_steel_shovelhead_sharp", {
	description = "Sharp Fine Steel Shovel Head",
	inventory_image = "default_comp_fine_steel_shovelhead_sharp.png",
})

minetest.register_craftitem("default:comp_steel_swordhead", {
	description = "Brittle Steel Sword Blade",
	inventory_image = "default_comp_steel_swordhead.png",
})

minetest.register_craftitem("default:comp_steel_swordhead_sharp", {
	description = "Sharp Brittle Steel Sword Blade",
	inventory_image = "default_comp_steel_swordhead_sharp.png",
})

minetest.register_craftitem("default:comp_fine_steel_swordhead", {
	description = "Fine Steel Sword Blade",
	inventory_image = "default_comp_fine_steel_swordhead.png",
})

minetest.register_craftitem("default:comp_fine_steel_swordhead_sharp", {
	description = "Sharp Fine Steel Sword Blade",
	inventory_image = "default_comp_fine_steel_swordhead_sharp.png",
})

minetest.register_craftitem("default:wrought_iron_lump", {
	description = "Wrought Iron Lump",
	inventory_image = "default_wrought_iron_lump.png"
})

minetest.register_craftitem("default:wrought_iron_ingot", {
	description = "Wrought Iron Ingot",
        groups = {metal_ingot = 1,ferrous_ingot = 1}, 
	inventory_image = "default_wrought_iron_ingot.png"
})

minetest.register_craftitem("default:steel_lump", {
	description = "Brittle Steel Lump",
	inventory_image = "default_steel_lump.png"
})

minetest.register_craftitem("default:fine_steel_lump", {
	description = "Fine Steel Lump",
	inventory_image = "default_fine_steel_lump.png"
})

minetest.register_craftitem("default:fine_steel_ingot", {
	description = "Fine Steel Ingot",
        groups = {metal_ingot = 1,ferrous_ingot = 1},
	inventory_image = "default_fine_steel_ingot.png"
})

minetest.register_craftitem("default:aluminium_ingot", {
	description = "Aluminium Ingot",
        groups = {metal_ingot = 1,ferrous_ingot = 1},
	inventory_image = "default_aluminium.png"
})

minetest.register_craftitem("default:elem_chromium", {
	description = "Chromium",
	inventory_image = "default_elem_chromium.png"
})

minetest.register_craftitem("default:lead", {
	description = "Lead",
        groups = {metal_ingot = 1},
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
        groups = {metal_ingot = 1},
	inventory_image = "default_brass_ingot.png"
})

minetest.register_craftitem("default:alubronze_ingot", {
	description = "Aluminium Bronze Ingot",
        groups = {metal_ingot = 1,ferrous_ingot = 1},
	inventory_image = "default_alubronze_ingot.png"
})

minetest.register_craftitem("default:slag", {
	description = "Slag",
	inventory_image = "default_slag.png"
})

minetest.register_craftitem("default:bacon", {
	description = "Bacon",
	inventory_image = "default_bacon.png",
	on_use = minetest.item_eat(4),
	groups = {food_smoked_meat = 1, food_cooked_meat = 1}
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

minetest.register_craftitem("default:comp_iron_chain", {
	description = "Iron Chain",
        groups = {chain=1},
	inventory_image = "default_iron_chain.png"
})
minetest.register_craftitem("default:comp_iron_scale", {
	description = "Iron Scale",
        groups = {scale=1},
	inventory_image = "default_iron_scale.png"
})
minetest.register_craftitem("default:comp_iron_plate", {
	description = "Iron Plate",
        groups = {plate=1},
	inventory_image = "default_iron_plate.png"
})

minetest.register_craftitem("default:comp_steel_chain", {
	description = "Brittle Steel Chain",
        groups = {chain=1},
	inventory_image = "default_steel_chain.png"
})
minetest.register_craftitem("default:comp_steel_scale", {
	description = "Brittle Steel Scale",
        groups = {scale=1},
	inventory_image = "default_steel_scale.png"
})
minetest.register_craftitem("default:comp_steel_plate", {
	description = "Brittle Steel Plate",
        groups = {plate=1},
	inventory_image = "default_steel_plate.png"
})

minetest.register_craftitem("default:comp_fine_steel_chain", {
	description = "Fine Steel Chain",
        groups = {chain=1},
	inventory_image = "default_fine_steel_chain.png"
})
minetest.register_craftitem("default:comp_fine_steel_scale", {
	description = "Fine Steel Scale",
        groups = {scale=1},
	inventory_image = "default_fine_steel_scale.png"
})
minetest.register_craftitem("default:comp_fine_steel_plate", {
	description = "Fine Steel Plate",
        groups = {plate=1},
	inventory_image = "default_fine_steel_plate.png"
})

minetest.register_craftitem("default:comp_fabric", {
	description = "Fabric",
        groups = {cloth=1},
	inventory_image = "default_fabric.png"
})
