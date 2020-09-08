--////////////////////////////////////////
--Reactor Hall
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "msr-reactor-hall",
		result = "msr-reactor-hall",
		enabled = false,
		energy_required = 30,
		ingredients =
		{
			{"structural-concrete", 12},
			{"msr-reactor-vessel-segment", msr_reactor_segments},
			{"corrosion-resist-pipe", 100},
			{"adv-heat-exchanger", 100},
			{"pump", 26}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-reactor-vessel-segment",
		result = "msr-reactor-vessel-segment",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"adv-nickel-alloy", 200},
			{"msr-reactor-salt", msr_salt_per_segment}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-reactor-salt",
		result = "msr-reactor-salt",
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{"empty-barrel", 1},
			{"stone", math.ceil(1250 / msr_salt_per_segment)},
			{"iron-ore", math.ceil(1250 / msr_salt_per_segment)},
			{"copper-ore", math.ceil(1250 / msr_salt_per_segment)},
			{"uranium-235", msr_inital_u235_inventory},
			{"uranium-238", msr_inital_u238_inventory},
		}
	},
})

--////////////////////////////////////////
--Turbine Hall
--////////////////////////////////////////
data:extend({
	{	
		type = "recipe",
		category = "crafting",
		name = "msr-turbine-hall",
		result = "msr-turbine-hall",
		enabled = false,
		energy_required = 30,
		ingredients =
		{
			{"structural-concrete", 20},
			{"msr-hp-gas-turbine", 1},
			{"msr-lp-gas-turbine", 3},
			{"msr-helium-gas", 100}
		}
	},
	--||||||||||
	--High Pressure Turbine
	--||||||||||
	{
		type = "recipe",
		category = "crafting",
		name = "msr-hp-gas-turbine",
		result = "msr-hp-gas-turbine",
		enabled = false,
		energy_required = 15,
		ingredients =
		{
			{"msr-hp-gas-shaft", 1},
			{"msr-hp-gas-disk", 16}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-hp-gas-shaft",
		result = "msr-hp-gas-shaft",
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
		name = "msr-hp-gas-disk",
		result = "msr-hp-gas-disk",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"msr-hp-gas-blade", 104},
			{"turbine-disk-blank", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-hp-gas-blade",
		result = "msr-hp-gas-blade",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"adv-nickel-alloy", 2}
		}
	},
	--||||||||||
	--Low Pressure Turbine
	--||||||||||
	{
		type = "recipe",
		category = "crafting",
		name = "msr-lp-gas-turbine",
		result = "msr-lp-gas-turbine",
		enabled = false,
		energy_required = 15,
		ingredients =
		{
			{"msr-lp-gas-shaft", 1},
			{"msr-lp-gas-disk", 8}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-lp-gas-shaft",
		result = "msr-lp-gas-shaft",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 80}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-lp-gas-disk",
		result = "msr-lp-gas-disk",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"msr-lp-gas-blade", 52},
			{"turbine-disk-blank", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-lp-gas-blade",
		result = "msr-lp-gas-blade",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"adv-nickel-alloy", 4}
		}
	},
	{
		type = "recipe",
		category = "chemistry",
		name = "msr-helium-gas",
		result = "msr-helium-gas",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"empty-barrel", 1},
			{
				amount = 600,
				name = "crude-oil",
				type = "fluid"
			},
		}
	},
})

--////////////////////////////////////////
--Online Reprocessing Facility
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "msr-online-repro-fac",
		result = "msr-online-repro-fac",
		enabled = false,
		energy_required = 45,
		ingredients =
		{
			{"structural-concrete", 20},
			{"centrifuge", 1},
			{"storage-tank", 1},
			{"chemical-plant", 1},
			{"msr-underground-century-storage-fac", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "msr-underground-century-storage-fac",
		result = "msr-underground-century-storage-fac",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"concrete", 100},
			{"electric-mining-drill", 1},
			{"empty-barrel", 300}
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
		name = "gen-three-electric-grid-interface",
		result = "gen-three-electric-grid-interface",
		enabled = false,
		energy_required = 15,
		ingredients =
		{
			{"switchgear", 4},
			{"green-wire", 75},
			{"red-wire", 75},
			{"copper-cable", 600}
		}
	}
})

--////////////////////////////////////////
--MSR itself
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "msr",
		result = "msr",
		enabled = false,
		energy_required = 600,
		ingredients =
		{
			{"gen-three-electric-grid-interface", 4},
			{"msr-reactor-hall", 1},
			{"msr-turbine-hall", 1},
			{"msr-online-repro-fac", 1},
			{"structural-concrete", 75}
		}
	}
})