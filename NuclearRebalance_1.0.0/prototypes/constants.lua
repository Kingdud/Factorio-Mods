--///////////////////////////////////////////
--Constants section
--///////////////////////////////////////////
--In total, a LWR, at 500MWe scale, should need around 50 tons (metric? we assume so) of
-- enriched uranium in the core. 50 tons, in factorio terms (see i-fuels.lua) ends up being
-- around 50,000,000 units of refined uranium (either u238 or u235).
lwr_total_enriched_uranium_per_core = 50000000
lwr_total_rods = 22500
lwr_rods_per_bundle = 155
--lwr_bundles_per_core = math.ceil(lwr_total_rods / lwr_rods_per_bundle)
lwr_u235_pct = 3
lwr_u238_pct = 97

--Base game says: 1 unit of U-235 is:
-- In a uranium-fuel-cell, 80GJ. (Apparently 40% of the energy in the 80GJ comes from the 238 lifecycle)
-- In Nuclear Fuel 1.21GJ (...so, clearly this is just a Back to the Future reference)
--Reality says:
-- 1 kg of U-235 has 80 TJ of energy.
--Thus, 80GJ/unit = 80000GJ/kg * x ==> 80 / 80000 = .001 kg per unit ==> 1 unit in factorio is 1 gram of U-235.
--We use this assumption to scale all of our nuclear fuel recipes.

u235_gj_per_unit = 48
u238_gj_per_unit_thermal = 1.6842
--Near as I can tell, in a fast reactor, U-238 ends up yeilding at least as much energy per unit as 235
-- as long as you have a breeding ratio of 1.0 or higher. The breeding ratio doesn't increase the energy,
-- it just means you no longer need a supply of U235 to keep the reactor on, because you create more
-- fission products than you consume.
u238_gj_per_unit_fast = u235_gj_per_unit

lwr_burnup_pct = 3
lmr_burnup_pct = 15
msr_burnup_pct = 80

--///////////////////////////////////////////
--Recipe relevant section
--///////////////////////////////////////////

lwr_recipe_u235 = math.floor(lwr_total_enriched_uranium_per_core / lwr_total_rods * (lwr_u235_pct/100))
lwr_recipe_u238 = math.floor(lwr_total_enriched_uranium_per_core / lwr_total_rods * (lwr_u238_pct/100))

lwr_u235_reprocessing_result = math.floor(lwr_recipe_u235 * lwr_rods_per_bundle * (lwr_burnup_pct/100))
lwr_u238_reprocessing_result = math.floor(lwr_recipe_u238 * lwr_rods_per_bundle * (lwr_burnup_pct/100))


--///////////////////////////////////////////
--Item relevant section
--///////////////////////////////////////////

lwr_u235_energy_portion_gj = math.ceil(lwr_recipe_u235 * lwr_rods_per_bundle * u235_gj_per_unit)
lwr_u238_energy_portion_gj = math.ceil(lwr_recipe_u238 * lwr_rods_per_bundle * u238_gj_per_unit_thermal)
lwr_fuel_energy = math.ceil((lwr_u235_energy_portion_gj + lwr_u238_energy_portion_gj) * (lwr_burnup_pct/100))
