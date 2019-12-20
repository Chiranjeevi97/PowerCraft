minetest.register_node("powercraft:burger", {
	paramtype2="facedir",
	description = "burger",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles ={"Food.png", "Food.png",
			"Food.png", "Food.png",
			"Food.png", "Food.png"},
	--inventory_image = "Food.png",
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_defaults(),
	on_timer = function(pos)
        minetest.chat_send_all("Timer : ")
        return false
    end
},{
	groups = {dig_immediate=2},
	tiles = {	"Food.png", "Food.png",
				"Food.png", "Food.png",
				"Food.png", "Food.png"},
},{
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	tiles = {	"Food.png", "Food.png",
				"Food.png", "Food.png",
				"Food.png", "Food.png"},
})

minetest.register_abm({
    nodenames = {"powercraft:burger"},
    --neighbors = {"default:water_source", "default:water_flowing"},
    interval = 2, -- Run every 10 seconds
    chance = 1, -- Select every 1 in 50 nodes
    action = function(pos, node, active_object_count,
            active_object_count_wider)
        minetest.chat_send_all("Voltage :  " ..volt .."; Amperage : " ..amperage .."; Phase :  " ..phase)
		change(voltage, amperage, phase)
    end
})

function change(voltage, amperage, phase)
	for i=0,volt,1 do
		volt = i
		amperage = i+20
		phase = i+30
	end
	minetest.chat_send_all("Voltage :  " ..volt .."; Amperage : " ..amperage .."; Phase :  " ..phase)
end

volt = 40
amperage = 1
phase = 0

