script.on_event(defines.events.on_entity_died, function(event)
    if event.entity.name ~= 'construction-robot-nuclear' and event.entity.name ~= 'logistic-robot-nuclear' then return end
    event.entity.surface.create_entity({name = "nuclear-robots-explosion", position = event.entity.position, target=event.entity.position, speed=1})
end)
