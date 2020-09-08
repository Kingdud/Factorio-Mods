--These need to be defined here because the global variable doesn't exist when this file is parsed.
local research_size_steps = settings.startup["TS_research_size"].value
local research_speed_steps = settings.startup["TS_research_speed"].value

local inverted_size_steps = 1 / research_size_steps
local inverted_speed_steps = 1 / research_speed_steps

data:extend({
  
  {
		type = "technology",
		name = "turret-shields-base",
		icon = "__KingsTurret-Shields__/graphics/base-research.png",
		icon_size = 128,
		effects ={      {
        type = "unlock-recipe",
        recipe = "ts-shield-disabler"
      },
	  {
        type = "unlock-recipe",
        recipe = "turret-shield-combinator"
      }},
		prerequisites = {"military-2", "turrets"},
		unit =
		{
			count = 75,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},

			},
			time = 30
		},
		upgrade = false,
		enabled = true,
		order = "e-l-a"
	},-------------------------------------------------------------------------------------------------------------------------------
	{
		type = "technology",
		name = "turret-shields-size",
		icon = "__KingsTurret-Shields__/graphics/size-research.png",
		icon_size = 128,
		effects =
		{{
		type = "nothing",
		effect_description = {"modifier-description.turret-shields-size"},
		}},
		prerequisites = {"turret-shields-base"},
		unit =
		{
			count_formula = "500*10^(L*" .. inverted_size_steps .. ")-200*" .. inverted_size_steps,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 60
		},
		max_level = 100,
		upgrade = true,
		enabled = true,
		order = "e-l-a"
	},
	{
		type = "technology",
		name = "turret-shields-speed",
		icon = "__KingsTurret-Shields__/graphics/speed-research.png",
		icon_size = 128,
		effects =
		{{
		type = "nothing",
		effect_description = {"modifier-description.turret-shields-speed"},
		}},
		prerequisites = {"turret-shields-base"},
		unit =
		{
			--Factorio doesn't support division, so we have to get creative.
			--OG formula assuming 200 base shields and 54/s recharge. 9 research steps per order of magnitude
			--500 * 10^(L / 9) - 54 / 9
			count_formula = "500*10^(L*" .. inverted_speed_steps .. ")-500*" .. inverted_speed_steps,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 60
		},
		max_level = 100,
		upgrade = true,
		enabled = true,
		order = "e-l-a"
	}
  })


