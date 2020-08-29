if settings.startup["fluid-compression-singeEntity"].value == false then
  data:extend({
    {
      type = "recipe",
      name = "fluid-compressor-to-decompressor",
      enabled = false,
      energy_required = 1,
      ingredients =
      {
        {"fluid-compressor", 1},
      },
      result = "fluid-decompressor",
    },
    {
      type = "recipe",
      name = "fluid-decompressor-to-compressor",
      enabled = false,
      energy_required = 2.5,
      ingredients =
      {
        {"fluid-decompressor", 1},
      },
      allow_as_intermediate = false,
      allow_intermediates = false,
      result = "fluid-compressor",
      order = data.raw["item"]["fluid-compressor"].order.."-bis"
    },
  })
end
