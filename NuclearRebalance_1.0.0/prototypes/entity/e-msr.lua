require("prototypes.constants")

--////////////////////////////////////////
--LWR Entity
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
			  -1.3500000000000001,
			  -2.3500000000000001
			},
			{
			  1.3500000000000001,
			  2.3500000000000001
			}
		},
		corpse = "steam-engine-remnants",
		dying_explosion = "medium-explosion",
		effectivity = .55,
		energy_source = {
			type = "electric",
			--Sodium leaks are a constant problem.
			emissions_per_minute = 5,
			usage_priority = "primary-output"
		},
		fast_replaceable_group = "steam-engine",
		flags = {
			"placeable-neutral",
			"player-creation"
		},
		fluid_box = nil,
		horizontal_animation = {
			layers = {
			{
				filename = "__base__/graphics/entity/steam-engine/steam-engine-H.png",
				frame_count = 32,
				height = 128,
				hr_version = {
					filename = "__base__/graphics/entity/steam-engine/hr-steam-engine-H.png",
					frame_count = 32,
					height = 257,
					line_length = 8,
					scale = 0.5,
					shift = {
						0.03125,
						-0.1484375
					},
					width = 352
				},
				line_length = 8,
				shift = {
					0.03125,
					-0.15625
				},
				width = 176
			},
			{
				draw_as_shadow = true,
				filename = "__base__/graphics/entity/steam-engine/steam-engine-H-shadow.png",
				frame_count = 32,
				height = 80,
				hr_version = {
					draw_as_shadow = true,
					filename = "__base__/graphics/entity/steam-engine/hr-steam-engine-H-shadow.png",
					frame_count = 32,
					height = 160,
					line_length = 8,
					scale = 0.5,
					shift = {
						1.5,
						0.75
					},
					width = 508
				},
				line_length = 8,
				shift = {
					1.5,
					0.75
				},
				width = 254
			}}
		},
		icon = "__base__/graphics/icons/steam-engine.png",
		icon_size = 32,
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
			-1.5,
			-2.5
		},
		{
			1.5,
			2.5
		}
		},
		smoke = nil,
		type = "generator",
		vehicle_impact_sound = {
			filename = "__base__/sound/car-metal-impact.ogg",
			volume = 0.65
		},
		vertical_animation = {
			layers = {
			{
				filename = "__base__/graphics/entity/steam-engine/steam-engine-V.png",
				frame_count = 32,
				height = 195,
				hr_version = {
					filename = "__base__/graphics/entity/steam-engine/hr-steam-engine-V.png",
					frame_count = 32,
					height = 391,
					line_length = 8,
					scale = 0.5,
					shift = {
						0.1484375,
						-0.1953125
					},
					width = 225
				},
				line_length = 8,
				shift = {
					0.15625,
					-0.203125
				},
				width = 112
			},
			{
				draw_as_shadow = true,
				filename = "__base__/graphics/entity/steam-engine/steam-engine-V-shadow.png",
				frame_count = 32,
				height = 153,
				hr_version = {
					draw_as_shadow = true,
					filename = "__base__/graphics/entity/steam-engine/hr-steam-engine-V-shadow.png",
					frame_count = 32,
					height = 307,
					line_length = 8,
					scale = 0.5,
				shift = {
					1.265625,
					0.2890625
				},
				width = 330
				},
				line_length = 8,
				shift = {
					1.265625,
					0.296875
				},
				width = 165
			}
			}
		},
		working_sound = {
			match_speed_to_activity = true,
			sound = {
				filename = "__base__/sound/steam-engine-90bpm.ogg",
				volume = 0.6
			}
		}
	}
})