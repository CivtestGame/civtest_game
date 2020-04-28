farming.register_hoe(":farming:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	groups = { hoe = 1 , flammable = 2},
	groupcaps = {
		tillable = { times = {[1] = 5.00}, uses = 30, maxlevel = 1},
	},
	material = "group:wood"
})

farming.register_hoe(":farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 2.50}, uses = 90, maxlevel = 1},
	},
	material = "group:stone"
})

farming.register_hoe(":farming:hoe_copper", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_copperhoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 1.50}, uses = 160, maxlevel = 1}
	},
    material = "default:copper_ingot"
})

farming.register_hoe(":farming:hoe_tin", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_tinhoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 1.50}, uses = 180, maxlevel = 1}
	},
    material = "default:tin_ingot"
})


farming.register_hoe(":farming:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 1.00}, uses = 220, maxlevel = 1},
		field = { maxlevel = 0}
	},
	material = "default:bronze_ingot"
})

farming.register_hoe(":farming:hoe_iron", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_ironhoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 0.80}, uses = 300, maxlevel = 1}
	},
    material = "default:iron_ingot"
})

farming.register_hoe(":farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	groups = { hoe = 1 },
	groupcaps = {
		tillable = { times = {[1] = 0.50}, uses = 500, maxlevel = 1},
		field = { maxlevel = 0}
	},
	material = "default:steel_ingot"
})
