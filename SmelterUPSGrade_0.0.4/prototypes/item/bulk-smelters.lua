--Item definitions
local item_smelter = table.deepcopy(data.raw.item["electric-furnace"])
--item_smelter.icon = "__base__/graphics/icons/assembling-machine-2.png"
item_smelter.icons = {
	{
		icon = "__base__/graphics/icons/electric-furnace.png",
		tint = {r= 1, g = .647, b = 0, a = 1},
		icon_size = 32
	}
}
item_smelter.name = "bulk-smelter"
item_smelter.order = "f[bulk-smelter]"
item_smelter.stack_size = 1
item_smelter.place_result = "bulk-smelter"

local item_centrifuge = table.deepcopy(data.raw.item["centrifuge"])
item_centrifuge.icon = nil
item_centrifuge.icons = {
	{
		icon = "__base__/graphics/icons/centrifuge.png",
		tint = {r= 1, g = .647, b = 0, a = 1},
		icon_size = 32
	}
}
item_centrifuge.name = "bulk-centrifuge"
item_centrifuge.order = "cc[bulk-centrifuge]"
item_centrifuge.stack_size = 1
item_centrifuge.place_result = "bulk-centrifuge"

data:extend({item_smelter})
data:extend({item_centrifuge})