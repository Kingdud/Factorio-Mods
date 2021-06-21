require("prototypes.constants")

script.on_configuration_changed(function()
	--Group gathering time is random between min and max.
	game.map_settings.unit_group.max_group_gathering_time = spawn_cooldowns[1] * max_bug_groups_per_atk_wave + 600
	game.map_settings.unit_group.min_group_gathering_time = spawn_cooldowns[1] * max_bug_groups_per_atk_wave + 60
	game.map_settings.unit_group.max_wait_time_for_late_members = 600
	game.map_settings.unit_group.max_unit_group_size = max_bug_groups_per_atk_wave
	--Increasing this has a dramatic CPU drain
	game.map_settings.unit_group.max_gathering_unit_groups = global_max_bug_groups
	game.map_settings.unit_group.max_member_slowdown_when_ahead = .8
	game.map_settings.unit_group.max_group_slowdown_factor = 1
	game.map_settings.unit_group.max_member_speedup_when_behind = 7

	--game.map_settings.pollution.diffusion_ratio = 0.25
	--game.map_settings.pollution.expected_max_per_chunk = 3200

	game.map_settings.path_finder.long_cache_size = 15000
	game.map_settings.path_finder.max_steps_worked_per_tick  = 10000
	game.map_settings.path_finder.max_work_done_per_tick = 80000
	game.map_settings.path_finder.short_cache_size = 25

	game.map_settings.max_expansion_cooldown = 120
	game.map_settings.min_expansion_cooldown = 60
	game.map_settings.max_expansion_distance = 1
	game.map_settings.settler_group_max_size = 20
	game.map_settings.settler_group_min_size = 5
end)


--This code is all copy-pasted from Invulnerable rails and poles, but adapted to make walls invincible.
local function check_entity(entity, protect)
    local vType = entity.type
    local prototype = game.entity_prototypes[entity.name]
    local flag = false
    --"big-electric-pole-2"
    if (prototype ~= nil) then
        if prototype.name == "stone-wall" then
            flag = true
        end
    end
    if (flag) then
        if (protect == true) then        
            --entity.force = "neutral"
            entity.destructible = false
        else
            --entity.force = "player"
            entity.destructible = true
        end
    end
end

local function on_first_tick()
    local surface = game.surfaces[1]
    for c in surface.get_chunks() do
        for key, entity in pairs(surface.find_entities_filtered({area={{c.x * 32, c.y * 32}, {c.x * 32 + 32, c.y * 32 + 32}}})) do
            check_entity(entity,true)
        end
    end
    --script.on_event(defines.events.on_tick, nil)
end

script.on_event(defines.events.on_built_entity, function(event)
	onBuild(event.created_entity)
end)

script.on_init(on_first_tick)

script.on_event({defines.events.on_built_entity,
                 defines.events.on_robot_built_entity}, function(event)
    check_entity(event.created_entity,true) end)