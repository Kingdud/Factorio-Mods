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

A nuclear reactor (in Factorio), on the other hand, is 25 square meters and delivers between 40 and 160 MWth (Megawatts Thermal) depending on how many neighbors it has. A modern, real-world reactor
would be capable of generating [3300 MWth in ~250 cubic meters](https://ocw.mit.edu/courses/nuclear-engineering/22-06-engineering-of-nuclear-systems-fall-2010/lectures-and-readings/MIT22_06F10_lec06a.pdf), or about 66 square 
meters. To be clear, that is the thermal power output. In factorio the themeral output is 100% efficient to electrical output. In reality this ratio is normally in the 33-45% range. A 3300MWth reactor is generally able to output
around 1155MWe. 

This means that in factorio, the nuclear reactor itself, with a 300% neighbor bonus, is only generating around 6.4MW/m2 whereas a real reactor is able to output around 16.6 MW/m2. 
This is comparing apples to apples, the reactor pressure vessels themselves, not counting the heat exchangers, pumps, turbines, and other support equipment. So while solar power is UPS efficient and 60X better 
than the perfect-case scenario, nuclear energy is only around 40% as awesome as present-day (not even best case!) realities. Thus, the idea of this mod was born: to make nuclear power take fewer UPS, and increase the
power densities to realistic levels while also increasing the materials costs and assembly complexities to realistic levels. 

As reactor temperature increases, steam stops being a viable means to take heat out of the primary coolant loop. MSR reactors will need CO2 gas turbines, and MSR reactors will need helium turbines.
Recipies for both gases are added in this mod and are part of oil processing. This is realistic, since CO2 emissions are a well known side-effect of burning fossil fuels and 
[industrial helium is produced as part of natural gas production](https://www.popularmechanics.com/science/health/a4046/why-is-there-a-helium-shortage-10031229/).

Make no mistake, Nuclear Power is not simple to build in the real world. No new raw materials will be added as part of this mod, instead, 
the quantity of materials and physical size of land needed to build a nuclear site, as well as very long construction times, will be used to bring balance and realism.

Balancing is always hard. Because it's impossible to get a finite mass or volume for one unit of iron/copper in Factorio, the recipes were scaled off what it takes to build a 500MWe, 1GWe, and 1.5GWe nuclear reactor using the 
base-game components.

##A note on fuel
Unless my math is wrong (and by all means, inform me if you know better details for real-world stuff!) a 500MWe LWR should need around 50 million units of in-game refined (u235/238) uranium in order to turn on. That would be 
*per* LWR. This is excessive, so in-game you will be allowed to power a reactor on with a single fuel rod bundle. That bundle will still take around 345,000 refined uranium to build, but that's far better than requring quite 
so much mining before you can get power online. Don't worry, LMR and MSR reactors are *far* easier to fuel, largely because they are able to utilize far more of the energy in their cores!

If you'd like to check my math, see constants.lua. The short version is that 1 unit of u-235 and u-238 in game is roughly 1 gram IRL. This actually works out nicely to each fuel rod needing around 3KG of 
enriched uranium each, which is around what a IRL fuel rod weighs.

### build_manifest.stock_nuclear_500mw
copper-ore 34,980
iron-ore 39,105
stone 20,000
uranium-ore 0
Total limited materials: 94,085

crude-oil 0
heavy-oil 0
light-oil 0
petroleum-gas 80,000
water 200,000
Total unlimited materials: 280,000
Approximate Crude Oil needed: 88,888

##Target for mod version:
* 1:1 pairity, or as close as reasonable. Rational: base factorio version is a light water reactor as well, we're just making it into a single building.
* That said, 'pairity' means ~94,000 units of limited materials needed, and based on real-world needs, 95% of that will be concrete and iron/steel.
* 25% efficiency of overall plant.

### build_manifest.stock_nuclear_1gw
copper-ore 70,910
iron-ore 77,950
stone 40,000
uranium-ore 0
Total limited materials: 188,860

crude-oil 0
heavy-oil 0
light-oil 0
petroleum-gas 160,000
water 400,000
Total unlimited materials: 560,000
Approximate Crude Oil needed: 177,777

##Target for mod version:
* 1/3 the materials needed compared to stock factorio. Again, mostly iron/steel and concrete, but closer to 90% to cover the huge volume of sodium metal needed.
* Building will be physically the same size as the 500MWe plant because the core ends up being around 1/5th the size, but the rest of the machinery is around the same size.
* New fuel type will be added that just converts existing Nuclear Fuel Cells into LMR fuel cells. This is to get around a Factorio limitation. The real-world reason is because
in a real LMR, specifically because it's a fast-breeder reactor, you get around 5x as much energy from a given quantity of fuel as you would in a LWR. If you put 1 ton of fuel
into a LWR, you'd burn up 2-3% of that 1 ton volume (~10-30kg) by the time refuelling happened. In a LMR, you burn up 12-15%, so that same 1 ton of fuel yields FAR more energy.
* 33% efficiency of overall plant.

### build_manifest.stock_nuclear_1.5gw
copper-ore 92,890
iron-ore 104,325
stone 50,000
uranium-ore 0
Total limited materials: 247,215

crude-oil 0
heavy-oil 0
light-oil 0
petroleum-gas 200,000
water 500,000
Total unlimited materials: 700,000
Approximate Crude Oil needed: 222,222

##Target for mod version:
* 2/3 the materials needed for stock factorio reactor. Reasons: low-pressure design (like LMR), greatly improved power density, advanced design and fab techniques.
* Based on a Molten Salt Reactor.
* U-235/238 can be fed directly into the reactor with no need to process into fuel. The online reprocessing plant can grind it down and liquify it.
* Approximatly double the size of MSR. I can't find data indicating they have wildly better power density than LMRs.
* Fuel only needs to be added. Because we don't care about the environment in Factorio, we just consider the radioactive badness ejected into the world 'later' as the pollution from the plant.
* Mod option will exist to disable this pollution if you prefer to play the game under the assumption that a difficult-to-implement option to let the short-lived radioisotopes decay is utilized in your factory.
* 55% efficiency of overall plant. Rationale: 45% efficiency from the plant itself, 10% additional from the lack of need for refueling outages, which cannot easily be simulated in Factorio.

##Reference data:
https://inis.iaea.org/collection/NCLCollectionStore/_Public/04/059/4059045.pdf
https://web.archive.org/web/20060316092516/http://www.nuc.berkeley.edu/news/CEC/CEC_Nuclear_Workshop_PFP_8=051.pdf
https://pdfs.semanticscholar.org/519e/a5c55a312f3f45ccfcc4a093a941366c6658.pdf (see table 1)
https://www.iaea.org/sites/default/files/publications/magazines/bulletin/bull20-6/20604782938.pdf
https://www-pub.iaea.org/MTCD/Publications/PDF/te_1569_web.pdf
https://ocw.mit.edu/courses/nuclear-engineering/22-06-engineering-of-nuclear-systems-fall-2010/lectures-and-readings/MIT22_06F10_lec06a.pdf (LWR reactor sizes, fuel info, etc)

(these are all for how much energy should be in the fuels)
https://www.imperial.ac.uk/media/imperial-college/research-centres-and-groups/nuclear-engineering/1-Introduction-to-water-reactors.pdf
https://www2.lbl.gov/abc/wallchart/chapters/14/1.html
https://whatisnuclear.com/energy-density.html
https://www.nuclear-power.net/nuclear-power-plant/nuclear-fuel/fuel-consumption-of-conventional-reactor/
https://en.wikipedia.org/wiki/Nuclear_fuel
https://old.reddit.com/r/askscience/comments/e5fl9x/can_anyone_explain_nuclear_reactor_breeding/
https://www.osti.gov/servlets/purl/6198515 (table 5; be sure to multiply results by 6 to get the total fuel load for the entire core!)
https://www.researchgate.net/publication/263104281_Proposal_for_a_Simplified_Thorium_Molten_Salt_Reactor (for MSR data)
http://www.janleenkloosterman.nl/reports/thesis_frima_2013.pdf (More MSR data)
http://ecolo.org/documents/documents_in_english/MSR-Molten-salt-reactor.pdf (msr fueling data, and good info on LMRs)
http://www.egeneration.org/wp-content/Repository/Argonne_National_Laboratory_Analysis/NA_MCFBR.pdf (MSR data for uranium cycle)