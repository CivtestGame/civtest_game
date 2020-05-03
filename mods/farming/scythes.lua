farming.register_scythe("farming:scythe_stone", {
	description = "Stone Scythe",
	inventory_image = "farming_tool_stonescythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 50, maxlevel = 1}
	},
    material = "group:stone",
	radius = 1,
	efficacy = .5
})

farming.register_scythe("farming:scythe_steel", {
	description = "Steel Scythe",
	inventory_image = "farming_tool_steelscythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 1000, maxlevel = 1}
	},
    material = "default:steel_ingot",
	radius = 2,
	efficacy = .7
})

farming.register_scythe("farming:scythe_bronze", {
	description = "Bronze Scythe",
	inventory_image = "farming_tool_bronzescythe.png",
	groups = { scythe = 1 },
	groupcaps = {
		poaceae = { times = {[1] = 0.01}, uses = 500, maxlevel = 1}
	},
    material = "default:bronze_ingot",
	radius = 1,
	efficacy = .7
})

