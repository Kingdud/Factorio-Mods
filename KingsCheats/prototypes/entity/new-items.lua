require("prototypes.constants")

--///////////////////////////////
--Custom oil pump, no more pesky beacons!
--///////////////////////////////
local newpump = table.deepcopy(data.raw["mining-drill"]["pumpjack"])
for _,layer in pairs(newpump.animations.north.layers) do
	layer.tint = { r = 128, b = 128, g = 128, a = 255 }
end
newpump.energy_source.emissions_per_minute = 108
newpump.energy_source.drain = "5760kW"
newpump.energy_usage = "972kW"
newpump.minable.result = "super-pumpjack"
newpump.name = "super-pumpjack"
newpump.module_specification.module_slots = 0
newpump.allowed_effects = {}
newpump.mining_speed =  8

data:extend({newpump})

newpump = table.deepcopy(data.raw.item["pumpjack"])
newpump.name = "super-pumpjack"
newpump.place_result = "super-pumpjack"
newpump.icons = {
	{
		icon = "__base__/graphics/icons/pumpjack.png",
		tint = { r = 128, b = 128, g = 128, a = 255 }
	}
}
data:extend({newpump})

newpump = table.deepcopy(data.raw.recipe["pumpjack"])
newpump.name = "super-pumpjack"
newpump.result = "super-pumpjack"
newpump.ingredients = {
	{"pumpjack", 1},
	{"speed-module-3", 26},
	{"beacon", 12}
}
newpump.enabled = true
data:extend({newpump})

--///////////////////////////////
--Custom water pump
--///////////////////////////////
local newpump = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
for _,dir in pairs({"north", "east", "south", "west"})
do
	for _,layer in pairs(newpump.graphics_set.animation[dir].layers) do
		layer.tint = { r = 128, b = 128, g = 128, a = 255 }
		layer.hr_version.tint = { r = 128, b = 128, g = 128, a = 255 }
	end
end
newpump.pumping_speed = 200
newpump.minable.result = "super-offshore-pump"
newpump.name = "super-offshore-pump"
newpump.fluid_box.base_area = 10

data:extend({newpump})

newpump = table.deepcopy(data.raw.item["offshore-pump"])
newpump.name = "super-offshore-pump"
newpump.place_result = "super-offshore-pump"
newpump.icons = {
	{
		icon = "__base__/graphics/icons/offshore-pump.png",
		tint = { r = 128, b = 128, g = 128, a = 255 }
	}
}
data:extend({newpump})

newpump = table.deepcopy(data.raw.recipe["offshore-pump"])
newpump.name = "super-offshore-pump"
newpump.result = "super-offshore-pump"
newpump.ingredients = {
	{"offshore-pump", 10}
}
newpump.enabled = true
data:extend({newpump})