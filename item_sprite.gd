extends Sprite2D

@onready var character = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var item_texture = Global.get_held_item().get("texture")
	if item_texture == null:
		visible = false
		texture = PlaceholderTexture2D.new()
	else:
		visible = true
		texture = load(item_texture)
		scale = Vector2(8,8) / texture.get_size()
		
	if character.direction == -1:
		position = Vector2(-7.0, 2)
		flip_h = true
	elif character.direction == 1:
		position = Vector2(7.0, 2.0)
		flip_h = false
