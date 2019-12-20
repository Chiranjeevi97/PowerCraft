minetest.register_node("powercraft:generator", {
	paramtype2="facedir",
	description="Generator",
	tiles ={"generator_top.png", "generator_front.png",
			"generator_back.png", "generator_back.png", 
			"generatorback.png", "generator_front.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	sounds = default.node_sound_defaults(),
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
			minetest.chat_send_all("Voltage Set to " .. fields.newVoltage)
			--local name = minetest.get_content_id("mymods_generator:generator")
			--minetest.chat_send_all(" ID : " ..name)
			ChangeVoltage(fields.newVoltage, pos)
		end
    end
})

minetest.register_abm({
    nodenames = {"powercraft:generator"},
    neighbors = {"powercraft:cablewire"},
    interval = 2, -- Run every 10 seconds
    chance = 1, -- Select every 1 in 50 nodes
    action = function(pos, node, active_object_count, active_object_count_wider)
		
		local id = "X"..pos.x.."Y"..pos.y.."Z"..pos.z
		local node_pos = minetest.find_node_near(pos, 1, { "powercraft:cablewire" })
		if (node_pos and changed) then
			--minetest.chat_send_all("Node found at: " .. dump(node_pos))
			--node = minetest.get_node(node_pos)
			--minetest.chat_send_all("Node is : " ..node.name)
			--node.ReceivePacket(Generator.voltage[id])
			Wire.ReceiveVoltage(id)
		end
		
    end
})


ChangeVoltage = function(volt, pos)
	id = "X"..pos.x.."Y"..pos.y.."Z"..pos.z
	Generator.voltage[id] = volt
	voltage = Generator.voltage[id]
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec",
						"size[5,5]".. 
						"label[1,1;Previous Voltage : " .. voltage .."]"..
						"label[1,2; Set Voltage ]"..
						"field[1,3;2,1;newVoltage;Voltage;]"..
						"button[1,4;3,1;set;Set Voltage]")
	minetest.chat_send_all("Generator at: X"..pos.x.."Y:"..pos.y.." Z:"..pos.z.."Voltage: "..Generator.voltage[id])
	changed = true
end

Generator = {
				voltage = {}
			}
-- Generator.SetVoltage = function(volt, pos)
	-- id = "X"..pos.x.."Y"..pos.y.."Z"..pos.z
	-- minetest.chat_send_all(" Position : " ..id)
	-- Generator.voltage[id] = volt
	-- --changed = true
	-- minetest.chat_send_all(" New Generator Voltage : " ..Generator.voltage[id])
-- end

--generatorsVoltage = {}
--wiresPendingPowerPackets = {}
changed = false;
voltage = 120
