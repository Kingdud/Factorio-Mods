if settings.startup["fluid-compression-singeEntity"].value == false then
  -- add overlay to compressor
  data.raw["item"]["fluid-compressor"].icons =
  {
    [0] = {icon = data.raw["item"]["fluid-compressor"].icon},
    [1] = {icon = "__CompressedFluidsKingfork__/graphics/icons/overlay-plus.png",
           tint = {r=0,g=1,b=0}}
  }
  data.raw["item"]["fluid-compressor"].icon = nil

  -- make decompressor
  local decompressor = util.table.deepcopy(data.raw["item"]["fluid-compressor"])
  decompressor.name = "fluid-decompressor"
  decompressor.icons[1].icon = "__CompressedFluidsKingfork__/graphics/icons/overlay-minus.png"
  decompressor.order = data.raw["item"]["pump"].order.."a["..decompressor.name.."]"
  decompressor.crafting_categories = {"fluid-decompressing"}
  decompressor.place_result = "fluid-decompressor"
  data:extend{decompressor}
end
