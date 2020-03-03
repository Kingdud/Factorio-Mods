data:extend({
  {
    type = "technology",
    name = "pulse-laser",
    icon = "__base__/graphics/technology/laser-turrets.png",
    icon_size = 128,
    effects =
    {
	  --someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
      {
        type = "unlock-recipe",
        recipe = "pulse-laser"
      },
    },
    prerequisites = {"laser-turrets", "rocket-silo"},
    unit =
    {
      count = 2500,
      ingredients =
      {
		{"automation-science-pack", 1},
        {"logistic-science-pack", 1},
		{"chemical-science-pack", 1},		
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
		{"space-science-pack", 1}	
      },
      time = 60
    },
    order = "a-b-c"
  },
})