require("prototypes.constants")

data.raw["underground-belt"]["express-underground-belt"].max_distance = 11

local stacksize = 50

if settings.startup["ore_stacks_200"].value then
	stacksize = 200
elseif settings.startup["ore_stacks_100"].value then
	stacksize = 100
end

data.raw.item["iron-ore"].stack_size = stacksize
data.raw.item["copper-ore"].stack_size = stacksize
data.raw.item["stone"].stack_size = stacksize
data.raw.item["uranium-ore"].stack_size = stacksize
data.raw.item["coal"].stack_size = stacksize

--make biters tougher
data.raw["unit-spawner"]["biter-spawner"].result_units[2] = { "medium-biter", {{0.2,0}, {0.6,0.3}, {0.7,0.1}, {.99,0}} }
data.raw["unit-spawner"]["biter-spawner"].result_units[3] = { "big-biter", {{0.5,0}, {.99,0}} }
data.raw["unit-spawner"]["biter-spawner"].result_units[4] = { "behemoth-biter", {{0.9,0}, {.99,1}} }
data.raw["unit-spawner"]["biter-spawner"].spawning_cooldown = spawn_cooldowns
data.raw["unit-spawner"]["biter-spawner"].pollution_absorption_absolute = 1600
data.raw["unit-spawner"]["biter-spawner"].max_count_of_owned_units = max_bugs_per_spawner
data.raw["unit-spawner"]["biter-spawner"].max_friends_around_to_spawn = max_bugs_per_spawner

data.raw["unit-spawner"]["spitter-spawner"].result_units[3] = { "medium-spitter", {{0.4,0}, {0.7,0.3}, {0.9,0.1}, {.99,0}} }
data.raw["unit-spawner"]["spitter-spawner"].result_units[4] = { "big-spitter", {{0.5,0}, {.99,0}} }
data.raw["unit-spawner"]["spitter-spawner"].result_units[5] = { "behemoth-spitter", {{0.9,0}, {.99,1}} }
data.raw["unit-spawner"]["spitter-spawner"].spawning_cooldown = spawn_cooldowns
data.raw["unit-spawner"]["spitter-spawner"].pollution_absorption_absolute = 800
data.raw["unit-spawner"]["spitter-spawner"].max_count_of_owned_units = max_bugs_per_spawner
data.raw["unit-spawner"]["spitter-spawner"].max_friends_around_to_spawn = max_bugs_per_spawner

local movespeed = 1
--Since I can't make more biters, I have to make them bigger and meaner. Lame!
local density_factor = 10
--data.raw.unit["behemoth-biter"].movement_speed = movespeed
--data.raw.unit["behemoth-biter"].distance_per_frame = movespeed + .08
data.raw.unit["behemoth-biter"].ai_settings.do_separation = false
--data.raw.unit["behemoth-biter"].ai_settings.path_resolution_modifier = -4
data.raw.unit["behemoth-biter"].dying_explosion = nil
data.raw.unit["behemoth-biter"].max_health = 3000 * density_factor
data.raw.unit["behemoth-biter"].pollution_to_join_attack = 400 * density_factor
data.raw.unit["behemoth-biter"].attack_parameters.ammo_type.action.action_delivery.target_effects.damage.amount = 90 * density_factor

--Increasing this breaks pathing.
--data.raw.unit["behemoth-spitter"].movement_speed = movespeed
--data.raw.unit["behemoth-spitter"].distance_per_frame = movespeed + .08
data.raw.unit["behemoth-spitter"].ai_settings.do_separation = false
--Higher value = lots more CPU use (and more path waypoints?); low values don't help.
--data.raw.unit["behemoth-spitter"].ai_settings.path_resolution_modifier = -4
data.raw.unit["behemoth-spitter"].dying_explosion = nil
data.raw.unit["behemoth-spitter"].max_health = 1500 * density_factor
data.raw.unit["behemoth-spitter"].pollution_to_join_attack = 400 * density_factor
data.raw.unit["behemoth-spitter"].attack_parameters.damage_modifier = 60 * density_factor
data.raw.fire["acid-splash-fire-spitter-behemoth"].on_damage_tick_effect.action_delivery.target_effects[2].damage.amount = 1 * density_factor