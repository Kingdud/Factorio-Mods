--////////////////////////////////////////
--Site Infrastructure section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "fuel-storage",
		result = "fuel-storage",
		enabled = false,
		energy_required = 30,
		ingredients =
		{
			{"structural-concrete", 30},
			{"purified-water-tank", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lwr-reactor-building",
		result = "lwr-reactor-building",
		enabled = false,
		energy_required = 200,
		ingredients =
		{
			{"structural-concrete", 80},
			{"pipe", 50},
			{"pump", 25},
			{"lwr-rpv",1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lwr-turbine-hall",
		result = "lwr-turbine-hall",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"structural-concrete", 40},
			{"gen-one-turbine",1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "gen-one-site-infrastructure",
		result = "gen-one-site-infrastructure",
		enabled = false,
		energy_required = 300,
		ingredients =
		{
			{"fuel-storage", 1},
			{"lwr-reactor-building",1},
			{"lwr-turbine-hall", 1}
		}
	}
})

--////////////////////////////////////////
--RPV section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "lwr-rpv",
		result = "lwr-rpv",
		enabled = false,
		energy_required = 55,
		ingredients =
		{
			{"lwr-rpv-segment", 20},
			{"steam-generator", 1},
			{"purified-water-tank", 5},
			{"heat-exchanger",205},
			{"lwr-fuel-rod-bundle", tostring(lwr_bundles_per_core - 1) }
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lwr-rpv-segment",
		result = "lwr-rpv-segment",
		enabled = false,
		energy_required = 10,
		ingredients =
		{
			{"steel-plate", 100},
		}
	}
})

--////////////////////////////////////////
--Turbine section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "gen-one-turbine",
		result = "gen-one-turbine",
		enabled = false,
		energy_required = 600,
		ingredients =
		{
			{"gen-one-turbine-disk", 8},
			{"gen-one-turbine-shaft", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "gen-one-turbine-shaft",
		result = "gen-one-turbine-shaft",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 50}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "gen-one-turbine-blades",
		result = "gen-one-turbine-blades",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 15}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "gen-one-turbine-disk",
		result = "gen-one-turbine-disk",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"turbine-disk-blank", 1},
			{"gen-one-turbine-blades",25},
			{"iron-plate",5}
		}
	}
})

--////////////////////////////////////////
--Electric Grid Interface section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "gen-one-electric-grid-interface",
		result = "gen-one-electric-grid-interface",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"switchgear", 1},
			{"green-wire", 25},
			{"red-wire", 25},
			{"copper-cable", 200}
		}
	}
})

--////////////////////////////////////////
--The actual final product
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "lwr",
		result = "lwr",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"gen-one-electric-grid-interface",1},
			{"gen-one-site-infrastructure", 1}
		}
	}
})

--////////////////////////////////////////
--Add a way for players to enrich uranium before kovarex is available.
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "centrifuging",
		name = "dirty-uranium-enrichment",
		result = "uranium-235",
		enabled = false,
		energy_required = 60,
		emissions_multiplier = 25,
		ingredients =
		{
			{"uranium-238",20},
		}
	}
})
