extends RigidBody2D

@export var item_id = "undefined"
@export var item_name = "Name Not defined"
@export var item_texture = "res://"
@export var size_wanted = Vector2(8,8)
@export var item_mass = 1
enum ItemType {
	GENERIC,
	TOOL,
	ARTIFACT
}
@export var item_type: ItemType = ItemType.GENERIC
@export var extra_flags= {}

@onready var sprite = $Sprite2D



func _ready() -> void:
	add_to_group("items")
	if item_texture != "":
		var tex = load(item_texture) as Texture2D
		sprite.texture = tex
		sprite.scale = size_wanted / tex.get_size()
		mass = item_mass
		

func _pickup() -> void:
	var item= {
		"id": item_id,
		"name": item_name,
		"texture": item_texture,
		"type": item_type
	  }
	if len(extra_flags) != 0:
		item.merge(extra_flags)
	Global.inventory.append(item)
	queue_free()
	

func _drop(instance) -> void:
	pass
