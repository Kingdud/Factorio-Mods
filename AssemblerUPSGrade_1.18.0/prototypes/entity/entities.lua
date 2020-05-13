require("prototypes.constants")
require("prototypes.functions")

function computePowerDraw(count, power_draw)
	local total_beacon_pwr_drain = (count * math.ceil(beacon_count * .5) + beacon_count) * beacon_pwr_drain
	
	return power_draw * count + total_beacon_pwr_drain
end

function createAssemblerEntity(name, compression_ratio, n_ass, e_ass)
		
	--Pollution
	--modify here if you wish to create separate entities for normal/expensive mode.
	local total_pollution_value = assembler_base_pollution * (assembler_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * assembler_base_modules + 1)) * n_ass
	
	local new_entity = util.table.deepcopy(base_ass_entity)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	--modify here if you wish to create separate entities for normal/expensive mode.
	new_entity.energy_usage = computePowerDraw(n_ass, assembler_total_pwr_draw) .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.base_productivity = .1*assembler_base_modules
	
	--todo: graphics, tint
	
	data:extend({new_entity})
end

function createChemPlantEntity(name, compression_ratio, n_chem, e_chem)
	local new_entity = util.table.deepcopy(base_chem_entity)
	
	new_entity.fixed_recipe = name .. "-recipe"
	new_entity.name = name
	new_entity.crafting_speed = 1
	new_entity.energy_source.emissions_per_minute = total_pollution_value
	new_entity.energy_usage = computePowerDraw(n_chem, chem_total_pwr_draw) .. "kW"
	new_entity.allowed_effects = nil
	new_entity.module_specification.module_slots = 0
	new_entity.base_productivity = .1*chem_base_modules
	
	--todo: graphics, tint
	
	data:extend({new_entity})
end