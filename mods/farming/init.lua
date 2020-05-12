-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming")

farming.mod = "civfarm"

-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")
dofile(farming.path .. "/sickles.lua")
dofile(farming.path .. "/trees.lua")


-- WHEAT

farming.register_plant("farming:wheat", {
	description = "Wheat Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_wheat_seed.png",
	steps = 8,
	fertility = {"grassland", "desert"},
	groups = {food_wheat = 1, food_grain = 1, flammable = 4, spoils=7},
	place_param2 = 3,
	custom_growth = {optimum_heat = 60, heat_scaling = "exponential", heat_a = 2.1, heat_b = 1.2, heat_base_speed = 5000, optimum_humidity = 46, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.5, humidity_base_speed = 2500, variance = 1250},
})

minetest.register_craftitem("farming:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

minetest.register_craftitem("farming:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2, spoils=5},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:bread",
	recipe = "farming:flour"
})


-- Cotton

farming.register_plant("farming:cotton", {
	description = "Cotton Seed",
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 4.0, heat_b = 1.8, heat_base_speed = 2500, optimum_humidity = 55, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.5, humidity_base_speed = 2500, variance = 500},
})

minetest.register_craftitem("farming:string", {
	description = "String",
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
	groups = {food_potato = 1, food_rich =1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 40, heat_scaling = "exponential", heat_a = 2.5, heat_b = 1.3, heat_base_speed = 7500, optimum_humidity = 77, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.5, humidity_base_speed = 7500, variance = 2500},
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

-- Rice

farming.register_plant("farming:rice", {
	description = "Rice Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_rice_seed.png",
	steps = 4,
	fertility = {"grassland","desert"},
	groups = {food_rice = 1, food_grain = 1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 65, heat_scaling = "exponential", heat_a = 1.9, heat_b = 2.0, heat_base_speed = 3000, optimum_humidity = 73, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.5, humidity_base_speed = 3000, variance = 1250},
})

minetest.register_craftitem("farming:rice", {
	description = "Rice",
	inventory_image = "farming_rice.png",
	groups = {food_rice = 1},
})


minetest.register_craftitem("farming:cooked_rice", {
	description = "Cooked Rice",
	inventory_image = "farming_cooked_rice.png",
	on_use = minetest.item_eat(3),
	groups = {food_rice = 1, flammable = 2, spoils=1},
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:cooked_rice",
	recipe = "farming:rice"
})

minetest.register_craftitem("farming:rice_flour", {
	description = "Rice Flour",
	inventory_image = "farming_rice_flour.png",
	groups = {food_flour = 1},
})

minetest.register_craft({
	output = "farming:rice_flour",
	recipe = {{"farming:rice", "farming:rice"}}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming:bread",
	recipe = "farming:rice_flour"
})

-- Canola

farming.register_plant("farming:canola", {
	description = "Canola Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_canola_seed.png",
	steps = 6,
	fertility = {"grassland","desert"},
	groups = {food_canola = 1, flammable = 4, food_oil_seed = 1},
	place_param2 = 3,
	drops_seeds = 1,
	custom_growth = {optimum_heat = 50, heat_scaling = "exponential", heat_a = 2.0, heat_b = 1.3, heat_base_speed = 10000, optimum_humidity = 50, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.2, humidity_base_speed = 5000, variance = 2500},
})

-- Soybeans

farming.register_plant("farming:soybean", {
	description = "Soybean Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_soybean_seed.png",
	steps = 4,
	fertility = {"grassland","desert"},
	groups = {food_bean = 1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 60, heat_scaling = "exponential", heat_a = 2.8, heat_b = 1.8, heat_base_speed = 7500, optimum_humidity = 53, humidity_scaling = "exponential", humidity_a = 1.2, humidity_b = 1.5, humidity_base_speed = 7500, variance = 1250},
})

minetest.register_craftitem("farming:soybean", {
	description = "Soybean",
	inventory_image = "farming_soybean.png",
	groups = {food_bean = 1},
})

-- Agave

farming.register_plant("farming:agave", {
	description = "Agave Cutting",
	paramtype2 = "meshoptions",
	inventory_image = "farming_agave_seed.png",
	steps = 8,
	fertility = {"desert"},
	groups = {food_cactus = 1, flammable = 1},
	place_param2 = 2,
	custom_growth = {optimum_heat = 90, heat_scaling = "exponential", heat_a = 2.0, heat_b = 1.4, heat_base_speed = 20000, optimum_humidity = 18, humidity_scaling = "exponential", humidity_a = 1.3, humidity_b = 2.5, humidity_base_speed = 20000, variance = 8000},
})

minetest.register_craftitem("farming:agave", {
	description = "Agave Leaf",
	inventory_image = "farming_agave.png",
	on_use = minetest.item_eat(3),
	groups = {food_syrup = 1, sugar_source = 1},
})

-- Rhubarb

farming.register_plant("farming:rhubarb", {
	description = "Rhubarb Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_rhubarb_seed.png",
	steps = 4,
	fertility = {"grassland"},
	groups = {flammable = 4},
	place_param2 = 2,
	custom_growth = {optimum_heat = 35, heat_scaling = "exponential", heat_a = 2.1, heat_b = 1.7, heat_base_speed = 10000, optimum_humidity = 75, humidity_scaling = "exponential", humidity_a = 1.2, humidity_b = 1.7, humidity_base_speed = 10000, variance = 2500},
})

minetest.register_craftitem("farming:rhubarb", {
	description = "Rhubarb",
	inventory_image = "farming_rhubarb.png",
	groups = {food_stalk = 1},
})

-- Flax

farming.register_plant("farming:flax", {
	description = "Flax Seed",
	inventory_image = "farming_flax_seed.png",
	steps = 5,
	fertility = {"grassland"},
	place_param2 = 3,
	groups = {flammable = 4},
	custom_growth = {optimum_heat = 44, heat_scaling = "exponential", heat_a = 2.2, heat_b = 1.6, heat_base_speed = 8000, optimum_humidity = 55, humidity_scaling = "exponential", humidity_a = 1.2, humidity_b = 1.6, humidity_base_speed = 5000, variance = 900},
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:flax", "farming:flax", "farming:flax"},
		{"farming:flax", "farming:flax", "farming:flax"},
	}
})

minetest.register_craft({
	output = "farming:string 2",
	recipe = {
		{"farming:flax"},
		{"farming:flax"},
	}
})

-- Sorghum

farming.register_plant("farming:sorghum", {
	description = "Sorghum Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_sorghum_seed.png",
	steps = 6,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4, food_grain = 1, spoils=14},
	place_param2 = 3,
	custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 1.6, heat_b = 1.6, heat_base_speed = 7500, optimum_humidity = 35, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.5, humidity_base_speed = 7500, variance = 2500},
})

