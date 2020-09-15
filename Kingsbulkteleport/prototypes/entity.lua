local function energizer(job, name, energy, tiles)
	local s_corner = tiles/2 - 0.5
	local sound_file
	
	if name == "send" then
		sound_file = "__Kingsbulkteleport__/sound/energize.ogg"
	else
		sound_file = "__Kingsbulkteleport__/sound/de-energize.ogg"
	end

	data:extend({
		{
			type = "item",
			name = "bulkteleport-energizer-"..name,
			icon = "__Kingsbulkteleport__/graphics/"..name..".png",
			icon_size = 32,
			flags = {"hidden","only-in-cursor"},
			stack_size = 10,
		},
		{
			type = "furnace",
			name = "bulkteleport-energizer-"..name,
			icon = "__Kingsbulkteleport__/graphics/"..name..".png",
			icon_size = 32,
			flags = {
				"placeable-neutral",
				"player-creation",
				"not-deconstructable",
			},
			mined_sound = nil,
			minable = nil,
			collision_mask = {},
			max_health = 300,
			collision_box = nil,
			selection_box = {{-s_corner, -s_corner}, {0, 0}},
			module_specification = {
				module_slots = 0,
			},
			corpse = "big-remnants",
			dying_explosion = "medium-explosion",
			allowed_effects = nil,
			crafting_categories = {
				"bulkteleport",
			},
			crafting_speed = 1.0,
			energy_source = {
				type = "electric",
				usage_priority = "secondary-input",
				emissions_per_second_per_watt = 0.00001,
				drain = "1MW",
			},
			energy_usage = energy,
			result_inventory_size = 1,
			source_inventory_size = 1,
			animation = {
				filename = "__Kingsbulkteleport__/graphics/"..name.."-frames-lr.png",
				width = tiles*48,
				height = tiles*48,
				frame_count = 30,
				line_length = 5,
				shift = {0, 0},
				animation_speed = 1.0,
				hr_version = {
					filename = "__Kingsbulkteleport__/graphics/"..name.."-frames-hr.png",
					width = tiles*96,
					height = tiles*96,
					frame_count = 30,
					line_length = 5,
					shift = {0, 0},
					animation_speed = 1.0,
					scale = 0.5,
				},
			},
			vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
			repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
			open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
			close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
			working_sound = {
				apparent_volume = 1.5,
				sound = {
					filename = sound_file,
					volume = 0.7
				}
			},
			order = "z",
			placeable_by = {
				item = "bulkteleport-buffer-"..name,
				count = 1,
			},
			tile_width = tiles,
			tile_height = tiles,
		},
	})
end

local function buffer(name, size, tiles)
	local corner = tiles/2 - 0.1
	local s_corner = tiles/2 - 0.5

	data:extend({
		{
			type = "item",
			name = "bulkteleport-buffer-"..name,
			icon = "__Kingsbulkteleport__/graphics/"..name.."-b.png",
			icon_size = 32,
			flags = {"hidden","only-in-cursor"},
			stack_size = 10,
		},
		{
			type = "container",
			name = "bulkteleport-buffer-"..name,
			icon = "__Kingsbulkteleport__/graphics/"..name.."-b.png",
			icon_size = 32,
			flags = {"placeable-neutral", "player-creation"},
			minable = {mining_time = 1, result = "bulkteleport-"..name},
			max_health = 300,
			corpse = "small-remnants",
			open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65 },
			close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
			resistances =
			{
				{
					type = "fire",
					percent = 90
				}
			},
			collision_box = {{-corner, -corner}, {corner, corner}},
			selection_box = {{0, 0}, {s_corner, s_corner}},
			inventory_size = size,
			vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
			picture = {
				filename = "__Kingsbulkteleport__/graphics/job.png",
				priority = "low",
				width = 32,
				height = 32,
			},
			circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
			circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
			circuit_wire_max_distance = default_circuit_wire_max_distance,
			placeable_by = {
				item = "bulkteleport-"..name,
				count = 1,
			},
			tile_width = tiles,
			tile_height = tiles,
		},
	})
end

