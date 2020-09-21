require("prototypes.constants")
require("prototypes.functions")

function createItem(is_chem_plant, new_name)
	local newitem = nil
	if is_chem_plant then
		newitem = util.table.deepcopy(data.raw.item["chemical-plant"])
	else
		newitem = util.table.deepcopy(data.raw.item["assembling-machine-3"])
	end
	
	newitem.name = new_name
	newitem.place_result = new_name
	newitem.order = ORDER_MAP[new_name]
	newitem.icon = "__AssemblerUPSGrade__/graphics/" .. GRAPHICS_MAP[new_name].icon
	newitem.stack_size = 1
	newitem.icon_mipmaps = 1
	newitem.subgroup = "asif-buildings"
	
	if DEBUG then
		log("Debug createItem: " .. do_dump(newitem))
	end
	
	data:extend({newitem})
end

data:extend({
    {
      icon = "__AssemblerUPSGrade__/graphics/ass-blk.png",
      icon_mipmaps = 1,
      icon_size = 64,
      name = "asif-assembler-block",
      order = "h[asif-assembler-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
	{
      icon = "__AssemblerUPSGrade__/graphics/chem-blk.png",
      icon_mipmaps = 1,
      icon_size = 64,
      name = "asif-chem-block",
      order = "h[asif-chem-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
	{
      icon = "__AssemblerUPSGrade__/graphics/logi-blk.png",
      icon_mipmaps = 1,
      icon_size = 64,
      name = "asif-logi-block",
      order = "h[asif-logi-block]",
      stack_size = 50,
      subgroup = "intermediate-product",
      type = "item"
    },
})