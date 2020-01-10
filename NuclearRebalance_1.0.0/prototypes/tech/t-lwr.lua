data:extend({
	{
		effects = {
			{ recipe = "lwr-fuel-rod-reprocessing", type = "unlock-recipe" },
			{ recipe = "dirty-uranium-enrichment", type = "unlock-recipe" },
		},
		icon = "__NuclearRebalance__/graphics/recipe/lwr-dirty-enrichment.png",
		icon_size = 128,
		name = "lwr-tech-fuel-reprocessing",
		order = "l-a",
		prerequisites = {
			"chemical-science-pack",
			"lwr-tech-step-one"
		},
		type = "technology",
		unit = {
			count = 50,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
			},
			time = 30
		}
    },
	{
		effects = {
			{ recipe = "lwr-rod", type = "unlock-recipe" },
			{ recipe = "lwr-fuel-rod-bundle", type = "unlock-recipe" }
		},
		icon = "__NuclearRebalance__/graphics/technology/lwr-tech-icon-one.png",
		icon_size = 128,
		name = "lwr-tech-step-one",
		order = "l-a",
		prerequisites = {
			"uranium-processing"
		},
		type = "technology",
		unit = {
			count = 25,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
			},
			time = 15
		}
    },
	{
		effects = {
			{ recipe = "rebar", type = "unlock-recipe" },
			{ recipe = "structural-concrete", type = "unlock-recipe" },
			{ recipe = "purified-water-tank", type = "unlock-recipe" },
			{ recipe = "switchgear", type = "unlock-recipe" },
			{ recipe = "gen-one-electric-grid-interface", type = "unlock-recipe" },
			{ recipe = "fuel-storage", type = "unlock-recipe" }
		},
		icon = "__NuclearRebalance__/graphics/technology/lwr-tech-icon-two.png",
		icon_size = 128,
		name = "lwr-tech-step-two",
		order = "l-a",
		prerequisites = {
			"lwr-tech-step-one",
			"circuit-network",
			"concrete",
			"fluid-handling",
			"oil-processing"
		},
		type = "technology",
		unit = {
			count = 100,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
			},
			time = 15
		}
    },
	{
		effects = {
			{ recipe = "lwr-turbine-hall", type = "unlock-recipe" },
			{ recipe = "turbine-disk-blank", type = "unlock-recipe" },
			{ recipe = "gen-one-turbine", type = "unlock-recipe" },
			{ recipe = "gen-one-turbine-shaft", type = "unlock-recipe" },
			{ recipe = "gen-one-turbine-blades", type = "unlock-recipe" },
			{ recipe = "gen-one-turbine-disk", type = "unlock-recipe" }
		},
		icon = "__NuclearRebalance__/graphics/technology/lwr-tech-icon-three.png",
		icon_size = 128,
		name = "lwr-tech-step-three",
		order = "l-a",
		prerequisites = {
			"lwr-tech-step-two"
		},
		type = "technology",
		unit = {
			count = 100,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
			},
			time = 15
		}
    },
	{
		effects = {
			{ recipe = "lwr", type = "unlock-recipe" },
			{ recipe = "lwr-reactor-building", type = "unlock-recipe" },
			{ recipe = "gen-one-site-infrastructure", type = "unlock-recipe" },
			{ recipe = "lwr-rpv", type = "unlock-recipe" },
			{ recipe = "steam-generator", type = "unlock-recipe" },
			{ recipe = "lwr-rpv-segment", type = "unlock-recipe" },
			{ recipe = "water-heat-exchanger", type = "unlock-recipe" }
		},
		icon = "__NuclearRebalance__/graphics/icons/lwr/i-lwr.png",
		icon_size = 128,
		name = "lwr-tech-final",
		order = "l-a",
		prerequisites = {
			"lwr-tech-step-three"
		},
		type = "technology",
		unit = {
			count = 375,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
			},
			time = 15
		}
    },
})