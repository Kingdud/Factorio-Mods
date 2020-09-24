--Item definitions
local item_smelter = table.deepcopy(data.raw.item["electric-furnace"])
item_smelter.icons = {
	{
		icon = "__base__/graphics/icons/electric-furnace.png",
		tint = building_tint,
		icon_size = data.raw.item["electric-furnace"].icon_size,
		icon_mipmaps = data.raw.item["electric-furnace"].icon_mipmaps
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
		tint = building_tint,
		icon_size = data.raw.item["centrifuge"].icon_size,
		icon_mipmaps = data.raw.item["centrifuge"].icon_mipmaps
	}
}
item_centrifuge.name = "bulk-centrifuge"
item_centrifuge.order = "cc[bulk-centrifuge]"
item_centrifuge.stack_size = 1
item_centrifuge.place_result = "bulk-centrifuge"

data:extend({item_smelter})
data:extend({item_centrifuge})

data:extend({
    {
      icon = "__SmelterUPSGrade__/graphics/smelter-blk.png",
      icon_mipmaps = 1,
      icon_size = 64,
      name = "smelter-block",
      order = "h[smelter-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
	{
      icon = "__SmelterUPSGrade__/graphics/centri-blk.png",
      icon_mipmaps = 1,
      icon_size = 64,
      name = "centrifuge-block",
      order = "h[centrifuge-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
})