require("prototypes.constants")

--///////////////////////////////////////////
--LWR
--///////////////////////////////////////////
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
			{"used-up-lwr-fuel-rod-bundle", 1},
			{"steel-plate", 5},
			{"uranium-235",	lwr_reprocessing_u235_needed},
			{"uranium-238",	lwr_reprocessing_u238_needed}
		},
		main_product = "",
		name = "lwr-fuel-rod-reprocessing",
		order = "c[used-up-lwr-fuel-rod-bundle]-[lwr-fuel-rod-reprocessing]",
		results = {
			{"lwr-fuel-rod-bundle",	1}
		},
		subgroup = "lwr-common",
		type = "recipe"
	}
})

--///////////////////////////////////////////
--LMR
--///////////////////////////////////////////
data:extend({
	{
		enabled = false,
		energy_required = 1,
		ingredients = {
			{"uranium-235", tostring(lmr_u235_per_rod) },
			{"uranium-238", tostring(lmr_u238_per_rod) }
		},
		name = "lmr-rod",
		result = "lmr-rod",
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
			{"used-up-lmr-rod", 1},
			{"steel-plate", 1},
			{"uranium-235",	lmr_reprocessing_u235_needed},
			{"uranium-238",	lmr_reprocessing_u238_needed}
		},
		main_product = "",
		name = "lmr-rod-reprocessing",
		order = "c[used-up-lmr-rod]-[lmr-rod-reprocessing]",
		results = {
			{"lmr-rod",	1}
		},
		subgroup = "lmr-common",
		type = "recipe"
	}
})

--///////////////////////////////////////////
--MSR
--///////////////////////////////////////////
--MSR fuel is raw uranium itself.