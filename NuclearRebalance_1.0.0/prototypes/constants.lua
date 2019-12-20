--///////////////////////////////////////////
--Constants section
--///////////////////////////////////////////
--Base game says: 1 unit of U-235 is:
-- In a uranium-fuel-cell, 80GJ.
-- In Nuclear Fuel 1.21GJ (...so, clearly this is just a Back to the Future reference)
--Reality says:
-- 1 kg of U-235 has 80 TJ of energy.
--Thus, 80GJ/unit = 80000GJ/kg * x ==> 80 / 80000 = .001 kg per unit ==> 1 unit in factorio is 1 gram of U-235.
--We use this assumption to scale all of our nuclear fuel recipes.
--This calculation can't be perfect because you'd need to simulate the entire chain, from uranium to lead,
-- and the energies of every fission event in between, to accurately determine how much energy a unit of
-- u235 has. Instead, we will use burnup rates and the ~80TJ/kg fission energy of U235 to scale our fuel.

---Update: We are going to say that 1 unit in game is 1kg, instead of 1 gram, because it makes more sense in terms of
-- the amount of uranium available on most maps. In the mod FAQ we will explain our choice and how the devs may/may not
-- be incorrect with their values for base-game nuclear.
SCALE_FACTOR = 1 --set to 1000 for grams instead of kg
u235_gj_per_kg = 79390 / SCALE_FACTOR
u238_gj_per_kg_thermal = 1684.2 / SCALE_FACTOR
--In a fast reactor, u238 becomes pu239 or pu241. Both of these yield slightly more fission energy (around 1% more)
-- than straight u235.
u238_gj_per_kg_fast = 80620 / SCALE_FACTOR
msr_gj_per_thorium_kg = 79420 / SCALE_FACTOR

--||||||||||||||||||||||||
--LWR constants
--||||||||||||||||||||||||
--In total, a LWR, at 500MWe scale, should need around 50 tons (metric? we assume so) of
-- enriched uranium in the core. 50 tons, in factorio terms (see i-fuels.lua) ends up being
-- around 50,000,000 units of refined uranium (either u238 or u235).
lwr_fuel_load_kg_per_gwe = 100000 * SCALE_FACTOR --total fuel inventory, not just fissile.
lwr_total_enriched_uranium_per_core = lwr_fuel_load_kg_per_gwe * .5
--should be 22500
lwr_total_rods = 225
--Should be 155
lwr_rods_per_bundle = 1
lwr_bundles_per_core = math.ceil(lwr_total_rods / lwr_rods_per_bundle)
lwr_u235_pct = 3 / 100
lwr_u238_pct = 1 - lwr_u235_pct

--Burnup is the total amount of fuel in that actually gets consumed before refueling.
lwr_burnup_pct = 3 / 100

--The breeding ratio determines how much u238 gets consumed for every unit of u235 consumed.
-- 50pct would be 2 units of u235 for every unit of 238.
--lwr_breeding_pct = 60 / 100
--Not used because we don't actually need to worry about breeding.

--Amount of plutonium in spent fuel that gets rolled into the reprocessed rod.
--For balance reasons, we don't allow plutonium slavaging until LMR/MSR.
--lwr_plutonium_reprocessing_pct = 1 / 100
lwr_plutonium_reprocessing_pct = 0

--||||||||||||||||||||||||
--LMR constants
--||||||||||||||||||||||||
lmr_power_output_gw = 1

--Fast reactors require ~20% enrichment in order to operate.
lmr_u235_pct = 20 / 100
lmr_u238_pct = 1 - lmr_u235_pct

--fuel load = fissile content * fraction of core that's fissile.
--15 tons of fuel per gigawatt (fissile load only, IE, u235 content only)
lmr_fissile_load_kg_per_gwe = 15000 * SCALE_FACTOR * (1 / lmr_u235_pct) --Note, this is fissile only, unlike for LWR where it's all fuel.
lmr_rods_per_core = 155

lmr_burnup_pct = 15 / 100

local lmr_total_fuel_needed = lmr_power_output_gw * lmr_fissile_load_kg_per_gwe

--||||||||||||||||||||||||
--MSR constants
--||||||||||||||||||||||||
--Ok, look, molten salt reactors are super new. It's hard to find concrete numbers. I pulled these 
-- out of my ass. I tried. I really tried, but...I can't find decent sources.
msr_u235_pct = 30 / 100
msr_u238_pct = 1 - msr_u235_pct
--We just assume there's a certain amount of thorium in stone. It's not that far off reality...
-- If we choose to refine stone somehow later, whatever. The ratio shouldn't change much.
--msr_thorium_pct = 1 - msr_u238_pct - msr_u235_pct

