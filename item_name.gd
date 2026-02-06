extends Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if len(Global.get_held_item()) == 0:
		visible = false
	else:
		visible = true
	
	if Global.get_held_item().get("name") != null:
		text = Global.get_held_item().get("name")
