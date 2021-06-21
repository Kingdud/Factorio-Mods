data:extend(
{


{
    type = "technology",
    name = "oil-processing-inverted",
    icon_size = 256,
    icon = "__base__/graphics/technology/oil-gathering.png",
    prerequisites = {"oil-processing"},
    effects =
    {
      
      {
        type = "unlock-recipe",
        recipe = "basic-oil-processing-inverted"
      },
    },
    unit =
    {
      count = 20,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
      time = 30
    },
    order = "d-a"
  },
  
  
  
  
  
  {
    type = "technology",
    name = "advanced-oil-processing-inverted",
    icon_size = 256,
    icon = "__base__/graphics/technology/oil-processing.png",
    prerequisites = {"advanced-oil-processing"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "advanced-oil-processing-inverted"
      },
      {
        type = "unlock-recipe",
        recipe = "heavy-oil-cracking-inverted"
      },
      {
        type = "unlock-recipe",
        recipe = "light-oil-cracking-inverted"
      }
    },
    unit =
    {
      count = 15,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "d-b"
  },
  
  
  
  
  
  
  {
    type = "technology",
    name = "coal-liquefaction-inverted",
    icon_size = 256,
    icon = "__base__/graphics/technology/coal-liquefaction.png",
    prerequisites = {"coal-liquefaction"},
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "coal-liquefaction-inverted"
      }
    },
    unit =
    {
      count = 200,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
      },
      time = 15
    },
    order = "d-c"
  },
  
  
  
  
  
  
  
  
  {
    type = "technology",
    name = "sulfur-processing-inverted",
    icon_size = 256,
    icon = "__base__/graphics/technology/sulfur-processing.png",
    prerequisites = {"sulfur-processing"},
    effects =
    {
      
      {
        type = "unlock-recipe",
        recipe = "sulfur-inverted"
      }
    },
    unit =
    {
      count = 15,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
      time = 30
    },
    order = "d-d"
  },
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  {
    type = "recipe",
    name = "basic-oil-processing-inverted",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="crude-oil", amount=100}
    },
    results=
    {
      {type="fluid", name="petroleum-gas", amount=45}
    },
    icon = "__base__/graphics/icons/fluid/basic-oil-processing.png",
    icon_size = 64,
	icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-a[basic-oil-processing]",
	
  },

  {
    type = "recipe",
    name = "advanced-oil-processing-inverted",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {type="fluid", name="crude-oil", amount=100},
      {type="fluid", name="water", amount=50}
    },
    results=
    {
      {type="fluid", name="petroleum-gas", amount=55},
      {type="fluid", name="light-oil", amount=45},
      {type="fluid", name="heavy-oil", amount=25}
    },
    icon = "__base__/graphics/icons/fluid/advanced-oil-processing.png",
    icon_size = 64,
	icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-b[advanced-oil-processing]"
  },

  {
    type = "recipe",
    name = "coal-liquefaction-inverted",
    category = "oil-processing",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      
      {type="fluid", name="steam", amount=50},
	  {type="fluid", name="heavy-oil", amount=25},
      {type="item", name="coal", amount=10},
    },
    results=
    {
     {type="fluid", name="petroleum-gas", amount=10},
      {type="fluid", name="light-oil", amount=20},
       {type="fluid", name="heavy-oil", amount=90},
    },
    icon = "__base__/graphics/icons/fluid/coal-liquefaction.png",
    icon_size = 64,
	icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-c[coal-liquefaction]",
    allow_decomposition = false
  },

  {
    type = "recipe",
    name = "heavy-oil-cracking-inverted",
    category = "chemistry",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      {type="fluid", name="heavy-oil", amount=40},
	  {type="fluid", name="water", amount=30},
    },
    results=
    {
      {type="fluid", name="light-oil", amount=30}
    },
    main_product= "",
    icon = "__base__/graphics/icons/fluid/heavy-oil-cracking.png",
    icon_size = 64,
	icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "b[fluid-chemistry]-a[heavy-oil-cracking]",
    crafting_machine_tint =
    {
      primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
      secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
      tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
    }
  },

  {
    type = "recipe",
    name = "light-oil-cracking-inverted",
    category = "chemistry",
    enabled = false,
    energy_required = 3,
    ingredients =
    {
      
      {type="fluid", name="light-oil", amount=30},
	  {type="fluid", name="water", amount=30},
    },
    results=
    {
      {type="fluid", name="petroleum-gas", amount=20}
    },
    main_product= "",
    icon = "__base__/graphics/icons/fluid/light-oil-cracking.png",
    icon_size = 64,
	icon_mipmaps = 4,
    subgroup = "fluid-recipes",
    order = "b[fluid-chemistry]-b[light-oil-cracking]",
    crafting_machine_tint =
    {
      primary = {r = 0.785, g = 0.406, b = 0.000, a = 0.000}, -- #c8670000
      secondary = {r = 0.795, g = 0.805, b = 0.605, a = 0.000}, -- #cacd9a00
      tertiary = {r = 0.835, g = 0.551, b = 0.000, a = 0.000}, -- #d48c0000
    }
  },

 

  
  


  {
    type = "recipe",
    name = "sulfur-inverted",
    category = "chemistry",
    energy_required = 1,
    enabled = false,
    ingredients =
    {
      
      {type="fluid", name="petroleum-gas", amount=30},
	  {type="fluid", name="water", amount=30},
    },
    results=
    {
      {type="item", name="sulfur", amount=2}
    },
    crafting_machine_tint =
    {
      primary = {r = 1.000, g = 0.659, b = 0.000, a = 0.000}, -- #ffa70000
      secondary = {r = 0.812, g = 1.000, b = 0.000, a = 0.000}, -- #cfff0000
      tertiary = {r = 0.960, g = 0.806, b = 0.000, a = 0.000}, -- #f4cd0000
    }
  },



})

table.insert(data.raw.module["productivity-module"].limitation,"basic-oil-processing-inverted")
table.insert(data.raw.module["productivity-module"].limitation,"advanced-oil-processing-inverted")
table.insert(data.raw.module["productivity-module"].limitation,"coal-liquefaction-inverted")
table.insert(data.raw.module["productivity-module"].limitation,"heavy-oil-cracking-inverted")
table.insert(data.raw.module["productivity-module"].limitation,"light-oil-cracking-inverted")
table.insert(data.raw.module["productivity-module"].limitation,"sulfur-inverted")

table.insert(data.raw.module["productivity-module-2"].limitation,"basic-oil-processing-inverted")
table.insert(data.raw.module["productivity-module-2"].limitation,"advanced-oil-processing-inverted")
table.insert(data.raw.module["productivity-module-2"].limitation,"coal-liquefaction-inverted")
table.insert(data.raw.module["productivity-module-2"].limitation,"heavy-oil-cracking-inverted")
table.insert(data.raw.module["productivity-module-2"].limitation,"light-oil-cracking-inverted")
table.insert(data.raw.module["productivity-module-2"].limitation,"sulfur-inverted")

table.insert(data.raw.module["productivity-module-3"].limitation,"basic-oil-processing-inverted")
table.insert(data.raw.module["productivity-module-3"].limitation,"advanced-oil-processing-inverted")
table.insert(data.raw.module["productivity-module-3"].limitation,"coal-liquefaction-inverted")
table.insert(data.raw.module["productivity-module-3"].limitation,"heavy-oil-cracking-inverted")
table.insert(data.raw.module["productivity-module-3"].limitation,"light-oil-cracking-inverted")
table.insert(data.raw.module["productivity-module-3"].limitation,"sulfur-inverted")