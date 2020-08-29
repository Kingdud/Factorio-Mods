--[[for i, prototype in pairs (data.raw["electric-pole"]) do

    if (prototype.maximum_wire_distance >= 30 and prototype.supply_area_distance <= 5) then
        prototype.max_health = 19999
    
    end

end
for i, prototype in pairs (data.raw["straight-rail"]) do

        prototype.max_health = 19999

end
for i, prototype in pairs (data.raw["curved-rail"]) do

        prototype.max_health = 19999

end]]--
--[[for i, prototype in pairs (data.raw["rail-signal"]) do

        prototype.max_health = 19999

end
for i, prototype in pairs (data.raw["rail-chain-signal"]) do

        prototype.max_health = 19999

end]]--