local nimh_tint = {r = 1, b = 0, g = 1, a = 1}
local li_tint = {r = 1, b = 0, g = 1, a = 1}


local entity_nimh = table.deepcopy(data.raw["accumulator"])
entity_nimh.accumulator.charge_animation.layers[1].layers[1].tint = nimh_tint
entity_nimh.accumulator.charge_animation.layers[1].layers[1].hr_version.tint = nimh_tint
entity_nimh.accumulator.discharge_animation.layers[1].layers[1].tint = nimh_tint
entity_nimh.accumulator.discharge_animation.layers[1].layers[1].hr_version.tint = nimh_tint
entity_nimh.accumulator.energy_source = {
	buffer_capacity = "11GJ",
    input_flow_limit = "650MW",
    output_flow_limit = "650MW",
    type = "electric",
    usage_priority = "tertiary"
}

data:extend({entity_nimh})



local entity_li = table.deepcopy(data.raw["accumulator"])
entity_li.accumulator.charge_animation.layers[1].layers[1].tint = li_tint
entity_li.accumulator.charge_animation.layers[1].layers[1].hr_version.tint = li_tint
entity_li.accumulator.discharge_animation.layers[1].layers[1].tint = li_tint
entity_li.accumulator.discharge_animation.layers[1].layers[1].hr_version.tint = li_tint
entity_li.accumulator.energy_source = {
	buffer_capacity = "19GJ",
    input_flow_limit = "1.1GW",
    output_flow_limit = "1.1GW",
    type = "electric",
    usage_priority = "tertiary"
}

data:extend({entity_li})