--From a physics standpoint, I don't see why nearly 100% burnup would be impossible. You just have
-- to solve the chemsitry problems to do it.
msr_burnup_pct = 99 / 100

--MSRs are also special in that they only need a fissile fuel load to start. Since this reactor is a
-- breeder reactor, it will only ever need u238 as fuel.

msr_target_power_output_gw = 1.5
msr_fuel_load_kg_per_gwe = 400 * SCALE_FACTOR * (1 / msr_u235_pct)
local msr_total_fuel_needed = msr_fuel_load_kg_per_gwe * msr_target_power_output_gw
msr_reactor_segments = 1
msr_salt_per_segment = 20




--///////////////////////////////////////////
--Recipe relevant section
--///////////////////////////////////////////


--||||||||||||||||||||||||
--LWR
--||||||||||||||||||||||||
lwr_recipe_u235 = math.floor(lwr_total_enriched_uranium_per_core / lwr_total_rods * lwr_u235_pct)
lwr_recipe_u238 = math.floor(lwr_total_enriched_uranium_per_core / lwr_total_rods * lwr_u238_pct)

--For those confused: a fuel rod/bundle contains *far* more than the 31TJ displayed in game. Rather,
-- the number shown is the *extractable* power (before plant efficiency) from all that uranium.
-- Thus, to refuel, you need only resupply the 31TJ worth of uranium that got burned up!
local total_fuel_in_assembly = (lwr_recipe_u235 + lwr_recipe_u238) * lwr_rods_per_bundle * lwr_burnup_pct
local plutonium_carryover = lwr_recipe_u235 * lwr_plutonium_reprocessing_pct

--In a LWR the u235 and u238 are burned at approximately the same rate. If plutonium could be recovered, it would
-- reduce the amount of new u235 needed.
lwr_reprocessing_u235_needed = math.ceil((total_fuel_in_assembly - plutonium_carryover)/2)
lwr_reprocessing_u238_needed = math.ceil(total_fuel_in_assembly - plutonium_carryover - lwr_reprocessing_u235_needed)

--||||||||||||||||||||||||
--LMR
--||||||||||||||||||||||||
lmr_u235_per_rod = math.ceil((lmr_total_fuel_needed * lmr_u235_pct)/lmr_rods_per_core)
lmr_u238_per_rod = math.ceil((lmr_total_fuel_needed * lmr_u238_pct)/lmr_rods_per_core)

--The LMR is a breeder reactor, meaning it shouldn't need any u235 at all once online. We include a single unit in 
-- refueling to make MSRs seem like an upgrade (maybet he reprocessing tech isn't perfect yet) and also to simulate
-- the reality that some decay would happen while the reactor was shut down for refueling, so a tiny amount of makeup
-- fissile fuel is reasonable.
lmr_reprocessing_u235_needed = 1
lmr_reprocessing_u238_needed = math.ceil((lmr_u238_per_rod + lmr_u235_per_rod) * lmr_burnup_pct - lmr_reprocessing_u235_needed)

--||||||||||||||||||||||||
--MSR
--||||||||||||||||||||||||
msr_inital_u235_inventory = math.ceil(msr_total_fuel_needed * msr_u235_pct / (msr_reactor_segments * msr_salt_per_segment))
msr_inital_u238_inventory = math.ceil(msr_total_fuel_needed * msr_u238_pct / (msr_reactor_segments * msr_salt_per_segment))
--No reprocessing needed, done online, no special fuel for MSR.

--///////////////////////////////////////////
--Item relevant section
--///////////////////////////////////////////

--||||||||||||||||||||||||
--LWR
--||||||||||||||||||||||||
lwr_u235_energy_portion_gj = math.ceil(lwr_recipe_u235 * lwr_rods_per_bundle * u235_gj_per_kg)
lwr_u238_energy_portion_gj = math.ceil(lwr_recipe_u238 * lwr_rods_per_bundle * u238_gj_per_kg_thermal)
lwr_fuel_energy = math.ceil((lwr_u235_energy_portion_gj + lwr_u238_energy_portion_gj) * lwr_burnup_pct)

--||||||||||||||||||||||||
--LMR
--||||||||||||||||||||||||
lmr_u235_energy_portion_gj = math.ceil(lmr_u235_per_rod * u235_gj_per_kg)
lmr_u238_energy_portion_gj = math.ceil(lmr_u238_per_rod * u238_gj_per_kg_fast)

--Equations for a one rod
lmr_fuel_energy_per_rod = math.ceil((lmr_u235_energy_portion_gj + lmr_u238_energy_portion_gj) * lmr_burnup_pct)
--Equations for a whole core
lmr_fuel_energy_per_core = math.ceil((lmr_u235_energy_portion_gj + lmr_u238_energy_portion_gj) * lmr_rods_per_core * lmr_burnup_pct)