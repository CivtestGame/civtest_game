
farming.register_sickle("farming:sickle_stone", {
	description = "Stone Sickle",
	inventory_image = "farming_tool_stonesickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 5.00}, uses = 40, maxlevel = 1}
	},
	material = "group:stone",
	sapling_chance = 5
})

farming.register_sickle("farming:sickle_copper", {
	description = "Copper Sickle",
	inventory_image = "farming_tool_coppersickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 4.50}, uses = 400, maxlevel = 1}
	},
	material = "default:copper_ingot",
	sapling_chance = 4
})

farming.register_sickle("farming:sickle_bronze", {
	description = "Bronze Sickle",
	inventory_image = "farming_tool_bronzesickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 4}, uses = 1000, maxlevel = 1}
	},
	material = "default:bronze_ingot",
	sapling_chance = 3
})

farming.register_sickle("farming:sickle_iron", {
	description = "Iron Sickle",
	inventory_image = "farming_tool_ironsickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 3}, uses = 750, maxlevel = 1}
	},
	material = "default:iron_ingot",
	sapling_chance = 2
})

farming.override_leaves("default:leaves", "default:sapling")
farming.override_leaves("default:jungleleaves", "default:junglesapling")
farming.override_leaves("default:acacia_leaves", "default:acacia_sapling")
farming.override_leaves("default:aspen_leaves", "default:aspen_sapling")
farming.override_leaves("default:bush_leaves", "default:bush_sapling")
farming.override_leaves("default:blueberry_bush_leaves", "default:blueberry_bush_sapling")
farming.override_leaves("default:acacia_bush_leaves", "default:acacia_bush_sapling")
farming.override_leaves("default:pine_needles", "default:pine_sapling")
