local nimh_tint = {r = .75, b = .5, g = .5, a = 1}
local li_tint = {r = 0, b = 1, g = 0, a = 1}

--/////////////////////
--NiMH battery
--/////////////////////
local entity_nimh = table.deepcopy(data.raw.accumulator["accumulator"])
--entity_nimh.charge_animation.layers[1].layers[1].tint = nimh_tint
--entity_nimh.charge_animation.layers[1].layers[1].hr_version.tint = nimh_tint
--entity_nimh.discharge_animation.layers[1].layers[1].tint = nimh_tint
--entity_nimh.discharge_animation.layers[1].layers[1].hr_version.tint = nimh_tint
entity_nimh.name = "nimh-grid-battery"
entity_nimh.corpse = "nimh-remnants"
entity_nimh.minable.result = "nimh-grid-battery"
entity_nimh.picture.layers[1].tint = nimh_tint
entity_nimh.picture.layers[1].hr_version.tint = nimh_tint
entity_nimh.energy_source = {
	buffer_capacity = "11GJ",
    input_flow_limit = "650MW",
    output_flow_limit = "650MW",
    type = "electric",
    usage_priority = "tertiary"
}
data:extend({entity_nimh})

local entity_dead_nimh = table.deepcopy(data.raw.corpse["accumulator-remnants"])
entity_dead_nimh.animation[1].tint = nimh_tint
entity_dead_nimh.animation[1].hr_version.tint = nimh_tint
entity_dead_nimh.name = "nimh-remnants"
data:extend({entity_dead_nimh})

--/////////////////////
--Li-ion battery
--/////////////////////
local entity_li = table.deepcopy(data.raw.accumulator["accumulator"])
entity_li.name = "li-ion-grid-battery"
entity_li.corpse = "li-ion-remnants"
entity_li.minable.result = "li-ion-grid-battery"
entity_li.picture.layers[1].tint = li_tint
entity_li.picture.layers[1].hr_version.tint = li_tint
entity_li.energy_source = {
	buffer_capacity = "19GJ",
    input_flow_limit = "1.1GW",
    output_flow_limit = "1.1GW",
    type = "electric",
    usage_priority = "tertiary"
}

data:extend({entity_li})

local entity_dead_li = table.deepcopy(data.raw.corpse["accumulator-remnants"])
entity_dead_li.animation[1].tint = nimh_tint
entity_dead_li.animation[1].hr_version.tint = nimh_tint
entity_dead_li.name = "li-ion-remnants"
data:extend({entity_dead_li})

--/////////////////////
--Flywheel
--/////////////////////

local entity_flywheel = table.deepcopy(data.raw.accumulator["accumulator"])
entity_flywheel.name = "flywheel-grid-battery"
--to-do
--entity_flywheel.corpse = "flywheel-remnants"
entity_flywheel.minable.result = "flywheel-grid-battery"
--to-do: replace graphics.
entity_flywheel.picture.layers[1].tint = li_tint
entity_flywheel.picture.layers[1].hr_version.tint = li_tint
entity_flywheel.energy_source = {
	buffer_capacity = "91GJ",
    input_flow_limit = "21GW",
    output_flow_limit = "21GW",
    type = "electric",
    usage_priority = "tertiary"
}

data:extend({entity_flywheel})

--to-do:
--local entity_dead_flywheel = table.deepcopy(data.raw.corpse["accumulator-remnants"])
--entity_dead_flywheel.animation[1].tint = nimh_tint
--entity_dead_flywheel.animation[1].hr_version.tint = nimh_tint
--entity_dead_flywheel.name = "flywheel-remnants"
--data:extend({entity_dead_flywheel})