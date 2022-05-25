--///////////////////////////////////
--Global Variable members:
-- global.buffers[sender_or_reciever_unitID] = the buffer entity associated with a given sender or receiver.
-- global.senders = a table of all dematerializer entities.
-- global.receivers = a table of all rematerializer entities.
-- global.teleportJobs = A table of all pending teleport jobs
-- global.busyList = A map of all transporters currently busy trying to send (since calling is_crafting() isn't reliable in all cases)
-- global.blockedRecv = a list of all receivers blocked because no sender for them exists.
--///////////////////////////////////

local function serialize(t)
	local s = {}
	for k,v in pairs(t) do
		if type(v) == "table" then
			v = serialize(v)
		end
		s[#s+1] = tostring(k).." = "..tostring(v)
	end
	return "{ "..table.concat(s, ", ").." }"
end

local function prefixed(str, start)
	return str:sub(1, #start) == start
end

local function suffixed(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

local entity_component_counterparts = {
	["bulkteleport-energizer-send1"] = "bulkteleport-buffer-send1",
	["bulkteleport-energizer-recv1"] = "bulkteleport-buffer-recv1",
	["bulkteleport-energizer-send2"] = "bulkteleport-buffer-send2",
	["bulkteleport-energizer-recv2"] = "bulkteleport-buffer-recv2",
	["bulkteleport-energizer-send3"] = "bulkteleport-buffer-send3",
	["bulkteleport-energizer-recv3"] = "bulkteleport-buffer-recv3",
	["bulkteleport-energizer-send4"] = "bulkteleport-buffer-send4",
	["bulkteleport-energizer-recv4"] = "bulkteleport-buffer-recv4",
	["bulkteleport-buffer-send1"] = "bulkteleport-energizer-send1",
	["bulkteleport-buffer-recv1"] = "bulkteleport-energizer-recv1",
	["bulkteleport-buffer-send2"] = "bulkteleport-energizer-send2",
	["bulkteleport-buffer-recv2"] = "bulkteleport-energizer-recv2",
	["bulkteleport-buffer-send3"] = "bulkteleport-energizer-send3",
	["bulkteleport-buffer-recv3"] = "bulkteleport-energizer-recv3",
	["bulkteleport-buffer-send4"] = "bulkteleport-energizer-send4",
	["bulkteleport-buffer-recv4"] = "bulkteleport-energizer-recv4",
}

local function create_component_counterpart(entity)
	return entity.surface.create_entity({
		name = entity_component_counterparts[entity.name],
		position = entity.position,
		force = entity.force,
	})
end

local entity_components = {
	["bulkteleport-send1"] = {"bulkteleport-buffer-send1", "bulkteleport-energizer-send1"},
	["bulkteleport-recv1"] = {"bulkteleport-buffer-recv1", "bulkteleport-energizer-recv1"},
	["bulkteleport-send2"] = {"bulkteleport-buffer-send2", "bulkteleport-energizer-send2"},
	["bulkteleport-recv2"] = {"bulkteleport-buffer-recv2", "bulkteleport-energizer-recv2"},
	["bulkteleport-send3"] = {"bulkteleport-buffer-send3", "bulkteleport-energizer-send3"},
	["bulkteleport-recv3"] = {"bulkteleport-buffer-recv3", "bulkteleport-energizer-recv3"},
	["bulkteleport-send4"] = {"bulkteleport-buffer-send4", "bulkteleport-energizer-send4"},
	["bulkteleport-recv4"] = {"bulkteleport-buffer-recv4", "bulkteleport-energizer-recv4"},
}

local function create_components(entity)
	local energizer = nil
	local buffer = entity.surface.create_entity({
		name = entity_components[entity.name][1],
		position = entity.position,
		force = entity.force,
	})
	if buffer then
		energizer = entity.surface.create_entity({
			name = entity_components[entity.name][2],
			position = entity.position,
			force = entity.force,
		})
		if not energizer then
			buffer.destroy()
			buffer = nil
		end
	end
	return buffer, energizer
end

local function find_component_counterpart(en)
	local list = en.surface.find_entities_filtered({
		name = entity_component_counterparts[en.name],
		area = {
			{ en.position.x-1, en.position.y-1, },
			{ en.position.x+1, en.position.y+1, },
		},
	})
	return list and list[1]
end

local entity_names = {
	"bulkteleport-energizer-send1",
	"bulkteleport-energizer-recv1",
	"bulkteleport-energizer-send2",
	"bulkteleport-energizer-recv2",
	"bulkteleport-energizer-send3",
	"bulkteleport-energizer-recv3",
	"bulkteleport-energizer-send4",
	"bulkteleport-energizer-recv4",
	"bulkteleport-buffer-send1",
	"bulkteleport-buffer-recv1",
	"bulkteleport-buffer-send2",
	"bulkteleport-buffer-recv2",
	"bulkteleport-buffer-send3",
	"bulkteleport-buffer-recv3",
	"bulkteleport-buffer-send4",
	"bulkteleport-buffer-recv4",
}

local function teleporter_at(surface, position)
	return surface.count_entities_filtered({
		name = entity_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 0
end

local function teleporter_ghost_double_up(surface, position)
	return surface.count_entities_filtered({
		ghost_name = entity_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 2
end

local entity_energizer_names = {
	"bulkteleport-energizer-send1",
	"bulkteleport-energizer-recv1",
	"bulkteleport-energizer-send2",
	"bulkteleport-energizer-recv2",
	"bulkteleport-energizer-send3",
	"bulkteleport-energizer-recv3",
	"bulkteleport-energizer-send4",
	"bulkteleport-energizer-recv4",
}

local function teleporter_ghost_energizer_at(surface, position)
	return surface.count_entities_filtered({
		ghost_name = entity_energizer_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 0
end

local entity_buffer_names = {
	"bulkteleport-buffer-send1",
	"bulkteleport-buffer-recv1",
	"bulkteleport-buffer-send2",
	"bulkteleport-buffer-recv2",
	"bulkteleport-buffer-send3",
	"bulkteleport-buffer-recv3",
	"bulkteleport-buffer-send4",
	"bulkteleport-buffer-recv4",
}

local function teleporter_ghost_buffer_at(surface, position)
	return surface.count_entities_filtered({
		ghost_name = entity_buffer_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	}) > 0
end

local function chase_away_ghosts(surface, position)
	local ghosts = surface.find_entities_filtered({
		ghost_name = entity_names,
		area = {
			{ position.x-1, position.y-1, },
			{ position.x+1, position.y+1, },
		},
	})
	for _, ghost in ipairs(ghosts) do
		if ghost.valid then
			ghost.destroy()
		end
	end
end

local function OnEntityCreated(event)
	local entity = event.created_entity

	if not entity or not entity.valid then
		return
	end

	-- Due to both energizers and buffers being included in blueprints, and energizers lacking
	-- a collision box, it's possible to overlay an energizer ghost onto an existing teleporter
	-- if placing a blueprint twice. Detect and fix it.
	if entity.name == "entity-ghost"
		and entity.ghost_name
		and prefixed(entity.ghost_name, "bulkteleport-")
	then

		if teleporter_at(entity.surface, entity.position) then
			chase_away_ghosts(entity.surface, entity.position)
			return
		end

		if teleporter_ghost_double_up(entity.surface, entity.position) then
			entity.destroy()
			return
		end

		local e = teleporter_ghost_energizer_at(entity.surface, entity.position)
		local b = teleporter_ghost_buffer_at(entity.surface, entity.position)

		if not (e and b) and not event.item then
			game.print("Broken teleporter blueprint! Include both materializer and buffer entities.")
			entity.destroy()
			return
		end
	end

	if not prefixed(entity.name, "bulkteleport-") then
		return
	end

	chase_away_ghosts(entity.surface, entity.position)
	-- placed from item
	if prefixed(entity.name, "bulkteleport-send") or prefixed(entity.name, "bulkteleport-recv") then
		local buffer, energizer = create_components(entity)

		if buffer and energizer then
			global.buffers[energizer.unit_number] = buffer
			if prefixed(entity.name, "bulkteleport-send") then
				global.senders[energizer.unit_number] = energizer
			else
				global.recievers[energizer.unit_number] = energizer
			end
			global.busyList[energizer.unit_number] = false
		else
			game.print("Placing a teleporter failed. Please report a bug if you can reproduce it!")
		end

		entity.destroy()
		return
	end

	-- placed from blueprint
	if prefixed(entity.name, "bulkteleport-buffer-send") or prefixed(entity.name, "bulkteleport-buffer-recv") then
		local buffer = entity
		local energizer = create_component_counterpart(buffer)

		if energizer then
			global.buffers[energizer.unit_number] = buffer
			if prefixed(entity.name, "bulkteleport-buffer-send") then
				global.senders[energizer.unit_number] = energizer
			else
				global.recievers[energizer.unit_number] = energizer
			end
			global.busyList[energizer.unit_number] = false
		else
			buffer.destroy()
			game.print("Placing a teleporter from a blueprint failed. Please report a bug if you can reproduce it!")
		end
		return
	end
end

local function OnEntityRemoved(event)
	local entity = event.entity

	if not entity or not entity.valid then
		return
	end

	if prefixed(entity.name, "bulkteleport-") then
		local counterpart = find_component_counterpart(entity)
		
		--Remove from data structures as well
		if prefixed(entity.name, "bulkteleport-buffer-send") then
			--counterpart is energizer
			local eid = counterpart.unit_number
			global.buffers[eid] = nil
			global.senders[eid] = nil
			global.busyList[eid] = nil
		elseif prefixed(entity.name, "bulkteleport-send") then
			global.senders[entity.unit_number] = nil
			global.buffers[entity.unit_number] = nil
			global.busyList[entity.unit_number] = nil
		elseif prefixed(entity.name, "bulkteleport-buffer-recv") then
			local eid = counterpart.unit_number
			global.recievers[eid] = nil
			global.buffers[eid] = nil
			global.busyList[eid] = nil
		else
			global.recievers[entity.unit_number] = nil
			global.buffers[entity.unit_number] = nil
			global.busyList[entity.unit_number] = nil
		end
		
		if entity.health >= 1 and counterpart and counterpart.valid then
			counterpart.destroy()
		end
		return
	end

	if entity.name == "entity-ghost"
		and entity.ghost_name
		and prefixed(entity.ghost_name, "bulkteleport-")
	then
		chase_away_ghosts(entity.surface, entity.position)
		return
	end
end

local function OnEntityDamaged(event)

	local entity = event.entity

	if not entity or not entity.valid then
		return
	end

	if prefixed(entity.name, "bulkteleport-") then
		local counterpart = find_component_counterpart(entity)
		if counterpart and counterpart.valid then
			if entity.health < 1 then
				entity.die(event.force)
				if counterpart.valid then -- required as above die() could destroy() in event handler
					counterpart.die(event.force)
				end
				return
			end
			local health = math.min(entity.health, counterpart.health)
			entity.health = health
			counterpart.health = health
		end
		return
	end
end

local fluidic_entity_names = {
	["bulkteleport-energizer-send3"] = true,
	["bulkteleport-energizer-recv3"] = true,
	["bulkteleport-energizer-send4"] = true,
	["bulkteleport-energizer-recv4"] = true,
	["bulkteleport-buffer-send3"] = true,
	["bulkteleport-buffer-recv3"] = true,
	["bulkteleport-buffer-send4"] = true,
	["bulkteleport-buffer-recv4"] = true,
}

local function is_fluidic(entity)
	return fluidic_entity_names[entity.name] or false
end

local function inventory_counts(inventory)
	local blocked_slots = #inventory - (inventory.get_bar() or #inventory)
	local free_slots = inventory.insert({ name = "bulkteleport-job-1", count = #inventory })

	if free_slots > 0 then
		inventory.remove({ name = "bulkteleport-job-1", count = free_slots })
	end

	return #inventory, blocked_slots, free_slots
end

local function free_space(entity)
	if is_fluidic(entity) then
		local capacity = entity.prototype.fluid_capacity
		return (capacity-entity.get_fluid_count()) / capacity
	end
	local total, blocked, free = inventory_counts(entity.get_inventory(defines.inventory.chest))
	return free / total
end

-- For fluid teleporters this is just 1-free_space()
-- But for item teleporters with optionally limited inventories (red bar)
-- the blocked-off slots need to be taken into account.
local function used_space(entity)
	if is_fluidic(entity) then
		local capacity = entity.prototype.fluid_capacity
		return entity.get_fluid_count() / capacity
	end
	local total, blocked, free = inventory_counts(entity.get_inventory(defines.inventory.chest))
	return (total - free - blocked - 1) / total
end

local function is_empty(entity)
	if is_fluidic(entity) then
		return entity.get_fluid_count() < 1
	end
	return entity.get_inventory(defines.inventory.chest).is_empty()
end

local function is_full(entity)
	if is_fluidic(entity) then
		local full = (settings.global["bulkteleport-fluid-full"].value or 0.999)
		return entity.get_fluid_count() >= (entity.prototype.fluid_capacity * full)
	end
	local inventory = entity.get_inventory(defines.inventory.chest)
	return not inventory.can_insert({ name = "bulkteleport-job-1", count = 1 })
end

local function notify(state, msg)
	state.surface.create_entity({
		name = "flying-text",
		position = state.position,
		color = {r=1,g=1,b=1},
		text = msg,
	})
end

local function warning(state, msg)
	state.surface.create_entity({
		name = "flying-text",
		position = state.position,
		color = {r=1,g=0.6,b=0.6},
		text = msg,
	})
end

local function beam_color(surface)
	local d = surface.darkness/3
	local r = settings.global["bulkteleport-show-beam-r"].value
	local g = settings.global["bulkteleport-show-beam-g"].value
	local b = settings.global["bulkteleport-show-beam-b"].value
	return { r = math.min(1.0, math.max(0.0, r-d)), g = math.min(1.0, math.max(0.0, g-d)), b = math.min(1.0, math.max(0.0, b-d)) }
end

local SENDERS = 1
local P_SENDERS = 2
local RECIEVERS = 3
local P_RECIEVERS = 4

local function check_networks(energizer_id, networks, is_sender)
	local buffer = global.buffers[energizer_id]
	local signals = buffer.get_merged_signals()
	local temp_network = {}
	local is_priority = false
	
	if global.busyList[energizer_id] then
		return
	end
	
	if is_sender then
		--If the buffer is < 90% full, disable sending.
		if global.senders[energizer_id].energy <= global.senders[energizer_id].electric_buffer_size * .9 then return end
		--If this energizer is currently busy, do nothing.
		if global.senders[energizer_id].is_crafting() then return end
	else
		if global.recievers[energizer_id].energy <= global.recievers[energizer_id].electric_buffer_size * .9 then return end
		if global.recievers[energizer_id].is_crafting() then return end
	end
	
	if signals ~= nil then
		local signal_count = 0
		local found_virtual = false
		for _, v in ipairs(signals) do
			if v.signal.type == "virtual" and v.signal.name ~= nil then
				if v.signal.type == "virtual" and v.signal.name == "signal-red" then
					return
				elseif v.signal.type == "virtual" and v.signal.name == "signal-green" then
					is_priority = true
				elseif v.signal.type == "virtual" and v.signal.name == "signal-yellow" and is_full(buffer) then
					is_priority = true
				else
					if not found_virtual then
						temp_network = {}
					end
					found_virtual = true
					temp_network[v.signal.name .. v.count] = energizer_id
					signal_count = signal_count + 1
				end
			elseif v.signal.name ~= nil and not found_virtual then
				temp_network[v.signal.name] = energizer_id
				signal_count = signal_count + 1
			end
		end
		
		if signal_count > 1 and not found_virtual then
			warning(buffer, "Virtual signal must be used to send multiple item types")
			return
		end
	end
	
	if table_size(temp_network) == 0 then
		warning(buffer, "no network...")
		return
	end
	
	--If we aren't full, and we also aren't priority, then we aren't up for consideration on this check.
	if ( is_sender and not is_priority and not is_full(buffer) ) or (is_sender and is_empty(buffer)) then
		return
	end
	--If we are a receiver, and we are not empty, then we aren't up for consideration on this check.
	if not is_sender and not is_empty(buffer) then
		return
	end
	
	for network, eID in pairs(temp_network) do
		if is_sender then
			if is_priority then
				if not networks[P_SENDERS][network] then
					networks[P_SENDERS][network] = {eID}
				else
					table.insert(networks[P_SENDERS][network], eID)
				end
			else
				if not networks[SENDERS][network] then
					networks[SENDERS][network] = {eID}
				else
					table.insert(networks[SENDERS][network], eID)
				end
			end
		else
			if is_priority then
				if not networks[P_RECIEVERS][network] then
					networks[P_RECIEVERS][network] = {eID}
				else
					table.insert(networks[P_RECIEVERS][network], eID)
				end
			else
				if not networks[RECIEVERS][network] then
					networks[RECIEVERS][network] = {eID}
				else
					table.insert(networks[RECIEVERS][network], eID)
				end
			end
		end
	end
end

function draw_teleport_beam(recipe, sender, reciever)
	--Draw the beam between the two teleporters.
	if settings.global["bulkteleport-show-beam"].value then
		local duration = game.recipe_prototypes[recipe].energy / sender.crafting_speed

		local s_position = { sender.position.x, sender.position.y - 1 }
		local t_position = { reciever.position.x, reciever.position.y - 1 }

		if settings.global["bulkteleport-show-beam-pretty"].value then
			-- slower
			sender.surface.create_entity({
				name = "electric-beam",
				position = s_position,
				source_position = s_position,
				target_position = t_position,
				duration = math.ceil(duration*60),
			})
		else
			-- faster
			rendering.draw_line({
				color = beam_color(sender.surface),
				width = 2,
				gap_length = 0.5,
				dash_length = 0.5,
				from = s_position,
				to = t_position,
				surface = sender.surface,
				forces = { sender.force },
				time_to_live = math.ceil(duration*60),
			})
		end
	end
end

local function OnNthTick(event)	
	-- Networks Design:
	-- networks[<type>][<signal name>..<count>] ==> The in-game signal 'Iron Plate' with a value of '1', becomes "iron-plate1"
	-- networks[senders][<signal name>..<count>] = {sender id 1, id2, id3, etc}
	-- networks[priority_senders][<signal name>..<count>]
	-- networks[receivers][<signal name>..<count>]
	local networks = {{}, {}, {}}
	
	--Step 1, Move any existing, completed, transfer jobs.
	for jobTick, job_list in pairs(global.teleportJobs) do
		if jobTick > event.tick then
			goto done_moving_inventory
		end
		
		--We only get here if the shipment has had time to complete (IE: 4 seconds have passed).
		
		for idx, job in pairs(job_list) do
			local send_entity = global.senders[job[1]]
			local recv_entity = global.recievers[job[2]]
			local send_buf = global.buffers[job[1]]
			local recv_buf = global.buffers[job[2]]
			local shipment
			local sender_tier = send_entity.name:sub(-1)
			local recipe = "bulkteleport-job-"..sender_tier
			
			--Ensure that both have finished their cycles. IE: localized power problems may slow one down.
			if send_entity.is_crafting() or send_entity.energy == 0 then
				warning(recv_buf, "Sender still busy or offline")
				draw_teleport_beam(recipe, send_entity, recv_entity)
				goto next_delivery
			end
			if recv_entity.is_crafting() or recv_entity.energy == 0 then
				warning(send_buf, "Receiver still busy or offline")
				draw_teleport_beam(recipe, send_entity, recv_entity)
				goto next_delivery
			end
			
			--We already know that either both sender and receiver are fluidic or not.
			if is_fluidic(send_entity) then
				shipment = send_buf.get_fluid_contents()
				local temp = send_buf.fluidbox[1].temperature
				send_buf.clear_fluid_inside()
				recv_buf.clear_fluid_inside()
				
				global.busyList[job[1]] = false
				global.busyList[job[2]] = false
				
				for name, count in pairs(shipment) do
					if game.fluid_prototypes[name] then
						recv_buf.insert_fluid({
							name = name,
							amount = count,
							temperature = temp
						})
					end
				end
			else
				local send_inventory = send_buf.get_inventory(defines.inventory.chest)
				local recv_inventory = recv_buf.get_inventory(defines.inventory.chest)
				shipment = send_inventory.get_contents()
				send_inventory.clear()
				recv_inventory.clear()
				
				--True, the send may fail below, but if it does, we've already wiped out both inventories, so...yeah.
				global.busyList[job[1]] = false
				global.busyList[job[2]] = false
				
				for name, count in pairs(shipment) do
					if game.item_prototypes[name] then
						recv_inventory.insert({
							name = name,
							count = count
						})
					end
				end
			end
			
			job_list[idx] = nil
			::next_delivery::
		end
		
		if table_size(global.teleportJobs[jobTick]) == 0 then
			global.teleportJobs[jobTick] = nil
		end
	end
	::done_moving_inventory::
	
	--Step 2, build list of all senders.
	for thing,sender in pairs(global.senders) do
		check_networks(sender.unit_number, networks, true)
	end
	
	--Step 3, iterate through list of receivers.
	for _,reciever in pairs(global.recievers) do
		check_networks(reciever.unit_number, networks, false)
	end
	
	local send_eID = 0
	local recv_eID = 0
	--Step 4.1, go through priority receivers, find any priority (or normal) senders to fulfill them
	for network, recievers in pairs(networks[P_RECIEVERS]) do
		for _, recv_eID in pairs(recievers) do
			if networks[P_SENDERS][network] and next(networks[P_SENDERS][network]) ~= nil then
				send_eID = table.remove(networks[P_SENDERS][network])
				recv_eID = recv_eID
			elseif networks[SENDERS][network] and next(networks[SENDERS][network]) ~= nil then
				send_eID = table.remove(networks[SENDERS][network])
				recv_eID = recv_eID
			else
				--We have no senders for any receiver on this network. Abort search.
				if global.blockedRecv[network] then
					global.blockedRecv[network] = global.blockedRecv[network] + 1
				else
					global.blockedRecv[network] = 1
				end
				goto p_next_network_continue
			end
			
			local teleport_job = {send_eID, recv_eID}
			
			--4 seconds to send, 60 ticks per second.
			if not global.teleportJobs[event.tick + 4*60 - 1] then
				global.teleportJobs[event.tick + 4*60 - 1] = {teleport_job}
			else
				table.insert(global.teleportJobs[event.tick + 4*60 - 1], teleport_job)
			end
			--We found a matching sender, so reset back to 0
			if global.blockedRecv[network] ~= 0 then
				global.blockedRecv[network] = 0
			end
		end
		::p_next_network_continue::
	end
	
	send_eID = 0
	recv_eID = 0
	--Step 4.2, go through normal receivers, find any priority (or normal) senders to fulfill them
	for network, recievers in pairs(networks[RECIEVERS]) do
		for _, recv_eID in pairs(recievers) do
			if networks[P_SENDERS][network] and next(networks[P_SENDERS][network]) ~= nil then
				send_eID = table.remove(networks[P_SENDERS][network])
				recv_eID = recv_eID
			elseif networks[SENDERS][network] and next(networks[SENDERS][network]) ~= nil then
				send_eID = table.remove(networks[SENDERS][network])
				recv_eID = recv_eID
			else
				--We have no senders for any receiver on this network. Abort search.
				if global.blockedRecv[network] then
					global.blockedRecv[network] = global.blockedRecv[network] + 1
				else
					global.blockedRecv[network] = 1
				end
				goto next_network_continue
			end
			
			local teleport_job = {send_eID, recv_eID}
			
			--4 seconds to send, 60 ticks per second.
			if not global.teleportJobs[event.tick + 4*60 - 1] then
				global.teleportJobs[event.tick + 4*60 - 1] = {teleport_job}
			else
				table.insert(global.teleportJobs[event.tick + 4*60 - 1], teleport_job)
			end
			--We found a matching sender, so reset back to 0
			if global.blockedRecv[network] ~= 0 then
				global.blockedRecv[network] = 0
			end
		end
		::next_network_continue::
	end
	
	--Step 5, At this point, all empty receivers that could be filled have been. Now we issue out the teleport jobs.
	for timeslot, shipment_list in pairs(global.teleportJobs) do
		for shipment_idx, shipment in pairs(shipment_list) do
			--Confirm that sender and receiver are the same tier
			local sender_tier = global.senders[shipment[1]].name:sub(-1)
			local reciever_teir = global.recievers[shipment[2]].name:sub(-1)
			local sender = global.senders[shipment[1]]
			local reciever = global.recievers[shipment[2]]
			
			if sender.is_crafting() or reciever.is_crafting() then goto next_shipment end
			
			if sender_tier ~= reciever_teir then
				warning(sender, "Mismatch (de)materializer tiers on network")
				warning(reciever, "Mismatch (de)materializer tiers on network")
				global.teleportJobs[timeslot] = nil
				goto next_shipment
			end
			
			if is_fluidic(sender) ~= is_fluidic(reciever) then
				warning(sender, "Mixing fluid and material teleporters not allowed")
				warning(reciever, "Mixing fluid and material teleporters not allowed")
				global.teleportJobs[timeslot] = nil
				goto next_shipment
			end
			
			--Get both energizers spinning up.
			local recipe = "bulkteleport-job-"..sender_tier
			
			global.busyList[shipment[1]] = true
			global.busyList[shipment[2]] = true
			
			sender.insert({ name = recipe })
			reciever.insert({ name = recipe })
			
			draw_teleport_beam(recipe, sender, reciever)
		end
		
		::next_shipment::
	end
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

local function init_data_structures()
	global.teleportJobs = {}
	global.senders = {}
	global.recievers = {}
	global.buffers = {}
	global.busyList = {}
	global.blockedRecv = {}
	
	for _, surface in pairs(game.surfaces) do
		for i=1,4 do
			for _, entity in pairs(surface.find_entities_filtered{name= "bulkteleport-energizer-send"..i}) do
				global.senders[entity.unit_number] = entity
				global.buffers[entity.unit_number] = find_component_counterpart(entity)
				global.busyList[entity.unit_number] = false
			end
			for _, entity in pairs(surface.find_entities_filtered{name= "bulkteleport-energizer-recv"..i}) do
				global.recievers[entity.unit_number] = entity
				global.buffers[entity.unit_number] = find_component_counterpart(entity)
				global.busyList[entity.unit_number] = false
			end
		end
	end
end

local function set_tick_handler()
	script.on_nth_tick(settings.global["bulkteleport-seconds-between-checks"].value*60, OnNthTick)
end

local function OnSettingChanged()
	set_tick_handler()
end

script.on_configuration_changed(function(delta)
	set_tick_handler()
	init_data_structures()
end)

script.on_init(function()
	init_data_structures()
	script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive}, OnEntityCreated)
	script.on_event({defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity, defines.events.on_entity_died, defines.events.script_raised_destroy}, OnEntityRemoved)
	script.on_event({defines.events.on_entity_damaged}, OnEntityDamaged)
	script.on_event({defines.events.on_runtime_mod_setting_changed}, OnSettingChanged)
--	script.on_event({defines.events.on_gui_opened}, OnGuiOpened)
end)

script.on_load(function()
	set_tick_handler()
	script.on_event({defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built, defines.events.script_raised_revive}, OnEntityCreated)
	script.on_event({defines.events.on_player_mined_entity, defines.events.on_robot_mined_entity, defines.events.on_entity_died, defines.events.script_raised_destroy}, OnEntityRemoved)
	script.on_event({defines.events.on_entity_damaged}, OnEntityDamaged)
	script.on_event({defines.events.on_runtime_mod_setting_changed}, OnSettingChanged)
--	script.on_event({defines.events.on_gui_opened}, OnGuiOpened)
end)

script.on_event( defines.events.on_console_chat, function(event)
	if DEBUG then
		log("debug script.on_event( defines.events.on_console_chat")
	end

	if event.message == "kbt_blocked" then
		for k,v in pairs(global.blockedRecv) do
			if v ~= 0 then
				game.print(k .. " for " .. v .. " seconds")
			end
		end
	end
end)