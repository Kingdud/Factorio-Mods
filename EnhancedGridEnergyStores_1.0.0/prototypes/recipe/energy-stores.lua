--////////////////////////////////////////
--NiMH Battery section
--////////////////////////////////////////

data:extend({
	{
		type = "recipe",
		category = "advanced-crafting",
		name = "nimh-foil",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 5},
			{"stone", 5}
		},
		result = "nimh-foil"
	},
	{
		--balance notes: Normal accumulator is 5 copper, 7 iron, and 20 sulfuric acid for 5 MJ
		-- This recipie is 25,000 iron, 5000 stone, and 100 water for 11 GJ
		-- Not counting fluids; that works out to 2.4 material/MJ for normal, and 2.7 material/MJ for nimh.
		type = "recipe",
		category = "advanced-crafting",
		name = "nimh-grid-battery",
		enabled = false,
		energy_required = 25,
		ingredients =
		{
			{"steel-plate", 100},
			{"nimh-foil", 1000},
			{"water-barrel", 2}
		},
		result = "nimh-grid-battery"
	}
})

--////////////////////////////////////////
--Li-Ion Battery section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "advanced-crafting",
		name = "li-foil",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 5},
			{"stone", 25},
			{"plastic-bar", 1}
		},
		result = "li-foil"
	},
	{
		--balance notes: Target is to be around 1.25 material/MJ. This is a huge efficiency step up.
		type = "recipe",
		category = "advanced-crafting",
		name = "li-ion-grid-battery",
		enabled = false,
		energy_required = 25,
		ingredients =
		{
			{"steel-plate", 100},
			{"nimh-foil", 1000},
		},
		result = "li-ion-grid-battery"
	}
})

--////////////////////////////////////////
--Flywheel Battery section
--////////////////////////////////////////
data:extend({
	{
		type = "recipe",
		category = "advanced-crafting",
		name = "high-precision-flywheel-segment",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 1000},
			{"iron-plate", 10}
		},
		result = "high-precision-flywheel-segment"
	},
	{
		type = "recipe",
		category = "advanced-crafting",
		name = "vacuum-chamber",
		enabled = false,
		energy_required = 5,
		ingredients =
		{
			{"steel-plate", 100},
			{"copper-plate", 50},
			{"pump", 1}
		},
		result = "vacuum-chamber"
	},
	{
		--balance notes: Target is to be around 1.25 material/MJ. This is a huge efficiency step up.
		type = "recipe",
		category = "advanced-crafting",
		name = "flywheel-grid-battery",
		enabled = false,
		energy_required = 25,
		ingredients =
		{
			{"high-precision-flywheel-segment", 20},
			{"vacuum-chamber", 1},
			{"electric-engine-unit", 4}
		},
		result = "flywheel-grid-battery"
	}
})
