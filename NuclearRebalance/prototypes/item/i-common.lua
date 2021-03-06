--////////////////////////////////////////
--Smoke for the Cooling Towers
--////////////////////////////////////////
local lwr_nuclear_smoke = util.table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"]);
lwr_nuclear_smoke.name = "lwr-cooling-tower-smoke";
lwr_nuclear_smoke.start_scale = 7
lwr_nuclear_smoke.end_scale = 3.5
data:extend({lwr_nuclear_smoke})
local lmr_nuclear_smoke = util.table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"]);
lmr_nuclear_smoke.name = "lmr-cooling-tower-smoke";
lmr_nuclear_smoke.start_scale = 8
lmr_nuclear_smoke.end_scale = 4
data:extend({lmr_nuclear_smoke})
local msr_nuclear_smoke = util.table.deepcopy(data.raw["trivial-smoke"]["turbine-smoke"]);
msr_nuclear_smoke.name = "msr-cooling-tower-smoke";
msr_nuclear_smoke.start_scale = 15
msr_nuclear_smoke.end_scale = 7.5
data:extend({msr_nuclear_smoke})

--////////////////////////////////////////
--Site Infrastructure section
--////////////////////////////////////////
data:extend({
	{
		type = "item",
		name = "rebar",
		icon = "__NuclearRebalance__/graphics/icons/rebar.png",
		icon_size = 128,
		subgroup = "nuclear-common",
		order = "b[rebar]",
		stack_size = 100
	},
	{
		type = "item",
		name = "structural-concrete",
		icon = "__NuclearRebalance__/graphics/icons/structural-concrete.png",
		icon_size = 128,
		subgroup = "nuclear-common",
		order = "b[structural-concrete]",
		stack_size = 100
	},
	{
		type = "item",
		name = "purified-water-tank",
		icon = "__NuclearRebalance__/graphics/icons/purified-water-tank.png",
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
		icon = "__NuclearRebalance__/graphics/icons/steam-generator.png",
		icon_size = 128,
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
		icon = "__NuclearRebalance__/graphics/icons/switchgear.png",
		icon_size = 128,
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
		icon = "__NuclearRebalance__/graphics/icons/adv-nickel-alloy.png",
		icon_size = 128,
		subgroup = "nuclear-common",
		order = "b[adv-nickel-alloy]",
		stack_size = 100
	},
	{
		type = "item",
		name = "corrosion-resist-pipe",
		icon = "__NuclearRebalance__/graphics/icons/corrosion-resist-pipe.png",
		icon_size = 128,
		subgroup = "nuclear-common",
		order = "b[corrosion-resist-pipe]",
		stack_size = 100
	},
	{
		type = "item",
		name = "water-heat-exchanger",
		icon = "__NuclearRebalance__/graphics/icons/water-heat-exchanger.png",
		icon_size = 128,
		subgroup = "nuclear-common",
		order = "b-heatex-[water-heat-exchanger]",
		stack_size = 100
	},
	{
		type = "item",
		name = "adv-heat-exchanger",
		icon = "__NuclearRebalance__/graphics/icons/adv-heat-exchanger.png",
		icon_size = 128,
		subgroup = "nuclear-common",
		order = "b-heatex-[adv-heat-exchanger]",
		stack_size = 100
	},
})