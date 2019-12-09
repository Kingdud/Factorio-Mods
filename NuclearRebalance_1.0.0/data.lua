--entity
require("prototypes.entity.e-lwr")
require("prototypes.entity.e-lmr")

--items
require("prototypes.item.i-common")
require("prototypes.item.i-fuels")
require("prototypes.item.i-lwr")
require("prototypes.item.i-lmr")

--recipes
require("prototypes.recipe.r-common")
require("prototypes.recipe.r-fuels")
require("prototypes.recipe.r-lwr")
require("prototypes.recipe.r-lmr")

--tech
require("prototypes.tech.t-lwr")
require("prototypes.tech.t-lmr")
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
      name = "lwr-common",
      order = "c",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "lwr-intermediate",
      order = "d",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "lmr-common",
      order = "e",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "lmr-intermediate",
      order = "f",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "msr-common",
      order = "g",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "msr-intermediate",
      order = "h",
      type = "item-subgroup"
    },
	{
      group = "adv-nuclear",
      name = "nuclear-finals",
      order = "z",
      type = "item-subgroup"
    }
})

--////////////////////////////////////////
--Add fuel categories
--////////////////////////////////////////
data:extend({
	{
		name = "lwr-nuclear",
		type = "fuel-category"
	},
	{
		name = "lmr-nuclear",
		type = "fuel-category"
	},
	{
		name = "msr-nuclear",
		type = "fuel-category"
	}
})