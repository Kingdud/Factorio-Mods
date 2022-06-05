 --entity.destructable=false

 

local function check_entity(entity, protect)
    local vType = entity.type
    local prototype = game.entity_prototypes[entity.name]
    local flag = false
    --"big-electric-pole-2"
    if (prototype ~= nil) then
        if (prototype.name == "big-electric-pole" or prototype.name == "big-electric-pole-2" or prototype.name == "big-electric-pole-3" or prototype.name == "big-electric-pole-4") then
            flag = true
        elseif (vType == "straight-rail" or vType == "curved-rail") then
            flag = true
        elseif (vType == "rail-signal" or vType == "rail-chain-signal") then
            flag = true
        end
    end
    if (flag) then
        if (protect == true) then        
            --entity.force = "neutral"
            entity.destructible = false
        else
            --entity.force = "player"
            entity.destructible = true
        end
    end
end

local function on_first_tick()
    local surface = game.surfaces[1]
    for c in surface.get_chunks() do
        for key, entity in pairs(surface.find_entities_filtered({area={{c.x * 32, c.y * 32}, {c.x * 32 + 32, c.y * 32 + 32}}})) do
            check_entity(entity,true)
        end
    end
    --script.on_event(defines.events.on_tick, nil)
end

--script.on_event(defines.events.on_tick, on_tick)

script.on_init(on_first_tick)

script.on_configuration_changed(on_first_tick)
script.on_event(defines.events.on_force_created, on_first_tick)

script.on_event({defines.events.on_robot_built_entity,defines.events.on_built_entity,defines.events.script_raised_revive,defines.events.script_raised_built,defines.events.on_entity_cloned}, function(event)
	local entity = event.created_entity or event.entity or event.destination
    check_entity(entity,true) end)
    
--[[script.on_event({defines.events.on_player_mined_item,
                 defines.events.on_robot_mined}, function(event)
    check_item(event.item_stack) end) ]]--
    
    
    
--[[      local autoRepair = { 
        "straight-rail" = true, 
        "curved-rail" = true,
        "electric-pole" = true
    }

-- this code would be in the onDeath event. Auto repair things like rails, and signals. Also by destroying the entity the enemy retargets.
    if (event.force == game.forces.enemy) and autoRepair[event.entity.name] then
        local repairPosition = event.entity.position
        local repairName = event.entity.name
        local repairForce = event.entity.force
        local repairDirection = event.entity.direction
        event.entity.destroy()
        local entityRepaired = game.surfaces[1].create_entity({position=repairPosition,
                                                               name=repairName,
                                                               direction=repairDirection,
                                                               force=repairForce})
        -- forces enemy to disperse 
        local enemies = game.surfaces[1].find_entities_filtered({area = {{x=repairPosition.x-20, y=repairPosition.y-20},
                                                                         {x=repairPosition.x+20, y=repairPosition.y+20}},
                                                                 type = "unit",
                                                                 force = game.forces.enemy})
        for i=1, #enemies do
            local enemy = enemies[i]
            enemy.set_command({type=defines.command.wander,
                               distraction=defines.distraction.by_enemy})
        end
    end
]]--

--[[
script.on_event(defines.events.on_player_selected_area, function(event)
  on_selected_area(event)
end)

script.on_event(defines.events.on_player_alt_selected_area, function(event)
  on_alt_selected_area(event)
end)

function on_selected_area(event)
    if event.item ~= "deprotector" then return end--If its a upgrade builder 
    local player = game.players[event.player_index]

    local surface = player.surface
    for k, entity in pairs (event.entities) do --Get the items that are set to be upgraded
        check_entity(entity,false)
    end

end

function on_alt_selected_area(event)
    if event.item ~= "deprotector" then return end--If its a upgrade builder 
    local player = game.players[event.player_index]

    local surface = player.surface
    for k, entity in pairs (event.entities) do --Get the items that are set to be upgraded
        check_entity(entity,true)
    end

end]]--




