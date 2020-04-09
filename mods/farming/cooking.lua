-- Cooking tools

minetest.register_craftitem("farming:kitchen_knife", {
	description = "Kitchen Knife",
	inventory_image = "farming_kitchen_knife.png",
	groups = {food_knife = 1},
})

minetest.register_craft({
	output = 'farming:kitchen_knife',
	recipe = {
		{'', 'group:metal_ingot', 'group:metal_ingot'},
		{'group:stick', '', ''},
	}
})

minetest.register_craftitem("farming:cooking_pot", {
	description = "Cooking Pot",
	inventory_image = "farming_cooking_pot.png",
	groups = {food_pot = 1},
})

minetest.register_craft({
	output = 'farming:cooking_pot',
	recipe = {
		{'group:metal_ingot', '', 'group:metal_ingot'},
		{'group:metal_ingot', 'bucket:bucket_empty', 'group:metal_ingot'},
	}
})

minetest.register_craftitem("farming:skillet", {
	description = "Skillet",
	inventory_image = "farming_skillet.png",
	groups = {food_pan = 1},
})

minetest.register_craft({
	output = 'farming:skillet',
	recipe = {
		{'default:stick', '', ''},
		{'group:metal_ingot', 'group:food_oil', 'group:metal_ingot'},
		{'', 'group:metal_ingot', ''}
	}
})

minetest.register_craftitem("farming:mortar_pestle", {
	description = "Mortar and Pestle",
	inventory_image = "farming_mortar_pestle.png",
	groups = {food_grind = 1},
})

minetest.register_craft({
	output = 'farming:mortar_pestle',
	recipe = {
		{'', 'default:stick', ''},
		{'default:stone', '', 'default:stone'},
		{'', 'default:stone', ''}
	}
})

minetest.register_craftitem("farming:hand_press", {
	description = "Hand Press",
	inventory_image = "farming_hand_press.png",
	groups = {food_press = 1},
})

minetest.register_craft({
	output = 'farming:hand_press',
	recipe = {
		{'group:metal_ingot', 'farming:string', 'group:metal_ingot'},
		{'', '', ''},
		{'group:metal_ingot', 'farming:string', 'group:metal_ingot'}
	}
})

-- Cooking Recipes

