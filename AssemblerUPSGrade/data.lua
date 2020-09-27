require("prototypes.constants")
require("prototypes.functions")

require("prototypes.recipe.recipe-functions")
require("prototypes.recipe.recipe")
require("prototypes.entity.entities")
require("prototypes.item.items")
require("prototypes.technology.technology")

data:extend({
	{
		type = "item-subgroup",
		name = "asif-buildings",
		group = "production",
		order = "e1",
	}
})

for new_item,stock_item in pairs(ITEM_LIST) do
	local compression_ratio = settings.startup[new_item .. "-ratio"].value
	
	--Add new crafting category
	data:extend({
		{
			type = "recipe-category",
			name = new_item
		}
	})
	
	local productivity_factor = 0
	local crafting_cat = data.raw.recipe[stock_item].category or "crafting"
	local plastic_override = false
	if crafting_cat == "crafting" or crafting_cat == "advanced-crafting" or crafting_cat == "basic-crafting" or crafting_cat == "crafting-with-fluid"
	then
		productivity_factor = assembler_productivity_factor+1
	elseif crafting_cat == "chemistry"
	then
		plastic_override = true
		productivity_factor = chem_productivity_factor+1
	end
	
	local nrips,erips = computeItemsPerSecond(stock_item, plastic_override)
	
	--We need to add productivity factor to items_per_second from the recipe calculation, since unwindAssemblersNeeded requires it to be there.
	local ipsn = nrips * productivity_factor * compression_ratio
	local ipse = erips * productivity_factor * compression_ratio
	
	--Determine how many assemblers make up our ASIF
	local result = { ["expensive"] = {}, ["normal"] = {}, ["recip_n"] = {}, ["recip_e"] = {}, ["fluid_per_second"] = 0 }
	
	unwindAssemblersNeeded(stock_item, "n", ipsn, productivity_factor, result, plastic_override)
	unwindAssemblersNeeded(stock_item, "e", ipse, productivity_factor, result, plastic_override)
	
	local normal_ass_needed = compression_ratio
	local expensive_ass_needed = compression_ratio
	for _,num in pairs(result.normal) do
		--New way: Assume partially utilized buildings are kept busy through ASIF magic.
		normal_ass_needed = normal_ass_needed + num
		--Old way: assume we have partially used extra buildings for each intermediate.
		--normal_ass_needed = normal_ass_needed + math.ceil(num)
	end
	for _,num in pairs(result.expensive) do
		expensive_ass_needed = expensive_ass_needed + num
		--expensive_ass_needed = expensive_ass_needed + math.ceil(num)
	end
	normal_ass_needed = math.ceil(normal_ass_needed)
	expensive_ass_needed = math.ceil(expensive_ass_needed)
	
	--Create ASIFs
	if crafting_cat == "crafting" or crafting_cat == "advanced-crafting" or crafting_cat == "basic-crafting" or crafting_cat == "crafting-with-fluid"
	then
		createEntityRecipe(new_item, normal_ass_needed, expensive_ass_needed, "a", compression_ratio)
		createAssemblerEntity(new_item, compression_ratio, normal_ass_needed, expensive_ass_needed, result.fluid_per_second)
	elseif crafting_cat == "chemistry"
	then
		createEntityRecipe(new_item, normal_ass_needed, expensive_ass_needed, "c", compression_ratio)
		createChemPlantEntity(new_item, compression_ratio, normal_ass_needed, expensive_ass_needed, result.fluid_per_second)
	end
	
	--Create the recipe the ASIF uses to build components
	createResultRecipes(stock_item, new_item, compression_ratio, ipsn, ipse, result)
	createItem(plastic_override, new_item)
	
	--Add research
	addTechnology(new_item)
end
	
	--Create items