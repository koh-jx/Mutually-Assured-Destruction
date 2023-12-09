extends "res://scenes/entity/entity.gd"

const SPEED = 50000.0

func _physics_process(delta):
	reset_physics()
	handle_gravity_rotation()
	
	handle_input_velocity(delta)
	
	handle_gravity_velocity(delta)
	super._physics_process(delta)

func handle_input_velocity(delta):
	# Add input key directions
	var input_dir = Input.get_action_strength("ui_right") - \
					Input.get_action_strength("ui_left")
	var input_vector = SPEED * delta * input_dir * Vector2.RIGHT
	
	# rotate to current rotation's axis
	velocity += input_vector.rotated(rotation)
	
