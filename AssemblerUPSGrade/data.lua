require("prototypes.constants")
require("prototypes.functions")
require("prototypes.oil-functions")

require("prototypes.recipe.recipe-functions")
require("prototypes.recipe.recipe")
require("prototypes.entity.entities")
require("prototypes.entity.oil-entity")
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
	local building_mod_bonus = 0
	if crafting_cat == "crafting" or crafting_cat == "advanced-crafting" or crafting_cat == "basic-crafting" or crafting_cat == "crafting-with-fluid"
	then
		productivity_factor = assembler_productivity_factor+1
		building_mod_bonus = assembler_total_speed_bonus
	elseif crafting_cat == "chemistry"
	then
		plastic_override = true
		productivity_factor = chem_productivity_factor+1
		building_mod_bonus = chem_total_speed_bonus
	end
	
	local nrips,erips = computeItemsPerSecond(stock_item, building_mod_bonus)
	
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

--///////////////////////////////////////////////
--oil is its own little world and a bit simpler than the other items as each thing is only a single stage, so we do it in its own loop.
--///////////////////////////////////////////////
local compression_ratio = settings.startup["oil-asif-ratio"].value

local productivity_factor = oil_productivity_factor
local building_mod_bonus = oil_total_speed_bonus

--Create item definition
createOilRefItem("oil-asif")

--There's a dependency here between the recipe and the building. You need to know
-- how much the recipe needs/produces to build the entity.
--So here's the order we do things:
--1. Create the recipe for the building itself
--2. Recompute the recipe for oil processing. As in X crude oil in = y HO/LO/PG out.
--3. Determine how many inputs and outputs are needed to handle the fluid flow rate of the new recipe.
--4. Determine how large the building is supposed to be (limiter vs unlimited size)
--5. Create the building and place the fluid inputs along the side(s).

--Create recipe for the Oil Refinery ASIF building itself
local new_recipe = util.table.deepcopy(data.raw.recipe["oil-refinery"])
new_recipe.result = "oil-asif"
new_recipe.name = "oil-asif"
new_recipe.energy_required = 30

new_recipe.overload_multiplier = 1.0
new_recipe.requester_paste_multiplier = 1
new_recipe.ingredients = {
	{ "asif-oil-block", compression_ratio },
	{ "beacon", 16 },
	{ "speed-module-3", 16 * 2 },
	{ "substation", math.ceil(compression_ratio / 6) },
}
data:extend({new_recipe})

local asif_adv_oil_recipe = computeAdvOilProcRecipe("advanced-oil-processing", compression_ratio, productivity_factor)
createAdvOilProResultRecipes("advanced-oil-processing", "oil-asif", asif_adv_oil_recipe)
createOilRefEntity("oil-asif", compression_ratio, asif_adv_oil_recipe)

--///////////////////////////////////////////////
--Now we create the cracking recipes/buildings.
--///////////////////////////////////////////////
for _,item in pairs({"hc-asif", "lc-asif"}) do
	local compression_ratio = settings.startup[item .. "-ratio"].value
	
	--Add new crafting category
	data:extend({
		{
			type = "recipe-category",
			name = item
		}
	})
	
	--Create item definition
	createItem(true,item)
	
	--Recipe to build the ASIF
	createEntityRecipe(item, compression_ratio, compression_ratio, "c", compression_ratio)
	
	local asif_result_recipe = computeAdvOilProcRecipe(RECIPE_MAP[item], compression_ratio, productivity_factor)
	createAdvOilProResultRecipes(RECIPE_MAP[item], item, asif_result_recipe)

	--Create the entity of the ASIF
	createCrackingChemPlantEntity(item, compression_ratio, asif_result_recipe)
end