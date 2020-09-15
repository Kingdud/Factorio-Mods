local payload = 97

if settings.startup["bigger-cargo"].value == true then
	payload = 197
end

data:extend(
{
    -- entity
    {
        type = "logistic-robot",
        name = "logistic-robot-nuclear",
        icon = "__KingsNuclearBots__/graphics/icons/logistic-robot-nuclear.png",
        icon_size = 32,        
        flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map"},
        minable = {hardness = 0.1, mining_time = 0.1, result = "logistic-robot-nuclear"},
        resistances = { { type = "fire", percent = 85 } },
        max_health = 500,
        dying_explosion = "massive-explosion",
        collision_box = {{0, 0}, {0, 0}},
        selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
        max_payload_size = 97,
        speed = 0.05,
        transfer_distance = 0.5,
        max_energy = "1.5MJ",
        energy_per_tick = "0kJ",
        speed_multiplier_when_out_of_energy = 0.2,
        energy_per_move = "0kJ",
        min_to_charge = 0.2,
        max_to_charge = 0.95,
        idle = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear.png",
            priority = "high",
            line_length = 16,
            width = 41,
            height = 42,
            frame_count = 1,
            shift = {0.015625, -0.09375},
            direction_count = 16,
            y = 42
        },
        idle_with_cargo = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear.png",
            priority = "high",
            line_length = 16,
            width = 41,
            height = 42,
            frame_count = 1,
            shift = {0.015625, -0.09375},
            direction_count = 16
        },
        in_motion = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear.png",
            priority = "high",
            line_length = 16,
            width = 41,
            height = 42,
            frame_count = 1,
            shift = {0.015625, -0.09375},
            direction_count = 16,
            y = 126
        },
        in_motion_with_cargo = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear.png",
            priority = "high",
            line_length = 16,
            width = 41,
            height = 42,
            frame_count = 1,
            shift = {0.015625, -0.09375},
            direction_count = 16,
            y = 84
        },
        shadow_idle = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear-shadow.png",
            priority = "high",
            line_length = 16,
            width = 59,
            height = 23,
            frame_count = 1,
            shift = {0.96875, 0.609375},
            direction_count = 16,
            y = 23
        },
        shadow_idle_with_cargo = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear-shadow.png",
            priority = "high",
            line_length = 16,
            width = 59,
            height = 23,
            frame_count = 1,
            shift = {0.96875, 0.609375},
            direction_count = 16
        },
        shadow_in_motion = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear-shadow.png",
            priority = "high",
            line_length = 16,
            width = 59,
            height = 23,
            frame_count = 1,
            shift = {0.96875, 0.609375},
            direction_count = 16,
            y = 23
        },
        shadow_in_motion_with_cargo = {
            filename = "__KingsNuclearBots__/graphics/entity/logistic-robot/logistic-robot-nuclear-shadow.png",
            priority = "high",
            line_length = 16,
            width = 59,
            height = 23,
            frame_count = 1,
            shift = {0.96875, 0.609375},
            direction_count = 16
        },
        working_sound = data.raw["logistic-robot"]["logistic-robot"].working_sound,
        cargo_centered = {0.0, 0.2},
    },
    -- recipe
    {
        type = "recipe",
        name = "logistic-robot-nuclear",
        enabled = false,
        ingredients =
        {
            {"logistic-robot", 5},
            {"nuclear-reactor", 1},
			{"heat-exchanger", 4},
			{"steam-turbine", 7},
			{"heat-pipe", 25},
            {"uranium-fuel-cell", 1500}
        },
        result = "logistic-robot-nuclear"
    },
    -- item
    {
        type = "item",
        name = "logistic-robot-nuclear",
        icon = "__KingsNuclearBots__/graphics/icons/logistic-robot-nuclear.png",
        icon_size = 32,        
        subgroup = "logistic-network",
        order = "a[robot]-b[logistic-robot]-c[nuclear]",
        place_result = "logistic-robot-nuclear",
        stack_size = 50
    },
})
