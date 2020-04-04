-- farming/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("farming")

-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming")
farming.get_translator = S

farming.mod = "civfarm"

-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")
dofile(farming.path .. "/trees.lua")


-- WHEAT

farming.register_plant("farming:wheat", {
	description = S("Wheat Seed"),
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_wheat_seed.png",
	steps = 8,
	fertility = {"grassland", "desert"},
	groups = {food_wheat = 1, flammable = 4, spoils=7},
	place_param2 = 3,
	custom_growth = {optimum_heat = 50, heat_scaling = "exponential", heat_a = 2.5, heat_b = 1.7, heat_base_speed = 5000, variance = 1250},
})

minetest.register_craftitem("farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("farming:bread", {
	description = S("Bread"),
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2, spoils=5},
})

minetest.register_craft({
	output = "farming:flour",
	recipe = {{"farming:wheat", "farming:wheat"}}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:bread",
	recipe = "farming:flour"
})


-- Cotton

farming.register_plant("farming:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 10, heat_b = 1.2, heat_base_speed = 2500, variance = 500},
})

minetest.register_craftitem("farming:string", {
	description = S("String"),
	inventory_image = "farming_string.png",
	groups = {flammable = 2},
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:cotton", "farming:cotton"},
		{"farming:cotton", "farming:cotton"},
	}
})

minetest.register_craft({
	output = "farming:string 2",
	recipe = {
		{"farming:cotton"},
		{"farming:cotton"},
	}
})


-- Straw

minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"farming:straw"},
	}
})


-- Fuels

minetest.register_craft({
	type = "fuel",
	recipe = "farming:straw",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:cotton",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:string",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:hoe_wood",
	burntime = 5,
})

-- Potato

farming.register_plant("farming:potato", {
	description = "Potato Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_potato_seed.png",
	steps = 4,
	fertility = {"grassland","desert"},
	groups = {food_potato = 1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 40, heat_scaling = "exponential", heat_a = 2.5, heat_b = 1.7, heat_base_speed = 10000, variance = 2500},
})

minetest.register_craftitem("farming:potato", {
	description = "Potato",
	inventory_image = "farming_potato.png",
	on_use = minetest.item_eat(5),
	groups = {food_potato = 1, flammable = 2},
})


minetest.register_craftitem("farming:baked_potato", {
	description = "Baked Potato",
	inventory_image = "farming_baked_potato.png",
	on_use = minetest.item_eat(5),
	groups = {food_potato = 1, flammable = 2, spoils=3},
})


minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:baked_potato",
	recipe = "farming:potato"
})

-- Saplings

farming.register_sapling("default:sapling", {
	description = "Apple Tree Sapling",
	image = "default_sapling.png",
        tree_min_pos = {x = -3, y = 1, z = -3},
        tree_max_pos = {x = 3, y = 6, z = 3},
	custom_growth = {optimum_heat = 50, heat_scaling = "exponential", heat_a = 1, heat_b = 2, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:junglesapling", {
	description = "Jungle Tree Sapling",
	image = "default_junglesapling.png",
        tree_min_pos = {x = -2, y = 1, z = -2},
        tree_max_pos = {x = 2, y = 15, z = 2},
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 16, heat_b = 2.5, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:emergent_jungle_sapling", {
	description = "Emergent Jungle Tree Sapling",
	image = "default_emergent_jungle_sapling.png",
        tree_min_pos = {x = -3, y = -5, z = -3},
        tree_max_pos = {x = 3, y = 31, z = 3},
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 16, heat_b = 2.5, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:pine_sapling", {
	description = "Pine Tree Sapling",
	image = "default_pine_sapling.png",
        tree_min_pos = {x = -2, y = 1, z = -2},
        tree_max_pos = {x = 2, y = 14, z = 2},
	custom_growth = {optimum_heat = 35, heat_scaling = "exponential", heat_a = 16, heat_b = 1.7, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:acacia_sapling", {
	description = "Acacia Tree Sapling",
	image = "default_acacia_sapling.png",
        tree_min_pos = {x = -4, y = 1, z = -4},
        tree_max_pos = {x = 4, y = 7, z = 4},
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 16, heat_b = 2.5, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:aspen_sapling", {
	description = "Aspen Tree Sapling",
	image = "default_aspen_sapling.png",
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
	},
        tree_min_pos = {x = -2, y = 1, z = -2},
        tree_max_pos = {x = 2, y = 12, z = 2},
	custom_growth = {optimum_heat = 50, heat_scaling = "exponential", heat_a = 16, heat_b = 2.5, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:bush_sapling", {
	description = "Bush Sapling",
	image = "default_bush_sapling.png",
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
        },
        tree_min_pos = {x = -1, y = 0, z = -1},
        tree_max_pos = {x = 1, y = 1, z = 1},
	custom_growth = {optimum_heat = 50, heat_scaling = "exponential", heat_a = 1, heat_b = 2, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:blueberry_bush_sapling", {
	description = "Blueberry Bush Sapling",
	image = "default_blueberry_bush_sapling.png",
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
        tree_min_pos = {x = -1, y = 0, z = -1},
        tree_max_pos = {x = 1, y = 1, z = 1},
	custom_growth = {optimum_heat = 50, heat_scaling = "exponential", heat_a = 16, heat_b = 2.5, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:acacia_bush_sapling", {
	description = "Acacia Bush Sapling",
	image = "default_acacia_bush_sapling.png",
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 2 / 16, 3 / 16}
	},
        tree_min_pos = {x = -1, y = 0, z = -1},
        tree_max_pos = {x = 1, y = 1, z = 1},
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 16, heat_b = 2.5, heat_base_speed = 100000, variance = 10000},
})

farming.register_sapling("default:pine_bush_sapling", {
	description = "Pine Bush Sapling",
	image = "default_pine_bush_sapling.png",
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 2 / 16, 4 / 16}
	},
        tree_min_pos = {x = -1, y = 0, z = -1},
        tree_max_pos = {x = 1, y = 1, z = 1},
	custom_growth = {optimum_heat = 35, heat_scaling = "exponential", heat_a = 16, heat_b = 1.7, heat_base_speed = 100000, variance = 10000},
})
