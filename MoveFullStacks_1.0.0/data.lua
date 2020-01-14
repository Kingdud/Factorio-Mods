data:extend(
{
	{
		type = "technology",
		name = "actual-stacks-fifty",
		icon = "__MoveFullStacks__/graphics/stack-inserter-50.png",
		icon_size = 32,
		effects =
		{
			{
				type = "stack-inserter-capacity-bonus",
				modifier = 38,
			},
		},
		prerequisites = {"inserter-capacity-bonus-7"},
		unit =
		{
			count = 2500,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
	{
		type = "technology",
		name = "actual-stacks-hundred",
		icon = "__MoveFullStacks__/graphics/stack-inserter-100.png",
		icon_size = 32,
		effects =
		{
			{
				type = "stack-inserter-capacity-bonus",
				modifier = 50,
			},
		},
		prerequisites = {"actual-stacks-fifty"},
		unit =
		{
			count = 25000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
	{
		type = "technology",
		name = "actual-stacks-twohundred",
		icon = "__MoveFullStacks__/graphics/stack-inserter-200.png",
		icon_size = 32,
		effects =
		{
			{
				type = "stack-inserter-capacity-bonus",
				modifier = 100,
			},
		},
		prerequisites = {"actual-stacks-hundred"},
		unit =
		{
			count = 125000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
})