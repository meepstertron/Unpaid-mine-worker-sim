extends TileMapLayer


@onready var overlay = get_parent().get_node("Overlay")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func break_cell(cell:Vector2i):
	if Global.tile_data.get(cell).get("on_break") != null:
		var script = load(Global.tile_data.get(cell).get("on_break"))
		var instance = script.new()
		
		if instance.has_method("_call"):
			
			instance._call(Global.tile_data.get(cell), cell, map_to_local(to_global(cell)), get_parent())
	Global.tile_data.erase(cell)
	overlay.erase_cell(cell)
	
	set_cells_terrain_connect([cell], 0, -1)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var cell = local_to_map(to_local(get_global_mouse_position()))
		if get_cell_source_id(cell) == -1:
			return
		print(cell)
		var tileData = Global.tile_data.get(cell, {})
		if not tileData.has("damage"):
			tileData["damage"] = 100 # 100%
			Global.tile_data.set(cell, tileData)
		elif tileData["damage"] <= 0:
			break_cell(cell)
			
		var cell_data = get_cell_tile_data(cell)
		var cell_unbreakable = false
		var cell_hardness = 0
		if cell_data != null:
			cell_unbreakable = cell_data.get_custom_data("unbreakable")
			cell_hardness = cell_data.get_custom_data("hardness")
		
		if cell_unbreakable:
			return
		
		var hardness_diff = cell_hardness-Global.get_held_item().get("hardness", 0)
		
		var mult = pow(0.5, hardness_diff)
		tileData["damage"] = tileData["damage"]-(Global.get_held_item().get("block_damage", 5)*mult)
		Global.tile_data.set(cell, tileData)
		
		var tile_damage_texture = round((100-tileData["damage"])/25)
		
		if tile_damage_texture != 0:
			overlay.set_cell(cell, 0, Vector2i(tile_damage_texture, 0))
		
		
		
		if tileData["damage"] <= 0:
			break_cell(cell)
			
		
		
		
		
		
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
