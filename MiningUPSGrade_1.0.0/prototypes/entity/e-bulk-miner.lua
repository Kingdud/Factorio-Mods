require("prototypes.constants")

local SCALE_FACTOR = 5.666
--local OFFSET_SCALING_FACTOR = 1.95

local newitem = util.table.deepcopy(data.raw["mining-drill"]["electric-mining-drill"]);
newitem.name = "tfx-emd";
newitem.minable.result = "tfx-emd"
newitem.icon = nil
newitem.icons = {
	{
		icon = "__base__/graphics/icons/electric-mining-drill.png",
		tint = newTint,
		icon_size = 32
	}
}
newitem.module_specification.module_info_icon_scale = SCALE_FACTOR
newitem.energy_source.emissions_per_minute = replacement_pollution_value
newitem.energy_usage = tostring(replacement_miner_power) .. "kW"
newitem.mining_speed = replacement_miner_speed
newitem.collision_box = {{ -width, -length}, {width, length}}
newitem.selection_box = {{ -width, -length}, {width, length}}
--assumes item is square
local side_length = math.ceil(width)
newitem.input_fluid_box.pipe_connections =
	{
		{ position = { -side_length, 0 } },
		{ position = { side_length, 0 } },
		{ position = { 0, side_length } },
		--this is the output vector, can't be a pipe!
		--{ position = { 0, -side_length } },		
	}
newitem.resource_searching_radius = new_resource_searching_radius
newitem.vector_to_place_result = { 0, -side_length-.11 }

--And now the mountain of animation offsets and scales. Sigh.
--Correction, yay loops!
for _,thing in pairs(
	{newitem.animations,
		newitem.shadow_animations,
		newitem.input_fluid_patch_shadow_animations, 
		newitem.input_fluid_patch_shadow_sprites, 
		newitem.input_fluid_patch_sprites, 
		newitem.input_fluid_patch_window_sprites
	}) do
	for _,value in pairs(thing) do
		value.scale = SCALE_FACTOR
		value.hr_version.scale = value.hr_version.scale * SCALE_FACTOR
		--value.shift[1] = value.shift[1] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
		--value.shift[2] = value.shift[2] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
		--value.hr_version.shift[1] = value.hr_version.shift[1] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
		--value.hr_version.shift[2] = value.hr_version.shift[2] * OFFSET_SCALING_FACTOR * SCALE_FACTOR
	end
end

for _,thing in pairs({newitem.input_fluid_patch_window_base_sprites, newitem.input_fluid_patch_window_flow_sprites}) do
	for _,value in pairs(thing[1]) do
		value.scale = SCALE_FACTOR
		value.hr_version.scale = value.hr_version.scale * SCALE_FACTOR
	end
end

for _,value in pairs(newitem.circuit_connector_sprites) do
	value.connector_main.scale = 	value.connector_main.scale 		* SCALE_FACTOR
	value.connector_shadow.scale = 	value.connector_shadow.scale 	* SCALE_FACTOR
	value.led_blue.scale = 			value.led_blue.scale 			* SCALE_FACTOR
	value.led_blue_off.scale = 		value.led_blue_off.scale 		* SCALE_FACTOR
	value.led_green.scale = 		value.led_green.scale 			* SCALE_FACTOR
	value.led_red.scale = 			value.led_red.scale 			* SCALE_FACTOR
	value.wire_pins.scale = 		value.wire_pins.scale 			* SCALE_FACTOR
	value.wire_pins_shadow.scale = 	value.wire_pins_shadow.scale 	* SCALE_FACTOR
	value.led_green.scale = 		value.led_green.scale 			* SCALE_FACTOR
end

data:extend({newitem})