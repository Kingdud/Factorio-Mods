local item_nimh_satelite = table.deepcopy(data.raw.item["satelite"])
item_nimh_satelite.icon = nil
item_nimh_satelite.icons = {
	{
		icon = "__base__/graphics/icons/satelite.png",
		tint = {r= 1, g = .647, b = 0, a = 1},
		icon_size = 32
	}
}
item_nimh_satelite.rocket_launch_product =
{
	--1.0, 'I have this new battery, let's use it instead and simplfy our production chain!'
    {"space-science-pack", 1000}
}
item_nimh_satelite.name = "nimh-satelite"


local item_li-ion_satelite = table.deepcopy(data.raw.item["satelite"])
item_li-ion_satelite.icon = nil
item_li-ion_satelite.icons = {
	{
		icon = "__base__/graphics/icons/satelite.png",
		tint = {r= 1, g = .647, b = .25, a = 1},
		icon_size = 32
	}
}
item_li-ion_satelite.rocket_launch_product =
{
	--2.0 'I have an even newer battery. Hey, I betcha I can make use of all this extra power I've got...
    {"space-science-pack", 2000}
}

item_li-ion_satelite.name = "li-ion-satelite"


local item_flywheel_satelite = table.deepcopy(data.raw.item["satelite"])
item_flywheel_satelite.icon = nil
item_flywheel_satelite.icons = {
	{
		icon = "__base__/graphics/icons/satelite.png",
		tint = {r= .5, g = .647, b = .5, a = 1},
		icon_size = 32
	}
}
item_flywheel_satelite.rocket_launch_product =
{
	--3.0, 'I have this hugely dense battery, and these great generators. Let's make a deep space probe!'
    {"space-science-pack", 8000}
}
item_flywheel_satelite.result = "flywheel-satelite"
item_flywheel_satelite.name = "flywheel-satelite"