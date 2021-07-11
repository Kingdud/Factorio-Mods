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

function getProductivityAndSpeedFactors(name)
	local crafting_cat = data.raw.recipe[name].category or "crafting"
	local speed_bonus = 1
	local prod_factor = 1
	
	if has_value(data.raw.module["productivity-module-3"].limitation, name) then
		if crafting_cat == "crafting" or crafting_cat == "advanced-crafting" or crafting_cat == "basic-crafting" or crafting_cat == "crafting-with-fluid"
		then
			prod_factor = assembler_productivity_factor+1
			speed_bonus = assembler_total_speed_bonus_prod
		elseif crafting_cat == "chemistry"
		then
			prod_factor = chem_productivity_factor+1
			speed_bonus = chem_total_speed_bonus
		end
	else
		if crafting_cat == "crafting" or crafting_cat == "advanced-crafting" or crafting_cat == "basic-crafting" or crafting_cat == "crafting-with-fluid"
		then
			speed_bonus = assembler_total_speed_bonus_speed
		elseif crafting_cat == "chemistry"
		then
			speed_bonus = chem_total_speed_bonus
		end
	end
	return prod_factor, speed_bonus
end

function getResultCount(name)
	local the_recipe = data.raw.recipe[name]
	
	if not the_recipe
	then
		return 1,1
	end
	
	--This is not perfect, it will break on things like uranium processing, which have multiple result outputs (u-235 and u238)
	local n_res_cnt = (the_recipe.normal and the_recipe.normal.result_count)
		or (the_recipe.normal and the_recipe.normal.results and the_recipe.normal.results.amount)
		or (the_recipe.results and the_recipe.results[1].amount)
		or the_recipe.result_count 
		or (the_recipe.expensive and the_recipe.expensive.result_count)
		or 1
	local e_res_cnt = (the_recipe.expensive and the_recipe.expensive.result_count)
		or (the_recipe.expensive and the_recipe.expensive.results and the_recipe.expensive.results.amount)
		or (the_recipe.results and the_recipe.results[1].amount)
		or the_recipe.result_count 
		or (the_recipe.normal and the_recipe.normal.result_count)
		or 1
		
	return n_res_cnt, e_res_cnt
end

--Computes how many items per second are produced by the given recipe (assuming fully beaconed/moduled).
-- Productivty NOT factored in!
function computeItemsPerSecond(name)
	local normal_time, expensive_time = getItemCreateTime(name)
	local prod_bonus, building_mod_bonus = getProductivityAndSpeedFactors(name)
	
	local n_res_cnt, e_res_cnt = getResultCount(name)
	
	local normal_ips = n_res_cnt / (normal_time / building_mod_bonus)
	local expensive_ips = e_res_cnt / (expensive_time / building_mod_bonus)
	
	return normal_ips * prod_bonus, expensive_ips * prod_bonus
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
	if not ingredients[1] then
		return ingredients.name, ingredients.amount
	else
		return ingredients[1], ingredients[2]
	end
end

function unwindVanillaRecipeHelper(name, nmultiplier, emultipler, mode, result, base_recipe_list)
	local normal_ingredients, expensive_ingredients = getItemIngredients(name)
	local n_res_cnt, e_res_cnt = getResultCount(name)

	if has_value(base_recipe_list, name) then
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
function unwindVanillaRecipe(name, plastic_override)
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

