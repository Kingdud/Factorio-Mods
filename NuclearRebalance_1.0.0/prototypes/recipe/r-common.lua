--////////////////////////////////////////
--Site Infrastructure section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "rebar",
		result = "rebar",
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{"steel-plate", 11}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "structural-concrete",
		result = "structural-concrete",
		enabled = false,
		energy_required = 15,
		ingredients =
		{
			{"concrete", 30},
			{"rebar",1}
		}
	},
	{
		type = "recipe",
		category = "chemistry",
		name = "purified-water-tank",
		result = "purified-water-tank",
		enabled = false,
		energy_required = 30,
		ingredients =
		{
			{
				amount = 30000,
				name = "water",
				type = "fluid"
			},
			{"storage-tank",1}
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
		name = "steam-generator",
		result = "steam-generator",
		enabled = false,
		energy_required = 20,
		ingredients =
		{
			{"steel-plate", 15},
			{"pipe",100}
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
		name = "switchgear",
		result = "switchgear",
		enabled = false,
		energy_required = 30,
		ingredients =
		{
			{"copper-plate", 10},
			{"decider-combinator", 5},
			{"arithmetic-combinator", 5},
			{"steel-plate",10}
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
		name = "turbine-disk-blank",
		result = "turbine-disk-blank",
		enabled = false,
		energy_required = 20,
		ingredients =
		{
			{"steel-plate", 10}
		}
	}
})

--////////////////////////////////////////
--Misc/Components section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "crafting",
		name = "adv-nickel-alloy",
		result = "adv-nickel-alloy",
		enabled = false,
		energy_required = 1,
		ingredients =
		{
			{"stone", 1},
			{"iron-ore", 1},
			{"copper-ore", 1},
			{"uranium-ore", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "corrosion-resist-pipe",
		result = "corrosion-resist-pipe",
		enabled = false,
		energy_required = 0.5,
		ingredients =
		{
			{"adv-nickel-alloy", 1}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "water-heat-exchanger",
		result = "water-heat-exchanger",
		enabled = false,
		energy_required = 2,
		ingredients =
		{
			{"steel-plate", 20},
			{"copper-plate", 20},
			{"pipe", 50}
		}
	},
	{
		type = "recipe",
		category = "crafting",
		name = "adv-heat-exchanger",
		result = "adv-heat-exchanger",
		enabled = false,
		energy_required = 0.5,
		ingredients =
		{
			{"adv-nickel-alloy", 50},
			{"copper-plate", 10},
			{"corrosion-resist-pipe", 100}
		}
	}
})