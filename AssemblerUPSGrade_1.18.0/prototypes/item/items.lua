require("prototypes.constants")
require("prototypes.functions")

function createItem(stock_name, new_name)
	local newitem = util.table.deepcopy(data.raw.item[stock_name])
	newitem.name = new_name
	newitem.place_result = new_name
	newitem.order = newitem.order .. "z"
	newitem.icons = {
		{
			icon = newitem.icon,
			--TODO: Graphics
			--tint = newTint,
			icon_mipmaps = 4,
			icon_size = 64,
		}
	}
	newitem.icon = nil
	newitem.stack_size = 1
	data:extend({newitem})
end

--TODO: Graphics
data:extend({
    {
      icon = "__base__/graphics/icons/engine-unit.png",
      icon_mipmaps = 4,
      icon_size = 64,
      name = "asif-assembler-block",
      order = "h[asif-assembler-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
	{
      icon = "__base__/graphics/icons/engine-unit.png",
      icon_mipmaps = 4,
      icon_size = 64,
      name = "asif-chem-block",
      order = "h[asif-chem-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
	{
      icon = "__base__/graphics/icons/engine-unit.png",
      icon_mipmaps = 4,
      icon_size = 64,
      name = "asif-logi-block",
      order = "h[asif-logi-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
})