local function tank(name, fluid, tiles)
	local corner = tiles/2 - 0.1
	local s_corner = tiles/2 - 0.5

	local pipeA = tiles/2 - 0.5
	local pipeB = tiles/2 + 0.5
	
	local fluid_base_level = 0
	if string.find(name, "send", 1) ~= nil then
		--This setting helps the tank fill quickly, prevents fluid from leaving.
		fluid_base_level = -1
	else
		--This setting helps the tank empty, fluid will be very hard to pump back in.
		fluid_base_level = 1
	end

	data:extend({
		{
			type = "item",
			name = "bulkteleport-buffer-"..name,
			icon = "__Kingsbulkteleport__/graphics/"..name.."-b.png",
			icon_size = 32,
			flags = {"hidden"},
			stack_size = 10,
		},
		{
			type = "storage-tank",
			name = "bulkteleport-buffer-"..name,
			icon = "__Kingsbulkteleport__/graphics/"..name.."-b.png",
			icon_size = 32,
			flags = {"placeable-neutral", "player-creation", "not-rotatable"},
			minable = {mining_time = 1, result = "bulkteleport-"..name},
			max_health = 300,
			corpse = "small-remnants",
			open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65 },
			close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
			resistances = { { type = "fire", percent = 90 } },
			collision_box = {{-corner, -corner}, {corner, corner}},
			selection_box = {{0, 0}, {s_corner, s_corner}},
			fluid_box = {
				base_area = fluid/100,
				base_level = fluid_base_level,
				pipe_covers = pipecoverspictures(),
				pipe_connections = {
					{ position = {-pipeA, -pipeB} },
					{ position = {pipeB, pipeA} },
					{ position = {pipeA, pipeB} },
					{ position = {-pipeB, -pipeA} },
				},
			},
			two_direction_only = false,
			flow_length_in_ticks = 360,
			window_bounding_box = {{-0.125, 0.6875}, {0.1875, 1.1875}},
			vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
			pictures = {
				picture =
				{
					filename = "__Kingsbulkteleport__/graphics/job.png",
					priority = "low",
					width = 32,
					height = 32,
				},
				fluid_background = {
					filename = "__base__/graphics/entity/storage-tank/fluid-background.png",
					priority = "low",
					width = 32,
					height = 15
				},
				window_background = {
					filename = "__base__/graphics/entity/storage-tank/window-background.png",
					priority = "low",
					width = 17,
					height = 24
				},
				flow_sprite = {
					filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
					priority = "low",
					width = 160,
					height = 20
				},
				gas_flow = {
					filename = "__base__/graphics/entity/pipe/steam.png",
					priority = "low",
					line_length = 10,
					width = 24,
					height = 15,
					frame_count = 60,
					axially_symmetrical = false,
					direction_count = 1,
					animation_speed = 0.25,
					hr_version =
					{
						filename = "__base__/graphics/entity/pipe/hr-steam.png",
						priority = "low",
						line_length = 10,
						width = 48,
						height = 30,
						frame_count = 60,
						axially_symmetrical = false,
						animation_speed = 0.25,
						direction_count = 1
					}
				}
			},
			working_sound = {
				sound = {
					filename = "__base__/sound/storage-tank.ogg",
					volume = 0.8
				},
				apparent_volume = 1.5,
				max_sounds_per_type = 3
			},
			circuit_wire_connection_points = circuit_connector_definitions["storage-tank"].points,
			circuit_connector_sprites = circuit_connector_definitions["storage-tank"].sprites,
			circuit_wire_max_distance = default_circuit_wire_max_distance,
			placeable_by = {
				item = "bulkteleport-"..name,
				count = 1,
			},
			tile_width = tiles,
			tile_height = tiles,
		},
	})
end

local function dummy(name, tiles)
	local corner = tiles/2 - 0.1

	data:extend({
		{
			type = "simple-entity-with-force",
			name = "bulkteleport-"..name,
			flags = {
				"player-creation",
			},
			selectable_in_game = true,
			build_sound = nil,
			mined_sound = nil,
			created_smoke = nil,
			minable = {
				mining_time = 1,
				result = placeable,
			},
			collision_mask = {
				"object-layer",
			},
			collision_box = {{-corner, -corner}, {corner, corner}},
			selection_box = {{-corner, -corner}, {corner, corner}},
			picture = {
				filename = "__Kingsbulkteleport__/graphics/"..name.."-frames-lr.png",
				width = tiles*48,
				height = tiles*48,
				hr_version = {
					filename = "__Kingsbulkteleport__/graphics/"..name.."-frames-hr.png",
					width = tiles*96,
					height = tiles*96,
					scale = 0.5,
				},
			},
			render_layer = "object",
			tile_width = tiles,
			tile_height = tiles,
		},
	})
end

local function teleporter(tier, energy, size, tiles)
	energizer("job1", "send"..tier, energy, tiles)
	energizer("job1", "recv"..tier, energy, tiles)
	buffer("send"..tier, size, tiles)
	buffer("recv"..tier, size, tiles)
	dummy("send"..tier, tiles)
	dummy("recv"..tier, tiles)
end

local function fluid_teleporter(tier, energy, fluid, tiles)
	energizer("job1", "send"..tier, energy, tiles)
	energizer("job1", "recv"..tier, energy, tiles)
	tank("send"..tier, fluid, tiles)
	tank("recv"..tier, fluid, tiles)
	dummy("send"..tier, tiles)
	dummy("recv"..tier, tiles)
end

local small_pwr_cost = 250
local big_pwr_cost = 1000
local slots = 250
local fluid = 50000
local tech_1_2_multipler = 4

if settings.startup["bulkteleport-smalltp-energy-need"] then
	small_pwr_cost = settings.startup["bulkteleport-smalltp-energy-need"].value
end
if settings.startup["bulkteleport-bigtp-energy-need"] then
	big_pwr_cost = settings.startup["bulkteleport-bigtp-energy-need"].value
end

teleporter(1, 		small_pwr_cost .. "MW", 	slots, 4)
teleporter(2, 		big_pwr_cost .. "MW", 		slots*tech_1_2_multipler, 6)
fluid_teleporter(3, small_pwr_cost .. "MW", 	fluid, 4)
fluid_teleporter(4, big_pwr_cost .. "MW", 		fluid*tech_1_2_multipler, 6)
