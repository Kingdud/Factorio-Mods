local check = function(force, techname)
  if force.technologies[techname] ~= nil and force.technologies[techname].researched then
    force.technologies[techname].researched = false
    force.technologies[techname].researched = true
  end
end

for i, force in pairs(game.forces) do
  force.reset_recipes()
  force.reset_technologies()
  check(force, "bulkteleport-tech1")
  check(force, "bulkteleport-tech2")
end
