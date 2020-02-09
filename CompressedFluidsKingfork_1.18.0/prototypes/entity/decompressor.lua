if settings.startup["fluid-compression-singeEntity"].value == true then
  table.insert(data.raw["furnace"]["fluid-compressor"].crafting_categories, "fluid-decompressing")
else
  --See prototypes/recipie/compressor-fluid.lua for explainations
  local compressionRate = settings.startup["fluid-compression-rate"].value
  local compressionFlow = settings.startup["fluid-compression-speed"].value
  local inputBaseArea = math.ceil(compressionFlow / 100)
  local outputBaseArea = math.ceil(compressionFlow / compressionRate / 100)


  local decompressor = util.table.deepcopy(data.raw["furnace"]["fluid-compressor"])
  decompressor.name = "fluid-decompressor"
  decompressor.minable.result = "fluid-decompressor"
  decompressor.crafting_categories = {"fluid-decompressing"}
  decompressor.fluid_boxes =
  {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        base_area = outputBaseArea,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -1} }}
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        base_area = inputBaseArea,
        base_level = 1,
        pipe_connections = {{ position = {0, 1} }}
      },
    },
  data:extend{decompressor}
end
