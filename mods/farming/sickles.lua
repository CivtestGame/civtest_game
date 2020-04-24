farming.register_sickle(":farming:sickle_wood", {
	description = "Wooden sickle",
	inventory_image = "farming_tool_woodsickle.png",
	groups = { sickle = 1 , flammable = 2},
	groupcaps = {
		leaves = { times = {[1] = 20.00}, uses = 10, maxlevel = 1}
	},
	max_uses = 30,
	material = "group:wood"
})

farming.register_sickle(":farming:sickle_stone", {
	description = "Stone sickle",
	inventory_image = "farming_tool_stonesickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 8.00}, uses = 10, maxlevel = 1}
	},
	max_uses = 30,
	material = "group:wood"
})

farming.register_sickle(":farming:sickle_bronze", {
	description = "Stone sickle",
	inventory_image = "farming_tool_bronzesickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 2.00}, uses = 10, maxlevel = 1}
	},
	max_uses = 30,
	material = "group:wood"
})

farming.register_sickle(":farming:sickle_steel", {
	description = "Stone sickle",
	inventory_image = "farming_tool_steelsickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 1.00}, uses = 10, maxlevel = 1}
	},
	max_uses = 30,
	material = "group:wood"
})

