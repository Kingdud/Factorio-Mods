--We have new types of battery, why not make better satellites that use these better kinds
-- of battery?

--Nimh batteries have more MJ/Kg than lead-acid batteries. Because 1 nimh grid battery has
-- 22x as much capacity as the 100 accumulators it is replacing, we only fit one.
local recipe_nimh_satellite = table.deepcopy(data.raw.recipe["satellite"])
recipe_nimh_satellite.icon = nil
recipe_nimh_satellite.icons = {
	{
		icon = "__base__/graphics/icons/satellite.png",
		tint = {r= 1, g = .647, b = 0, a = 1},
		icon_size = 32
	}
}
recipe_nimh_satellite.ingredients =
{
	--1.0, 'I have this new battery, let's use it instead and simplfy our production chain!'
    {"low-density-structure", 100},
    {"solar-panel", 100},
	{"nimh-grid-battery", 1},
	{"radar", 5},
	{"processing-unit", 100},
    {"rocket-fuel", 50}
}
recipe_nimh_satellite.result = "nimh-satellite"
recipe_nimh_satellite.name = "nimh-satellite"
data:extend({recipe_nimh_satellite})

--li-ion actually has the best energy-density per Kg, even better than flywheels. In reality, this would probably be
-- the top tier innovation for satellites.
local recipe_li_ion_satellite = table.deepcopy(data.raw.recipe["satellite"])
recipe_li_ion_satellite.icon = nil
recipe_li_ion_satellite.icons = {
	{
		icon = "__base__/graphics/icons/satellite.png",
		tint = {r= 1, g = .647, b = .25, a = 1},
		icon_size = 32
	}
}
recipe_li_ion_satellite.ingredients =
{
	--2.0 'I have an even newer battery. Hey, I betcha I can make use of all this extra power I've got...
    {"low-density-structure", 100},
    {"solar-panel", 100},
	{"li-ion-grid-battery", 1},
	{"radar", 50},
	{"processing-unit", 200},
    {"rocket-fuel", 50}
}
recipe_li_ion_satellite.result = "li-ion-satellite"
recipe_li_ion_satellite.name = "li-ion-satellite"
data:extend({recipe_li_ion_satellite})

--And before anyone says 'this isn't realistic!', yes it is. Flywheels have an energy density of .36 to .5 MJ/Kg.
-- Lead acid batteries (what accumulators use) are 0.17 MJ/Kg. So not only do we have more capacity and charge/discharge
-- but we also are lighter, overall, in spite of being bigger! And mass is God when it comes to rockets!
local recipe_flywheel_satellite = table.deepcopy(data.raw.recipe["satellite"])
recipe_flywheel_satellite.icon = nil
recipe_flywheel_satellite.icons = {
	{
		icon = "__base__/graphics/icons/satellite.png",
		tint = {r= .5, g = .647, b = .5, a = 1},
		icon_size = 32
	}
}
recipe_flywheel_satellite.ingredients =
{
	--3.0, 'I have this hugely dense battery, and these great generators. Let's make a deep space probe!'
    {"low-density-structure", 100},
    {"fusion-reactor-equipment", 10},
	{"flywheel-grid-battery", 1},
	{"radar", 250},
	{"processing-unit", 600},
    {"rocket-fuel", 50}
}
recipe_flywheel_satellite.result = "flywheel-satellite"
recipe_flywheel_satellite.name = "flywheel-satellite"
data:extend({recipe_flywheel_satellite})