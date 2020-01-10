--////////////////////////////////////////
--Turbine Hall Items
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "lmr-turbine-hall",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-turbine-hall.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-turbine-hall]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-hp-turbine",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-hp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-hp-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-lp-turbine",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-lp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-lp-turbine]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-hp-turbine-shaft",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-shaft-hp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-hp-turbine-shaft]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-lp-turbine-shaft",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-shaft-lp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-lp-turbine-shaft]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-hp-turbine-disk",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-disk-hp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-hp-turbine-disk]",
		stack_size = 5
	},
	{
		type = "item",
		name = "lmr-lp-turbine-disk",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-disk-lp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-lp-turbine-disk]",
		stack_size = 5
	},
	{
		type = "item",
		name = "lmr-hp-turbine-blade",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-blade-hp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-hp-turbine-blade]",
		stack_size = 20
	},
	{
		type = "item",
		name = "lmr-lp-turbine-blade",
		icon = "__NuclearRebalance__/graphics/icons/lmr/turbine-blade-lp-gen2.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-lp-turbine-blade]",
		stack_size = 20
	}
})

--////////////////////////////////////////
--Reactor Hall Item
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "lmr-reactor-hall",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-reactor-hall.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-reactor-hall]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-reactor-vessel",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-reactor-vessel.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-reactor-vessel]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-heat-exchange-loop",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-heat-exchange-loop.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-heat-exchange-loop]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-steam-loop",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-steam-loop.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f[lmr-steam-loop]",
		stack_size = 1
	},
	{
		type = "item",
		name = "lmr-em-pump",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-em-pump.png",
		icon_size = 128,
		subgroup = "lmr-common",
		order = "e[lmr-em-pump]",
		stack_size = 50
	},
	{
		type = "item",
		name = "lmr-sodium-coolant",
		icon = "__NuclearRebalance__/graphics/icons/lmr/lmr-sodium-coolant.png",
		icon_size = 32,
		subgroup = "lmr-common",
		order = "e[lmr-sodium-coolant]",
		stack_size = 100
	}
})

--////////////////////////////////////////
--Electric Grid Interface section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "gen-two-electric-grid-interface",
		icon = "__NuclearRebalance__/graphics/icons/lmr/gen-two-electric-grid-interface.png",
		icon_size = 128,
		subgroup = "lmr-intermediate",
		order = "f-1-[gen-two-electric-grid-interface]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--LMR Item
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "lmr",
		icon = "__NuclearRebalance__/graphics/icons/lmr/i-lmr.png",
		icon_size = 128,
		subgroup = "nuclear-finals",
		order = "z2[lmr]",
		place_result = "lmr",
		stack_size = 1
	}
})