minetest.register_craftitem("farming:sorghum", {
	description = "Sorghum",
	inventory_image = "farming_sorghum.png",
	on_use = minetest.item_eat(2),
	groups = {food_grain = 1},
})

-- Corn

farming.register_plant("farming:corn", {
	description = "Corn Kernel",
	paramtype2 = "meshoptions",
	inventory_image = "farming_corn_seed.png",
	steps = 6,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4, spoils=7},
	place_param2 = 3,
	custom_growth = {optimum_heat = 62, heat_scaling = "exponential", heat_a = 1.6, heat_b = 1.6, heat_base_speed = 4500, optimum_humidity = 33, humidity_scaling = "exponential", humidity_a = 1.5, humidity_b = 1.5, humidity_base_speed = 5500, variance = 2500},
})

minetest.register_craftitem("farming:corn", {
	description = "Corn Cob",
	inventory_image = "farming_corn.png",
	on_use = minetest.item_eat(3),
	groups = {food_grain = 1, food_salad = 1},
})

-- Rye

farming.register_plant("farming:rye", {
	description = "Rye Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_rye_seed.png",
	steps = 8,
	fertility = {"grassland"},
	groups = {food_wheat = 1, food_grain = 1, flammable = 4, spoils=7},
	place_param2 = 3,
	custom_growth = {optimum_heat = 37, heat_scaling = "exponential", heat_a = 1.7, heat_b = 1.7, heat_base_speed = 7500, optimum_humidity = 54, humidity_scaling = "exponential", humidity_a = 1.6, humidity_b = 1.6, humidity_base_speed = 5000, variance = 2500},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:rye", "farming:rye", "farming:rye"}
})

-- Tomato

farming.register_plant("farming:tomato", {
	description = "Tomato Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_tomato_seed.png",
	steps = 6,
	fertility = {"grassland","desert"},
	groups = {food_tomato = 1, flammable = 4, spoils=7},
	place_param2 = 3,
	custom_growth = {optimum_heat = 70, heat_scaling = "exponential", heat_a = 1.7, heat_b = 1.7, heat_base_speed = 7500, optimum_humidity = 43, humidity_scaling = "exponential", humidity_a = 1.6, humidity_b = 1.6, humidity_base_speed = 7500, variance = 2500},
})

