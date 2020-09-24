require("prototypes.constants")

function create_entity(e_type)
	local entity
	local r_icon
	local ratio
	
	if e_type == "smelter" then
		entity = table.deepcopy(data.raw.furnace["electric-furnace"])
		r_icon = "__base__/graphics/icons/electric-furnace.png"
		ratio = settings.startup["smelter-ratio"].value
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
		entity.alert_icon_scale = BUILDING_SCALE
		entity.animation.layers[1].hr_version.scale = BUILDING_SCALE
		entity.animation.layers[1].hr_version.shift[1] = entity.animation.layers[1].hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.animation.layers[1].hr_version.shift[2] = entity.animation.layers[1].hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.animation.layers[2].hr_version.scale = BUILDING_SCALE
		entity.animation.layers[2].hr_version.shift[1] = entity.animation.layers[2].hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.animation.layers[2].hr_version.shift[2] = entity.animation.layers[2].hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.working_visualisations[1].animation.hr_version.scale = BUILDING_SCALE
		entity.working_visualisations[1].animation.hr_version.shift[1] = entity.working_visualisations[1].animation.hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.working_visualisations[1].animation.hr_version.shift[2] = entity.working_visualisations[1].animation.hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.working_visualisations[2].animation.hr_version.scale = BUILDING_SCALE
		entity.working_visualisations[2].animation.hr_version.shift[1] = entity.working_visualisations[2].animation.hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.working_visualisations[2].animation.hr_version.shift[2] = entity.working_visualisations[2].animation.hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.working_visualisations[3].animation.hr_version.scale = BUILDING_SCALE
		entity.working_visualisations[3].animation.hr_version.shift[1] = entity.working_visualisations[3].animation.hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		entity.working_visualisations[3].animation.hr_version.shift[2] = entity.working_visualisations[3].animation.hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
		
		local edge_art = {
			filename = "__SmelterUPSGrade__/graphics/smelter_border.png",
			frame_count = 1,
			height = 256,
			priority = "high",
			scale = BUILDING_SCALE * .75,
			width = 256,
		}
		
		table.insert(entity.animation.layers, edge_art)
	
	elseif e_type == "centrifuge" then
		entity = table.deepcopy(data.raw["assembling-machine"]["centrifuge"])
		r_icon = "__base__/graphics/icons/centrifuge.png"
		ratio = settings.startup["centrifuge-ratio"].value
		entity.base_productivity = centrifuge_productivity_factor
		entity.crafting_speed = centrifuge_total_speed_bonus
		entity.energy_usage = centrifuge_total_pwr_draw * ratio .. "kW"
		entity.energy_source.drain = (beacon_pwr_drain * ratio) + (centrifuge_total_pwr_draw * ratio) / 30 .. "kW"
		entity.energy_source.emissions_per_minute = centrifuge_base_pollution * (centrifuge_per_unit_pwr_drain_penalty * (prod_mod_pollution_penalty * centrifuge_base_modules + 1)) * ratio
		entity.crafting_categories = { "bulkcentrifuging" }
		entity.result_inventory_size = uranium_output_windows_needed
		
		entity.fluid_boxes = nil
		entity.scale_entity_info_icon = true
		entity.alert_icon_scale = BUILDING_SCALE
		entity.animation.layers[1].hr_version.scale = BUILDING_SCALE
		entity.animation.layers[2].hr_version.scale = BUILDING_SCALE
		entity.animation.layers[3].hr_version.scale = BUILDING_SCALE

		entity.idle_animation.layers[1].hr_version.scale = BUILDING_SCALE
		entity.idle_animation.layers[2].hr_version.scale = BUILDING_SCALE
		entity.idle_animation.layers[3].hr_version.scale = BUILDING_SCALE
		entity.idle_animation.layers[4].hr_version.scale = BUILDING_SCALE
		entity.idle_animation.layers[5].hr_version.scale = BUILDING_SCALE
		entity.idle_animation.layers[6].hr_version.scale = BUILDING_SCALE
		
		local edge_art = {
			filename = "__SmelterUPSGrade__/graphics/centrifuge-border.png",
			frame_count = 64,
			line_length = 8,
			height = 256,
			priority = "high",
			scale = BUILDING_SCALE * .75,
			width = 256,
		}
		
		table.insert(entity.animation.layers, edge_art)
		table.insert(entity.idle_animation.layers, edge_art)
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
		{
		  -24.8,
		  -24.8
		},
		{
		  24.8,
		  24.8
		}
	}
	entity.selection_box = {
		{
		  -25,
		  -25
		},
		{
		  25,
		  25
		}
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