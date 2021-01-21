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
local modules = 0
local internal_modules = 3

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
--# of beacons that would be around 25 actual miners.
local buffed_beacon_count = base_miner_beacon_count + math.ceil((base_miner_beacon_count/2) * miners_in_miner)

local vanilla_beacon_pwr_bonus = spd_module_pwr_penality * base_miner_beacon_count + internal_modules * (spd_module_pwr_penality + prod_mod_pwr_penality) + 1

--Mining speed and power use of a single miner with beacons
--We give the buffed building both 3 speed and 3 prod mods internally, but disallow it to benefit from beacons.
--We can't *only* disallow beacons, so this is our one 'hack' that makes this better than a normal miner, since, out of the box, it's flat out better than 25 beaconed miners. Sadface
local buffed_base_miner_speed = (base_miner_beacon_count * spd_module_speed_bonus + internal_modules * (spd_module_speed_bonus + prod_mod_speed_penalty) +  1) * miner_base_speed
--Drain vs draw: drain is always happening, draw is only when the building is 'active' (mining)
local buffed_energy_draw = miner_base_pwr_use * vanilla_beacon_pwr_bonus
local total_energy_drain = buffed_beacon_count * beacon_pwr_use

--For pollution it's <base pollution> * <speed bonus> * <pollution bonus>
local total_pollution_value = miner_base_pollution * (vanilla_beacon_pwr_bonus + internal_modules * prod_mod_pollution_penalty) * miners_in_miner

--Now we know how fast each of the replaced miners would be able to mine, how much power they would consume,
-- and how much energy the beacons to do that would take.

--//////////////////////////////////
--New miner info
--//////////////////////////////////
newTint = {r= .8, g = .2, b = .2, a = 1}

--At 25:1 new miner should have (no modules):
-- 62.5 mining speed
-- 1650/m pollution
-- 14850 kw power use + 49920 kw drain

width = 8.49
length = 8.49
--math assumes item is square
new_resource_searching_radius = width + 2 + 3

replacement_miner_speed = buffed_base_miner_speed * miners_in_miner

replacement_miner_drain = total_energy_drain
replacement_miner_power = buffed_energy_draw * miners_in_miner

replacement_pollution_value = total_pollution_value

--//////////////////////////////////
--Recipe info
--//////////////////////////////////
r_beacons = buffed_beacon_count
if r_beacons <= 0 then
	r_beacons = 1
end
r_speed_mods = r_beacons * 2
r_prod_mods = (miners_in_miner-1) * 3
r_belts = miners_in_miner * 4

