ORDER_MAP = {
	["gc-asif"] = "a",
	["rc-asif"] = "b",
	["bc-asif"] = "c",
	["lds-asif"] = "e",
	["eng-asif"] = "d",
	["pla-asif"] = "f",
	["rf-asif"] = "h",
	["sfpg-asif"] = "g2",
	["sflo-asif"] = "g1",
	["sfho-asif"] = "g3",
	["rcu-asif"] = "i",
	["arty-shell-asif"] = "j",
	["oil-asif"] = "o1",
	["lc-asif"] = "o2",
	["hc-asif"] = "o3",
	["spd-3-asif"] = "z1",
	["prod-3-asif"] = "z2",
	["eff-3-asif"] = "z3",
	["beacon-asif"] = "z4",
}

function remove_radars()
	if DEBUG then
		log("debug remove_radars")
	end
	
	for _, surface in pairs(game.surfaces) do
		for _, entity in pairs(surface.find_entities_filtered{type= "radar"}) do
			if entity.name:sub(-string.len("-ass-radar")) == "-ass-radar" then
				entity.destroy()
			end
		end
	end
end

--Skip non-asif machines
function is_asif(name)
	return ORDER_MAP[name] ~= nil
end

function do_dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. do_dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function init_radar(asif)
	if DEBUG then
		log("debug init_radar " .. asif.unit_number)
	end
	
	if not is_asif(asif.name) then
		return
	end
	
	local position = asif.position
	local new_radar = asif.surface.create_entity{name = asif.name.."-ass-radar", position = {position.x, position.y }, force = "player"}
	global.radars[asif.unit_number]=new_radar
end

function rescan_for_radars(force)
	if not force.technologies["asif"].researched then
		return
	end

	for _, surface in pairs(game.surfaces) do
		for _, asif in pairs(surface.find_entities_filtered{type= "assembling-machine", force}) do
			init_radar(asif)
		end
	end
end

script.on_init(function()
	if DEBUG then
		log("debug script.on_init")
	end
	
	remove_radars()
	global.radars = {}

	for _, force in pairs (game.forces) do	
		rescan_for_radars(force)
	end
end)

script.on_configuration_changed(function()
	if DEBUG then
		log("debug script.on_configuration_changed")
	end

	remove_radars()
	for _, force in pairs (game.forces) do	
		rescan_for_radars(force)
	end
end)

script.on_event(defines.events.on_force_created,function(event)
	if DEBUG then
		log("debug script.on_event(defines.events.on_force_created fired")
	end

	rescan_for_radars(event.force)
end)

script.on_event( defines.events.on_console_chat, function(event)
	if DEBUG then
		log("debug script.on_event( defines.events.on_console_chat")
	end
	
	if event.message == "asif reset" then
		remove_radars()
		rescan_for_radars(game.players[event.player_index].force)
	end
end)

-- script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	-- if DEBUG then
		-- log("debug script.on_event(defines.events.on_runtime_mod_setting_changed")
	-- end
	
	-- if event.setting == "TS_research_enabled" then
		-- global.research_enabled = settings.global["TS_research_enabled"].value
		-- if not global.research_enabled then
			-- game.players[event.player_index].force.technologies["turret-shields-base"].researched = true
		-- end
		-- rescan_for_turrets(game.players[event.player_index].force)
		-- setTechAndRecipes(game.players[event.player_index].force)
		-- update_electricity_force(game.players[event.player_index].force)
	-- end
	
	-- if event.setting == "TS_alternate_effect" then
		-- global.alternate_effect = settings.global["TS_alternate_effect"].value
	-- end
-- end)

script.on_event(defines.events.script_raised_revive,function(event)
	if DEBUG then
		log("debug script.on_event(defines.events.script_raised_revive")
	end
	
	if event.entity.type == "assembling-machine" then
		init_radar(event.entity)
	end
end)

script.on_event({defines.events.on_robot_built_entity,defines.events.on_built_entity,defines.events.script_raised_revive,defines.events.script_raised_built,defines.events.on_entity_cloned},function(event)
	if DEBUG then
		log("debug script.on_event({defines.events.on_robot_built_entity")
	end
	
	local entity = event.created_entity or event.entity or event.destination
	if entity.type == "assembling-machine" then
		init_radar(entity)
	end
end)

--Building
script.set_event_filter(defines.events.on_robot_built_entity, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.on_built_entity, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.script_raised_revive, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.script_raised_built, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.on_entity_cloned, {{filter = "crafting-machine"}})

--Destroying/removing
--script.set_event_filter(defines.events.on_entity_died, {{filter = "turret"}, {filter = "name", name = "turret-shield-combinator"}})
script.set_event_filter(defines.events.on_player_mined_entity, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.on_robot_mined_entity, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.script_raised_destroy, {{filter = "crafting-machine"}})

-----------------------------------------------------------------------------------------------------------------------------------------------------------

script.on_event({defines.events.on_entity_died,defines.events.on_player_mined_entity,defines.events.on_robot_mined_entity,defines.events.script_raised_destroy},function(event)
	if DEBUG then
		log("debug script.on_event({defines.events.on_entity_died")
	end
	
	if event.entity.type == "assembling-machine" then
		if not is_asif(event.entity.name) then
			return
		end
		
		global.radars[event.entity.unit_number].destroy()
		global.radars[event.entity.unit_number] = nil
	end
end)