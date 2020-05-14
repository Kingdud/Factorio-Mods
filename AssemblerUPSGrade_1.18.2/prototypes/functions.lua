require("prototypes.constants")

--///////
--I know it might be nice to have all the functions in this file, but I'd rather have functions specific to just one area
-- (recipes, entities, etc) be in those files. Makes it less confusing trying to maintain things.
--///////

--thanks stackoverflow! https://stackoverflow.com/questions/33510736/check-if-array-contains-specific-value/33511182
function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function getItemCreateTime(name)
	local the_recipe = data.raw.recipe[name]
	
	local normal_time = the_recipe.normal and the_recipe.normal.energy_required 
		or the_recipe.energy_required 
		or the_recipe.expensive and the_recipe.expensive.energy_required
		or 0.5
	local expensive_time = the_recipe.expensive and the_recipe.expensive.energy_required 
		or the_recipe.energy_required 
		or the_recipe.normal and the_recipe.normal.energy_required
		or 0.5
	
	return normal_time, expensive_time
end

function getResultCount(name)
	local the_recipe = data.raw.recipe[name]
	
	if not the_recipe
	then
		return 1,1
	end
	
	local n_res_cnt = the_recipe.normal and the_recipe.normal.result_count 
		or the_recipe.result_count 
		or the_recipe.expensive and the_recipe.expensive.result_count
		or 1
	local e_res_cnt = the_recipe.expensive and the_recipe.expensive.result_count 
		or the_recipe.result_count 
		or the_recipe.normal and the_recipe.normal.result_count
		or 1
		
	return n_res_cnt, e_res_cnt
end

--Computes how many items per second are produced by the given recipe (assuming fully beaconed/moduled).
-- Productivty NOT factored in!
function computeItemsPerSecond(name)
	local normal_time, expensive_time = getItemCreateTime(name)
	
	local n_res_cnt, e_res_cnt = getResultCount(name)
	
	local normal_ips = n_res_cnt / (normal_time / assembler_total_speed_bonus)
	local expensive_ips = e_res_cnt / (expensive_time / assembler_total_speed_bonus)
	
	return normal_ips, expensive_ips
end

--This returns the list of ingredients for a given item name.
function getItemIngredients(name)
	local the_recipe = data.raw.recipe[name]
	
	local normal_ing = the_recipe.normal and the_recipe.normal.ingredients
		or the_recipe.ingredients 
		or the_recipe.expensive and the_recipe.expensive.ingredients
	local expensive_ing = the_recipe.expensive and the_recipe.expensive.ingredients 
		or the_recipe.ingredients 
		or the_recipe.normal and the_recipe.normal.ingredients
	
	return normal_ing, expensive_ing
end

--This function ensures format of <item name>,<item quant> even when fluids are in play.
function getItemIngredient(ingredients)
	if not ingredients[1]
	then
		return ingredients.name, ingredients.amount
	else
		return ingredients[1], ingredients[2]
	end
end

function unwindVanillaRecipeHelper(name, nmultiplier, emultipler, mode, result)
	local normal_ingredients, expensive_ingredients = getItemIngredients(name)
	local n_res_cnt, e_res_cnt = getResultCount(name)

	if has_value(base_recipes, name) then
		if not result.expensive.name then
			result.expensive.name = emultipler
		else
			result.expensive.name = result.expensive.name + emultipler
		end

		if not result.normal.name then
			result.normal.name = nmultiplier
		else
			result.normal.name = result.normal.name + nmultiplier
		end
		return
	else
		--Check if normal / expensive mode definitions exist
		if (mode == "n" or mode == "i") and data.raw.recipe[name].normal then 
			for _,val in pairs(normal_ingredients) do
				local i_name, i_quant = getItemIngredient(val)
				--If we need 4 plates to produce 8 items, then 4/8 = 2 items per plate.
				local res_num = i_quant / n_res_cnt
				unwindVanillaRecipeHelper(i_name, nmultiplier*res_num, emultipler, "n", result)
			end			
		end
		
		if (mode == "e" or mode == "i") and data.raw.recipe[name].expensive then 
			for _,val in pairs(expensive_ingredients) do
				local i_name, i_quant = getItemIngredient(val)
				--If we need 4 plates to produce 8 items, then 4/8 = 2 items per plate.
				local res_num = i_quant / e_res_cnt
				unwindVanillaRecipeHelper(i_name,nmultiplier, emultipler*res_num, "e", result)
			end
		end
		
		--And some items only have ingredients, not a normal/expensive split.
		if data.raw.recipe[name].ingredients then 
			for _,val in pairs(normal_ingredients) do
				local i_name, i_quant = getItemIngredient(val)
				--If we need 4 plates to produce 8 items, then 4/8 = 2 items per plate.
				local res_num = i_quant / n_res_cnt
				--We use mode here because this could be part of the expensive or normal recipe chain.
				unwindVanillaRecipeHelper(i_name, nmultiplier*res_num, emultipler*res_num, mode, result)
			end
		end
	end
	return
