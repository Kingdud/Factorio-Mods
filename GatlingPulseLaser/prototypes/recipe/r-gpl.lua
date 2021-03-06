data:extend({
	{
      enabled = false,
      energy_required = 20,
      ingredients = {
        {"laser-turret", 1 * 50 },
        {"stone-wall", 20 * 50 },
        {"processing-unit", 1 * 50}
      },
      name = "pulse-laser",
      result = "pulse-laser",
      type = "recipe"
    },
	{
      enabled = false,
      energy_required = 5,
      ingredients = {
        {"pulse-laser", 1 },
      },
      name = "p-pulse-laser",
      result = "p-pulse-laser",
      type = "recipe"
    }
})