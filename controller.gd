extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -200.0
const MAX_FALL_SPEED = 600.0

var direction: float = 0.0
var item_scene = preload("res://item.tscn")
var pickup_cooldown: float = 0.0

@onready var item_area = $Area2D

func _physics_process(delta: float) -> void:
	if pickup_cooldown > 0:
		pickup_cooldown -= delta
		if pickup_cooldown <= 0:
			item_area.monitoring = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		velocity.y = min(velocity.y, MAX_FALL_SPEED)
	
	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("drop"):
		var item = item_scene.instantiate()
		var current_item = Global.get_held_item()
		if current_item == {} or current_item == null:
			return
		item.item_id = current_item.get("id")
		item.item_name = current_item.get("name")
		item.item_texture = current_item.get("texture")
		item.item_type = current_item.get("type")
		
		var core_keys = ["id", "name", "texture", "type"]
		var extra = {}
		
		for key in current_item.keys():
			if key not in core_keys:
				extra[key] = current_item[key]
		
		if extra.size() > 0:
			item.extra_flags = extra
		var directionvectorx = 15 * direction
		item.global_position = position + Vector2(directionvectorx, -6)
		
		var throw_direction = direction if direction != 0 else 1
		item.linear_velocity = Vector2(throw_direction * 300, -200)
		
		item_area.monitoring = false
		pickup_cooldown = 0.3
		Global.inventory.erase(current_item)
		get_parent().add_child(item)
		
		
	if Input.is_action_just_pressed("scroll_up"):
		Global.selected_slot += 1
		if Global.selected_slot > len(Global.inventory)- 1:
			Global.selected_slot = 0

	if Input.is_action_just_pressed("scroll_down"):
		Global.selected_slot -= 1
		if Global.selected_slot < 0 :
			Global.selected_slot = len(Global.inventory)-1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
