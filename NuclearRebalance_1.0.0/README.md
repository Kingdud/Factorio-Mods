#Nuclear UPS Grade

The purpose of this mod is to make nuclear power viable late game. Normally, late-game megabases always use solar power because of its extreme UPS efficiency. 
However, vanilla solar arrays which provide 1GW or more of power present two frustrations to players:

1. They consume vast amounts of space. On a planet with water, this makes the process of landfilling in large bodies annoying.
2. They are time consuming to build without blueprints that contain robotports integrated in for completelly automated assembly (outside of the aforementioned landfill, which bots cannot do)

##The rationale behind this mod - AKA "The Lore"
Note: m2 is 'meters squared', m3 is 'meters cubed'. MWe is 'Megawatts Electrical'. MWth is 'Megawatts Thermal'.

Traditional mods for solar make solar cells deliver more power, normally with the same footprint. The problem with this approach is that, on earth, and indeed on most planets in the goldilocks zone,
there will only ever be around 1000 watts of solar energy available per square meter. And that assumes a solar panel was 100% efficient.
A factorio solar cell is around 9 square meters and delivers 60 KW of power at peak. This means factorio solar panels are, at stock, 6000% percent efficient!

A nuclear reactor, on the other hand, is 25 square meters and delivers between 40 and 160 MWth (Megawatts Thermal) depending on how many neighbors it has. A modern, real-world reactor
would be capable of generating [3300 MWth in ~250 cubic meters](https://ocw.mit.edu/courses/nuclear-engineering/22-06-engineering-of-nuclear-systems-fall-2010/lectures-and-readings/MIT22_06F10_lec06a.pdf), or about 66 square meters.
To be clear, that is the thermal power output. In factorio the themeral output is 100% efficient to electrical output. In reality this ratio is normally in the 30% range. A 3300MWth reactor is generally able to output
around 1100MWe. 

This means that in factorio, the nuclear reactor itself, with a 300% neighbor bonus, is only generating around 6.4MW/m2 whereas a real reactor is able to output around 16.6 MW/m2. 
This is comparing apples to apples, the reactor pressure vessels themselves, not counting the heat exchangers, pumps, turbines, and other support equipment. So while solar power is UPS efficient and 60X better 
than the perfect-case scenario, nuclear energy is only around 40% as awesome as present-day (not even best case!) realities. Thus, the idea of this mod was born: to make nuclear power take fewer UPS, and increase the
power densities to realistic levels while also increasing the materials costs and assembly complexities to realistic levels. 

As reactor temperature increases, steam stops being a viable means to take heat out of the primary coolant loop. MSR reactors will need CO2 gas turbines, and MSR reactors will need helium turbines.
Recipies for both gases are added in this mod and are part of oil processing. This is realistic, since CO2 emissions are a well known side-effect of burning fossil fuels and 
[industrial helium is produced as part of natural gas production](https://www.popularmechanics.com/science/health/a4046/why-is-there-a-helium-shortage-10031229/).

Make no mistake, Nuclear Power is not simple to build in the real world, and it will not be easy in this mod. No new raw materials will be added as part of this mod, 
instead, 1 million units of iron may take the place of what would, in reality, be maybe 100,000 units of iron and the rest of titanium, nickle, aluminum, and other metals/materials.

Reference data:
https://inis.iaea.org/collection/NCLCollectionStore/_Public/04/059/4059045.pdf