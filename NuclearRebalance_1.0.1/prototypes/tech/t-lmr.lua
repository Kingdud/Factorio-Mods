data:extend({
	{
		effects = {
			{ recipe = "lmr-rod", type = "unlock-recipe" },
			{ recipe = "lmr-rod-reprocessing", type = "unlock-recipe" },
			{ recipe = "adv-nickel-alloy", type = "unlock-recipe" },
			{ recipe = "corrosion-resist-pipe", type = "unlock-recipe" },
			{ recipe = "lmr-sodium-coolant", type = "unlock-recipe" },
			{ recipe = "lmr-em-pump", type = "unlock-recipe" },
			{ recipe = "adv-heat-exchanger", type = "unlock-recipe" },
		},
		icon = "__NuclearRebalance__/graphics/technology/lmr-fuel-and-mats.png",
		icon_size = 128,
		name = "lmr-fuel-and-mats",
		order = "l-a",
		prerequisites = {
			"lwr-tech-final"
		},
		type = "technology",
		unit = {
			count = 200,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
			},
			time = 45
		}
    },
	{
		effects = {
			{ recipe = "lmr-lp-turbine-blade", type = "unlock-recipe" },
			{ recipe = "lmr-hp-turbine-blade", type = "unlock-recipe" },
			{ recipe = "lmr-lp-turbine-disk", type = "unlock-recipe" },
			{ recipe = "lmr-hp-turbine-disk", type = "unlock-recipe" },
			{ recipe = "lmr-lp-turbine-shaft", type = "unlock-recipe" },
			{ recipe = "lmr-hp-turbine-shaft", type = "unlock-recipe" },
			{ recipe = "lmr-lp-turbine", type = "unlock-recipe" },
			{ recipe = "lmr-hp-turbine", type = "unlock-recipe" },
			{ recipe = "lmr-turbine-hall", type = "unlock-recipe" },
		},
		icon = "__NuclearRebalance__/graphics/technology/lmr-turbine-tech.png",
		icon_size = 128,
		name = "lmr-turbine-tech",
		order = "l-a",
		prerequisites = {
			"lmr-fuel-and-mats"
		},
		type = "technology",
		unit = {
			count = 200,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
			},
			time = 45
		}
    },
	{
		effects = {
			{ recipe = "gen-two-electric-grid-interface", type = "unlock-recipe" },
			{ recipe = "lmr-steam-loop", type = "unlock-recipe" },
			{ recipe = "lmr-heat-exchange-loop", type = "unlock-recipe" },
			{ recipe = "lmr-reactor-vessel", type = "unlock-recipe" },
			{ recipe = "lmr-reactor-hall", type = "unlock-recipe" },
			{ recipe = "lmr", type = "unlock-recipe" },
		},
		icon = "__NuclearRebalance__/graphics/icons/lmr/i-lmr.png",
		icon_size = 128,
		name = "lmr-tech-final",
		order = "l-a",
		prerequisites = {
			"lmr-turbine-tech"
		},
		type = "technology",
		unit = {
			count = 800,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
			},
			time = 45
		}
    },
})