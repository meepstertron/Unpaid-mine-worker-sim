extends Node


var tile_data = {}

var inventory = []

var inventory_max = 8

var selected_slot = 0


#ar held_item = {
#	"id": "default_pickaxe",
#	"name": "Default Pickaxe",
#	"block_damage": 20, # assuming block matches hardness
#	"hardness": 1  
#}
func get_held_item():
	if len(inventory) == 0:
		return {}
	var item = inventory.get(selected_slot)
	if item == null:
		item = {}
	return item




var item_registry = [
	{
		"id": "iron"
	},
	{
		"id": "coal"
	}
]
