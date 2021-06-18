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