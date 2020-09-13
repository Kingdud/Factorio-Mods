local function teleporter(tier)
	data:extend({
		{
			type = "item",
			name = "bulkteleport-send"..tier,
			icon = "__Kingsbulkteleport__/graphics/send"..tier..".png",
			icon_size = 32,
			flags = {},
			stack_size = 10,
			place_result = "bulkteleport-send"..tier,
			subgroup = "bulkteleport",
			order = "a",
		},
		{
			type = "item",
			name = "bulkteleport-recv"..tier,
			icon = "__Kingsbulkteleport__/graphics/recv"..tier..".png",
			icon_size = 32,
			flags = {},
			stack_size = 10,
			place_result = "bulkteleport-recv"..tier,
			subgroup = "bulkteleport",
			order = "b",
		},
	})

	for i = 1,10,1 do
		data:extend({
			{
				type = "item",
				name = "bulkteleport-job-"..i.."-"..tier,
				icon = "__Kingsbulkteleport__/graphics/job.png",
				icon_size = 32,
				flags = {"hidden"},
				stack_size = 1,
			},
		})
	end
end

teleporter(1)
teleporter(2)
teleporter(3)
teleporter(4)