minetest.register_craft({
	type = "shapeless",
	output = "farming:seed_oil",
	recipe = {"farming:hand_press", "farming:seed_canola", "farming:seed_canola", "farming:seed_canola", "farming:seed_canola"},
    replacements = {{"farming:hand_press", "farming:hand_press"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:salt",
	recipe = {"bucket:bucket_water", "farming:cooking_pot"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"},{"farming:cooking_pot", "farming:cooking_pot"}},
})

minetest.register_craftitem("farming:tofu", {
	description = "Tofu",
	inventory_image = "farming_tofu.png",
	groups = {food_tofu = 1},
})

minetest.register_craftitem("farming:smoked_tofu", {
	description = "Smoked Tofu",
	inventory_image = "farming_cooked_tofu.png",
	groups = {food_tofu = 1, food_smoked_meat = 1, food_cooked_meat = 1},
})

minetest.register_craftitem("farming:fried_tofu", {
	description = "Fried Tofu",
	inventory_image = "farming_cooked_tofu.png",
	groups = {food_tofu = 1, food_cooked_meat = 1},
})

minetest.register_craftitem("farming:aqua_faba", {
	description = "Aqua Faba",
	inventory_image = "farming_aqua_faba.png",
})

minetest.register_craftitem("farming:soy_sauce", {
	description = "Soy Sauce",
	inventory_image = "farming_soy_sauce.png",
	groups = {food_sauce = 1},
})

minetest.register_craftitem("farming:vegan_egg", {
	description = "Vegan Egg",
	inventory_image = "mobs_chicken_egg.png",
	groups = {food_egg = 1},
})

minetest.register_craftitem("farming:seitan", {
	description = "Seitan (Wheat Gluten)",
	inventory_image = "farming_tofu.png",
	groups = {food_meat = 1, food_cooked_meat = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:tofu",
	recipe = {"farming:hand_press", "farming:soybean", "farming:soybean"},
    replacements = {{"farming:hand_press", "farming:hand_press"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:fried_tofu",
	recipe = {"farming:skillet", "farming:tofu", "group:food_oil"},
    replacements = {{"farming:skillet", "farming:skillet"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:soy_sauce",
	recipe = {"bucket:bucket_water", "farming:cooking_pot", "farming:soybean", "farming:salt"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"},{"farming:cooking_pot", "farming:cooking_pot"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:vegan_egg",
	recipe = {"farming:cooking_pot", "farming:tofu"},
	replacements = {{"farming:cooking_pot", "farming:cooking_pot"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:seitan",
	recipe = {"bucket:bucket_water", "farming:cooking_pot", "farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"},{"farming:cooking_pot", "farming:cooking_pot"}}
})

minetest.register_craftitem("farming:shortening", {
	description = "Vegetable Shortening",
	inventory_image = "farming_shortening.png",
	groups = {food_fat = 1},
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:shortening",
	recipe = {"farming:cooking_pot", "group:food_oil", "farming:salt"},
	replacements = {{"farming:cooking_pot", "farming:cooking_pot"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:sugar",
	recipe = {"farming:cooking_pot", "group:sugar_source", "group:sugar_source"},
	replacements = {{"farming:cooking_pot", "farming:cooking_pot"}}
})

minetest.register_craftitem("farming:noodles", {
	description = "Noodles",
	inventory_image = "farming_noodles.png",
	groups = {food_noodles = 1},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:noodles 5",
	recipe = {"farming:kitchen_knife", "group:food_flour","group:food_flour", "group:food_flour", "group:food_flour", "group:food_salt", "bucket:bucket_water",},
	replacements = {{"farming:kitchen_knife", "farming:kitchen_knife"},{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craftitem("farming:stir_fry", {
	description = "Stir Fry",
	inventory_image = "farming_spaghetti.png",
	groups = {food_noodles = 1},
	on_use = minetest.item_eat(7),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:stir_fry",
	recipe = {"farming:skillet", "group:food_oil", "farming:noodles", "group:food_tofu", "group:food_salad", "farming:soy_sauce"},
	replacements = {{"farming:skillet", "farming:skillet"}}
})

minetest.register_craftitem("farming:pasta", {
	description = "Pasta",
	inventory_image = "farming_pasta.png",
	groups = {food_pasta = 1},
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pasta 2",
	recipe = {"farming:kitchen_knife", "group:food_flour","group:food_flour", "bucket:bucket_water",},
	replacements = {{"farming:kitchen_knife", "farming:kitchen_knife"},{"bucket:bucket_water", "bucket:bucket_empty"}}
})

minetest.register_craftitem("farming:spaghetti", {
	description = "Spaghetti",
	inventory_image = "farming_spaghetti.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:spaghetti",
	recipe = {"farming:cooking_pot", "group:food_oil", "farming:salt", "group:food_pasta", "farming:tomato", "group:food_spice"},
	replacements = {{"farming:cooking_pot", "farming:cooking_pot"}}
})

minetest.register_craftitem("farming:spaghetti_meat", {
	description = "Spaghetti and Meatballs",
	inventory_image = "farming_spaghetti.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:spaghetti_meat",
	recipe = {"farming:skillet", "farming:spaghetti", "group:food_cooked_meat"},
	replacements = {{"farming:skillet", "farming:skillet"}}
})

minetest.register_craftitem("farming:fries", {
	description = "Fries",
	inventory_image = "farming_fries.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:fries 3",
	recipe = {"farming:cooking_pot", "group:food_oil", "group:food_oil", "farming:salt", "farming:potato", "farming:potato", "farming:potato", "farming:kitchen_knife"},
	replacements = {{"farming:cooking_pot", "farming:cooking_pot"},{"farming:kitchen_knife", "farming:kitchen_knife"}}
})

minetest.register_craftitem("farming:burger", {
	description = "Burger",
	inventory_image = "farming_burger.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:burger",
	recipe = {"farming:kitchen_knife", "group:food_cooked_meat", "farming:tomato", "farming:lettuce", "farming:bread"},
	replacements = {{"farming:kitchen_knife", "farming:kitchen_knife"}}
})

minetest.register_craftitem("farming:burger_fries", {
	description = "Burger and Fries",
	inventory_image = "farming_burger_fries.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:burger_fries",
	recipe = {"farming:burger", "farming:fries", "farming:fries"}
})

minetest.register_craftitem("farming:pie_luxurious", {
	description = "Luxurious Pie",
	inventory_image = "farming_pie_luxurious.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craftitem("farming:crumble", {
	description = "Rhubarb Apple Crumble",
	inventory_image = "farming_baked.png",
	on_use = minetest.item_eat(10),
})

--minetest.register_craft({
--	type = "shapeless",
--	output = "farming:pie_luxurious",
--	recipe = {"farming:flour", "group:food_egg", "group:food_fat", "group:food_cooked_meat", "farming:potato"}
--})

minetest.register_craftitem("farming:garden_salad", {
	description = "Garden Salad",
	inventory_image = "farming_garden_salad.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:garden_salad",
	recipe = {"farming:kitchen_knife", "group:food_salad", "group:food_salad", "group:food_salad"},
	replacements = {{"farming:kitchen_knife", "farming:kitchen_knife"}}
})

minetest.register_craftitem("farming:ploughmans_simple", {
	description = "Simple Ploughman's Lunch",
	inventory_image = "farming_ploughmans.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:ploughmans_simple",
	recipe = {"farming:kitchen_knife", "group:food_salad", "group:food_salad", "farming:bread"},
	replacements = {{"farming:kitchen_knife", "farming:kitchen_knife"}}
})

minetest.register_craftitem("farming:ploughmans", {
	description = "Ploughman's Lunch",
	inventory_image = "farming_ploughmans.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:ploughmans",
	recipe = {"farming:kitchen_knife", "group:food_salad", "group:food_salad", "farming:bread", "group:food_smoked_meat"},
	replacements = {{"farming:kitchen_knife", "farming:kitchen_knife"}}
})

minetest.register_craftitem("farming:corn_cob", {
	description = "Corn on the Cob",
	inventory_image = "farming_corn_cob.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:corn_cob",
	recipe = {"farming:salt", "farming:corn", "group:food_fat"}
})