local nimh_tint = {r = .75, b = .5, g = .5, a = 1}
local li_tint = {r = 0, b = 1, g = 0, a = 1}

--////////////////////////////////////////
--NiMH Battery section
--////////////////////////////////////////
local item_nimh = table.deepcopy(data.raw.item["accumulator"])
item_nimh.icon = nil
item_nimh.icons = {
	{
		icon = "__base__/graphics/icons/accumulator.png",
		tint = nimh_tint
	}
}
item_nimh.name = "nimh-grid-battery"
item_nimh.place_result = "nimh-grid-battery"
data:extend({item_nimh})

local item_nimh_foil = table.deepcopy(data.raw.item["iron-gear-wheel"])
item_nimh_foil.icon = nil
item_nimh_foil.icons = {
	{
		icon = "__EnhancedGridEnergyStores__/graphics/icons/nimh-foil.png",
		icon_size = 128,
		tint = nimh_tint
	}
}
item_nimh_foil.order = "c[iron-gear-wheel]b"
item_nimh_foil.name = "nimh-foil"
data:extend({item_nimh_foil})


--////////////////////////////////////////
--Li-Ion Battery section
--////////////////////////////////////////
local item_li = table.deepcopy(data.raw.item["accumulator"])
item_li.icon = nil
item_li.icons = {
	{
		icon = "__base__/graphics/icons/accumulator.png",
		tint = li_tint
	}
}
item_li.name = "li-ion-grid-battery"
item_li.place_result = "li-ion-grid-battery"

data:extend({item_li})

local item_li_foil = table.deepcopy(data.raw.item["iron-gear-wheel"])
item_li_foil.icon = nil
item_li_foil.icons = {
	{
		icon = "__EnhancedGridEnergyStores__/graphics/icons/li-ion-foil.png",
		icon_size = 128,
		tint = li_tint
	}
}
item_li_foil.order = "c[iron-gear-wheel]c"
item_li_foil.name = "li-foil"
data:extend({item_li_foil})

--////////////////////////////////////////
--Flywheel Battery section
--////////////////////////////////////////
local item_flywheel = table.deepcopy(data.raw.item["accumulator"])
item_flywheel.icon = "__EnhancedGridEnergyStores__/graphics/icons/flywheel.png"
item_flywheel.icon_size = 128
item_flywheel.name = "flywheel-grid-battery"
item_flywheel.place_result = "flywheel-grid-battery"

data:extend({item_flywheel})

local item_flywheel_segment = table.deepcopy(data.raw.item["iron-gear-wheel"])
item_flywheel_segment.icon = "__EnhancedGridEnergyStores__/graphics/icons/flywheel-segment.png"
item_flywheel_segment.icon_size = 128
item_flywheel_segment.order = "c[iron-gear-wheel]d"
item_flywheel_segment.name = "high-precision-flywheel-segment"
data:extend({item_flywheel_segment})

local item_vac_chamber = table.deepcopy(data.raw.item["iron-gear-wheel"])
item_vac_chamber.icon = "__EnhancedGridEnergyStores__/graphics/icons/vacuum-chamber.png"
item_vac_chamber.icon_size = 128
item_vac_chamber.order = "c[iron-gear-wheel]e"
item_vac_chamber.name = "vacuum-chamber"
data:extend({item_vac_chamber})
