data:extend({
	{
		effects = {
			{
			  recipe = "nimh-foil",
			  type = "unlock-recipe"
			},
			{
			  recipe = "nimh-grid-battery",
			  type = "unlock-recipe"
			}
		},
		icon = "__EnhancedGridEnergyStores__/graphics/icons/nimh.png",
		icon_size = 32,
		name = "nimh-cell",
		order = "l-a",
		prerequisites = {
			"electric-energy-accumulators"
		},
		type = "technology",
		unit = {
			count = 400,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
				{ "utility-science-pack", 1 }
			},
			time = 60
		}
	},
	{
		effects = {
			{
			  recipe = "li-foil",
			  type = "unlock-recipe"
			},
			{
			  recipe = "li-ion-grid-battery",
			  type = "unlock-recipe"
			}
		},
		icon = "__EnhancedGridEnergyStores__/graphics/icons/li-ion.png",
		icon_size = 32,
		name = "li-ion-cell",
		order = "l-a",
		prerequisites = {
			"nimh-cell"
		},
		type = "technology",
		unit = {
			count = 600,
			ingredients = {
				{ "automation-science-pack", 1 },
				{ "logistic-science-pack", 1 },
				{ "chemical-science-pack", 1 },
				{ "production-science-pack", 1 },
				{ "utility-science-pack", 1 }
			},
			time = 60
		}
	},
	{
		effects = {
			{
			  recipe = "high-precision-flywheel-segment",
			  type = "unlock-recipe"
			},
			{
			  recipe = "vacuum-chamber",
			  type = "unlock-recipe"
			},
			{
			  recipe = "flywheel-grid-battery",
			  type = "unlock-recipe"
			}
		},
		icon = "__EnhancedGridEnergyStores__/graphics/icons/flywheel.png",
		icon_size = 128,
		name = "flywheel-cell",
		order = "l-a",
		prerequisites = {
			"li-ion-cell",
			"rocket-silo"
		},
		type = "technology",
		unit = {
			count = 800,
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