function unwindAssemblersNeeded(name, mode, main_item_ips, result, plastic_override)
	local productivity_factor = 1
	
	local crafting_cat = data.raw.recipe[name].category or "crafting"
	if crafting_cat == "crafting" or crafting_cat == "advanced-crafting" or crafting_cat == "basic-crafting" or crafting_cat == "crafting-with-fluid"
	then
		productivity_factor = assembler_productivity_factor+1
	elseif crafting_cat == "chemistry"
	then
		productivity_factor = chem_productivity_factor+1
	end
	
	local main_item_res_cnt, _ = getResultCount(name)
	if has_value(data.raw.module["productivity-module-3"].limitation, name) then
		main_item_ips = main_item_ips / main_item_res_cnt / productivity_factor
	else
		main_item_ips = main_item_ips / main_item_res_cnt
	end
	
	local normal_ingredients, expensive_ingredients = getItemIngredients(name)
	
	local base_recipe_list = nil
	if plastic_override then
		base_recipe_list = plastic_base_recipes
	else
		base_recipe_list = base_recipes
	end

	--Check if normal / expensive mode definitions exist
	if mode == "n" then 
		for _,val in pairs(normal_ingredients) do
			local i_name, i_quant = getItemIngredient(val)
			local res_cnt, _ = getResultCount(i_name)
			--This is how many of this item are needed per second to build the main result.
			local ips_needed = main_item_ips * i_quant
			
			if has_value(FLUID_NAMES, i_name) then
				result.fluid_per_second = result.fluid_per_second + ips_needed
			end
			
			if not has_value(base_recipe_list, i_name) then
				--Get how many items/second one assembler making this sub-component can crank out (factors in result cnt)
				local ips, _ = computeItemsPerSecond(i_name)
				
				--main_item_ips * val[2] is saying "we need to build 100 units per second, and 
				-- each unit take val[2] items to build", thus, we divide by the IPS per assembler
				-- to get how many assemblers we need.
				if result.normal[i_name] then
					result.normal[i_name] = result.normal[i_name] + (ips_needed / ips)
				else
					result.normal[i_name] = ips_needed / ips
				end
				
				unwindAssemblersNeeded(i_name, "n", ips_needed, result, plastic_override)
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

			if not has_value(base_recipe_list, i_name) then
				--Get how many items/second one assembler making this sub-component can crank out
				local _, ips = computeItemsPerSecond(i_name)

				--WARNING! This will compound with normal above and give a value that's ridiculously too high.
				--Fix appears to be that no expensive recipes actually use a different amount of fluid.
				-- if has_value(FLUID_NAMES, i_name) then
					-- result.fluid_per_second = result.fluid_per_second + ips_needed
				-- end
				
				--main_item_ips * val[2] is saying "we need to build 100 units per second, and 
				-- each unit take val[2] items to build", thus, we divide by the IPS per assembler
				-- to get how many assemblers we need.
				if result.expensive[i_name] then
					result.expensive[i_name] = result.expensive[i_name] + (ips_needed / ips)
				else
					result.expensive[i_name] = ips_needed / ips
				end
				
				unwindAssemblersNeeded(i_name, "e", ips_needed / res_cnt, result, plastic_override)
			else
				if result.recip_e[i_name] then
					result.recip_e[i_name] = result.recip_e[i_name] + math.floor(ips_needed / res_cnt)
				else
					result.recip_e[i_name] = math.floor(ips_needed / res_cnt)
				end
			end
		end
	end
end

function createEntityRadar(asif_name, side_length)
	local new_entity = util.table.deepcopy(data.raw.radar.radar)
	new_entity.max_distance_of_nearby_sector_revealed = (side_length / 32) + 1
	new_entity.max_distance_of_sector_revealed = 0
	new_entity.energy_source = {type = "void"}
	new_entity.name = asif_name .. "-radar"
	new_entity.minable = nil
	new_entity.collision_box = nil
	new_entity.damaged_trigger_effect = nil
	new_entity.flags = {"not-blueprintable", "hidden", "hide-alt-info", "placeable-player"}
	new_entity.integration_patch = nil
	new_entity.selection_box = nil
	new_entity.water_reflection = nil
	new_entity.working_sound = nil
	new_entity.collision_mask = {}
	data:extend({new_entity})
end

function getScaleFactors(base_building_side_len, beacons_on_side, bld_count)
	--There is a more efficient way to lay out beacons for non-oil processing recipes,
	-- but I can't be bothered to do the math on it, and it only saves a little bit of space.
	local new_side_length = 3 * (beacons_on_side-1) * math.sqrt(bld_count) + 3
	
	if math.floor(new_side_length) + 0.5 > new_side_length then
		new_side_length = math.ceil(new_side_length)
	else
		new_side_length = math.floor(new_side_length)
	end
	
	--This is done to ensure we always have a slot in the middle for a pipe.
	if new_side_length % 2 == 0
	then
		new_side_length = new_side_length + 1
	end

	local result_side_len = new_side_length/2
	
	--you'd think this would use the whole side length to scale, but for whatever reason, Factorio doesn't.
	local scale_factor = result_side_len / base_building_side_len

	return result_side_len, scale_factor
end

function do_dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. do_dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end