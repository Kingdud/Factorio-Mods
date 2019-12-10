--////////////////////////////////////////
--Turbine Hall Items
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-turbine-hall",
		result = "lmr-turbine-hall",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"structural-concrete", 15},
			{"lmr-hp-turbine", 1},
			{"lmr-lp-turbine", 1}
		}
	},
	--||||||||||
	--High Pressure Turbine
	--||||||||||
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-hp-turbine",
		result = "lmr-hp-turbine",
		enabled = false,
		energy_required = 15,
		ingredients =
		{
			{"lmr-hp-turbine-shaft", 1},
			{"lmr-hp-turbine-disk", 8},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-hp-turbine-shaft",
		result = "lmr-hp-turbine-shaft",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 40},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-hp-turbine-disk",
		result = "lmr-hp-turbine-disk",
		enabled = false,
		energy_required = 3,
		ingredients =
		{
			{"lmr-hp-turbine-blade", 20},
			{"turbine-disk-blank", 1},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-hp-turbine-blade",
		result = "lmr-hp-turbine-blade",
		enabled = false,
		energy_required = 0.5,
		ingredients =
		{
			{"adv-nickel-alloy", 2},
		}
	},
	--||||||||||
	--Low Pressure Turbine
	--||||||||||
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-lp-turbine",
		result = "lmr-lp-turbine",
		enabled = false,
		energy_required = 15,
		ingredients =
		{
			{"lmr-lp-turbine-shaft", 1},
			{"lmr-lp-turbine-disk", 14},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-lp-turbine-shaft",
		result = "lmr-lp-turbine-shaft",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 70},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-lp-turbine-disk",
		result = "lmr-lp-turbine-disk",
		enabled = false,
		energy_required = 3,
		ingredients =
		{
			{"lmr-lp-turbine-blade", 10},
			{"turbine-disk-blank", 1},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-lp-turbine-blade",
		result = "lmr-lp-turbine-blade",
		enabled = false,
		energy_required = 0.5,
		ingredients =
		{
			{"adv-nickel-alloy", 4},
		}
	},
})

--////////////////////////////////////////
--Reactor Hall Items
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-reactor-hall",
		result = "lmr-reactor-hall",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"structural-concrete", 15},
			{"lmr-reactor-vessel", 1},
			{"lmr-heat-exchange-loop", 1},
			{"lmr-steam-loop", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-reactor-vessel",
		result = "lmr-reactor-vessel",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"inserter", 1},
			{"lmr-em-pump", 6},
			{"steel-plate", 50},
			{"adv-nickel-alloy", 10},
			{"lmr-sodium-coolant", 3},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-heat-exchange-loop",
		result = "lmr-heat-exchange-loop",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"heat-exchanger", 151},
			{"lmr-em-pump", 3},
			{"corrosion-resist-pipe", 10},
			{"lmr-sodium-coolant", 1},
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-steam-loop",
		result = "lmr-steam-loop",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"steam-generator", 1},
			{"purified-water-tank", 1},
		}
	},
})

--////////////////////////////////////////
--Misc LMR Items
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "lmr-em-pump",
		result = "lmr-em-pump",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{"electric-engine-unit", 1},
			{"copper-cable", 200},
		}
	},
	{
		type = "recipe",
		category = "chemistry",
		name = "lmr-sodium-coolant",
		result = "lmr-sodium-coolant",
		enabled = false,
		energy_required = 60,
		ingredients =
		{
			{
				amount = 10,
				name = "light-oil",
				type = "fluid"
			},
			{"storage-tank", 1},
			{"stone", 3000},
		}
	},
})

--////////////////////////////////////////
--Electric Grid Interface section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "gen-two-electric-grid-interface",
		result = "gen-two-electric-grid-interface",
		enabled = false,
		energy_required = 20,
		ingredients =
		{
			{"switchgear", 2},
			{"green-wire", 50},
			{"red-wire", 50},
			{"copper-cable", 400}
		}
	},
})

--////////////////////////////////////////
--LMR itself
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "lmr",
		result = "lmr",
		enabled = false,
		energy_required = 600,
		ingredients =
		{
			{"gen-two-electric-grid-interface", 1},
			{"lmr-turbine-hall", 1},
			{"lmr-reactor-hall", 1},
			{"structural-concrete", 10},
			{"lmr-rod",tostring(lmr_rods_per_core - 1)}
		}
	},
})