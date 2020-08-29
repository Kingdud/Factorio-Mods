--//////////////////////////////////
--Basic miner stats, no modules, no beacons
--//////////////////////////////////
local miner_density_setting = settings.startup["miner-compression-ratio"].value
miners_in_miner = miner_density_setting
local tmp = string.gsub(data.raw["mining-drill"]["electric-mining-drill"].energy_usage,"%kW","")
local miner_base_pwr_use = tonumber(tmp)
local miner_base_speed = data.raw["mining-drill"]["electric-mining-drill"].mining_speed
local miner_base_pollution = data.raw["mining-drill"]["electric-mining-drill"].energy_source.emissions_per_minute
tmp = string.gsub(data.raw["beacon"]["beacon"].energy_usage,"%kW","")
local beacon_pwr_use = tonumber(tmp)
local modules = 3

--//////////////////////////////////
--Module stats
--//////////////////////////////////
local spd_module_speed_bonus = data.raw.module["speed-module-3"].effect.speed.bonus
local spd_module_pwr_penality = data.raw.module["speed-module-3"].effect.consumption.bonus
local prod_mod_speed_penalty = data.raw.module["productivity-module-3"].effect.speed.bonus
--local prod_mod_prod_bonus
local prod_mod_pwr_penality = data.raw.module["productivity-module-3"].effect.consumption.bonus
local prod_mod_pollution_penalty = data.raw.module["productivity-module-3"].effect.pollution.bonus

--At this point, we know how much power our group of replaced miners would draw.

--//////////////////////////////////
--Basic miner stats, with modules and beacons
--//////////////////////////////////
--We assume you could get 8 beacons around miners
local base_miner_beacon_count = 8

--Total number of beacons around 25 normal miners
local buffed_beacon_count = base_miner_beacon_count + ((base_miner_beacon_count/2) * (miners_in_miner-1))

local vanilla_beacon_pwr_bonus = spd_module_pwr_penality * base_miner_beacon_count + 1

--Mining speed and power use of a single miner with beacons
local buffed_base_miner_speed = (base_miner_beacon_count * spd_module_speed_bonus + 1) * miner_base_speed
--For pollution it's <base pollution> * <speed bonus> * <pollution bonus>
local sum_energy_modifiers = spd_module_pwr_penality * base_miner_beacon_count + prod_mod_pwr_penality * modules + 1
local buffed_pollution_value = miner_base_pollution * (sum_energy_modifiers * (prod_mod_pollution_penalty * modules + 1)) * miners_in_miner

--Now we know how fast each of the replaced miners would be able to mine, how much power they would consume,
-- and how much energy the beacons to do that would take.

--//////////////////////////////////
--New miner info
--//////////////////////////////////
newTint = {r= .8, g = .2, b = .2, a = 1}

width = 8.49
length = 8.49
--math assumes item is square
-- Compute how many beacons go around the new building
local beacons = ((math.ceil(width + length) + 4 + 3) / 3) * 4
new_resource_searching_radius = width + 2 + 3

--These are the bonuses that will be applied to the new building
local new_bld_speed_bonus = .5 * beacons + 1
local new_bld_sum_energy_mods = .7 * beacons + .8 * modules + 1
local new_bld_pollution_bonus = new_bld_sum_energy_mods * (.1 * modules + 1)

--We now figure out what the speed of the replacement miner should be from the ratio between the
-- speed of X old miners fully buffed and the new building.
--We need to add 5% to the result for reasons unknown.
replacement_miner_speed = ((buffed_base_miner_speed * miners_in_miner) / new_bld_speed_bonus)

--To compute power draw of new miner:
--1. Compute the energy use of the power draw of the beacons + miners for vanilla
local vanilla_miner_power_pre_beacon = miner_base_pwr_use * miners_in_miner
local vanilla_beacon_pwr_drain = beacon_pwr_use * buffed_beacon_count
local vanilla_power_draw = vanilla_miner_power_pre_beacon * vanilla_beacon_pwr_bonus + vanilla_beacon_pwr_drain
--2. Compute the energy use of the beacons around the new building and the power bonus from that.
local new_bld_pwr_bonus = .7 * beacons + 1
local new_bld_beacon_power_draw = beacons * beacon_pwr_use
--3. Solve for X (X * new_bld_pwr_bonus + new_bld_beacon_power_draw = vanilla_power_draw)
--And people ask when they'll use algebra while in school. psh. I use that shit all the time!
replacement_miner_power = (vanilla_power_draw - new_bld_beacon_power_draw) / new_bld_pwr_bonus
--Why? Because We want to end up with the same total power usage (after beacons + miners) as we would with the vanilla buildings.

replacement_pollution_value = buffed_pollution_value / new_bld_pollution_bonus

--//////////////////////////////////
--Recipe info
--//////////////////////////////////
r_beacons = buffed_beacon_count - beacons
if r_beacons <= 0 then
	r_beacons = 1
end
r_speed_mods = r_beacons * 2
r_prod_mods = (miners_in_miner-1) * 3
r_belts = miners_in_miner * 4