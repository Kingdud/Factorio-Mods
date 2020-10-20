data:extend({
    {
		icons = {
			{
				icon = "__base__/graphics/icons/laser-turret.png",
				tint = {r= .8, g = .1, b = 0, a = 1},
				icon_mipmaps = 4,
				icon_size = 64,
			}
		},
		name = "pulse-laser",
		order = "b[turret]-b[pulse-laser]",
		place_result = "pulse-laser",
		stack_size = 50,
		subgroup = "defensive-structure",
		type = "item"
    },
	{
		default_request_amount = 1,
		icons = {
			{
				icon = "__base__/graphics/icons/personal-laser-defense-equipment.png",
				tint = {r= .8, g = .1, b = 0, a = 1},
				icon_mipmaps = 4,
				icon_size = 64,
			}
		},
		name = "p-pulse-laser",
		order = "b[active-defense]-a[p-pulse-laser]",
		placed_as_equipment_result = "p-pulse-laser",
		stack_size = 20,
		subgroup = "military-equipment",
		type = "item"
    }
})