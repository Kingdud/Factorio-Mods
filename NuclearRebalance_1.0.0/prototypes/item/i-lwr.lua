--////////////////////////////////////////
--Site Infrastructure section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "fuel-storage",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[fuel-storage]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lwr-reactor-building",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[lwr-reactor-building]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lwr-turbine-hall",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[lwr-turbine-hall]",
		stack_size = 1
	},
	{
		type = "item",
		name = "gen-one-site-infrastructure",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[gen-one-site-infrastructure]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--RPV section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "lwr-rpv",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[lwr-rpv]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lwr-rpv-segment",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-common",
		order = "b[lwr]-[lwr-rpv-segment]",
		stack_size = 10
	}
})

--////////////////////////////////////////
--Turbine section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "gen-one-turbine",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[gen-one-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "gen-one-turbine-shaft",
		icon = "__NuclearRebalance__/graphics/icons/turbine-shaft-gen1.png",
		icon_size = 128,
		subgroup = "lwr-common",
		order = "b[lwr]-[gen-one-turbine-shaft]",
		stack_size = 10
	},
	{
		type = "item",
		name = "gen-one-turbine-blades",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-common",
		order = "b[lwr]-[gen-one-turbine-blades]",
		stack_size = 200
	},
	{
		type = "item",
		name = "gen-one-turbine-disk",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[gen-one-turbine-disk]",
		stack_size = 200
	}
})

--////////////////////////////////////////
--Electric Grid Interface section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "gen-one-electric-grid-interface",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "lwr-intermediate",
		order = "c[lwr]-[gen-one-electric-grid-interface]",
		stack_size = 1
	}
})
	
--////////////////////////////////////////
--LWR Item
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "lwr",
		icon = "__NuclearRebalance__/graphics/icons/i-lwr.png",
		icon_size = 128,
		subgroup = "nuclear-finals",
		order = "z1[lwr]",
		place_result = "lwr",
		stack_size = 1
	}
})