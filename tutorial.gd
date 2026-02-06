extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.tile_data.set(Vector2i(-52, 0), {
		"on_break": "res://loot_table.gd",
		"loot_table": {
			"guaranteed": [
				{
					"item": {
						"id": "ash",
						"name": "Ashes",
						"texture": "res://ash.png"
					},
					"ammount": 1
				}
			]
		}
	})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
