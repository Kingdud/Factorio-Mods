data:extend(
	{
		effects = {
			{
			  recipe = "Nickle Oxide Foil",
			  type = "unlock-recipe"
			},
			{
			  recipe = "NiMH Grid Battery",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/nimh-store.png",
		icon_size = 128,
		name = "nimh-cell",
		order = "l-a",
		prerequisites = {
			"accumulator"
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
			  recipe = "Lithium Foil",
			  type = "unlock-recipe"
			},
			{
			  recipe = "Li-ion Grid Battery",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/li-ion-store.png",
		icon_size = 128,
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
			  recipe = "high-precision-flywheel",
			  type = "unlock-recipe"
			},
			{
			  recipe = "vacuum-chamber",
			  type = "unlock-recipe"
			},
			{
			  recipe = "Flywheel Grid Battery",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/flywheel-store.png",
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