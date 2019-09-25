data:extend(
	{
		effects = {
			{
			  recipe = "lmr-1",
			  type = "unlock-recipe"
			},
			{
			  recipe = "mercury-reactor-core",
			  type = "unlock-recipe"
			},
			{
			  recipe = "uranium-core-blanket",
			  type = "unlock-recipe"
			},
			{
			  recipe = "boronated-plastic",
			  type = "unlock-recipe"
			},
			{
			--boronated-plastic, steel, lead (stone)
			  recipe = "laminated-bio-shield",
			  type = "unlock-recipe"
			},
			{
			  recipe = "electromagnetic-pump",
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