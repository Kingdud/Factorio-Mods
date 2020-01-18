local new_dmg_per_shot = 46
local increase_factor = new_dmg_per_shot / 20
local energy_per_shot_kj = increase_factor * 800

local new_beam = table.deepcopy(data.raw.beam["laser-beam"])

new_beam.action.action_delivery.target_effects[1].damage.amount = new_dmg_per_shot
new_beam.damage_interval = 6
new_beam.name = "pulse-laser-beam"

data:extend({new_beam})

data.raw["electric-turret"]["laser-turret"].fast_replaceable_group = "energy-turret"

local new_item = table.deepcopy(data.raw["electric-turret"]["laser-turret"])
new_item.base_picture.layers[1].tint = {r= .8, g = .1, b = 0, a = 1}
new_item.base_picture.layers[1].hr_version.tint = {r= .8, g = .1, b = 0, a = 1}
new_item.folded_animation.layers[1].tint = {r= .8, g = .1, b = 0, a = 1}
new_item.folded_animation.layers[1].hr_version.tint = {r= .8, g = .1, b = 0, a = 1}
new_item.folding_animation.layers[1].tint = {r= .8, g = .1, b = 0, a = 1}
new_item.folding_animation.layers[1].hr_version.tint = {r= .8, g = .1, b = 0, a = 1}
new_item.prepared_animation.layers[1].tint = {r= .8, g = .1, b = 0, a = 1}
new_item.prepared_animation.layers[1].hr_version.tint = {r= .8, g = .1, b = 0, a = 1}
new_item.preparing_animation.layers[1].tint = {r= .8, g = .1, b = 0, a = 1}
new_item.preparing_animation.layers[1].hr_version.tint = {r= .8, g = .1, b = 0, a = 1}

new_item.name = "pulse-laser"
new_item.minable.result="pulse-laser"
new_item.attack_parameters.ammo_type.action.action_delivery.duration = 6
new_item.attack_parameters.ammo_type.action.action_delivery.beam = "pulse-laser-beam"
--We removed the 2x dmg modifer, but we are still doing 2.5x the base damage, so 2.5x the energy cost per shot.
new_item.attack_parameters.ammo_type.energy_consumption = tostring(energy_per_shot_kj) .. "kJ"
new_item.attack_parameters.cooldown = 6
new_item.attack_parameters.damage_modifier = 1
new_item.energy_source.buffer_capacity = tostring(energy_per_shot_kj+1) .. "kJ"
new_item.energy_source.input_flow_limit = "400MW"
new_item.fast_replaceable_group = "energy-turret"
new_item.hide_resistances = false
new_item.resistances =
{
	{
		type = "acid",
		decrease = 10,
		percent = 30
	},
	{
		type = "physical",
		decrease = 25,
		percent = 30
	}
}

data:extend({new_item})