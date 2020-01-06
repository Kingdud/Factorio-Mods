require("prototypes.constants")

--///////////////////////////////////////////
--LWR
--///////////////////////////////////////////
data:extend({
	{
		burnt_result = "used-up-lwr-fuel-rod-bundle",
		fuel_category = "lwr-nuclear",
		fuel_value = tostring(lwr_fuel_energy) .. "GJ",
		icon = "__NuclearRebalance__/graphics/icons/lwr-fuel-rod-bundle.png",
		icon_size = 128,
		name = "lwr-fuel-rod-bundle",
		order = "c-[lwr-rod]-[lwr-fuel-rod-bundle]",
		stack_size = 1,
		subgroup = "lwr-common",
		type = "item"
	},
	{
		icon = "__NuclearRebalance__/graphics/icons/used-up-lwr-fuel-rod-bundle.png",
		icon_size = 128,
		name = "used-up-lwr-fuel-rod-bundle",
		order = "c-[lwr-rod]-[used-up-lwr-fuel-rod-bundle]",
		stack_size = 1,
		subgroup = "lwr-common",
		type = "item"
	},
	{
		icon = "__NuclearRebalance__/graphics/icons/lwr-rod.png",
		icon_size = 128,
		name = "lwr-rod",
		order = "c[lwr-rod]",
		stack_size = 100,
		subgroup = "lwr-common",
		type = "item"
	},
})

--///////////////////////////////////////////
--LMR
--///////////////////////////////////////////
data:extend({
	{
		burnt_result = "used-up-lmr-rod",
		fuel_category = "lmr-nuclear",
		fuel_value = tostring(lmr_fuel_energy_per_rod) .. "GJ",
		icon = "__NuclearRebalance__/graphics/icons/lmr-rod.png",
		icon_size = 128,
		name = "lmr-rod",
		order = "c[lmr-rod]",
		stack_size = 1,
		subgroup = "lmr-common",
		type = "item"
	},
	{
		icon = "__NuclearRebalance__/graphics/icons/used-up-lmr-rod.png",
		icon_size = 128,
		name = "used-up-lmr-rod",
		order = "c[used-up-lmr-rod]",
		stack_size = 1,
		subgroup = "lmr-common",
		type = "item"
	}
})

--///////////////////////////////////////////
--MSR
--///////////////////////////////////////////
data.raw["item"]["uranium-235"].fuel_category = "msr-nuclear"
data.raw["item"]["uranium-235"].fuel_value = tostring(u235_gj_per_kg) .. "GJ"

data.raw["item"]["uranium-238"].fuel_category = "msr-nuclear"
data.raw["item"]["uranium-238"].fuel_value = tostring(u238_gj_per_kg_fast) .. "GJ"