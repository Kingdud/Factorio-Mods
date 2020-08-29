if settings.startup["fluid-compression-singeEntity"].value == false then
  table.insert(data.raw["technology"]["fluid-compressor"].effects, {
    type = "unlock-recipe",
    recipe = "fluid-decompressor-to-compressor"
  })
  table.insert(data.raw["technology"]["fluid-compressor"].effects, {
    type = "unlock-recipe",
    recipe = "fluid-compressor-to-decompressor"
  })
end
