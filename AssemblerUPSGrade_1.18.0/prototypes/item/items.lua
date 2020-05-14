require("prototypes.constants")
require("prototypes.functions")

function createItem(stock_name, new_name)
	local newitem = util.table.deepcopy(data.raw.item["assembling-machine-3"])
	newitem.name = new_name
	newitem.place_result = new_name
	newitem.order = newitem.order .. "z"
	newitem.icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[new_name].icon
	newitem.stack_size = 1
	data:extend({newitem})
end

--TODO: Graphics
data:extend({
    {
      icon = "__AssemblerUPSGrade__/graphics/ass-blk.png",
      icon_mipmaps = 4,
      icon_size = 64,
      name = "asif-assembler-block",
      order = "h[asif-assembler-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
	-- {
      -- icon = "__AssemblerUPSGrade__/graphics/chem-blk.png",
      -- icon_mipmaps = 4,
      -- icon_size = 64,
      -- name = "asif-chem-block",
      -- order = "h[asif-chem-block]",
      -- stack_size = 50,
      -- subgroup = "intermediate-product",
      -- type = "item"
    -- },
	{
      icon = "__AssemblerUPSGrade__/graphics/logi-blk.png",
      icon_mipmaps = 4,
      icon_size = 64,
      name = "asif-logi-block",
      order = "h[asif-logi-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
})