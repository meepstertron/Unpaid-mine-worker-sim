extends Control

@onready var inv_label = $InventoryLabel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	inv_label.text = str(len(Global.inventory))+"/"+str(Global.inventory_max)
