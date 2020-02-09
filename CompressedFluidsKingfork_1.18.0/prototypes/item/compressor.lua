data:extend{
  {
    type = "item",
    name = "fluid-compressor",
    icon = "__CompressedFluidsKingfork__/graphics/icons/compressor.png",
    icon_size = 51,
    flags = data.raw["item"]["pump"].flags,
    subgroup = data.raw["item"]["pump"].subgroup,
    order = data.raw["item"]["pump"].order.."a[fluid-compressor]",
    place_result = "fluid-compressor",
    stack_size = 10,
  },
}
