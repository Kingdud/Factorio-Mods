local nimh_tint = {r = .75, b = .5, g = .5, a = 1}
local li_tint = {r = 0, b = 1, g = 0, a = 1}
local dead_flywheel_tint = {r = .1, b = .1, g = .1, a = 1}

--/////////////////////
--NiMH battery
--/////////////////////
local entity_nimh = table.deepcopy(data.raw.accumulator["accumulator"])
entity_nimh.charge_animation.layers[1].layers[1].tint = nimh_tint
entity_nimh.charge_animation.layers[1].layers[1].hr_version.tint = nimh_tint
entity_nimh.discharge_animation.layers[1].layers[1].tint = nimh_tint
entity_nimh.discharge_animation.layers[1].layers[1].hr_version.tint = nimh_tint
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
entity_nimh.charge_animation.layers[1].layers[1].tint = li_tint
entity_nimh.charge_animation.layers[1].layers[1].hr_version.tint = li_tint
entity_nimh.discharge_animation.layers[1].layers[1].tint = li_tint
entity_nimh.discharge_animation.layers[1].layers[1].hr_version.tint = li_tint
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
entity_dead_li.animation[1].tint = li_tint
entity_dead_li.animation[1].hr_version.tint = li_tint
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
--custom graphics...I hate doing custom graphics! If you actually like this sort of work talk to me!
local flywheel_scale = .75
local flywheel_shift = {.75,-0.125}
local flywheel_shadow_scale = flywheel_scale
--why the shadow and normal image need two different offsets...~mysteries of Factorio~
local flywheel_shadow_shift = {.875,-0.125}
local entity_paths = {entity_flywheel.picture.layers[1], entity_flywheel.charge_animation.layers[1].layers[1], entity_flywheel.discharge_animation.layers[1].layers[1]}
local shadow_paths = {entity_flywheel.picture.layers[2], entity_flywheel.charge_animation.layers[1].layers[2], entity_flywheel.discharge_animation.layers[1].layers[2]}
for i = 1,#entity_paths
do
	basepath = entity_paths[i]
	basepath.filename = "__EnhancedGridEnergyStores__/graphics/entity/entity-flywheel.png"
	basepath.height = 123
	basepath.width = 157
	basepath.scale = flywheel_scale
	basepath.shift = flywheel_shift
	basepath.hr_version.filename = "__EnhancedGridEnergyStores__/graphics/entity/entity-flywheel.png"
	basepath.hr_version.height = 123
	basepath.hr_version.width = 157
	basepath.hr_version.scale = flywheel_scale
	basepath.hr_version.shift = flywheel_shift
end

for i = 1,#shadow_paths
do
	basepath = shadow_paths[i]
	basepath.filename = "__EnhancedGridEnergyStores__/graphics/entity/flywheel-shadow.png"
	basepath.height = 123
	basepath.width = 157
	basepath.scale = flywheel_shadow_scale
	basepath.shift = flywheel_shadow_shift
	basepath.hr_version.filename = "__EnhancedGridEnergyStores__/graphics/entity/flywheel-shadow.png"
	basepath.hr_version.height = 123
	basepath.hr_version.width = 157
	basepath.hr_version.scale = flywheel_shadow_scale
	basepath.hr_version.shift = flywheel_shadow_shift
end
entity_flywheel.icon = "__EnhancedGridEnergyStores__/graphics/icons/flywheel.png"
entity_flywheel.icon_size = 128

--Make object bigger, 3x3
entity_flywheel.collision_box = {
	{
	  -1.4,
	  -1.4
	},
	{
	  1.4,
	  1.4
	}
}
entity_flywheel.selection_box = {
	{
	  -1.5,
	  -1.5
	},
	{
	  1.5,
	  1.5
	}
}
entity_flywheel.energy_source = {
	buffer_capacity = "91GJ",
    input_flow_limit = "21GW",
    output_flow_limit = "21GW",
    type = "electric",
    usage_priority = "tertiary"
}

data:extend({entity_flywheel})

--/////////////////////
--Flywheel -- personal edition
--/////////////////////

local p_flywheel = table.deepcopy(data.raw["battery-equipment"]["battery-mk2-equipment"])

--I didn't bother changing this because the default in-equipment batteries are so OP compared to normal accumulators.
p_flywheel.energy_source = {
	buffer_capacity = "91GJ",
    input_flow_limit = "21GW",
    output_flow_limit = "21GW",
    type = "electric",
    usage_priority = "tertiary"
}
p_flywheel.name = "p-flywheel-grid-battery"
p_flywheel.sprite.filename = "__EnhancedGridEnergyStores__/graphics/icons/flywheel.png"
p_flywheel.sprite.height = 128
p_flywheel.sprite.width = 128
p_flywheel.sprite.tint = {r= .8, g = .1, b = 0, a = 1}
p_flywheel.shape.width = 2

data:extend({p_flywheel})

--to-do:
--local entity_dead_flywheel = table.deepcopy(data.raw.corpse["accumulator-remnants"])
--entity_dead_flywheel.animation[1].tint = dead_flywheel_tint
--entity_dead_flywheel.animation[1].hr_version.tint = dead_flywheel_tint
--entity_dead_flywheel.name = "flywheel-remnants"
--data:extend({entity_dead_flywheel})