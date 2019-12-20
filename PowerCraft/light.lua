dofile(minetest.get_modpath(minetest.get_current_modname()).."/cable_wire.lua");

minetest.register_node("powercraft:light_off", {
	description = "Light",
	paramtype2 = "facedir",
	tiles ={"Light_off.png"},
	inventory_image = "Light_off.png",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
						"size[5,5]".. 
						"label[1,1;Previous Voltage : " .. voltage .."]"..
						"label[1,2; Set Voltage ]"..
						"field[1,3;2,1;newVoltage;Voltage;]"..
						"button[1,4;3,1;set;Set Voltage]")	
    end,
	on_receive_fields = function (pos, formname, fields, player)
		if(fields.newVoltage) then
			minetest.chat_send_all("Voltage of Light at position : X: "..pos.x .." Y: "..pos.y .." Z: ".. pos.z.. " Set to " .. fields.newVoltage)
			Changelightvoltage(fields.newVoltage, pos)
		end
    end
})

minetest.register_node("powercraft:light_on_low", {
	description = "Light",
	paramtype2 = "facedir",
	tiles ={"Light_off.png"},
	inventory_image = "Light_off.png",	
	paramtype = "light",
	light_source = minetest.LIGHT_MAX - 8,
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
						"size[5,5]".. 
						"label[1,1;Previous Voltage : " .. voltage .."]"..
						"label[1,2; Set Voltage ]"..
						"field[1,3;2,1;newVoltage;Voltage;]"..
						"button[1,4;3,1;set;Set Voltage]")	
    end,
	on_receive_fields = function (pos, formname, fields, player)
		if(fields.newVoltage) then
			minetest.chat_send_all("Voltage of Light at position : X: "..pos.x .." Y: "..pos.y .." Z: ".. pos.z .." Set to " .. fields.newVoltage)
			Changelightvoltage(fields.newVoltage, pos)
		end
    end
})

minetest.register_node("powercraft:light_on", {
	description = "Light",
	paramtype2 = "facedir",
	tiles ={"Light_on.png"},
	inventory_image = "Light_on.png",	
	paramtype = "light",
	light_source = minetest.LIGHT_MAX - 2,
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
						"size[5,5]".. 
						"label[1,1;Previous Voltage : " .. voltage .."]"..
						"label[1,2; Set Voltage ]"..
						"field[1,3;2,1;newVoltage;Voltage;]"..
						"button[1,4;3,1;set;Set Voltage]")	
    end,
	on_receive_fields = function (pos, formname, fields, player)
		if(fields.newVoltage) then
			minetest.chat_send_all("Voltage of Light at position : X: "..pos.x .." Y: "..pos.y .." Z: ".. pos.z.. " Set to " .. fields.newVoltage)
			Changelightvoltage(fields.newVoltage, pos)
		end
    end
})

minetest.register_abm({
    nodenames = {"powercraft:light_off"},
    neighbors = {"powercraft:cablewire"},
    interval = 1, 
    chance = 1, 
    action = function(pos, node, active_object_count,
            active_object_count_wider)
			--minetest.swap_node(pos, {name = "powercraft:light" .. name .. "_on", param2 = node.param2})
			--light_source = minetest.LIGHT_MAX,
		id = "X: "..pos.x.." Y: "..pos.y.." Z: "..pos.z
		if(Light_Changed) then
			if(set) then
				if (tonumber(Generator.voltage[position]) < tonumber(Light.voltage[id])) then
					--minetest.chat_send_all("Low Voltage Low Light")
					minetest.swap_node(pos, {name = "powercraft:light_on_low", param2 = node.param2})
					set = false
				end
				if (tonumber(Generator.voltage[position]) == tonumber(Light.voltage[id])) then
					--minetest.chat_send_all("Turn on the Light")
					minetest.swap_node(pos, {name = "powercraft:light_on", param2 = node.param2})
					set = false
				end
				if (tonumber(Generator.voltage[position]) > tonumber(Light.voltage[id])) then
					minetest.chat_send_all("High Voltage !! at Light position : " ..id)
					blast(pos)
					set = false
				end
			end
		end
    end
})

