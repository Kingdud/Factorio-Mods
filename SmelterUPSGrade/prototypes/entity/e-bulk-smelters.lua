require("prototypes.constants")

--Entity definitions
local entity_smelter = table.deepcopy(data.raw.furnace["electric-furnace"])
--todo: replace graphics
entity_smelter.icon = nil
entity_smelter.icons = {
	{
		icon = "__base__/graphics/icons/electric-furnace.png",
		tint = building_tint,
		icon_size = 64,
		icon_mipmaps = 4
	}
}
entity_smelter.name = "bulk-smelter"
entity_smelter.result_inventory_size = r_output_windows_needed
--This is what it should be, but it's 10% too slow for some reason I can't figure out.
--entity_smelter.crafting_speed = 0.34625322997416
entity_smelter.crafting_speed = 0.380878552971576
--we detune this from 72900kW because it will end up using too much power relative to what
-- 405 beaconed smelters (with bots, inserters, etc) would actually use (~OFFSET_SCALING_FACTOR3GW)
entity_smelter.energy_usage = "32855kW"
entity_smelter.collision_box = {
	{
	  -24.8,
	  -24.8
	},
	{
	  24.8,
	  24.8
	}
}
entity_smelter.selection_box = {
	{
	  -25,
	  -25
	},
	{
	  25,
	  25
	}
}
entity_smelter.crafting_categories = 
{
	"bulksmelting"
}
entity_smelter.energy_source = {
	emissions_per_minute = 405,
	type = "electric",
	usage_priority = "secondary-input"
}
entity_smelter.minable = {
	mining_time = 0.2,
	result = "bulk-smelter"
}
--For reasons I don't understand, the offsets need additional padding to scale correctly on top of the building scale itself.
local OFFSET_SCALING_FACTOR = 1.95
entity_smelter.scale_entity_info_icon = true
entity_smelter.alert_icon_scale = BUILDING_SCALE
entity_smelter.animation.layers[1].hr_version.scale = BUILDING_SCALE
entity_smelter.animation.layers[1].hr_version.shift[1] = entity_smelter.animation.layers[1].hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.animation.layers[1].hr_version.shift[2] = entity_smelter.animation.layers[1].hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.animation.layers[2].hr_version.scale = BUILDING_SCALE
entity_smelter.animation.layers[2].hr_version.shift[1] = entity_smelter.animation.layers[2].hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.animation.layers[2].hr_version.shift[2] = entity_smelter.animation.layers[2].hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.working_visualisations[1].animation.hr_version.scale = BUILDING_SCALE
entity_smelter.working_visualisations[1].animation.hr_version.shift[1] = entity_smelter.working_visualisations[1].animation.hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.working_visualisations[1].animation.hr_version.shift[2] = entity_smelter.working_visualisations[1].animation.hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.working_visualisations[2].animation.hr_version.scale = BUILDING_SCALE
entity_smelter.working_visualisations[2].animation.hr_version.shift[1] = entity_smelter.working_visualisations[2].animation.hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.working_visualisations[2].animation.hr_version.shift[2] = entity_smelter.working_visualisations[2].animation.hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.working_visualisations[3].animation.hr_version.scale = BUILDING_SCALE
entity_smelter.working_visualisations[3].animation.hr_version.shift[1] = entity_smelter.working_visualisations[3].animation.hr_version.shift[1] * BUILDING_SCALE*OFFSET_SCALING_FACTOR
entity_smelter.working_visualisations[3].animation.hr_version.shift[2] = entity_smelter.working_visualisations[3].animation.hr_version.shift[2] * BUILDING_SCALE*OFFSET_SCALING_FACTOR

local new_mod_icon_shift = 0.8 * BUILDING_SCALE
entity_smelter.module_specification = {
	module_info_icon_shift = {
		0,
		new_mod_icon_shift
	},
	module_slots = 2,
	module_info_icon_scale = BUILDING_SCALE
}

--///////////////////////////////////////////////
--Centrifuge section
--///////////////////////////////////////////////

local entity_centrifuge = table.deepcopy(data.raw["assembling-machine"]["centrifuge"])
entity_centrifuge.icons = {
	{
		icon = "__base__/graphics/icons/centrifuge.png",
		tint = building_tint,
		icon_size = 64,
		icon_mipmaps = 4
	}
}
entity_centrifuge.name = "bulk-centrifuge"
entity_centrifuge.result_inventory_size = uranium_output_windows_needed
entity_centrifuge.crafting_speed = 0.17312661498708
--Similar to the smelter, this will pull too much power due to the beacons around it, so we detune it from 141750kW
entity_centrifuge.energy_usage = "46428kW"
entity_centrifuge.module_specification.module_info_icon_scale = BUILDING_SCALE
new_mod_icon_shift = 1.5 * BUILDING_SCALE
entity_centrifuge.module_specification.module_info_icon_shift = {0,	new_mod_icon_shift}
entity_centrifuge.collision_box = {
	{
	  -24.8,
	  -24.8
	},
	{
	  24.8,
	  24.8
	}
}
entity_centrifuge.selection_box = {
	{
	  -25,
	  -25
	},
	{
	  25,
	  25
	}
}	
entity_centrifuge.crafting_categories = 
{
	"bulkcentrifuging"
}
entity_centrifuge.energy_source = {
	emissions_per_minute = 1620,
	type = "electric",
	usage_priority = "secondary-input"
}
entity_centrifuge.minable = {
	mining_time = 0.2,
	result = "bulk-centrifuge"
}
entity_centrifuge.fluid_boxes = nil
entity_centrifuge.scale_entity_info_icon = true
entity_centrifuge.alert_icon_scale = BUILDING_SCALE
entity_centrifuge.animation.layers[1].hr_version.scale = BUILDING_SCALE
entity_centrifuge.animation.layers[2].hr_version.scale = BUILDING_SCALE
entity_centrifuge.animation.layers[3].hr_version.scale = BUILDING_SCALE

entity_centrifuge.idle_animation.layers[1].hr_version.scale = BUILDING_SCALE
entity_centrifuge.idle_animation.layers[2].hr_version.scale = BUILDING_SCALE
entity_centrifuge.idle_animation.layers[3].hr_version.scale = BUILDING_SCALE
entity_centrifuge.idle_animation.layers[4].hr_version.scale = BUILDING_SCALE
entity_centrifuge.idle_animation.layers[5].hr_version.scale = BUILDING_SCALE
entity_centrifuge.idle_animation.layers[6].hr_version.scale = BUILDING_SCALE

data:extend({entity_smelter})
data:extend({entity_centrifuge})