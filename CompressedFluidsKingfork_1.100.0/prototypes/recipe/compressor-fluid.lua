local compressionRate = settings.startup["fluid-compression-rate"].value
local compressionFlow = settings.startup["fluid-compression-speed"].value
local MAX_RUNS_PER_SECOND = 5
local batchingFactor = 1
local compressionSpeed = 1
--limit ourselves to running, at most, 5 times per second.
if ( compressionFlow / compressionRate > MAX_RUNS_PER_SECOND) then
	compressionSpeed = 1 / MAX_RUNS_PER_SECOND
	--For example, we want 12000 units/s of flow with 85:1 compression,
	-- That would require 120 compression per second, so we cap it at 5 compressions per second (.2 seconds per compression)
	-- Thus, 12000 / 85 = 141.176 * .2 = 28.235 -> ceilinged to 29 batches per cycle. 
	-- IE: Each cycle will need 85 * 29 = 2465 input every .2 seconds, and each cycle will produce 29 output products.
	batchingFactor = math.ceil( (compressionFlow / compressionRate) * compressionSpeed )
else
	compressionSpeed = 1 / (compressionFlow / compressionRate)

end

--No need to scale these with batching factor, as batches are implicitly smaller than 1 second of product.
--Input area holds 1 second worth of input product
local inputBaseArea = math.ceil(compressionFlow / 100)
--Output area holds 1 second worth of product (12000 units/sec @ 100:1 compression = 120 units/sec. 1 base-area unit = 100 fluid, thus we want to hold 2 base_area units
local outputBaseArea = math.ceil(compressionFlow / compressionRate / 100)

for fluidName,fluidPrototype in pairs(data.raw.fluid) do
  if (fluidPrototype.auto_barrel == nil) or (fluidPrototype.auto_barrel == "true") or (fluidPrototype.auto_barrel == true) then
    data:extend{
      {
        type = "recipe",
        name = "compressing-"..fluidName,
        hidden = true,
        hide_from_stats = true,
        enabled = true,
        category = "fluid-compressing",
        energy_required = compressionSpeed,
        ingredients =
        {
          {type="fluid", name=fluidName, amount=compressionRate*batchingFactor}
        },
        results =
        {
          {type="fluid", name="high-pressure-"..fluidName, amount=batchingFactor}
        }
      },

      {
        type = "recipe",
        name = "decompressing-"..fluidName,
        hidden = true,
        hide_from_stats = true,
        enabled = true,
        category = "fluid-decompressing",
        energy_required = compressionSpeed,
        ingredients =
        {
          {type="fluid", name="high-pressure-"..fluidName, amount=batchingFactor}
        },
        results =
        {
          {type="fluid", name=fluidName, amount=compressionRate*batchingFactor}
        }
      },
    }
  end
end
