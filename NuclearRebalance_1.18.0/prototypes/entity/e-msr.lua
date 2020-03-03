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
		--For sanity's sake, the animation direction is based on which way the turbine hall is pointing.
		animation = {
			north = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-msr-n.png",
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
					filename = "__NuclearRebalance__/graphics/entity/e-msr-n-shadow.png",
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
			},
			--new
			east = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-msr-e.png",
					frame_count = 1,
					width = 586,
					height = 707,
					hr_version = nil,
					line_length = 1,
					shift = {
						0,
						-6
					},
					scale = 3.2,
				},
				{
					draw_as_shadow = true,
					filename = "__NuclearRebalance__/graphics/entity/e-msr-e-shadow.png",
					frame_count = 1,
					width = 770,
					height = 604,
					hr_version = nil,
					line_length = 1,
					shift = {
						9.25,
						-1 -- was -.5
					},
					scale = 3.2
				}}
			},
			--Blender note: Multiply Y axis by 1.36 to get correct scaling.
			south = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-msr-s.png",
					frame_count = 1,
					width = 586,
					height = 920,
					hr_version = nil,
					line_length = 1,
					shift = {
						0,
						-17
					},
					scale = 3.2,
				},
				{
					draw_as_shadow = true,
					filename = "__NuclearRebalance__/graphics/entity/e-msr-s-shadow.png",
					frame_count = 1,
					width = 782,
					height = 707,
					hr_version = nil,
					line_length = 1,
					shift = {
						9.8125,
						-6.5
					},
					scale = 3.2
				},
				}
			},
			west = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-msr-w.png",
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
					filename = "__NuclearRebalance__/graphics/entity/e-msr-w-shadow.png",
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
				}}
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
		type = "burner-generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-stone-impact.ogg",
			volume = 0.65
		}
	}
})