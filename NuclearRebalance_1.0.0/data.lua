--entity
require("prototypes.entity.e-lwr")

--items
require("prototypes.item.i-common")
require("prototypes.item.i-lwr")

--recipes
require("prototypes.recipe.r-common")
require("prototypes.recipe.r-lwr")

--tech
require("prototypes.tech.t-lwr")
--require("prototypes.tech.t-lmr")
--require("prototypes.tech.t-msr")

--Item group to collect all added items
data:extend({
	{
		icon = "__base__/graphics/icons/uranium-235.png",
		icon_size = 32,
		name = "adv-nuclear",
		order = "Z",
		order_in_recipe = "0",
		type = "item-group"
	},
	{
      group = "adv-nuclear",
      name = "nuclear-common",
      order = "b",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "nuclear-intermediate",
      order = "c",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "nuclear-finals",
      order = "d",
      type = "item-subgroup"
    }
})