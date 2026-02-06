extends Area2D

@onready var sprite = $Sprite2D


@export var sprite_texture:Texture2D

var player_in_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.visible = false
	if sprite_texture:
		sprite.texture = sprite_texture
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		interact()
		


func _on_area_entered(area: Area2D) -> void:
		player_in_area = true
		sprite.visible = true


func _on_area_exited(area: Area2D) -> void:
	player_in_area = false
	sprite.visible = false
	
func interact():
	get_tree().change_scene_to_file("res://home.tscn")