minetest.register_abm({
    nodenames = {"powercraft:light_on"},
    neighbors = {"powercraft:cablewire"},
    interval = 1, 
    chance = 1, 
    action = function(pos, node, active_object_count,
            active_object_count_wider)
			--minetest.swap_node(pos, {name = "powercraft:light" .. name .. "_on", param2 = node.param2})
			--light_source = minetest.LIGHT_MAX,
		id = "X: "..pos.x.." Y: "..pos.y.." Z: "..pos.z
		if(Light_Changed) then
			if(set) then
				if (tonumber(Generator.voltage[position]) < tonumber(Light.voltage[id])) then
					--minetest.chat_send_all("Low Voltage Low Light")
					minetest.swap_node(pos, {name = "powercraft:light_on_low", param2 = node.param2})
					set = false
				end
				if (tonumber(Generator.voltage[position]) == tonumber(Light.voltage[id])) then
					--minetest.chat_send_all("Turn on the Light")
					minetest.swap_node(pos, {name = "powercraft:light_on", param2 = node.param2})
					set = false
				end
				if (tonumber(Generator.voltage[position]) > tonumber(Light.voltage[id])) then
					minetest.chat_send_all("High Voltage !! at Light position : " ..id)
					blast(pos)
					set = false
				end
			end
		end
    end
})

minetest.register_abm({
    nodenames = {"powercraft:light_on_low"},
    neighbors = {"powercraft:cablewire"},
    interval = 1, 
    chance = 1, 
    action = function(pos, node, active_object_count,
            active_object_count_wider)
			--minetest.swap_node(pos, {name = "powercraft:light" .. name .. "_on", param2 = node.param2})
			--light_source = minetest.LIGHT_MAX,
		id = "X: "..pos.x.." Y: "..pos.y.." Z: "..pos.z
		if(Light_Changed) then
			if(set) then
				if (tonumber(Generator.voltage[position]) < tonumber(Light.voltage[id])) then
					--minetest.chat_send_all("Low Voltage Low Light")
					minetest.swap_node(pos, {name = "powercraft:light_on_low", param2 = node.param2})
					set = false
				end
				if (tonumber(Generator.voltage[position]) == tonumber(Light.voltage[id])) then
					--minetest.chat_send_all("Turn on the Light")
					minetest.swap_node(pos, {name = "powercraft:light_on", param2 = node.param2})
					set = false
				end
				if (tonumber(Generator.voltage[position]) > tonumber(Light.voltage[id])) then
					minetest.chat_send_all("High Voltage !! at Light position : " ..id)
					blast(pos)
					set = false
				end
			end
		end
    end
})

Changelightvoltage = function(volt, pos)
	id = "X: "..pos.x.." Y: "..pos.y.." Z: "..pos.z
	Light.voltage[id] = volt
	voltage = Light.voltage[id]
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec",
						"size[5,5]".. 
						"label[1,1;Previous Voltage : " .. voltage .."]"..
						"label[1,2; Set Voltage ]"..
						"field[1,3;2,1;newVoltage;Voltage;]"..
						"button[1,4;3,1;set;Set Voltage]")
	--minetest.chat_send_all("Light at: X"..pos.x.."Y:"..pos.y.." Z:"..pos.z.."Voltage: "..Generator.voltage[id])
	Light_Changed = true
end

blast = function(pos)
		minetest.sound_play(
			"default_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1}
		)
		minetest.remove_node(pos)
	-- Remove the node
	return false
end

Light = {
			voltage = {}
		}

Light.ReceiveVoltage = function(pos, volt)
	position = pos
	voltage = volt
	set = true
end
 
voltage = 100
set = false
Light_Changed = false
