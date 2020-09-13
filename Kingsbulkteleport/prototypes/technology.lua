
data:extend({
	{
		type = "technology",
		name = "bulkteleport-tech1",
		icon = "__Kingsbulkteleport__/graphics/tech1.png",
		icon_size = 128,
		effects = {
			{ type = "unlock-recipe", recipe = "bulkteleport-send1" },
			{ type = "unlock-recipe", recipe = "bulkteleport-recv1" },
			{ type = "unlock-recipe", recipe = "bulkteleport-send3" },
			{ type = "unlock-recipe", recipe = "bulkteleport-recv3" },
		},
		prerequisites = {
			"logistics-2",
			"circuit-network",
			"electric-energy-accumulators",
			"advanced-electronics",
			"concrete",
		},
		unit = {
			count = 300,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
			},
			time = 30
		},
		order = "a",
	},
	{
		type = "technology",
		name = "bulkteleport-tech2",
		icon = "__Kingsbulkteleport__/graphics/tech2.png",
		icon_size = 128,
		effects = {
			{ type = "unlock-recipe", recipe = "bulkteleport-send2" },
			{ type = "unlock-recipe", recipe = "bulkteleport-recv2" },
			{ type = "unlock-recipe", recipe = "bulkteleport-send4" },
			{ type = "unlock-recipe", recipe = "bulkteleport-recv4" },
		},
		prerequisites = {
			"bulkteleport-tech1",
			"advanced-electronics-2",
		},
		unit = {
			count = 400,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"utility-science-pack", 1},
			},
			time = 30
		},
		order = "b",
	},
})
