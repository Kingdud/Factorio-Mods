require("prototypes.constants")
require("prototypes.functions")

--/////////////
--How the heck does this recipe scaling work?!
-- Ok, so here's the deal. The assembler this recipe is built in has a build speed of 1 and does not support
--  beacons or modules. The recipe also has a build speed of 1. This means that, no matter what, X items per
--  second will be produced.

-- Thus, if you are making green circuits, for example. Those take .5 seconds to produce, so you make 2 per
--  second. But then you need to factor in the speed of an assembler 3, it's modules, and the speed beacons
--  around it. This ends up with a fully beaconed and moduled assembler being able to produce 22.4 green
--  circuits per second.

-- Thus, if the compression ratio were 25:1, the recipe output would NOT be 25 green circuits. It would be
--  (ceiling(25 * 22.4) green circuits, while the materials cost to produce those circuits would also be
--  multiplied by 25, after having been scaled for production rate. IE:
--  Copper Plate per second: floor(428.571 * 25)
--  Iron Plate per second: floor(400 * 25)

-- The reason floor() is used for materials and ceiling() is used for production is because this is a
--  specialized production facility. There would be little optimizations and tweaks to reduce the waste.

-- And that's what the functions do to the recipes. They factor in all the bonuses, determine how many
--  items/second get produced, and then set the recipes accordingly. NOTE! Productivty is set on the ASIF
--  building itself, so if you are using an online factorio calculator to balance the recipes, the results
--  you get from these equations will not line up with the calculator results because these results DO NOT
--  factor in productivity bonuses, since they are transient (on both sides of the equation; transparent).
--/////////////

function createRecipeHelper(new_recipe, stock_item_name, results_per_second, compression_ratio, items_needed)
	local counter = 1
	for item,quantity in pairs(items_needed) do	
		if data.raw.fluid[item]
		then
			new_recipe.ingredients[counter] = {type="fluid", name = item, amount = math.floor(quantity) }
		else
			new_recipe.ingredients[counter] = {item, math.floor(quantity) }
		end
		counter = counter + 1
	end
	new_recipe.energy_required = 1
	if stock_item_name == "solid-fuel-from-petroleum-gas" or stock_item_name == "solid-fuel-from-light-oil" or stock_item_name == "solid-fuel-from-heavy-oil" then
		new_recipe.result = "solid-fuel"
	else
		new_recipe.result = stock_item_name
	end
	
	new_recipe.result_count = math.ceil(results_per_second)
	new_recipe.enabled = false
	new_recipe.always_show_made_in = true
end

--This function only creates the recipes for the result products (IE: Green chips, red chips, etc). It does NOT
-- create the recipes for the ASIFs themselves.
function createResultRecipes(stock_name, new_name, compression_ratio, nrips, erips, items_needed)
	local recipe_name = new_name .. "-recipe"
	local new_recipe = util.table.deepcopy(data.raw.recipe[stock_name])
	
	new_recipe.result = nil
	new_recipe.ingredients = nil
	new_recipe.name = recipe_name
	new_recipe.main_product = recipe_name
	new_recipe.icon = "__AssemblerUPSGrade__/graphics/recipe/" .. GRAPHICS_MAP[new_name].icon
	new_recipe.icon_size = 64
	if not new_recipe.normal
	then
		new_recipe.normal = {}
	end
	new_recipe.normal.ingredients = {}
	if not new_recipe.expensive
	then
		new_recipe.expensive = {}
	end
	new_recipe.expensive.ingredients = {}
	
	--normal
	createRecipeHelper(new_recipe.normal, stock_name, nrips, compression_ratio, items_needed.recip_n)
	--expensive
	createRecipeHelper(new_recipe.expensive, stock_name, erips, compression_ratio, items_needed.recip_e)

	new_recipe.category = new_name
	
	if DEBUG then
		log("Debug createResultRecipes: " .. do_dump(new_recipe))
	end
	
	data:extend({new_recipe})
end

--This is where the recipe for the ASIF itself is made.
function createEntityRecipe(name, n_ass_needed, e_ass_needed, bld_type, compression_ratio)
	local new_recipe = nil
	if bld_type == "a"
	then
		new_recipe = util.table.deepcopy(data.raw.recipe["assembling-machine-3"])
	else
		new_recipe = util.table.deepcopy(data.raw.recipe["chemical-plant"])
	end
	
	new_recipe.ingredients = nil
	new_recipe.result_count = 1
	new_recipe.result = name
	new_recipe.name = name
	new_recipe.normal = { ingredients = nil, energy_required = 10, enabled = false, result = name, overload_multiplier = 1.0, requester_paste_multiplier = 1}
	new_recipe.expensive = { ingredients = nil, energy_required = 30, enabled = false, result = name, overload_multiplier = 1.0, requester_paste_multiplier = 1 }
	
	--Every factory layout needs: 1) red chests 2) blue chests 3) beacons 4) Assemblers 5) speed mods 6) prod mods 7) stack inserters
	-- You could argue belts too, but in a high density construction we assume direct insertion and chests for load delivery/product
	-- removal.
	
	local item_name = "a"
	if bld_type == "a" then
		item_name = "asif-assembler-block"
	else
		item_name = "asif-chem-block"
	end
	
	new_recipe.normal.ingredients = {
		{ item_name, n_ass_needed },
		{ "asif-logi-block", n_ass_needed },
		{ "beacon", beacon_count },
		{ "speed-module-3", beacon_count * 2 },
		{ "substation", math.ceil(n_ass_needed / 6) },
	}
	
	new_recipe.expensive.ingredients = {
		{ item_name, e_ass_needed },
		{ "asif-logi-block", e_ass_needed },
		{ "beacon", beacon_count },
		{ "speed-module-3", beacon_count * 2 },
		{ "substation", math.ceil(e_ass_needed / 6) },
	}
	
	--an ugly hack, but whatever.
	if has_value(NEED_FLUID_RECIPES, name)
	then
		table.insert(new_recipe.normal.ingredients, { "pipe", 8*compression_ratio })
		table.insert(new_recipe.expensive.ingredients, { "pipe", 8*compression_ratio })
	end
	
	data:extend({new_recipe})
end