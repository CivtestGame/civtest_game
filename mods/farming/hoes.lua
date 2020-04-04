-- farming/hoes.lua

-- support for MT game translation.
local S = farming.get_translator

farming.register_hoe(":farming:hoe_wood", {
	description = S("Wooden Hoe"),
	inventory_image = "farming_tool_woodhoe.png",
	groups = { hoe = 1 },
	max_uses = 30,
	material = "group:wood",
	groups = {hoe = 1, flammable = 2},
})

farming.register_hoe(":farming:hoe_stone", {
	description = S("Stone Hoe"),
	inventory_image = "farming_tool_stonehoe.png",
	groups = { hoe = 1 },
	max_uses = 90,
	material = "group:stone",
	groups = {hoe = 1}
})

farming.register_hoe(":farming:hoe_bronze", {
	description = S("Bronze Hoe"),
	inventory_image = "farming_tool_bronzehoe.png",
	groups = { hoe = 1 },
	max_uses = 220,
        material = "default:bronze_ingot"
})

farming.register_hoe(":farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	groups = { hoe = 1 },
	max_uses = 500,
	material = "default:steel_ingot"
})
