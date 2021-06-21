data:extend(
{
  {
    type = "technology",
    name = "bulk-smelters",
	icon = nil,
	icons = {
		{
			icon = "__base__/graphics/technology/advanced-material-processing.png",
			tint = building_tint,
			icon_size = 256
		}
	},
    effects =
    {
	  --someone less lazy than me can convert this to a for-loop so it will support other mods like Bobs/angels
		{
			type = "unlock-recipe",
			recipe = "bulk-smelter"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-centrifuge"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-iron-plate"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-copper-plate"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-stone-brick"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-steel-plate"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-kovarex-enrichment-process"
		},
		{
			type = "unlock-recipe",
			recipe = "bulk-uranium-processing"
		},
		{
			type = "unlock-recipe",
			recipe = "centrifuge-block"
		},
		{
			type = "unlock-recipe",
			recipe = "smelter-block"
		},
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