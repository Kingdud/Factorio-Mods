data:extend({
	{
		effects = {
			{ recipe = "lwr-rod", type = "unlock-recipe" },
			{ recipe = "lwr-fuel-rod-bundle", type = "unlock-recipe" },
			{ recipe = "lwr-fuel-rod-reprocessing", type = "unlock-recipe" },
		},
		--icon = "__NuclearRebalance__/graphics/technology/light-water-gen-2.png",
		icon = "__base__/graphics/icons/productivity-module.png",
		icon_size = 32,
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
		--icon = "__NuclearRebalance__/graphics/technology/light-water-gen-2.png",
		icon = "__base__/graphics/icons/productivity-module.png",
		icon_size = 32,
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
		--icon = "__NuclearRebalance__/graphics/technology/light-water-gen-2.png",
		icon = "__base__/graphics/icons/productivity-module-2.png",
		icon_size = 32,
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
			{ recipe = "lwr-steam-generator", type = "unlock-recipe" },
			{ recipe = "lwr-rpv-segment", type = "unlock-recipe" },
			{ recipe = "heat-exchanger", type = "unlock-recipe" }
		},
		--icon = "__NuclearRebalance__/graphics/technology/light-water-gen-2.png",
		icon = "__base__/graphics/icons/productivity-module-3.png",
		icon_size = 32,
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