require("prototypes.constants")

--////////////////////////////////////////
--MSR Entity
--////////////////////////////////////////
data:extend({
	{
		burner = {
			burnt_inventory_size = 0,
			effectivity = 0.55,
			fuel_inventory_size = 1,
			fuel_category = "msr-nuclear"
		},
		collision_box = {
			{
			  -29.900000000000001,
			  -29.900000000000001
			},
			{
			  29.900000000000001,
			  29.900000000000001
			}
		},
		corpse = "steam-engine-remnants",
		dying_explosion = "medium-explosion",
		effectivity = .55,
		energy_source = {
			type = "electric",
			--While underground, we are still dumping waste underground, and that waste his HIGHLY pollutant.
			emissions_per_minute = 5,
			usage_priority = "primary-output"
		},
		fast_replaceable_group = "msr",
		flags = {
			"placeable-neutral",
			"player-creation"
		},
		fluid_box = nil,
		horizontal_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-msr-h.png",
				frame_count = 1,
				width = 587,
				height = 925,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-16.5
				},
				scale = 3.18,
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-msr-h-shadow.png",
				frame_count = 1,
				width = 1008,
				height = 705,
				hr_version = nil,
				line_length = 1,
				shift = {
					21,
					-5.5
				},
				scale = 3.18
			},
			}
		},
		icon = "__NuclearRebalance__/graphics/icons/msr/i-msr.png",
		icon_size = 128,
		max_health = 7000,
		max_power_output = tostring(msr_target_power_output_gw) .. "GW",
		min_perceived_performance = 0.25,
		minable = {
			mining_time = 30,
			result = "msr"
		},
		name = "msr",
		performance_to_sound_speedup = 0.5,
		selection_box = {
		{
			-29.5,
			-29.5
		},
		{
			29.5,
			29.5
		}
		},
		smoke = {
			{
				--horizontal orientation.
				east_position = {
					16, -- 5 to 15 == more east
					-40 -- -30 to -40 == more north
				},
				frequency = 0.3125,
				name = "msr-cooling-tower-smoke",
				--Vertical orientation
				north_position = {
					16,
					-17.5
				},
				slow_down_factor = 1,
				starting_frame_deviation = 60,
				starting_vertical_speed = 0.08
			}
		},
		type = "generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-stone-impact.ogg",
			volume = 0.65
		},
		vertical_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-msr-v.png",
				frame_count = 1,
				width = 586,
				height = 703,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-5.25
				},
				scale = 3.18,
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-msr-v-shadow.png",
				frame_count = 1,
				width = 996,
				height = 597,
				hr_version = nil,
				line_length = 1,
				shift = {
					20.25,
					0
				},
				scale = 3.18
			},
			}
		}
	}
})