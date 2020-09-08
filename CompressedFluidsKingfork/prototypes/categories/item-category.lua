local pressurizedFluids = util.table.deepcopy(data.raw["item-group"]["fluids"])
pressurizedFluids.name = "compressed-fluids"
pressurizedFluids.order = pressurizedFluids.order .. "-a["..pressurizedFluids.name.."]"

if pressurizedFluids.icon and (not pressurizedFluids.icons) then
  pressurizedFluids.icons = {{icon = pressurizedFluids.icon}}
end
pressurizedFluids.icon = nil
if pressurizedFluids.icon_size and pressurizedFluids.icons and pressurizedFluids.icons[1] and (not pressurizedFluids.icons.icon_size) then
  for k,_ in pairs(pressurizedFluids.icons) do
    pressurizedFluids.icons[k].icon_size = pressurizedFluids.icon_size
  end
end
pressurizedFluids.icon_size = nil

table.insert(pressurizedFluids.icons,  {
  icon = "__CompressedFluidsKingfork__/graphics/icons/overlay-HP-group.png",
  icon_size = 64,
  tint = {r=0,g=1,b=0}
})

data:extend{pressurizedFluids}