end --end unwindVanillaRecipeHelper

--The goal of this function is to tell you how many raw materials are needed
-- to produce a given item. IE: A green circuit needs 1 iron plate and 1.5 copper plate.
function unwindVanillaRecipe(name)
	local result = { ["expensive"] = {}, ["normal"] = {} }
	local n_res_cnt, e_res_cnt = getResultCount(name)

	--Check if normal / expensive mode definitions exist
	if data.raw.recipe[name].normal then 
		for _,val in pairs(data.raw.recipe[name].normal.ingredients) do
			local i_name, i_quant = getItemIngredient(val)
			--If we need 4 plates to produce 8 items, then 4/8 = 2 items per plate.
			local res_num = i_quant / n_res_cnt
			unwindVanillaRecipeHelper(i_name, res_num, 0,"n", result)
		end
	end
	
	if data.raw.recipe[name].expensive then
		for _,val in pairs(data.raw.recipe[name].expensive.ingredients) do
			local i_name, i_quant = getItemIngredient(val)
			--If we need 4 plates to produce 8 items, then 4/8 = 2 items per plate.
			local res_num = i_quant / e_res_cnt
			unwindVanillaRecipeHelper(i_name, 0, res_num,"e", result)
		end
	end
	
	--And some items only have ingredients, not a normal/expensive split.
	if data.raw.recipe[name].ingredients and not data.raw.recipe[name].normal then 
		for _,val in pairs(data.raw.recipe[name].ingredients) do
			local i_name, i_quant = getItemIngredient(val)
			--If we need 4 plates to produce 8 items, then 4/8 = 2 items per plate.
			local res_num = i_quant / n_res_cnt
			unwindVanillaRecipeHelper(i_name, res_num, res_num,"i", result)
		end
	end
	return result
end --end unwindVanillaRecipe

function unwindAssemblersNeeded(name, mode, main_item_ips, productivity_factor, result)
	
	main_item_ips = (main_item_ips / productivity_factor)
	
	local normal_ingredients, expensive_ingredients = getItemIngredients(name)

	--Check if normal / expensive mode definitions exist
	if mode == "n" then 
		for _,val in pairs(normal_ingredients) do
			local i_name, i_quant = getItemIngredient(val)
			local res_cnt, _ = getResultCount(i_name)
			--This is how many of this item are needed per second to build the main result.
			local ips_needed = main_item_ips * i_quant
			
			if not has_value(base_recipes, i_name) then
				--Get how many items/second one assembler making this sub-component can crank out (factors in result cnt)
				local ips, _ = computeItemsPerSecond(i_name)
				ips = ips * productivity_factor
				
				--main_item_ips * val[2] is saying "we need to build 100 units per second, and 
				-- each unit take val[2] items to build", thus, we divide by the IPS per assembler
				-- to get how many assemblers we need.
				if result.normal[i_name] then
					result.normal[i_name] = result.normal[i_name] + (ips_needed / ips)
				else
					result.normal[i_name] = ips_needed / ips
				end
				
				unwindAssemblersNeeded(i_name, "n", ips_needed / res_cnt, productivity_factor, result)
			else
				if result.recip_n[i_name] then
					result.recip_n[i_name] = result.recip_n[i_name] + math.floor(ips_needed)
				else
					result.recip_n[i_name] = math.floor(ips_needed)
				end
			end
		end
	end
	
	if mode == "e" then
		for _,val in pairs(expensive_ingredients) do
			local i_name, i_quant = getItemIngredient(val)
			local _, res_cnt = getResultCount(i_name)
			--This is how many of this item are needed per second to build the main result.
			local ips_needed = main_item_ips * i_quant
			
			if not has_value(base_recipes, i_name) then
				--Get how many items/second one assembler making this sub-component can crank out
				local _, ips = computeItemsPerSecond(i_name)
				ips = ips * productivity_factor

				--main_item_ips * val[2] is saying "we need to build 100 units per second, and 
				-- each unit take val[2] items to build", thus, we divide by the IPS per assembler
				-- to get how many assemblers we need.
				if result.expensive[i_name] then
					result.expensive[i_name] = result.expensive[i_name] + (ips_needed / ips)
				else
					result.expensive[i_name] = ips_needed / ips
				end
				
				unwindAssemblersNeeded(i_name, "e", ips_needed / res_cnt, productivity_factor, result)
			else
				if result.recip_e[i_name] then
					result.recip_e[i_name] = result.recip_e[i_name] + math.floor(ips_needed)
				else
					result.recip_e[i_name] = math.floor(ips_needed)
				end
			end
		end
	end
end