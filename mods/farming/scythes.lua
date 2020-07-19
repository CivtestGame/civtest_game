farming.register_scythe("farming:scythe_stone", {
	description = "Stone Scythe",
	inventory_image = "farming_tool_stonescythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 40, maxlevel = 1}
	},
        material = "group:stone",
	radius = 1,
	efficacy = .4
})

farming.register_scythe("farming:scythe_copper", {
	description = "Copper Scythe",
	inventory_image = "farming_tool_copperscythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 400, maxlevel = 1}
	},
        material = "default:copper_ingot",
	radius = 1,
	efficacy = .5
})

farming.register_scythe("farming:scythe_bronze", {
	description = "Bronze Scythe",
	inventory_image = "farming_tool_bronzescythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 1000, maxlevel = 1}
	},
        material = "default:bronze_ingot",
	radius = 1,
	efficacy = .6
})

farming.register_scythe("farming:scythe_iron", {
	description = "Iron Scythe",
	inventory_image = "farming_tool_ironscythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 750, maxlevel = 1}
	},
        material = "default:iron_ingot",
	radius = 1,
	efficacy = .7
})