minetest.register_craftitem("farming:tomato", {
	description = "Tomato",
	inventory_image = "farming_tomato.png",
	on_use = minetest.item_eat(2),
	groups = {food_salad = 1},
})

-- Spice Leaf

farming.register_plant("farming:spice_leaf", {
	description = "Spice Leaf Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_spice_leaf_seed.png",
	steps = 2,
	fertility = {"grassland","desert"},
	groups = {food_spice = 1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 54, heat_scaling = "exponential", heat_a = 1.7, heat_b = 1.7, heat_base_speed = 15000, optimum_humidity = 34, humidity_scaling = "exponential", humidity_a = 1.6, humidity_b = 1.6, humidity_base_speed = 15000, variance = 2500},
})

-- Lettuce

farming.register_plant("farming:lettuce", {
	description = "Lettuce Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_lettuce_seed.png",
	steps = 3,
	fertility = {"grassland","desert"},
	groups = {food_salad = 1, flammable = 4},
	place_param2 = 2,
	custom_growth = {optimum_heat = 42, heat_scaling = "exponential", heat_a = 1.7, heat_b = 1.7, heat_base_speed = 7500, optimum_humidity = 48, humidity_scaling = "exponential", humidity_a = 1.6, humidity_b = 1.6, humidity_base_speed = 7500, variance = 2500},
})

minetest.register_craftitem("farming:lettuce", {
	description = "Lettuce Leaf",
	inventory_image = "farming_lettuce.png",
	on_use = minetest.item_eat(2),
	groups = {food_salad = 1}
})

-- Beet

farming.register_plant("farming:beet", {
	description = "Sugar Beet Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_beet_seed.png",
	steps = 3,
	fertility = {"grassland"},
	groups = {food_salad = 1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 42, heat_scaling = "exponential", heat_a = 1.7, heat_b = 1.7, heat_base_speed = 7500, optimum_humidity = 61, humidity_scaling = "exponential", humidity_a = 1.6, humidity_b = 1.6, humidity_base_speed = 7500, variance = 2500},
})

minetest.register_craftitem("farming:beet", {
	description = "Sugar Beet",
	inventory_image = "farming_beet.png",
	on_use = minetest.item_eat(2),
	groups = {food_salad = 1, sugar_source = 1}
})

-- Grapes

farming.register_plant("farming:grape", {
	description = "Grape Seed",
	paramtype2 = "meshoptions",
	inventory_image = "farming_grape_seed.png",
	steps = 4,
	fertility = {"grassland","desert"},
	groups = {food_grape = 1, flammable = 4},
	place_param2 = 3,
	custom_growth = {optimum_heat = 61, heat_scaling = "exponential", heat_a = 2.1, heat_b = 2.4, heat_base_speed = 7500, optimum_humidity = 52, humidity_scaling = "exponential", humidity_a = 2.1, humidity_b = 2.4, humidity_base_speed = 7500, variance = 2500},
})

minetest.register_craftitem("farming:grape", {
	description = "Grape",
	inventory_image = "farming_grape.png",
	on_use = minetest.item_eat(2),
	groups = {food_salad = 1},
})


-- Other new ingredients

minetest.register_craftitem("farming:seed_oil", {
	description = "Seed Oil",
	inventory_image = "farming_seed_oil.png",
	groups = {food_oil = 1, flammable = 4},
})

minetest.register_craftitem("farming:salt", {
	description = "Salt",
	inventory_image = "farming_salt.png",
	groups = {food_salt = 1},
})

minetest.register_craftitem("farming:sugar", {
	description = "Sugar",
	inventory_image = "farming_sugar.png",
	groups = {food_sugar = 1},
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:seed_oil",
	burntime = 20,
})

dofile(farming.path .. "/cooking.lua")

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

-- Cactus Seedlings

farming.register_sapling("default:large_cactus_seedling", {
	description = "Cactus Seedling",
	image = "default_large_cactus_seedling.png",
	selection_box = {
		type = "fixed",
		fixed = { -5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16 }
	},
        tree_min_pos = {x = 0, y = 0, z = 0},
        tree_max_pos = {x = 0, y = 3, z = 0},
        custom_growth = {optimum_heat = 75, heat_scaling = "exponential", heat_a = 1, heat_b = 1, heat_base_speed = 10, variance = 10},
})
