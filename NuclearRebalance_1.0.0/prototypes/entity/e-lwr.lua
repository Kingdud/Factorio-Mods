--////////////////////////////////////////
--LWR Entity
--////////////////////////////////////////
data:extend({
	{
		burner = {
			burnt_inventory_size = 1,
			--Setting effectivity here actually makes it less efficient.
			effectivity = 0.25,
			fuel_inventory_size = 1,
			fuel_category = "lwr-nuclear"
		},
		collision_box = {
			{
			  -19.9000000000001,
			  -39.9000000000001
			},
			{
			  19.90000000000001,
			  39.90000000000001
			}
		},
		corpse = "steam-engine-remnants",
		dying_explosion = "medium-explosion",
		--Setting effectivity here sets it for the tooltip but does nothing else
		effectivity = .25,
		energy_source = {
			type = "electric",
			emissions_per_minute = .01,
			usage_priority = "primary-output"
		},
		fast_replaceable_group = "lwr",
		flags = {
			"placeable-neutral",
			"player-creation"
		},
		fluid_box = nil,
		horizontal_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-h.png",
				frame_count = 1,
				width = 771,
				height = 606,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-11.5
				},
				scale = 3.28
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-h-shadow.png",
				frame_count = 1,
				width = 1006,
				height = 522,
				hr_version = nil,
				line_length = 1,
				shift = {
					12.125,
					-7
				},
				scale = 3.28
			},
			}
		},
		icon = "__NuclearRebalance__/graphics/icons/i-lwr.png",
		icon_size = 128,
		max_health = 400,
		max_power_output = "500MW",
		min_perceived_performance = 0.25,
		minable = {
			mining_time = 30,
			result = "lwr"
		},
		name = "lwr",
		performance_to_sound_speedup = 0.5,
		selection_box = {
		{
			-19.5,
			-39.5
		},
		{
			19.5,
			39.5
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
				name = "cooling-tower-smoke",
				--Used when cooling tower is in lower-right.
				north_position = {
					18,
					-15
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
				filename = "__NuclearRebalance__/graphics/entity/e-lwr-v.png",
				frame_count = 1,
				width = 1024,
				height = 1024,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					0
				},
				scale = 2.8
			},
			}
		}
	}
})