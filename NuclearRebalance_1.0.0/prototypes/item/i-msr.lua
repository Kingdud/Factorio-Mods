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
		icon = "__NuclearRebalance__/graphics/icons/turbine-shaft-hp-gen3.png",
		icon_size = 128,
		subgroup = "msr-common",
		order = "g[msr-hp-gas-shaft]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-hp-gas-disk",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "msr-common",
		order = "g[msr-hp-gas-disk]",
		stack_size = 50
	},
	{
		type = "item",
		name = "msr-hp-gas-blade",
		icon = "__NuclearRebalance__/graphics/icons/turbine-blade-hp-gen3.png",
		icon_size = 128,
		subgroup = "msr-common",
		order = "g[msr-hp-gas-blade]",
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
		order = "g[msr-lp-gas-shaft]",
		stack_size = 1
	},
	{
		type = "item",
		name = "msr-lp-gas-disk",
		icon = "__NuclearRebalance__/graphics/icons/turbine-disk-lp-gen3.png",
		icon_size = 128,
		subgroup = "msr-common",
		order = "g[msr-lp-gas-disk]",
		stack_size = 50
	},
	{
		type = "item",
		name = "msr-lp-gas-blade",
		icon = "__NuclearRebalance__/graphics/icons/turbine-blade-lp-gen3.png",
		icon_size = 128,
		subgroup = "msr-common",
		order = "g[msr-lp-gas-blade]",
		stack_size = 100
	},
	{
		type = "item",
		name = "msr-helium-gas",
		icon = "__NuclearRebalance__/graphics/icons/msr-helium.png",
		icon_size = 128,
		subgroup = "msr-common",
		order = "g[msr-helium-gas]",
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
		icon = "__NuclearRebalance__/graphics/icons/i-msr.png",
		icon_size = 128,
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