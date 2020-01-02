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
				width = 973,
				height = 704,
				hr_version = nil,
				line_length = 1,
				shift = {
					29.5,
					-13
				},
				scale = 3.88,
			},
			}
		},
		icon = "__NuclearRebalance__/graphics/icons/i-msr.png",
		icon_size = 128,
		max_health = 400,
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
				--Used when cooling tower is in upper-right.
				east_position = {
					18, -- 5 to 15 == more east
					-38 -- -30 to -40 == more north
				},
				frequency = 0.3125,
				name = "msr-cooling-tower-smoke",
				--Used when cooling tower is in lower-right.
				north_position = {
					18,
					-20
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
				width = 973,
				height = 560,
				hr_version = nil,
				line_length = 1,
				shift = {
					29.5,
					-3.85
				},
				scale = 3.88,
			},
			}
		}
	}
})