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
		name = "lwr-steam-generator",
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b-[lwr-steam-generator]",
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
		icon = "__base__/graphics/icons/nuclear-reactor.png",
		icon_size = 32,
		subgroup = "nuclear-common",
		order = "b[turbine-disk-blank]",
		stack_size = 1
	}
})