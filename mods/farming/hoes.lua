farming.register_hoe(":farming:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	groups = { hoe = 1 , flammable = 2},
	groupcaps = {
		tillable = { times = {[1] = 5.00}, uses = 10, maxlevel = 1}
	},
	max_uses = 30,
	material = "group:wood"
})

farming.register_hoe(":farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 2.50}, uses = 10, maxlevel = 1}
	},
	max_uses = 90,
	material = "group:stone"
})

farming.register_hoe(":farming:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 1.00}, uses = 10, maxlevel = 1}
	},
	max_uses = 220,
        material = "default:bronze_ingot"
})

farming.register_hoe(":farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 0.50}, uses = 10, maxlevel = 1}
	},
	max_uses = 500,
	material = "default:steel_ingot"
})
