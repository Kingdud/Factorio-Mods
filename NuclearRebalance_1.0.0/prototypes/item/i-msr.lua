--////////////////////////////////////////
--Reactor Hall section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "msr-reactor-hall",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[msr-reactor-hall]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-reactor-vessel-segment",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-reactor-vessel-segment]",
		stack_size = 50
	},
	{
		type = "item",
		name = "msr-reactor-salt",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-reactor-salt]",
		stack_size = 100
	}
})

--////////////////////////////////////////
--Turbine Hall section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "msr-turbine-hall",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[msr-turbine-hall]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-hp-gas-turbine",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[msr-hp-gas-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-hp-gas-shaft",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-hp-gas-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-hp-gas-disk",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-hp-gas-turbine]",
		stack_size = 50
	},
	{
		type = "item",
		name = "msr-hp-gas-blade",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-hp-gas-turbine]",
		stack_size = 100
	},
		{
		type = "item",
		name = "msr-lp-gas-turbine",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[msr-lp-gas-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-lp-gas-shaft",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-lp-gas-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-lp-gas-disk",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-lp-gas-turbine]",
		stack_size = 50
	},
	{
		type = "item",
		name = "msr-lp-gas-blade",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-lp-gas-turbine]",
		stack_size = 100
	}
})

--////////////////////////////////////////
--Electric Grid Interface section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "gen-three-electric-grid-interface",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[gen-three-electric-grid-interface]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--MSR final assembly section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "msr",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-finals",
		order = "z3[msr]",
		place_result = "msr",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-online-repro-fac",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[msr-online-repro-fac]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-underground-century-storage-fac",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-intermediate",
		order = "h[msr-underground-century-storage-fac]",
		stack_size = 1
	}
})