function remove_radars()
	if DEBUG then
		log("debug remove_radars")
	end
	
	for _, surface in pairs(game.surfaces) do
		for _, entity in pairs(surface.find_entities_filtered{type= "radar"}) do
			if entity.name:sub(-string.len("-bs-radar")) == "-bs-radar" then
				entity.destroy()
			end
		end
	end
end

--Skip non-bulk smelters
function is_bulk_processor(name)
	return name:sub(1, string.len("bulk-")) == "bulk-"
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

function init_radar(bulk_processor)
	if DEBUG then
		log("debug init_radar " .. bulk_processor.unit_number)
	end

	if not is_bulk_processor(bulk_processor.name) then
		return
	end

	local position = bulk_processor.position
	local new_radar = bulk_processor.surface.create_entity{name = bulk_processor.name.."-bs-radar", position = {position.x, position.y }, force = bulk_processor.force}
	global.radars[bulk_processor.unit_number]=new_radar
end

function rescan_for_radars(the_force)
	-- if not the_force.technologies["bulk-smelters"].researched then
		-- return
	-- end
	
	for _, surface in pairs(game.surfaces) do
		for _, bulk_processor in pairs(surface.find_entities_filtered{type= "assembling-machine", force=the_force}) do
			init_radar(bulk_processor)
		end
		for _, bulk_processor in pairs(surface.find_entities_filtered{type= "furnace", force=the_force}) do
			init_radar(bulk_processor)
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
	
	if event.message == "bulk_processor reset" then
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
	
	if event.entity.type == "assembling-machine" or entity.type == "furnace" then
		init_radar(event.entity)
	end
end)

script.on_event({defines.events.on_robot_built_entity,defines.events.on_built_entity,defines.events.script_raised_revive,defines.events.script_raised_built,defines.events.on_entity_cloned},function(event)
	if DEBUG then
		log("debug script.on_event({defines.events.on_robot_built_entity")
	end
	
	local entity = event.created_entity or event.entity or event.destination
	if entity.type == "assembling-machine" or entity.type == "furnace" then
		init_radar(entity)
	end
end)

--Building
script.set_event_filter(defines.events.on_robot_built_entity, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})
script.set_event_filter(defines.events.on_built_entity, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})
script.set_event_filter(defines.events.script_raised_revive, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})
script.set_event_filter(defines.events.script_raised_built, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})
script.set_event_filter(defines.events.on_entity_cloned, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})

--Destroying/removing
script.set_event_filter(defines.events.on_entity_died, {{filter = "crafting-machine"}})
script.set_event_filter(defines.events.on_player_mined_entity, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})
script.set_event_filter(defines.events.on_robot_mined_entity, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})
script.set_event_filter(defines.events.script_raised_destroy, {{filter = "crafting-machine"}, {filter = "type", type = "furnace"}})

-----------------------------------------------------------------------------------------------------------------------------------------------------------

script.on_event({defines.events.on_entity_died,defines.events.on_player_mined_entity,defines.events.on_robot_mined_entity,defines.events.script_raised_destroy},function(event)
	if DEBUG then
		log("debug script.on_event({defines.events.on_entity_died")
	end
	
	if event.entity.type == "assembling-machine" or event.entity.type == "furnace" then
		if not is_bulk_processor(event.entity.name) then
			return
		end
		
		global.radars[event.entity.unit_number].destroy()
		global.radars[event.entity.unit_number] = nil
	end
end)