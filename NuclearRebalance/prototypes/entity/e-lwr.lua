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
			fuel_category = "lwr-nuclear",
			smoke = {
				--Two stacks = two smoke puffs.
				{
					--  4,4 is SE || 4,-4 is NE || -4, 4 is SW || -4, -4 is NW
					--Horizontal orientation - stacks on left; top stack.
					east_position = {
						-28, -- 5 to 15 == more east
						-32.5 -- -30 to -40 == more north
					},
					--Vertical orientation - stacks on bottom; left stack
					north_position = { -9, 8 },
					--Vertical orientation - stacks on top; right stack
					south_position = { 12, -52 },
					--Horizontal orientation - stacks on right; top stack.
					west_position = { 32, -32.5 },
					frequency = 6,
					name = "lwr-cooling-tower-smoke",
					slow_down_factor = 1,
					starting_frame_deviation = 60,
					starting_vertical_speed = 0.08
				},
				{
					--Horizontal orientation - stacks on left; bottom stack.
					east_position = {
						-28, -- 5 to 15 == more east
						-13 -- -30 to -40 == more north
					},
					--Vertical orientation - stacks on bottom; right stack
					north_position = { 12, 8 },
					--Vertical orientation - stacks on top; left stack
					south_position = { -8.5, -52 },
					--Horizontal orientation - stacks on right; bottom stack.
					west_position = { 32, -15 },
					frequency = 6,
					name = "lwr-cooling-tower-smoke",
					slow_down_factor = 1,
					starting_frame_deviation = 60,
					starting_vertical_speed = 0.08
				},
			},
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
		map_color = {56, 235, 255, 255},
		--For sanity's sake, the animation direction is based on which way the reactor hall is pointing, since the turbine hall is in the middle.
		--Note: in blender, use 1.3 instead of 1.4 for the scaling offests, since the fence is 2m high, this will yield the desired result.
		animation = {
			north = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-n.png",
					frame_count = 1,
					width = 383,
					height = 1005,
					hr_version = nil,
					line_length = 1,
					shift = {
						0,
						-11.5
					},
					scale = 3.26
				},
				{
					draw_as_shadow = true,
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-n-shadow.png",
					frame_count = 1,
					width = 616,
					height = 780,
					hr_version = nil,
					line_length = 1,
					shift = {
						12,
						0
					},
					scale = 3.26
				}}
			},
			east = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-e.png",
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
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-e-shadow.png",
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
				}}
			},
			south = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-s.png",
					frame_count = 1,
					width = 381,
					height = 1002,
					hr_version = nil,
					line_length = 1,
					shift = {
						0,
						-11.5
					},
					scale = 3.26
				},
				{
					draw_as_shadow = true,
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-s-shadow.png",
					frame_count = 1,
					width = 602,
					height = 901,
					hr_version = nil,
					line_length = 1,
					shift = {
						11.875,
						-6.25
					},
					scale = 3.26
				}}
			},
			west = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-w.png",
					frame_count = 1,
					width = 760,
					height = 606,
					hr_version = nil,
					line_length = 1,
					shift = {
						0,
						-11.5
					},
					scale = 3.3
				},
				{
					draw_as_shadow = true,
					filename = "__NuclearRebalance__/graphics/entity/e-lwr-w-shadow.png",
					frame_count = 1,
					width = 990,
					height = 525,
					hr_version = nil,
					line_length = 1,
					shift = {
						11.875,--was 11.75
						-7
					},
					scale = 3.3
				}}
			}
		},
		icon = "__NuclearRebalance__/graphics/icons/lwr/i-lwr.png",
		icon_size = 128,
		max_health = 400000,
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
		type = "burner-generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-stone-impact.ogg",
			volume = 0.65
		}
	}
})