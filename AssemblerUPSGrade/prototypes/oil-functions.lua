require("prototypes.constants")
require("prototypes.functions")

data:extend({
	{
		type = "recipe-category",
		name = "oil-asif"
	}
})

function computeAdvOilProcRecipe(name, compression_ratio, productivity_factor)
	local normal_time, _ = getItemCreateTime(name)
	local base_recipe = data.raw.recipe[name]
	
	speed_bonus = 0
	if name == "advanced-oil-processing" then
		speed_bonus = oil_total_speed_bonus
	else
		speed_bonus = chem_total_speed_bonus
	end

	--Result dict:
	--result[inputs][index]{connections_needed, amount_needed, name}
	--result[outputs][index]{connections_needed, amount_needed, name}
	--Example:
	--	result["inputs"][1]{["connections_needed"] = 3, ["name"] = "water", ["amount_needed"] = 22400 }
	--	result["outputs"][1]{["connections_needed"] = 7, ["name"] = "light-oil", ["amount_needed"] = 67800 }
	
	result = {["inputs"]={},["outputs"] = {}}
	for _, item in pairs(base_recipe.ingredients) do
		local ips = math.floor(item.amount / (normal_time / speed_bonus)) * compression_ratio
		
		table.insert(result["inputs"], {["name"] = item.name, ["connections_needed"] = math.ceil(ips/MAX_FLUID_PER_INPUT_PER_SECOND), ["amount_needed"] = ips})
	end
	
	for _, item in pairs(base_recipe.results) do
		local ips = math.ceil(item.amount / (normal_time / speed_bonus)) * compression_ratio * (1 + productivity_factor)
		
		table.insert(result["outputs"], {["name"] = item.name, ["connections_needed"] = math.ceil(ips/MAX_FLUID_PER_INPUT_PER_SECOND), ["amount_needed"] = ips})
	end
	
	return result
end

function createAdvOilProResultRecipes(stock_name, new_name, recipe_data)
	local recipe_name = new_name .. "-recipe"
	local new_recipe = util.table.deepcopy(data.raw.recipe[stock_name])
	
	new_recipe.name = recipe_name
	new_recipe.main_product = nil
	new_recipe.icon = "__AssemblerUPSGrade__/graphics/recipe/" .. GRAPHICS_MAP[new_name].icon
	new_recipe.icon_size = 64
	
	new_recipe.ingredients = {}
	local counter = 1
	for _,entry in pairs(recipe_data["inputs"]) do
		new_recipe.ingredients[counter] = {type="fluid", name = entry["name"], amount = entry["amount_needed"] }
		counter = counter + 1
	end
	
	new_recipe.result = nil
	new_recipe.results = {}
	counter = 1
	for _,entry in pairs(recipe_data["outputs"]) do
		new_recipe.results[counter] = {type="fluid", name = entry["name"], amount = entry["amount_needed"] }
		counter = counter + 1
	end
	
	new_recipe.energy_required = 1
	new_recipe.enabled = false
	new_recipe.always_show_made_in = true
	
	new_recipe.category = new_name
	
	if DEBUG then
		log("Debug createAdvOilProResultRecipes: " .. do_dump(new_recipe))
	end
	
	data:extend({new_recipe})
end