--//////////////////////////////////
--Graphics data
--//////////////////////////////////
--Recreate with: for file in *; do echo -n "[\"$file\"] = {"; file $file | awk -F, '{print $2}' | awk -Fx '{print $1","$2"},"}'; done
-- NEW_GRAPHICS = {
	-- ["base_path"] = "__base__/graphics/entity/electric-mining-drill",
	-- ["electric-mining-drill-E.png"] = { 840 , 784},
	-- ["electric-mining-drill-E-drill-received-shadow.png"] = { 816 , 784},
	-- ["electric-mining-drill-E-drill-shadow.png"] = { 880 , 776},
	-- ["electric-mining-drill-E-fluid-background.png"] = { 42 , 70},
	-- ["electric-mining-drill-E-fluid-flow.png"] = { 41 , 70},
	-- ["electric-mining-drill-E-patch.png"] = { 100 , 110},
	-- ["electric-mining-drill-E-patch-shadow.png"] = { 112 , 98},
	-- ["electric-mining-drill-E-window-background.png"] = { 51 , 74},
	-- ["electric-mining-drill-N.png"] = { 784 , 904},
	-- ["electric-mining-drill-N-drill-received-shadow.png"] = { 800 , 816},
	-- ["electric-mining-drill-N-drill-shadow.png"] = { 808 , 888},
	-- ["electric-mining-drill-N-fluid-background.png"] = { 70 , 48},
	-- ["electric-mining-drill-N-fluid-flow.png"] = { 68 , 50},
	-- ["electric-mining-drill-N-patch.png"] = { 100 , 111},
	-- ["electric-mining-drill-N-patch-shadow.png"] = { 110 , 98},
	-- ["electric-mining-drill-N-window-background.png"] = { 72 , 54},
	-- ["electric-mining-drill-radius-visualization.png"] = { 12 , 12},
	-- ["electric-mining-drill-S.png"] = { 784 , 872},
	-- ["electric-mining-drill-S-drill-received-shadow.png"] = { 800 , 784},
	-- ["electric-mining-drill-S-drill-shadow.png"] = { 800 , 824},
	-- ["electric-mining-drill-S-fluid-background.png"] = { 70 , 40},
	-- ["electric-mining-drill-S-fluid-flow.png"] = { 68 , 40},
	-- ["electric-mining-drill-S-patch.png"] = { 100 , 113},
	-- ["electric-mining-drill-S-patch-shadow.png"] = { 110 , 98},
	-- ["electric-mining-drill-S-window-background.png"] = { 71 , 44},
	-- ["electric-mining-drill-W.png"] = { 840 , 784},
	-- ["electric-mining-drill-W-drill-received-shadow.png"] = { 768 , 792},
	-- ["electric-mining-drill-W-drill-shadow.png"] = { 912 , 776},
	-- ["electric-mining-drill-W-fluid-background.png"] = { 42 , 69},
	-- ["electric-mining-drill-W-fluid-flow.png"] = { 42 , 70},
	-- ["electric-mining-drill-W-patch.png"] = { 100 , 108},
	-- ["electric-mining-drill-W-patch-shadow.png"] = { 110 , 98},
	-- ["electric-mining-drill-W-window-background.png"] = { 41 , 69},
	-- ["hr-electric-mining-drill-E.png"] = { 1688 , 1576},
	-- ["hr-electric-mining-drill-E-drill-received-shadow.png"] = { 1632 , 1672},
	-- ["hr-electric-mining-drill-E-drill-shadow.png"] = { 1768 , 1560},
	-- ["hr-electric-mining-drill-E-fluid-background.png"] = { 84 , 138},
	-- ["hr-electric-mining-drill-E-fluid-flow.png"] = { 82 , 139},
	-- ["hr-electric-mining-drill-E-patch.png"] = { 200 , 219},
	-- ["hr-electric-mining-drill-E-patch-shadow.png"] = { 224 , 198},
	-- ["hr-electric-mining-drill-E-window-background.png"] = { 104 , 147},
	-- ["hr-electric-mining-drill-N.png"] = { 1568 , 1808},
	-- ["hr-electric-mining-drill-N-drill-received-shadow.png"] = { 1632 , 1648},
	-- ["hr-electric-mining-drill-N-drill-shadow.png"] = { 1608 , 1784},
	-- ["hr-electric-mining-drill-N-fluid-background.png"] = { 138 , 94},
	-- ["hr-electric-mining-drill-N-fluid-flow.png"] = { 136 , 99},
	-- ["hr-electric-mining-drill-N-patch.png"] = { 200 , 222},
	-- ["hr-electric-mining-drill-N-patch-shadow.png"] = { 220 , 197},
	-- ["hr-electric-mining-drill-N-window-background.png"] = { 142 , 107},
	-- ["hr-electric-mining-drill-S.png"] = { 1568 , 1752},
	-- ["hr-electric-mining-drill-S-drill-received-shadow.png"] = { 1632 , 1632},
	-- ["hr-electric-mining-drill-S-drill-shadow.png"] = { 1600 , 1648},
	-- ["hr-electric-mining-drill-S-fluid-background.png"] = { 138 , 80},
	-- ["hr-electric-mining-drill-S-fluid-flow.png"] = { 136 , 80},
	-- ["hr-electric-mining-drill-S-patch.png"] = { 200 , 226},
	-- ["hr-electric-mining-drill-S-patch-shadow.png"] = { 220 , 197},
	-- ["hr-electric-mining-drill-S-window-background.png"] = { 141 , 86},
	-- ["hr-electric-mining-drill-W.png"] = { 1688 , 1576},
	-- ["hr-electric-mining-drill-W-drill-received-shadow.png"] = { 1584 , 1648},
	-- ["hr-electric-mining-drill-W-drill-shadow.png"] = { 1832 , 1560},
	-- ["hr-electric-mining-drill-W-fluid-background.png"] = { 83 , 137},
	-- ["hr-electric-mining-drill-W-fluid-flow.png"] = { 83 , 140},
	-- ["hr-electric-mining-drill-W-patch.png"] = { 200 , 220},
	-- ["hr-electric-mining-drill-W-patch-shadow.png"] = { 220 , 197},
	-- ["hr-electric-mining-drill-W-window-background.png"] = { 80 , 137},
-- }

-- function split(s, sep)
    -- local fields = {}
    
    -- local sep = sep or " "
    -- local pattern = string.format("([^%s]+)", sep)
    -- string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)
    
    -- return fields
-- end