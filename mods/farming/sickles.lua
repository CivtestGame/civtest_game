farming.register_sickle("farming:sickle_wood", {
	description = "Wooden sickle",
	inventory_image = "farming_tool_woodsickle.png",
	groups = { sickle = 1 , flammable = 2},
	groupcaps = {
		leaves = { times = {[1] = 20.00}, uses = 10, maxlevel = 1}
	},
	material = "group:wood",
	sapling_chance = 5
})

farming.register_sickle("farming:sickle_stone", {
	description = "Stone sickle",
	inventory_image = "farming_tool_stonesickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 8.00}, uses = 30, maxlevel = 1}
	},
	material = "group:stone",
	sapling_chance = 4
})

farming.register_sickle("farming:sickle_bronze", {
	description = "Bronze sickle",
	inventory_image = "farming_tool_bronzesickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 2.00}, uses = 200, maxlevel = 1}
	},
	material = "default:bronze_ingot",
	sapling_chance = 3
})

farming.register_sickle("farming:sickle_steel", {
	description = "Steel sickle",
	inventory_image = "farming_tool_steelsickle.png",
	groups = { sickle = 1 },
	groupcaps = {
		leaves = { times = {[1] = 1.00}, uses = 1000, maxlevel = 1}
	},
	material = "default:steel_ingot",
	sapling_chance = 2
})

farming.override_leaves("default:leaves", "default:sapling")
farming.override_leaves("default:jungleleaves", "default:junglesapling")
farming.override_leaves("default:acacia_leaves", "default:acacia_sapling")
farming.override_leaves("default:aspen_leaves", "default:aspen_sapling")
farming.override_leaves("default:bush_leaves", "default:bush_sapling")
farming.override_leaves("default:blueberry_bush_leaves", "default:blueberry_bush_sapling")
farming.override_leaves("default:acacia_bush_leaves", "default:acacia_bush_sapling")

