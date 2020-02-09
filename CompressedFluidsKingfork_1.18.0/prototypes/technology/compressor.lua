data:extend{
  {
    type = "technology",
    name = "fluid-compressor",
    icon = data.raw.technology["fluid-handling"].icon,
    icon_size = data.raw.technology["fluid-handling"].icon_size,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fluid-compressor"
      },
    },
    prerequisites = {"fluid-handling", "engine"},
    unit =
    {
      count = 250,
      ingredients = data.raw.technology["engine"].unit.ingredients,
      time = 2 * data.raw.technology["engine"].unit.time,
    },
    upgrade = false,
    order = "d-a-a"
  },
}
