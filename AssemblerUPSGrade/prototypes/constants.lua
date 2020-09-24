DEBUG = false

--Number of beacons around a standard building.
beacon_count = 12

NEED_FLUID_RECIPES = { "bc-asif", "spd-3-asif", "prod-3-asif", "pla-asif", "rf-asif", "sfpg-asif", "sflo-asif", "sfho-asif", "rcu-asif" }

TECH_DETAILS = {
	["gc-asif"] = { cost = 250000, prereqs = {"asif"} },
	["rc-asif"] = { cost = 500000, prereqs = {"gc-asif"} },
	["bc-asif"] = { cost = 1000000, prereqs = {"rc-asif"} },
	["lds-asif"] = { cost = 500000, prereqs = {"asif"} },
	["eng-asif"] = { cost = 500000, prereqs = {"asif"} },
	["pla-asif"] = { cost = 500000, prereqs = {"asif"} },
	--RF is handled on its own since it unlocks multiple recipes.
	--["rf-asif"] = { cost = 500000, prereqs = {"asif"} },
	["rcu-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	["spd-3-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
	["prod-3-asif"] = { cost = 1000000, prereqs = {"bc-asif"} },
}

ITEM_LIST = {
	["gc-asif"] = "electronic-circuit",
	["rc-asif"] = "advanced-circuit",
	["bc-asif"] = "processing-unit",
	["lds-asif"] = "low-density-structure",
	["eng-asif"] = "engine-unit",
	["pla-asif"] = "plastic-bar",
	["rf-asif"] = "rocket-fuel",
	["sfpg-asif"] = "solid-fuel-from-petroleum-gas",
	["sflo-asif"] = "solid-fuel-from-light-oil",
	["sfho-asif"] = "solid-fuel-from-heavy-oil",
	["rcu-asif"] = "rocket-control-unit",
	["spd-3-asif"] = "speed-module-3",
	["prod-3-asif"] = "productivity-module-3",
}
base_recipes = {"copper-plate", "iron-plate", "steel-plate", "plastic-bar", "sulfuric-acid", "solid-fuel", "light-oil"}
plastic_base_recipes = {"coal", "petroleum-gas", "light-oil", "heavy-oil" }

ORDER_MAP = {
	["gc-asif"] = "a",
	["rc-asif"] = "b",
	["bc-asif"] = "c",
	["lds-asif"] = "e",
	["eng-asif"] = "d",
	["pla-asif"] = "f",
	["rf-asif"] = "h",
	["sfpg-asif"] = "g2",
	["sflo-asif"] = "g1",
	["sfho-asif"] = "g3",
	["rcu-asif"] = "i",
	["spd-3-asif"] = "z1",
	["prod-3-asif"] = "z2",
}

--//modules (level 3)
local spd_module_speed_bonus = data.raw.module["speed-module-3"].effect.speed.bonus
local spd_module_pwr_penality = data.raw.module["speed-module-3"].effect.consumption.bonus
local prod_mod_speed_penalty = data.raw.module["productivity-module-3"].effect.speed.bonus
prod_mod_prod_bonus = data.raw.module["productivity-module-3"].effect.productivity.bonus
local prod_mod_pwr_penality = data.raw.module["productivity-module-3"].effect.consumption.bonus
prod_mod_pollution_penalty = data.raw.module["productivity-module-3"].effect.pollution.bonus

--//Beacon
tmp = string.gsub(data.raw["beacon"]["beacon"].energy_usage,"%kW","")
beacon_pwr_drain = tonumber(tmp)

beacon_pwr_penalty = spd_module_pwr_penality * beacon_count
total_beacon_speed_bonus = spd_module_speed_bonus * beacon_count

--//Assembler (refers to vanilla object)
base_ass_entity = data.raw["assembling-machine"]["assembling-machine-3"]
local tmp = string.gsub(base_ass_entity.energy_usage,"%kW","")
assembler_base_pwr_use = tonumber(tmp)
assembler_base_speed = base_ass_entity.crafting_speed
assembler_base_pollution = base_ass_entity.energy_source.emissions_per_minute
assembler_base_modules = base_ass_entity.module_specification.module_slots

local assembler_modules_speed_effect = assembler_base_modules * prod_mod_speed_penalty
local assembler_modules_pwr_penalty = assembler_base_modules * prod_mod_pwr_penality
assembler_productivity_factor = assembler_base_modules * prod_mod_prod_bonus

assembler_total_speed_bonus = assembler_base_speed * (assembler_modules_speed_effect + total_beacon_speed_bonus + 1)
assembler_per_unit_pwr_drain_penalty = (beacon_pwr_penalty + assembler_modules_pwr_penalty + 1)
--Note: value DOES NOT include power drain from beacons (IE the 320Kw the beacon itself uses). This is to be done in the
-- entity function itself.
assembler_total_pwr_draw = assembler_base_pwr_use * assembler_per_unit_pwr_drain_penalty


--//Chem plant (refers to vanilla object)
base_chem_entity = data.raw["assembling-machine"]["chemical-plant"]
local tmp = string.gsub(base_chem_entity.energy_usage,"%kW","")
chem_base_pwr_use = tonumber(tmp)
chem_base_speed = base_chem_entity.crafting_speed
chem_base_pollution = base_chem_entity.energy_source.emissions_per_minute
chem_base_modules = base_chem_entity.module_specification.module_slots

local chem_modules_speed_effect = chem_base_modules * prod_mod_speed_penalty
local chem_modules_pwr_penalty = chem_base_modules * prod_mod_pwr_penality
chem_productivity_factor = chem_base_modules * prod_mod_prod_bonus

chem_total_speed_bonus = chem_base_speed * (chem_modules_speed_effect + total_beacon_speed_bonus + 1)
chem_per_unit_pwr_drain_penalty = (beacon_pwr_penalty + chem_modules_pwr_penalty + 1)
chem_total_pwr_draw = chem_base_pwr_use * chem_per_unit_pwr_drain_penalty

--///
--Reminder: Crafting speed formula is:
--final speed = Recipe time / (assembler speed * (beacon_effect + module_spd_effect + 1)
--final speed is the number of seconds it takes to craft one item, so to get items/second,
-- you need to divide 1 by it. IE: 1/final speed = items per second.
--Note: Productivity modules also cause additional items to be produced, so remember to
-- factor in that effect as well. IE: Items per second = ProdModBonus * 1/final_speed
--///

--///
--Color, tint, and graphics section
--///

GRAPHICS_MAP = {
	["gc-asif"] = {icon = "gc-asif.png", tint = {r= .2, g = .6, b = .01, a = 1}},
	["rc-asif"] = {icon = "rc-asif.png", tint = {r= .78, g = .01, b = .01, a = 1}},
	["bc-asif"] = {icon = "bc-asif.png", tint = {r= .2, g = .13, b = .72, a = 1}},
	["lds-asif"] = {icon = "lds-asif.png", tint = {r= .88, g = .75, b = 0.5, a = 1}},
	["eng-asif"] = {icon = "eng-asif.png", tint = {r= .49, g = .35, b = .31, a = 1}},
	["pla-asif"] = {icon = "pla-asif.png", tint = data.raw.recipe["plastic-bar"].crafting_machine_tint},
	["rf-asif"] = {icon = "rf-asif.png", tint = {r= .8, g = .65, b = .11, a = 1}},
	["sfpg-asif"] = {icon = "sfpg-asif.png", tint = data.raw.recipe["solid-fuel-from-petroleum-gas"].crafting_machine_tint},
	["sflo-asif"] = {icon = "sflo-asif.png", tint = data.raw.recipe["solid-fuel-from-light-oil"].crafting_machine_tint},
	["sfho-asif"] = {icon = "sfho-asif.png", tint = data.raw.recipe["solid-fuel-from-heavy-oil"].crafting_machine_tint},
	["rcu-asif"] = {icon = "rcu-asif.png", tint = {r= 1, g = 1, b = 1, a = 1}},
	["prod-3-asif"] = {icon = "prod-3-asif.png", tint = {r= 240, g = 66, b = 19, a = 255}},
	["spd-3-asif"] = {icon = "spd-3-asif.png", tint = {r= .25, g = .93, b = .92, a = 1}},
}

recipe_tint = {r= 1, g = .533, b = 0, a = 1}
