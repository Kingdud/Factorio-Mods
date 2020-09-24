building_tint = {r= 1, g = .647, b = 0, a = 1}

BEACON_COUNT  = 12
BUILDING_SCALE = 8.33
MAX_OUTPUT_STACK_SIZE = 33
local disable_stack_splitting = true

--Ore->Plate/brick section
ore_batching_factor = 1
local ore_in = settings.startup["smelter-ratio"].value
local plate_out = settings.startup["smelter-ratio"].value

r_ore_in = ore_in * ore_batching_factor
total_outputs_ore = (plate_out * ore_batching_factor) / MAX_OUTPUT_STACK_SIZE
r_output_windows_needed = math.ceil(total_outputs_ore)

if (disable_stack_splitting) then
	r_output_windows_needed = 1
end

--Uranium Ore section
uranium_batching_factor = 1

local ore_in = 10 * settings.startup["centrifuge-ratio"].value
local uranium_out = settings.startup["centrifuge-ratio"].value

r_uranium_in = ore_in * uranium_batching_factor
r_total_uranium_output = uranium_out * uranium_batching_factor

--Kovarex section

kovarex_batching_factor = 1

local u235_in = 40 * settings.startup["centrifuge-ratio"].value
local u238_in = 5 * settings.startup["centrifuge-ratio"].value
local u235_out = 41 * settings.startup["centrifuge-ratio"].value
local u238_out = 2 * settings.startup["centrifuge-ratio"].value

r_u235_in = u235_in * kovarex_batching_factor
r_u238_in = u238_in * kovarex_batching_factor

r_u235_total_output = (u235_out * kovarex_batching_factor) / MAX_OUTPUT_STACK_SIZE
r_u238_total_output = (u238_out * kovarex_batching_factor) / MAX_OUTPUT_STACK_SIZE

uranium_output_windows_needed = math.ceil(r_u235_total_output + r_u238_total_output)
if (disable_stack_splitting) then
	uranium_output_windows_needed = 1
end

--//modules (level 3)
spd_module_speed_bonus = data.raw.module["speed-module-3"].effect.speed.bonus
local spd_module_pwr_penality = data.raw.module["speed-module-3"].effect.consumption.bonus
prod_mod_speed_penalty = data.raw.module["productivity-module-3"].effect.speed.bonus
prod_mod_prod_bonus = data.raw.module["productivity-module-3"].effect.productivity.bonus
local prod_mod_pwr_penality = data.raw.module["productivity-module-3"].effect.consumption.bonus
prod_mod_pollution_penalty = data.raw.module["productivity-module-3"].effect.pollution.bonus

--/////// Beacons
local tmp = string.gsub(data.raw["beacon"]["beacon"].energy_usage,"%kW","")
beacon_pwr_drain = tonumber(tmp)

beacon_pwr_penalty = spd_module_pwr_penality * BEACON_COUNT
total_beacon_speed_bonus = spd_module_speed_bonus * BEACON_COUNT

--//Smelter (refers to vanilla object)
base_smelter_entity = data.raw.furnace["electric-furnace"]
tmp = string.gsub(base_smelter_entity.energy_usage,"%kW","")
smelter_base_pwr_use = tonumber(tmp)
smelter_base_speed = base_smelter_entity.crafting_speed
smelter_base_pollution = base_smelter_entity.energy_source.emissions_per_minute
smelter_base_modules = base_smelter_entity.module_specification.module_slots

local smelter_modules_speed_effect = smelter_base_modules * prod_mod_speed_penalty
local smelter_modules_pwr_penalty = smelter_base_modules * prod_mod_pwr_penality
smelter_productivity_factor = smelter_base_modules * prod_mod_prod_bonus

smelter_total_speed_bonus = smelter_base_speed * (smelter_modules_speed_effect + total_beacon_speed_bonus + 1)
smelter_per_unit_pwr_drain_penalty = (beacon_pwr_penalty + smelter_modules_pwr_penalty + 1)
--Note: value DOES NOT include power drain from beacons (IE the 320Kw the beacon itself uses). This is to be done in the
-- entity function itself.
smelter_total_pwr_draw = smelter_base_pwr_use * smelter_per_unit_pwr_drain_penalty

--//Centrifuge (refers to vanilla object)
base_centrifuge_entity = data.raw["assembling-machine"]["centrifuge"]
local tmp = string.gsub(base_centrifuge_entity.energy_usage,"%kW","")
centrifuge_base_pwr_use = tonumber(tmp)
centrifuge_base_speed = base_centrifuge_entity.crafting_speed
centrifuge_base_pollution = base_centrifuge_entity.energy_source.emissions_per_minute
centrifuge_base_modules = base_centrifuge_entity.module_specification.module_slots

local centrifuge_modules_speed_effect = centrifuge_base_modules * prod_mod_speed_penalty
local centrifuge_modules_pwr_penalty = centrifuge_base_modules * prod_mod_pwr_penality
centrifuge_productivity_factor = centrifuge_base_modules * prod_mod_prod_bonus

centrifuge_total_speed_bonus = centrifuge_base_speed * (centrifuge_modules_speed_effect + total_beacon_speed_bonus + 1)
centrifuge_per_unit_pwr_drain_penalty = (beacon_pwr_penalty + centrifuge_modules_pwr_penalty + 1)
centrifuge_total_pwr_draw = centrifuge_base_pwr_use * centrifuge_per_unit_pwr_drain_penalty