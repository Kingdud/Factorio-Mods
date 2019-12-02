require("prototypes.constants")

data:extend({
	{
		burnt_result = "used-up-lwr-fuel-rod-bundle",
		fuel_category = "lwr-nuclear",
		fuel_value = tostring(lwr_fuel_energy) .. "GJ",
		icon = "__base__/graphics/icons/uranium-fuel-cell.png",
		icon_size = 32,
		name = "lwr-fuel-rod-bundle",
		order = "c[lwr-fuel-rod-bundle]",
		stack_size = 1,
		subgroup = "lwr-common",
		type = "item"
	},
	{
		icon = "__base__/graphics/icons/used-up-uranium-fuel-cell.png",
		icon_size = 32,
		name = "used-up-lwr-fuel-rod-bundle",
		order = "c[used-up-lwr-fuel-rod-bundle]",
		stack_size = 1,
		subgroup = "lwr-common",
		type = "item"
	},
	{
		icon = "__base__/graphics/icons/used-up-uranium-fuel-cell.png",
		icon_size = 32,
		name = "lwr-rod",
		order = "c[lwr-rod]",
		stack_size = 100,
		subgroup = "lwr-common",
		type = "item"
	},
})