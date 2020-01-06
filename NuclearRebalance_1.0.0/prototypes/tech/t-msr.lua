data:extend({
	{
		effects = {
			{ recipe = "gen-three-electric-grid-interface", type = "unlock-recipe" },
			{ recipe = "msr-online-repro-fac", type = "unlock-recipe" },
			{ recipe = "msr-reactor-vessel-segment", type = "unlock-recipe" },
			{ recipe = "msr-reactor-salt", type = "unlock-recipe" },
			{ recipe = "msr-underground-century-storage-fac", type = "unlock-recipe" },
			{ recipe = "msr-helium-gas", type = "unlock-recipe" },
		},
		icon = "__NuclearRebalance__/graphics/technology/msr-tech-step-one.png",
		icon_size = 128,
		name = "msr-tech-step-one",
		order = "l-a",
		prerequisites = {
			"lmr-tech-final"
		},
		type = "technology",
		unit = {
			count = 500,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
				{ "utility-science-pack", 1 },
				{ "space-science-pack", 1 },
			},
			time = 60
		}
    },
	{
		effects = {
			{ recipe = "msr-hp-gas-turbine", type = "unlock-recipe" },
			{ recipe = "msr-hp-gas-shaft", type = "unlock-recipe" },
			{ recipe = "msr-hp-gas-disk", type = "unlock-recipe" },
			{ recipe = "msr-hp-gas-blade", type = "unlock-recipe" },
			{ recipe = "msr-lp-gas-turbine", type = "unlock-recipe" },
			{ recipe = "msr-lp-gas-shaft", type = "unlock-recipe" },
			{ recipe = "msr-lp-gas-disk", type = "unlock-recipe" },
			{ recipe = "msr-lp-gas-blade", type = "unlock-recipe" },
		},
		icon = "__NuclearRebalance__/graphics/technology/msr-tech-step-two.png",
		icon_size = 128,
		name = "msr-tech-step-two",
		order = "l-a",
		prerequisites = {
			"msr-tech-step-one"
		},
		type = "technology",
		unit = {
			count = 1500,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
				{ "utility-science-pack", 1 },
				{ "space-science-pack", 1 },
			},
			time = 60
		}
    },
	{
		effects = {
			{ recipe = "msr-turbine-hall", type = "unlock-recipe" },
			{ recipe = "msr-reactor-hall", type = "unlock-recipe" },
			{ recipe = "msr", type = "unlock-recipe" }
		},
		icon = "__NuclearRebalance__/graphics/icons/i-msr.png",
		icon_size = 128,
		name = "msr-tech-final",
		order = "l-a",
		prerequisites = {
			"msr-tech-step-two"
		},
		type = "technology",
		unit = {
			count = 2000,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
				{ "utility-science-pack", 1 },
				{ "space-science-pack", 1 },
			},
			time = 60
		}
    }
})