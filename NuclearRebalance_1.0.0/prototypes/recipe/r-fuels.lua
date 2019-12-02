require("prototypes.constants")

data:extend({
	{
		enabled = false,
		energy_required = 5,
		ingredients = {
			{"uranium-235", tostring(lwr_recipe_u235) },
			{"uranium-238", tostring(lwr_recipe_u238) }
		},
		name = "lwr-rod",
		result = "lwr-rod",
		result_count = 1,
		type = "recipe"
	},
	{
		enabled = false,
		energy_required = 100,
		ingredients = {
			{"steel-plate", 5 },
			{"lwr-rod", tostring(lwr_rods_per_bundle) },
		},
		name = "lwr-fuel-rod-bundle",
		result = "lwr-fuel-rod-bundle",
		result_count = 1,
		type = "recipe"
	},
	{
		allow_decomposition = false,
		category = "centrifuging",
		enabled = false,
		energy_required = 60,
		icon = "__base__/graphics/icons/nuclear-fuel-reprocessing.png",
		icon_size = 32,
		ingredients = {
			{"used-up-lwr-fuel-rod-bundle", 1}
		},
		main_product = "",
		name = "lwr-fuel-rod-reprocessing",
		order = "c[used-up-lwr-fuel-rod-bundle]-[lwr-fuel-rod-reprocessing]",
		results = {
			{"uranium-235",	tostring(lwr_u235_reprocessing_result)},
			{"uranium-238",	tostring(lwr_u238_reprocessing_result)}
		},
		subgroup = "lwr-common",
		type = "recipe"
	}
})