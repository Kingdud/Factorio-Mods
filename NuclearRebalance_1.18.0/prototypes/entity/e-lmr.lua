--////////////////////////////////////////
--LWR Entity
--////////////////////////////////////////
data:extend({
	{
		burner = {
			burnt_inventory_size = 1,
			effectivity = 0.33,
			fuel_inventory_size = 1,
			fuel_category = "lmr-nuclear"
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
		effectivity = .33,
		energy_source = {
			type = "electric",
			--Sodium leaks are a constant problem.
			emissions_per_minute = .3,
			usage_priority = "primary-output"
		},
		fast_replaceable_group = "steam-engine",
		flags = {
			"placeable-neutral",
			"player-creation"
		},
		--For sanity's sake, the animation direction is based on which way the turbine hall is pointing.
		horizontal_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-lmr-h.png",
				frame_count = 1,
				width = 685,
				height = 518,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-10 -- -y = up, +y = down
				},
				scale = 3.7
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-lmr-h-shadow.png",
				frame_count = 1,
				width = 917,
				height = 514,
				hr_version = nil,
				line_length = 1,
				shift = {
					13,
					-10
				},
				scale = 3.7
			}}
		},
		icon = "__NuclearRebalance__/graphics/icons/lmr/i-lmr.png",
		icon_size = 128,
		max_health = 400,
		max_power_output = "1GW",
		min_perceived_performance = 0.25,
		minable = {
			mining_time = 30,
			result = "lmr"
		},
		name = "lmr",
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
				--Horizontal orientation; top stack.
				east_position = {
					33, -- 5 to 15 == more east
					-27 -- -30 to -40 == more north
				},
				frequency = 0.3125,
				name = "lmr-cooling-tower-smoke",
				--Vertical orientation; left stack
				north_position = {
					-8,
					11
				},
				slow_down_factor = 1,
				starting_frame_deviation = 60,
				starting_vertical_speed = 0.08
			},
			{
				--Horizontal orientation; bottom stack.
				east_position = {
					33, -- 5 to 15 == more east
					-9 -- -30 to -40 == more north
				},
				frequency = 0.3125,
				name = "lmr-cooling-tower-smoke",
				--Vertical orientation; right stack
				north_position = {
					12,
					11
				},
				slow_down_factor = 1,
				starting_frame_deviation = 60,
				starting_vertical_speed = 0.08
			},
		},
		type = "burner-generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-stone-impact.ogg",
			volume = 0.65
		},
		vertical_animation = {
			layers = {
			{
				filename = "__NuclearRebalance__/graphics/entity/e-lmr-v.png",
				frame_count = 1,
				width = 343,
				height = 875,
				hr_version = nil,
				line_length = 1,
				shift = {
					0,
					-9.5
				},
				scale = 3.6
			},
			{
				draw_as_shadow = true,
				filename = "__NuclearRebalance__/graphics/entity/e-lmr-v-shadow.png",
				frame_count = 1,
				width = 620,
				height = 871,
				hr_version = nil,
				line_length = 1,
				shift = {
					15.625,
					-9.25
				},
				scale = 3.6
			}
		}
	}
	}
})