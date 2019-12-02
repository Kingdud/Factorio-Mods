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
		name = "lmr-tech-step-one",
		order = "l-a",
		prerequisites = {
			"lwr-tech-final"
		},
		type = "technology",
		unit = {
			count = 25,
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