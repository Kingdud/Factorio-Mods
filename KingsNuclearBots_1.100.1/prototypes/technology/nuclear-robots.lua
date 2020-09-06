data:extend(
{
  {
    type = "technology",
    name = "nuclear-robots",
    icon = "__KingsNuclearBots__/graphics/technology/nuclear-robotics.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "construction-robot-nuclear"
      },
	  {
        type = "unlock-recipe",
        recipe = "construction-robot-nuclear-big"
      },
      {
        type = "unlock-recipe",
        recipe = "logistic-robot-nuclear"
      },
    },
    prerequisites = {"construction-robotics", "logistic-robotics","nuclear-power","worker-robots-storage-2"},
    unit =
    {
      count = 500,
      ingredients =
      {
		{"automation-science-pack", 1},
        {"logistic-science-pack", 1},        
        {"production-science-pack", 1},
        {"utility-science-pack", 1}		
      },
      time = 30
    },
    order = "a-b-c"
  },
})