data:extend(
	{
		effects = {
			{
			  recipe = "turbine-hall-gen-1",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-blades-gen-1",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-shaft-gen-1",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearUPSGrade__/prototype/tech/turbine-hall-gen-1.png",
		icon_size = 128,
		name = "turbine-hall-gen-1",
		order = "l-a",
		prerequisites = {
			"nuclear-power",
			"kovarex-enrichment-process"
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
			  recipe = "turbine-hall-gen-2",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-blades-gen-2",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-shaft-gen-2",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearUPSGrade__/prototype/tech/turbine-hall-gen-2.png",
		icon_size = 128,
		name = "turbine-hall-gen-2",
		order = "l-a",
		prerequisites = {
			"turbine-hall-gen-1",
			"closed-loop-heating-and-cooling",
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
	},
	{
		effects = {
			{
			  recipe = "turbine-hall-gen-3",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-blades-gen-3",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-shaft-gen-3",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearUPSGrade__/prototype/tech/turbine-hall-gen-3.png",
		icon_size = 128,
		name = "turbine-hall-gen-3",
		order = "l-a",
		prerequisites = {
			"turbine-hall-gen-2",
			"lwr-gen-3"
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
			  recipe = "turbine-hall-gen-4",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-blades-gen-4",
			  type = "unlock-recipe"
			},
			{
			  recipe = "turbine-shaft-gen-4",
			  type = "unlock-recipe"
			}
		},
		icon = "__NuclearUPSGrade__/prototype/tech/turbine-hall-gen-3.png",
		icon_size = 128,
		name = "turbine-hall-gen-4",
		order = "l-a",
		prerequisites = {
			"turbine-hall-gen-3",
			"lmr-2"
		},
		type = "technology",
		unit = {
			count = 128000,
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
