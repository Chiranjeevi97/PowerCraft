dofile(minetest.get_modpath(minetest.get_current_modname()).."/generatortest.lua");

minetest.register_node("powercraft:cablewire", {
	description = "Cablewire",
	drawtype = "raillike",
	paramtype2 = "facedir",
	tiles ={"wire_off.png"},
	inventory_image = "wire_off.png",
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	sounds = default.node_sound_defaults(),
	-- ReceivePacket = function(volt)
		-- voltage = volt	
	-- end
})

minetest.register_abm({
    nodenames = {"powercraft:cablewire"},
    neighbors = {"powercraft:cablewire"},
    interval = 1, -- Run every 10 seconds
    chance = 1, -- Select every 1 in 50 nodes
    action = function(pos, node, active_object_count,
            active_object_count_wider)
			if(set) then 
				minetest.chat_send_all("Wire: X:"..pos.x.." Y:"..pos.y.." Z:"..pos.z.." Voltage : " ..Wire.voltage[position])
				set = false
			end
    end
})
Wire = {
	voltage = {}
}

Wire.ReceiveVoltage = function(pos)
	position = pos
	Wire.voltage[position] = Generator.voltage[pos]
	set = true
end

set = false;


