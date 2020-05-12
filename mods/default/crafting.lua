-- mods/default/crafting.lua

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'default:tree'},
	}
})

minetest.register_craft({
	output = 'default:junglewood 4',
	recipe = {
		{'default:jungletree'},
	}
})

minetest.register_craft({
	output = 'default:pine_wood 4',
	recipe = {
		{'default:pine_tree'},
	}
})

minetest.register_craft({
	output = 'default:acacia_wood 4',
	recipe = {
		{'default:acacia_tree'},
	}
})

minetest.register_craft({
	output = 'default:aspen_wood 4',
	recipe = {
		{'default:aspen_tree'},
	}
})

minetest.register_craft({
	output = 'default:wood',
	recipe = {
		{'default:bush_stem'},
	}
})

minetest.register_craft({
	output = 'default:acacia_wood',
	recipe = {
		{'default:acacia_bush_stem'},
	}
})

minetest.register_craft({
	output = "default:pine_wood",
	recipe = {
		{"default:pine_bush_stem"},
	}
})

minetest.register_craft({
	output = 'default:stick 4',
	recipe = {
		{'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'default:charcoal'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:pick_wood',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'group:stone', 'group:stone', 'group:stone'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_iron',
	recipe = {
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_copper',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:shovel_wood',
	recipe = {
		{'group:wood'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_stone',
	recipe = {
		{'group:stone'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_iron',
	recipe = {
		{'default:iron_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel',
	recipe = {
		{'default:steel_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_copper',
	recipe = {
		{'default:copper_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_bronze',
	recipe = {
		{'default:bronze_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

-- Axes
-- Recipes face left to match appearence in textures and inventory

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'group:wood', 'group:wood'},
		{'group:wood', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'group:stone', 'group:stone'},
		{'group:stone', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_iron',
	recipe = {
		{'default:iron_ingot', 'default:iron_ingot'},
		{'default:iron_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_copper',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_bronze',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_wood',
	recipe = {
		{'group:wood'},
		{'group:wood'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_stone',
	recipe = {
		{'group:stone'},
		{'group:stone'},
		{'group:stick'},
	}
})


minetest.register_craft({
	output = 'default:sword_iron',
	recipe = {
		{'default:iron_ingot'},
		{'default:iron_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_steel',
	recipe = {
		{'default:steel_ingot'},
		{'default:steel_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_copper',
	recipe = {
		{'default:copper_ingot'},
		{'default:copper_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_bronze',
	recipe = {
		{'default:bronze_ingot'},
		{'default:bronze_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:coalblock',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'default:coal_lump 9',
	recipe = {
		{'default:coalblock'},
	}
})


minetest.register_craft({
	output = 'default:ironblock',
	recipe = {
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
		{'default:iron_ingot', 'default:iron_ingot', 'default:iron_ingot'},
	}
})

minetest.register_craft({
	output = 'default:iron_ingot 9',
	recipe = {
		{'default:ironblock'},
	}
})

minetest.register_craft({
	output = 'default:steelblock',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:steel_ingot 9',
	recipe = {
		{'default:steelblock'},
	}
})

minetest.register_craft({
	output = 'default:copperblock',
	recipe = {
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
		{'default:copper_ingot', 'default:copper_ingot', 'default:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'default:copper_ingot 9',
	recipe = {
		{'default:copperblock'},
	}
})

minetest.register_craft({
	output = "default:tinblock",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
	}
})

minetest.register_craft({
	output = "default:tin_ingot 9",
	recipe = {
		{"default:tinblock"},
	}
})

minetest.register_craft({
	output = 'default:bronzeblock',
	recipe = {
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
		{'default:bronze_ingot', 'default:bronze_ingot', 'default:bronze_ingot'},
	}
})

minetest.register_craft({
	output = 'default:bronze_ingot 9',
	recipe = {
		{'default:bronzeblock'},
	}
})

minetest.register_craft({
	output = 'default:goldblock',
	recipe = {
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'default:gold_ingot 9',
	recipe = {
		{'default:goldblock'},
	}
})

minetest.register_craft({
	output = 'default:diamondblock',
	recipe = {
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
		{'default:diamond', 'default:diamond', 'default:diamond'},
	}
})

minetest.register_craft({
	output = 'default:diamond 9',
	recipe = {
		{'default:diamondblock'},
	}
})

minetest.register_craft({
	output = "default:sandstone",
	recipe = {
		{"default:sand", "default:sand"},
		{"default:sand", "default:sand"},
	}
})

minetest.register_craft({
	output = "default:sand 2",
	recipe = {
		{"default:sandstone"},
	}
})

minetest.register_craft({
	output = "default:sandstonebrick 4",
	recipe = {
		{"default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone"},
	}
})

minetest.register_craft({
	output = "default:sandstone_block 9",
	recipe = {
		{"default:sandstone", "default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone", "default:sandstone"},
	}
})

minetest.register_craft({
	output = "default:desert_sandstone",
	recipe = {
		{"default:desert_sand", "default:desert_sand"},
		{"default:desert_sand", "default:desert_sand"},
	}
})

minetest.register_craft({
	output = "default:desert_sand 2",
	recipe = {
		{"default:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "default:desert_sandstone_brick 4",
	recipe = {
		{"default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "default:desert_sandstone_block 9",
	recipe = {
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
		{"default:desert_sandstone", "default:desert_sandstone", "default:desert_sandstone"},
	}
})

minetest.register_craft({
	output = "default:silver_sandstone",
	recipe = {
		{"default:silver_sand", "default:silver_sand"},
		{"default:silver_sand", "default:silver_sand"},
	}
})

minetest.register_craft({
	output = "default:silver_sand 2",
	recipe = {
		{"default:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "default:silver_sandstone_brick 4",
	recipe = {
		{"default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone"},
	}
})

minetest.register_craft({
	output = "default:silver_sandstone_block 9",
	recipe = {
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
		{"default:silver_sandstone", "default:silver_sandstone", "default:silver_sandstone"},
	}
})

minetest.register_craft({
	output = 'default:clay',
	recipe = {
		{'default:clay_lump', 'default:clay_lump'},
		{'default:clay_lump', 'default:clay_lump'},
	}
})

minetest.register_craft({
	output = 'default:clay_lump 4',
	recipe = {
		{'default:clay'},
	}
})

minetest.register_craft({
	output = 'default:brick',
	recipe = {
		{'default:clay_brick', 'default:clay_brick'},
		{'default:clay_brick', 'default:clay_brick'},
	}
})

minetest.register_craft({
	output = 'default:clay_brick 4',
	recipe = {
		{'default:brick'},
	}
})

minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})

minetest.register_craft({
	output = 'default:book',
	recipe = {
		{'default:paper'},
		{'default:paper'},
		{'default:paper'},
	}
})

minetest.register_craft({
	output = 'default:bookshelf',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = "default:ladder_wood 5",
	recipe = {
		{"group:stick", "", "group:stick"},
		{"group:stick", "group:stick", "group:stick"},
		{"group:stick", "", "group:stick"},
	}
})

minetest.register_craft({
	output = 'default:ladder_steel 15',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:mese',
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal 9',
	recipe = {
		{'default:mese'},
	}
})

minetest.register_craft({
	output = 'default:mese_crystal_fragment 9',
	recipe = {
		{'default:mese_crystal'},
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
	output = 'default:meselamp',
	recipe = {
		{'default:glass'},
		{'default:mese_crystal'},
	}
})

minetest.register_craft({
	output = "default:mese_post_light 3",
	recipe = {
		{"", "default:glass", ""},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"", "group:wood", ""},
	}
})

minetest.register_craft({
	output = 'default:obsidian_shard 9',
	recipe = {
		{'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:obsidian',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'default:obsidianbrick 4',
	recipe = {
		{'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian'}
	}
})

minetest.register_craft({
	output = 'default:obsidian_block 9',
	recipe = {
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	}
})

minetest.register_craft({
	output = 'default:stonebrick 4',
	recipe = {
		{'default:stone', 'default:stone'},
		{'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:stone_block 9',
	recipe = {
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'default:desert_stonebrick 4',
	recipe = {
		{'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:desert_stone_block 9',
	recipe = {
		{'default:desert_stone', 'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone', 'default:desert_stone'},
		{'default:desert_stone', 'default:desert_stone', 'default:desert_stone'},
	}
})

minetest.register_craft({
	output = 'default:snowblock',
	recipe = {
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
		{'default:snow', 'default:snow', 'default:snow'},
	}
})

minetest.register_craft({
	output = 'default:snow 9',
	recipe = {
		{'default:snowblock'},
	}
})

minetest.register_craft({
	output = "default:emergent_jungle_sapling",
	recipe = {
		{"default:junglesapling", "default:junglesapling", "default:junglesapling"},
		{"default:junglesapling", "default:junglesapling", "default:junglesapling"},
		{"default:junglesapling", "default:junglesapling", "default:junglesapling"},
	}
})

minetest.register_craft({
	output = "default:large_cactus_seedling 2",
	recipe = {
		{"default:cactus"},
		{"default:cactus"},
		{"default:cactus"},
	}
})

minetest.register_craft({
	output = 'default:limestone',
	recipe = {
		{'default:limestone_dust', 'default:limestone_dust'},
		{'default:limestone_dust', 'default:limestone_dust'}
	}
})


--
-- Crafting (tool repair)
--

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})


--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:mossycobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "default:desert_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:clay_brick",
	recipe = "default:clay_lump",
})

-- civtest_game specific

minetest.register_craft({
	type = "cooking",
	output = "default:marble_block",
	recipe = "default:limestone",
        cooktime = 5
})

minetest.register_craft({
	type = "cooking",
	output = "default:charcoal",
	recipe = "group:tree",
})

minetest.register_craft({
	output = 'default:pick_wrought_iron',
	recipe = {
		{'default:wrought_iron_ingot', 'default:wrought_iron_ingot', 'default:wrought_iron_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_wrought_iron_good',
	recipe = {
		{'default:comp_wrought_iron_pickhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:pick_wrought_iron_superior',
	recipe = {
		{'default:comp_wrought_iron_pickhead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:pick_steel_good',
	recipe = {
		{'default:comp_steel_pickhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:pick_steel_superior',
	recipe = {
		{'default:comp_steel_pickhead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:pick_fine_steel',
	recipe = {
		{'default:fine_steel_ingot', 'default:fine_steel_ingot', 'default:fine_steel_ingot'},
		{'', 'group:stick', ''},
		{'', 'group:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_fine_steel_good',
	recipe = {
		{'default:comp_fine_steel_pickhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:pick_fine_steel_superior',
	recipe = {
		{'default:comp_fine_steel_pickhead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel_good',
	recipe = {
		{'default:comp_steel_axehead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel_superior',
	recipe = {
		{'default:comp_steel_axehead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:axe_fine_steel',
	recipe = {
		{'default:fine_steel_ingot', 'default:fine_steel_ingot'},
		{'default:fine_steel_ingot', 'group:stick'},
		{'', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:axe_fine_steel_good',
	recipe = {
		{'default:comp_fine_steel_axehead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:axe_fine_steel_superior',
	recipe = {
		{'default:comp_fine_steel_axehead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel_good',
	recipe = {
		{'default:comp_steel_shovelhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel_superior',
	recipe = {
		{'default:comp_steel_shovelhead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:shovel_fine_steel',
	recipe = {
		{'default:fine_steel_ingot'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_fine_steel_good',
	recipe = {
		{'default:comp_fine_steel_shovelhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:shovel_fine_steel_superior',
	recipe = {
		{'default:comp_fine_steel_shovelhead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:sword_steel_good',
	recipe = {
		{'default:comp_steel_swordhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:sword_steel_superior',
	recipe = {
		{'default:comp_steel_swordhead_sharp',},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:sword_fine_steel',
	recipe = {
		{'default:fine_steel_ingot'},
		{'default:fine_steel_ingot'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:sword_fine_steel_good',
	recipe = {
		{'default:comp_fine_steel_swordhead'},
		{'default:comp_toolrod'},
	}
})

minetest.register_craft({
	output = 'default:sword_fine_steel_superior',
	recipe = {
		{'default:comp_fine_steel_swordhead_sharp'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:mace',
	recipe = {
	    {'group:ferrous_ingot'},
		{'default:comp_toolrod'}
	}
})

minetest.register_craft({
	output = 'default:morningstar',
	recipe = {
		{'', 'default:comp_fine_steel_shovelhead_sharp'},
		{'default:comp_toolrod_strong', ''}
	}
})

minetest.register_craft({
	output = 'default:katana',
	recipe = {
	    {'', '', 'default:comp_fine_steel_swordhead_sharp'},
		{'', 'default:comp_fine_steel_swordhead_sharp', ''},
		{'default:comp_toolrod_strong', '', ''},
	}
})

minetest.register_craft({
	output = 'default:sabre',
	recipe = {
	    {'', '', 'default:comp_fine_steel_swordhead_sharp'},
		{'', 'default:comp_toolrod_strong', ''},
		{'default:brass_ingot', '', ''},
	}
})

minetest.register_craft({
	output = 'default:rapier',
	recipe = {
		{'default:comp_fine_steel_swordhead_sharp'},
		{'default:comp_fine_steel_shovelhead'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:glaive',
	recipe = {
		{'default:comp_fine_steel_swordhead_sharp'},
		{'default:comp_toolrod_strong'},
		{'default:comp_toolrod_strong'},
	}
})

minetest.register_craft({
	output = 'default:halberd',
	recipe = {
		{'', 'default:comp_fine_steel_axehead_sharp', 'default:comp_fine_steel_swordhead_sharp'},
		{'', 'default:comp_toolrod_strong', ''},
		{'default:comp_toolrod_strong', '', ''},
	}
})

minetest.register_craft({
	output = 'default:war_hammer',
	recipe = {
		{'', '', 'default:comp_fine_steel_axehead_sharp'},
		{'', 'default:comp_toolrod_strong', ''},
		{'default:comp_toolrod_strong', '', ''},
	}
})

minetest.register_craft({
	output = 'default:discreet_lamp_wood 4',
	recipe = {
		{'', 'group:wood', ''},
		{'group:wood', 'group:coal', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'default:discreet_lamp_metal 8',
	recipe = {
		{'', 'group:metal_ingot', ''},
		{'group:metal_ingot', 'group:coal', 'group:metal_ingot'},
	}
})

minetest.register_craft({
	output = 'default:scaffolding',
	recipe = {
		{'group:stick', '', 'group:stick'},
		{'', 'group:wood', ''},
		{'group:stick', '', 'group:stick'},
	}
})

minetest.register_craft({
	output = 'default:basalt',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:stone', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'default:basalt_brick 4',
	recipe = {
		{'default:basalt', 'default:basalt'},
		{'default:basalt', 'default:basalt'}
	}
})

minetest.register_craft({
	output = 'default:basalt_block 9',
	recipe = {
		{'default:basalt', 'default:basalt', 'default:basalt'},
		{'default:basalt', 'default:basalt', 'default:basalt'},
		{'default:basalt', 'default:basalt', 'default:basalt'},
	}
})

minetest.register_craft({
	output = 'default:granite',
	recipe = {
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:gravel', 'default:obsidian_shard'},
		{'default:obsidian_shard', 'default:obsidian_shard', 'default:obsidian_shard'},
	}
})

minetest.register_craft({
	output = 'default:granite_brick 4',
	recipe = {
		{'default:granite', 'default:granite'},
		{'default:granite', 'default:granite'}
	}
})

minetest.register_craft({
	output = 'default:granite_block 9',
	recipe = {
		{'default:granite', 'default:granite', 'default:granite'},
		{'default:granite', 'default:granite', 'default:granite'},
		{'default:granite', 'default:granite', 'default:granite'},
	}
})

minetest.register_craft({
	output = 'default:stronghold_glass',
	recipe = {
		{'default:obsidianbrick', 'default:steel_ingot', 'default:obsidianbrick'},
		{'default:steel_ingot', 'default:glass', 'default:steel_ingot'},
		{'default:obsidianbrick', 'default:steel_ingot', 'default:obsidianbrick'},
	}
})

minetest.register_craft({
	output = 'default:stronghold_bricks',
	recipe = {
		{'default:obsidianbrick', 'default:steel_ingot', 'default:obsidianbrick'},
		{'default:steel_ingot', 'default:tinblock', 'default:steel_ingot'},
		{'default:obsidianbrick', 'default:steel_ingot', 'default:obsidianbrick'},
	}
})

minetest.register_craft({
	output = 'default:stronghold_tile 4',
	recipe = {
		{'default:stronghold_bricks', 'default:stronghold_bricks'},
		{'default:stronghold_bricks', 'default:stronghold_bricks'}
	}
})

minetest.register_craft({
	output = 'default:fortress_glass',
	recipe = {
		{'default:obsidianbrick', 'default:fine_steel_ingot', 'default:obsidianbrick'},
		{'default:fine_steel_ingot', 'default:glass', 'default:fine_steel_ingot'},
		{'default:obsidianbrick', 'default:fine_steel_ingot', 'default:obsidianbrick'},
	}
})

minetest.register_craft({
	output = 'default:fortress_bricks',
	recipe = {
		{'default:obsidianbrick', 'default:fine_steel_ingot', 'default:obsidianbrick'},
		{'default:fine_steel_ingot', 'default:tinblock', 'default:fine_steel_ingot'},
		{'default:obsidianbrick', 'default:fine_steel_ingot', 'default:obsidianbrick'},
	}
})

minetest.register_craft({
	output = 'default:fortress_tile 4',
	recipe = {
		{'default:fortress_bricks', 'default:fortress_bricks'},
		{'default:fortress_bricks', 'default:fortress_bricks'}
	}
})

minetest.register_craft({
	output = 'default:spikes_wooden 10',
	recipe = {
		{'', 'default:sword_wood', ''},
		{'default:sword_wood', 'group:stick', 'default:sword_wood'}
	}
})

minetest.register_craft({
	output = 'default:spikes_steel 20',
	recipe = {
		{'', 'default:comp_steel_swordhead_sharp', ''},
		{'default:comp_steel_swordhead_sharp', 'default:comp_toolrod_strong', 'default:comp_steel_swordhead_sharp'}
	}
})

armor_materials_advanced = {
	iron = "default:comp_iron_",
	steel = "default:comp_steel_",
	fine_steel = "default:comp_fine_steel_"
}

for k, v in pairs(armor_materials_advanced) do
	minetest.register_craft({
		output = "3d_armor:helmet_"..k,
		recipe = {
			{v.."plate", v.."plate", v.."plate"},
			{v.."plate", "", v.."plate"},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "3d_armor:boots_"..k,
		recipe = {
			{v.."plate", "", v.."plate"},
			{v.."plate", "", v.."plate"},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..k.."_mail",
		recipe = {
			{v.."chain", "", v.."chain"},
			{v.."chain", v.."chain", v.."chain"},
			{v.."chain", v.."chain", v.."chain"},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..k.."_mail",
		recipe = {
			{v.."chain", v.."chain", v.."chain"},
			{v.."chain", "", v.."chain"},
			{v.."chain", "", v.."chain"},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..k.."_scale",
		recipe = {
			{v.."scale", "", v.."scale"},
			{v.."scale", v.."scale", v.."scale"},
			{v.."scale", v.."scale", v.."scale"},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..k.."_scale",
		recipe = {
			{v.."scale", v.."scale", v.."scale"},
			{v.."scale", "", v.."scale"},
			{v.."scale", "", v.."scale"},
		},
	})
	minetest.register_craft({
		output = "3d_armor:chestplate_"..k.."_plate",
		recipe = {
			{v.."plate", "", v.."plate"},
			{v.."plate", v.."plate", v.."plate"},
			{v.."plate", v.."plate", v.."plate"},
		},
	})
	minetest.register_craft({
		output = "3d_armor:leggings_"..k.."_plate",
		recipe = {
			{v.."plate", v.."plate", v.."plate"},
			{v.."plate", "", v.."plate"},
			{v.."plate", "", v.."plate"},
		},
	})
end

--
-- Fuels
--

-- Support use of group:tree, includes default:tree which has the same burn time
minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 30,
})

-- Burn time for all woods are in order of wood density,
-- which is also the order of wood colour darkness:
-- aspen, pine, apple, acacia, jungle

minetest.register_craft({
	type = "fuel",
	recipe = "default:aspen_tree",
	burntime = 22,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_tree",
	burntime = 26,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_tree",
	burntime = 34,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:jungletree",
	burntime = 38,
})


-- Support use of group:wood, includes default:wood which has the same burn time
minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:aspen_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_wood",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglewood",
	burntime = 9,
})


-- Support use of group:sapling, includes default:sapling which has the same burn time
minetest.register_craft({
	type = "fuel",
	recipe = "group:sapling",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bush_sapling",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_bush_sapling",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_bush_sapling",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:aspen_sapling",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_sapling",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_sapling",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglesapling",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:emergent_jungle_sapling",
	burntime = 7,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_aspen_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_pine_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_acacia_wood",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_junglewood",
	burntime = 9,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_aspen_wood",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_pine_wood",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_wood",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_acacia_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fence_rail_junglewood",
	burntime = 7,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:bush_stem",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:acacia_bush_stem",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:pine_bush_stem",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:junglegrass",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:cactus",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:large_cactus_seedling",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:papyrus",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:ladder_wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:lava_source",
	burntime = 60,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:torch",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:charcoal",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coke",
	burntime = 80,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:dry_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:fern_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:marram_grass_1",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:paper",
	burntime = 1,
})

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
	recipe = "default:dry_shrub",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:stick",
	burntime = 1,
})


minetest.register_craft({
	type = "fuel",
	recipe = "default:pick_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:shovel_wood",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:axe_wood",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:sword_wood",
	burntime = 5,
})
