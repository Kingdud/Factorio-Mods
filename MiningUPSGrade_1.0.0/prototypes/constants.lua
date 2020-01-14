--//////////////////////////////////
--Basic miner stats, no modules, no beacons
--//////////////////////////////////
miners_in_miner = 25
local tmp = string.gsub(data.raw["mining-drill"]["electric-mining-drill"].energy_usage,"%kW","")
local miner_base_pwr_use = tonumber(tmp)
local miner_base_speed = data.raw["mining-drill"]["electric-mining-drill"].mining_speed
local miner_base_pollution = data.raw["mining-drill"]["electric-mining-drill"].energy_source.emissions_per_minute
tmp = string.gsub(data.raw["beacon"]["beacon"].energy_usage,"%kW","")
local beacon_pwr_use = tonumber(tmp)
local modules = 3

--At this point, we know how much power our group of replaced miners would draw.

--//////////////////////////////////
--Basic miner stats, with modules and beacons
--//////////////////////////////////
--We assume you could get 8 beacons around miners
local base_miner_beacon_count = 8

--Total number of beacons around 25 normal miners
local buffed_beacon_count = base_miner_beacon_count + ((base_miner_beacon_count/2) * (miners_in_miner-1))
--Power draw of all those beacons
local buffed_beacon_power_draw = beacon_pwr_use * buffed_beacon_count
--Mining speed and power use of a single miner with beacons
local buffed_base_miner_speed = (base_miner_beacon_count * .5 + 1) * miner_base_speed
local buffed_base_miner_power_draw = miner_base_pwr_use * (.7 * base_miner_beacon_count + 1)
--For pollution it's <base pollution> * <speed bonus> * <pollution bonus>
local sum_energy_modifiers = .7 * base_miner_beacon_count + .8 * modules + 1
local buffed_pollution_value = miner_base_pollution * (sum_energy_modifiers * (.1 * modules + 1)) * miners_in_miner

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
local new_bld_pwr_bonus = .7 * beacons + 1
local new_bld_sum_energy_mods = .7 * beacons + .8 * modules + 1
local new_bld_pollution_bonus = new_bld_sum_energy_mods * (.1 * modules + 1)

--At this point we need to figure out what the difference is in power draw for the beacons
-- that would be there anyway, and the beacons that will go around the replacement building.
local new_bld_unbuff_pwr_draw = beacons * beacon_pwr_use

local total_vanilla_power_use = miners_in_miner * buffed_base_miner_power_draw

--We now figure out what the speed of the replacement miner should be from the ratio between the
-- speed of X old miners fully buffed and the new building.
--We need to add 5% to the result for reasons unknown.
replacement_miner_speed = ((buffed_base_miner_speed * miners_in_miner) / new_bld_speed_bonus)

--Now we do the same process with power
replacement_miner_power = (buffed_beacon_power_draw - new_bld_unbuff_pwr_draw) / new_bld_pwr_bonus

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