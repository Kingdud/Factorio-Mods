local neutral_flags = {"not-repairable", "not-blueprintable", "not-deconstructable", "placeable-off-grid", "not-on-map", "placeable-neutral"}

function ts_createEntityRadar()
	local new_entity = util.table.deepcopy(data.raw.radar.radar)
	new_entity.max_distance_of_nearby_sector_revealed = 1
	new_entity.max_distance_of_sector_revealed = 0
	new_entity.energy_source = {type = "void"}
	new_entity.name = "ts-radar"
	new_entity.minable = nil
	new_entity.collision_box = nil
	new_entity.damaged_trigger_effect = nil
	new_entity.flags = {"not-blueprintable", "hidden", "hide-alt-info", "placeable-player"}
	new_entity.integration_patch = nil
	new_entity.selection_box = nil
	new_entity.water_reflection = nil
	new_entity.working_sound = nil
	new_entity.collision_mask = {}
	new_entity.pictures = {
        layers = {
          {
			direction_count = 1,
            filename = "__KingsTurret-Shields__/graphics/radar.png",
            height = 32,
            priority = "low",
            width = 32
          },
		}
	}	
	data:extend({new_entity})
end
ts_createEntityRadar()

--These have to be here since the global variable doesn't exist when this file is parsed.
local energy_consumption_multiplier = settings.startup["TS_energy_consumption_multiplier"].value
local power_usage = settings.startup["TS_power_drain"].value/100

local max_research_lvl = settings.startup["TS_max_research_level"].value

--outer loop = Shield size iteration
for size=-1,max_research_lvl,1 do
	--outer loop = Shield charge rate iteration
	for rate=-1,max_research_lvl,1 do
		capacity, recharge = getShieldValues(size, rate)
		local drain = (capacity/energy_consumption_multiplier) * power_usage
	
		data:extend({
			{
				type = "electric-energy-interface",
				name = "ts-electric-interface-"..size.."-"..rate,
				icon = "__KingsTurret-Shields__/graphics/entity_icon.png",
				icon_size = 128,
				flags = neutral_flags, --{"not-blueprintable", "placeable-neutral", "placeable-off-grid", "not-on-map"},
				subgroup = "wrecks",
				order = "d[remnants]-d[ship-wreck]-b[medium]-a",
				max_health = 200,
				collision_mask={"floor-layer"},
				selection_box = {{-1, -1 }, {1, 1}},
				alert_icon_shift = {0,0.08},
				render_layer = "entity-info-icon",
				selectable_in_game=false,
				energy_source =
				{
					type = "electric",
					usage_priority = "secondary-input",
					input_flow_limit = recharge + drain .. "kW",
					buffer_capacity = capacity .. "kJ",
					drain = drain .. "kW",
				},
				enable_gui = false,
			},-------------------------------------------------------------------------------------------------------------------------------
		
		})
	end
end