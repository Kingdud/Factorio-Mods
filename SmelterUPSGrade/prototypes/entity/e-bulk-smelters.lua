require("prototypes.constants")

function create_entity(e_type)
	local entity
	local r_icon
	local ratio
	local edge_size = 0
	
	if e_type == "smelter" then
		ratio = settings.startup["smelter-ratio"].value
		if MAX_BLD_SIZE ~= 0 then
			edge_size = MAX_BLD_SIZE/2
		else
			edge_size = (ratio * 3) / 2
		end
		
		entity = create_smelter(edge_size, ratio)
		r_icon = "__base__/graphics/icons/electric-furnace.png"
	elseif e_type == "centrifuge" then
		ratio = settings.startup["centrifuge-ratio"].value
		if MAX_BLD_SIZE ~= 0 then
			edge_size = MAX_BLD_SIZE/2
		else
			edge_size = (ratio * 3) / 2
		end
		
		entity = createCentrifuge(edge_size, ratio)
		r_icon = "__base__/graphics/icons/centrifuge.png"
	end
	
	entity.allowed_effects = nil
	entity.icon = nil
	entity.icons = {
		{
			icon = r_icon,
			tint = building_tint,
			icon_size = 64,
			icon_mipmaps = 4
		}
	}
	entity.name = "bulk-" .. e_type
	entity.collision_box = {
		{-1*edge_size + 0.2,-1*edge_size + 0.2},
		{ edge_size - 0.2, edge_size - 0.2}
	}
	entity.selection_box = {
		{ -1*edge_size, -1*edge_size },
		{  edge_size,  edge_size }
	}
	entity.minable = {
		mining_time = 0.2,
		result = "bulk-" .. e_type
	}
	entity.module_specification = {
		module_slots = 0,
	}
	
	data:extend({entity})
end

function create_smelter(edge_size, ratio)
	local entity
	local scale_factor = BUILDING_SCALE*(edge_size/BUILDING_SCALED_SIZE)
	
	entity = table.deepcopy(data.raw.furnace["electric-furnace"])
	entity.base_productivity = smelter_productivity_factor
	entity.crafting_speed = smelter_total_speed_bonus
	entity.energy_usage = smelter_total_pwr_draw * ratio .. "kW"
	entity.energy_source.drain = (beacon_pwr_drain * ratio) + (smelter_total_pwr_draw * ratio) / 30 .. "kW"
	entity.energy_source.emissions_per_minute = smelter_base_pollution * (smelter_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * smelter_base_modules + 1)) * ratio
	entity.crafting_categories = { "bulksmelting" }
	entity.result_inventory_size = r_output_windows_needed
	
	--For reasons I don't understand, the offsets need additional padding to scale correctly on top of the building scale itself.
	local OFFSET_SCALING_FACTOR = 1.95
	entity.scale_entity_info_icon = true
	entity.alert_icon_scale = scale_factor
	entity.animation.layers[1].hr_version.scale = scale_factor
	entity.animation.layers[1].hr_version.shift[1] = entity.animation.layers[1].hr_version.shift[1] * scale_factor*OFFSET_SCALING_FACTOR
	entity.animation.layers[1].hr_version.shift[2] = entity.animation.layers[1].hr_version.shift[2] * scale_factor*OFFSET_SCALING_FACTOR
	entity.animation.layers[2].hr_version.scale = scale_factor
	entity.animation.layers[2].hr_version.shift[1] = entity.animation.layers[2].hr_version.shift[1] * scale_factor*OFFSET_SCALING_FACTOR
	entity.animation.layers[2].hr_version.shift[2] = entity.animation.layers[2].hr_version.shift[2] * scale_factor*OFFSET_SCALING_FACTOR
	for z, _ in pairs(entity.working_visualisations) do
		if entity.working_visualisations[z].animation.layers then
			for i, _ in pairs(entity.working_visualisations[z].animation.layers) do
				entity.working_visualisations[z].animation.layers[i].hr_version.scale = scale_factor
				tmp = entity.working_visualisations[z].animation.layers[i].hr_version.shift[1]
				entity.working_visualisations[z].animation.layers[i].hr_version.shift[1] = tmp * scale_factor*OFFSET_SCALING_FACTOR
				tmp = entity.working_visualisations[z].animation.layers[i].hr_version.shift[2]
				entity.working_visualisations[z].animation.layers[i].hr_version.shift[2] = tmp * scale_factor*OFFSET_SCALING_FACTOR
			end
		else
			entity.working_visualisations[z].animation.hr_version.scale = scale_factor
			tmp = entity.working_visualisations[z].animation.hr_version.shift[1]
			entity.working_visualisations[z].animation.hr_version.shift[1] = tmp * scale_factor*OFFSET_SCALING_FACTOR
			tmp = entity.working_visualisations[z].animation.hr_version.shift[2]
			entity.working_visualisations[z].animation.hr_version.shift[2] = tmp * scale_factor*OFFSET_SCALING_FACTOR
		end
	end
	
	local edge_art = {
		filename = "__SmelterUPSGrade__/graphics/smelter_border.png",
		frame_count = 1,
		height = 256,
		priority = "high",
		scale = scale_factor * .75,
		width = 256,
	}
	
	table.insert(entity.animation.layers, edge_art)
	return entity
end

function createCentrifuge(edge_size, ratio)
	local scale_factor = BUILDING_SCALE*(edge_size/BUILDING_SCALED_SIZE)
	
	entity = table.deepcopy(data.raw["assembling-machine"]["centrifuge"])
	entity.base_productivity = centrifuge_productivity_factor
	entity.crafting_speed = centrifuge_total_speed_bonus
	entity.energy_usage = centrifuge_total_pwr_draw * ratio .. "kW"
	entity.energy_source.drain = (beacon_pwr_drain * ratio) + (centrifuge_total_pwr_draw * ratio) / 30 .. "kW"
	entity.energy_source.emissions_per_minute = centrifuge_base_pollution * (centrifuge_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * centrifuge_base_modules + 1)) * ratio
	entity.crafting_categories = { "bulkcentrifuging" }
	entity.result_inventory_size = uranium_output_windows_needed
	
	entity.fluid_boxes = nil
	entity.scale_entity_info_icon = true
	entity.alert_icon_scale = scale_factor
	
	for z, _ in pairs(entity.working_visualisations) do
		if entity.working_visualisations[z].animation and entity.working_visualisations[z].animation.layers then
			for i, _ in pairs(entity.working_visualisations[z].animation.layers) do
				entity.working_visualisations[z].animation.layers[i].hr_version.scale = scale_factor
			end
		else
			entity.working_visualisations[z].scale = scale_factor
		end
	end

	for i, _ in pairs(entity.idle_animation.layers) do
		entity.idle_animation.layers[i].hr_version.scale = scale_factor
	end

	local edge_art = {
		filename = "__SmelterUPSGrade__/graphics/centrifuge-border.png",
		frame_count = 64,
		line_length = 8,
		height = 256,
		priority = "high",
		scale = scale_factor * .75,
		width = 256,
	}
	
	table.insert(entity.working_visualisations[2].animation.layers, edge_art)
	table.insert(entity.idle_animation.layers, edge_art)
	
	return entity
end