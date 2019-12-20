dofile(minetest.get_modpath(minetest.get_current_modname()).."/generator.lua");

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
			local node_pos = minetest.find_node_near(pos, 1, { "powercraft:light" })
			local id = "X"..pos.x.."Y"..pos.y.."Z"..pos.z
			if(set) then 
				Wire.voltage[id] = volt
			end
			if(set and node_pos) then 
				--minetest.chat_send_all("Wire: X:"..pos.x.." Y:"..pos.y.." Z:"..pos.z.." Voltage : " ..Wire.voltage[position])
				Light.ReceiveVoltage(position, volt)
				set = false
			end
    end
})

Wire = {
	voltage = {}
}

Wire.ReceiveVoltage = function(pos, volt)
	position = pos
	voltage = volt
	set = true
end

set = false;


