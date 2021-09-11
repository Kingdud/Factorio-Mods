--////////////////////////////////////////
--LWR Entity
--////////////////////////////////////////
data:extend({
	{
		burner = {
			burnt_inventory_size = 1,
			effectivity = 0.33,
			fuel_inventory_size = 1,
			fuel_category = "lmr-nuclear",
			smoke = {
				--Two stacks = two smoke puffs.
				{
					--  4,4 is SE || 4,-4 is NE || -4, 4 is SW || -4, -4 is NW
					--Horizontal orientation - stacks on left; top stack.
					east_position = {
						-28, -- 5 to 15 == more east
						-25.5 -- -30 to -40 == more north
					},
					--Vertical orientation - stacks on bottom; left stack
					north_position = { -9, 12 },
					--Vertical orientation - stacks on top; right stack
					south_position = { 12, -45 },
					--Horizontal orientation - stacks on right; top stack.
					west_position = { 32, -25.5 },
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
						-6 -- -30 to -40 == more north
					},
					--Vertical orientation - stacks on bottom; right stack
					north_position = { 12, 12 },
					--Vertical orientation - stacks on top; left stack
					south_position = { -8.5, -45 },
					--Horizontal orientation - stacks on right; bottom stack.
					west_position = { 32, -7.5 },
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
		map_color = {196, 196, 196, 255},
		--For sanity's sake, the animation direction is based on which way the reactor hall hall is pointing (since the turbine hall is in the middle).
		--Unlike the LWR, this needs to be scaled by 1.4 in the Y direction (north/south) but 1.3 in the X direction (E/W). Not sure why.
		animation = {
			north = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-n.png",
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
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-n-shadow.png",
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
				}}
			},
			east = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-e.png",
					frame_count = 1,
					width = 684,
					height = 517,
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
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-e-shadow.png",
					frame_count = 1,
					width = 958,
					height = 514,
					hr_version = nil,
					line_length = 1,
					shift = {
						16,--was 13, 3 fence posts overhung
						-10
					},
					scale = 3.7
				}}
			},
			south = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-s.png",
					frame_count = 1,
					width = 343,
					height = 854,
					hr_version = nil,
					line_length = 1,
					shift = {
						0,
						-8.5
					},
					scale = 3.6
				},
				{
					draw_as_shadow = true,
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-s-shadow.png",
					frame_count = 1,
					width = 615,
					height = 761,
					hr_version = nil,
					line_length = 1,
					shift = {
						15.625,
						-3.25 --was -3.5
					},
					scale = 3.6
				}}
			},
			west = {
				layers = {
				{
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-w.png",
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
					filename = "__NuclearRebalance__/graphics/entity/e-lmr-w-shadow.png",
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
			}
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
		type = "burner-generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-stone-impact.ogg",
			volume = 0.65
		}
	}
})