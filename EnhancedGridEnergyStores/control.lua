local satellite_names = { "nimh-satellite", "li-ion-satellite", "flywheel-satellite" }

script.on_init( function()
	if not remote.interfaces["silo_script"] then
		log("silo_script interface not found.")
		return
	end
	
	for _, item in pairs(satellite_names) do
		remote.call("silo_script", "add_tracked_item", item)
	end
end)
