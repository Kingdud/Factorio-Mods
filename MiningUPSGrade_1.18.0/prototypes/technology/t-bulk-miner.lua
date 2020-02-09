data:extend(
{
  {
    type = "technology",
    name = "tfx-emd",
    icon = nil,
	icons = {
		{
			icon = "__base__/graphics/icons/electric-mining-drill.png",
			tint = newTint,
			icon_size = 32
		}
	},
    icon_size = 32,
    effects =
    {
		--someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
		{type = "unlock-recipe", recipe = "tfx-emd" },
    },
    prerequisites = {"advanced-material-processing-2", "rocket-silo"},
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