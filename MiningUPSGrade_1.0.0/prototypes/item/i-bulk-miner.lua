require("prototypes.constants")

local newitem = util.table.deepcopy(data.raw["item"]["electric-mining-drill"])
newitem.name = "tfx-emd"
newitem.place_result = "tfx-emd"
newitem.order = "c[z-tfx-emd]"
newitem.icons = {
	{
		icon = "__base__/graphics/icons/electric-mining-drill.png",
		tint = newTint,
		icon_size = 32
	}
}
data:extend({newitem})