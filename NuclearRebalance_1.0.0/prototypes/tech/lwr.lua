data:extend(
	{
		effects = {
			{
			  recipe = "lwr-1",
			  type = "unlock-recipe"
			},
			{
			  recipe = "reactor-pressure-vessel-gen-1",
			  type = "unlock-recipe"
			},
			{
			  recipe = "purified-light-water",
			  type = "unlock-recipe"
			},
			{
			  recipe = "boric-acid",
			  type = "unlock-recipe"
			},
			{
			  recipe = "explosive-welding",
			  type = "unlock-recipe"
			},
			{
			  recipe = "reactor-coolant-loop-gen-1",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/light-water-gen-1.png",
		icon_size = 128,
		name = "lwr-1",
		order = "l-a",
		prerequisites = {
			"nuclear-power",
			"kovarex-enrichment-process",
		},
		type = "technology",
		unit = {
			count = 1250,
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
			  recipe = "lwr-2",
			  type = "unlock-recipe"
			},
			{
			  recipe = "low-enrichment-fuel-rods",
			  type = "unlock-recipe"
			},
			{
			  recipe = "high-enrichment-fuel-rods",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/light-water-gen-2.png",
		icon_size = 128,
		name = "lwr-2",
		order = "l-a",
		prerequisites = {
			"lwr-1",
			"closed-loop-heating-and-cooling",
			"turbine-hall-gen-1"
		},
		type = "technology",
		unit = {
			count = 8000,
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
			{
			  recipe = "lwr-3",
			  type = "unlock-recipe"
			},
			{
			  recipe = "reactor-pressure-vessel-gen-3",
			  type = "unlock-recipe"
			},
			{
			  recipe = "reactor-automation-technology",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/light-water-gen-3.png",
		icon_size = 128,
		name = "lwr-3",
		order = "l-a",
		prerequisites = {
			"lwr-2",
			"turbine-hall-gen-2"
		},
		type = "technology",
		unit = {
			count = 32000,
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
			{
			  recipe = "lwr-4",
			  type = "unlock-recipe"
			},
			{
			  recipe = "reactor-pressure-vessel-gen-4",
			  type = "unlock-recipe"
			},
			{
			  recipe = "advanced-reactor-automation-technology",
			  type = "unlock-recipe"
			},
			{
			  recipe = "reactor-coolant-loop-gen-2",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearRebalance__/prototype/tech/light-water-gen-4.png",
		icon_size = 128,
		name = "lwr-4",
		order = "l-a",
		prerequisites = {
			"lwr-3",
			"turbine-hall-gen-4"
		},
		type = "technology",
		unit = {
			count = 256000,
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
)