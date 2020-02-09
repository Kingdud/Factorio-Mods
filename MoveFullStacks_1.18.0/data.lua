data:extend(
{
	{
		type = "technology",
		name = "actual-stacks-fifty",
		icon = "__MoveFullStacks__/graphics/stack-inserter-50.png",
		icon_size = 32,
		effects =
		{
			{
				type = "stack-inserter-capacity-bonus",
				modifier = 38,
			},
			{type = "unlock-recipe", recipe = "long-stack-inserter" },
			{type = "unlock-recipe", recipe = "near-side-inserter" }
		},
		prerequisites = {"inserter-capacity-bonus-7"},
		unit =
		{
			count = 2500,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
	{
		type = "technology",
		name = "actual-stacks-hundred",
		icon = "__MoveFullStacks__/graphics/stack-inserter-100.png",
		icon_size = 32,
		effects =
		{
			{
				type = "stack-inserter-capacity-bonus",
				modifier = 50,
			}
		},
		prerequisites = {"actual-stacks-fifty"},
		unit =
		{
			count = 25000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
	{
		type = "technology",
		name = "actual-stacks-twohundred",
		icon = "__MoveFullStacks__/graphics/stack-inserter-200.png",
		icon_size = 32,
		effects =
		{
			{
				type = "stack-inserter-capacity-bonus",
				modifier = 100,
			},
		},
		prerequisites = {"actual-stacks-hundred"},
		unit =
		{
			count = 125000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},		
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}	
			},
			time = 60
		},
		order = "a-b-c"
	},
})

--/////////////////////////////
--Long Arm inserter stuff
--/////////////////////////////
local newTint = {r= 1, g = 0, b = 0, a = 1}
--Item
local newitem = util.table.deepcopy(data.raw.item["stack-inserter"])
newitem.name = "long-stack-inserter"
newitem.place_result = "long-stack-inserter"
newitem.order = "f[long-stack-inserter]"
newitem.icon = nil
newitem.icons = {
	{
		icon = "__base__/graphics/icons/stack-inserter.png",
		tint = newTint,
		icon_size = 32
	}
}
data:extend({newitem})

--Entity
local newentity = util.table.deepcopy(data.raw["inserter"]["stack-inserter"])
newentity.name = "long-stack-inserter"
newentity.minable.result = "long-stack-inserter"
newentity.hand_size = 1.5
newentity.fast_replaceable_group = "long-handed-inserter"
newentity.insert_position = {0, 2.2000000000000002}
newentity.pickup_position = {0, -2}
newentity.energy_per_movement = "100kJ"
newentity.energy_per_rotation = "100kJ"
newentity.extension_speed = 0.045699999999999994
newentity.rotation_speed = 0.02

--colorize artwork
newentity.hand_base_picture.tint = newTint
newentity.hand_base_picture.hr_version.tint = newTint
newentity.hand_closed_picture.tint = newTint
newentity.hand_closed_picture.hr_version.tint = newTint
newentity.hand_open_picture.tint = newTint
newentity.hand_open_picture.hr_version.tint = newTint
newentity.platform_picture.sheet.tint = newTint
newentity.platform_picture.sheet.hr_version.tint = newTint
newentity.icon = nil
newentity.icons = {
	{
		icon = "__base__/graphics/icons/stack-inserter.png",
		tint = newTint,
		icon_size = 32
	}
}
data:extend({newentity})

--Recipe
data:extend({
	{
		enabled = false,
		ingredients = {
			{"stack-inserter", 1},
			{"electric-engine-unit", 1},
			{"steel-plate", 1}
		},
		name = "long-stack-inserter",
		result = "long-stack-inserter",
		type = "recipe"
	}
})

--/////////////////////////////
--Near-side inserter stuff
--/////////////////////////////
local newTint = {r= .2, g = .2, b = .2, a = 1}
--Item
local newitem = util.table.deepcopy(data.raw.item["fast-inserter"])
newitem.name = "near-side-inserter"
newitem.place_result = "near-side-inserter"
newitem.order = "f[near-side-inserter]"
newitem.icon = nil
newitem.icons = {
	{
		icon = "__base__/graphics/icons/inserter.png",
		tint = newTint,
		icon_size = 32
	}
}
data:extend({newitem})

--Entity
local newentity = util.table.deepcopy(data.raw["inserter"]["fast-inserter"])
newentity.name = "near-side-inserter"
newentity.minable.result = "near-side-inserter"
newentity.insert_position = {0, .9}
--newentity.pickup_position = {0, -1}

--colorize artwork
newentity.hand_base_picture.tint = newTint
newentity.hand_base_picture.hr_version.tint = newTint
newentity.hand_closed_picture.tint = newTint
newentity.hand_closed_picture.hr_version.tint = newTint
newentity.hand_open_picture.tint = newTint
newentity.hand_open_picture.hr_version.tint = newTint
newentity.platform_picture.sheet.tint = newTint
newentity.platform_picture.sheet.hr_version.tint = newTint
newentity.icon = nil
newentity.icons = {
	{
		icon = "__base__/graphics/icons/inserter.png",
		tint = newTint,
		icon_size = 32
	}
}
data:extend({newentity})

--Recipe
data:extend({
	{
		enabled = false,
		ingredients = {
			{"fast-inserter", 1},
		},
		name = "near-side-inserter",
		result = "near-side-inserter",
		type = "recipe"
	}
})