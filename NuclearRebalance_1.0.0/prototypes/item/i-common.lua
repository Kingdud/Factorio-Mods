--////////////////////////////////////////
--Smoke for the Cooling Towers
--////////////////////////////////////////
local lwr_nuclear_smoke = util.table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"]);
lwr_nuclear_smoke.name = "lwr-cooling-tower-smoke";
lwr_nuclear_smoke.start_scale = 7
lwr_nuclear_smoke.end_scale = 5
data:extend({lwr_nuclear_smoke})
local lmr_nuclear_smoke = util.table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"]);
lmr_nuclear_smoke.name = "lmr-cooling-tower-smoke";
lmr_nuclear_smoke.start_scale = 12
lmr_nuclear_smoke.end_scale = 9
data:extend({lmr_nuclear_smoke})
local msr_nuclear_smoke = util.table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"]);
msr_nuclear_smoke.name = "msr-cooling-tower-smoke";
msr_nuclear_smoke.start_scale = 15
msr_nuclear_smoke.end_scale = 10
data:extend({msr_nuclear_smoke})

--////////////////////////////////////////
--Site Infrastructure section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "rebar",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[rebar]",
		stack_size = 100
	},
	{
		type = "item",
		name = "structural-concrete",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[structural-concrete]",
		stack_size = 100
	},
	{
		type = "item",
		name = "purified-water-tank",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[purified-water-tank]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--RPV section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "steam-generator",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b-[steam-generator]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--Electric Grid Interface section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "switchgear",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[switchgear]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--Turbine section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "turbine-disk-blank",
		icon = "__NuclearRebalance__/graphics/icons/turbine-disk-blank.png",
		icon_size = 64,
		subgroup = "nuclear-common",
		order = "b[turbine-disk-blank]",
		stack_size = 1
	}
})

--////////////////////////////////////////
--Misc/Components section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "adv-nickel-alloy",
		icon = "__base__/graphics/icons/steel-plate.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[adv-nickel-alloy]",
		stack_size = 100
	},
	{
		type = "item",
		name = "corrosion-resist-pipe",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[corrosion-resist-pipe]",
		stack_size = 100
	},
	{
		type = "item",
		name = "water-heat-exchanger",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[water-heat-exchanger]",
		stack_size = 100
	},
	{
		type = "item",
		name = "adv-heat-exchanger",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[adv-heat-exchanger]",
		stack_size = 100
	},
})