extends Node



var item_scene = preload("res://item.tscn")

func _call(tileData, cell:Vector2i, location, parent):
	
	var loot_table = tileData.get("loot_table")
	var items_to_spawn = []
	
	if loot_table == null:
		return
	
	if loot_table.get("guaranteed") != null:
		for item in loot_table.get("guaranteed"):
			for i in range(0, item.get("ammount")):
				items_to_spawn.append(item.get("item"))
		
	
	if items_to_spawn.size() == 0:
		return
	else:
		for item in items_to_spawn:
			print(item)
			var item_obj = item_scene.instantiate()
			item_obj.item_id = item.get("id")
			item_obj.item_name = item.get("name")
			item_obj.item_texture = item.get("texture")
			item_obj.item_type = item.get("type", 0)
			
			var core_keys = ["id", "name", "texture", "type"]
			var extra = {}
			
			for key in item.keys():
				if key not in core_keys:
					extra[key] = item[key]
			
			if extra.size() > 0:
				item_obj.extra_flags = extra
			
			
			item_obj.global_position = location
			
			item_obj.linear_velocity = Vector2( randf_range(-200, 200), -200)
			parent.add_child(item_obj)
