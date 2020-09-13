local function teleporter(tier, time, ingredients)
	data:extend({
		{
			type = "recipe",
			name = "bulkteleport-send"..tier,
			category = "crafting",
			subgroup = "bulkteleport",
			enabled = false,
			icon = "__bulkteleport__/graphics/send"..tier..".png",
			icon_size = 32,
			ingredients = ingredients,
			results = {
				{ type = "item", name = "bulkteleport-send"..tier, amount = 1 },
			},
			hidden = false,
			energy_required = 10.0,
			order = "a"..tier,
		},
		{
			type = "recipe",
			name = "bulkteleport-recv"..tier,
			category = "crafting",
			subgroup = "bulkteleport",
			enabled = false,
			icon = "__bulkteleport__/graphics/recv"..tier..".png",
			icon_size = 32,
			ingredients = ingredients,
			results = {
				{ type = "item", name = "bulkteleport-recv"..tier, amount = 1 },
			},
			hidden = false,
			energy_required = 10.0,
			order = "b"..tier,
		},
	})

	-- rough range-based energy cost
	for i = 1,10,1 do
		data:extend({{
			type = "recipe",
			name = "bulkteleport-job-"..i.."-"..tier,
			category = "bulkteleport",
			subgroup = "bulkteleport",
			enabled = true,
			icon = "__bulkteleport__/graphics/job.png",
			icon_size = 32,
			ingredients = {
				{ type = "item", name = "bulkteleport-job-"..i.."-"..tier, amount = 1 },
			},
			results = {
				{ type = "item", name = "bulkteleport-job-"..i.."-"..tier, amount = 1, probability = 0 },
			},
			hidden = true,
			energy_required = time+(i-1),
			order = "c",
		}})
	end
end

local cycle = 10

teleporter(1, cycle, {
	{ type = "item", name = "advanced-circuit", amount = 50 },
	{ type = "item", name = "concrete", amount = 100 },
	{ type = "item", name = "steel-plate", amount = 100 },
	{ type = "item", name = "accumulator", amount = 50 },
})

teleporter(2, cycle*1.5, {
	{ type = "item", name = "processing-unit", amount = 25 },
	{ type = "item", name = "concrete", amount = 150 },
	{ type = "item", name = "steel-plate", amount = 150 },
	{ type = "item", name = "accumulator", amount = 75 },
})

teleporter(3, cycle, {
	{ type = "item", name = "advanced-circuit", amount = 50 },
	{ type = "item", name = "concrete", amount = 100 },
	{ type = "item", name = "steel-plate", amount = 100 },
	{ type = "item", name = "accumulator", amount = 50 },
})

teleporter(4, cycle*1.5, {
	{ type = "item", name = "processing-unit", amount = 25 },
	{ type = "item", name = "concrete", amount = 150 },
	{ type = "item", name = "steel-plate", amount = 150 },
	{ type = "item", name = "accumulator", amount = 75 },
})
