extends "res://scenes/entity/entity.gd"

var Missle = preload("res://scenes/Projectiles/missle.tscn")

const SPEED = 35000.0
enum Direction {FACING_LEFT, FACING_RIGHT}
var direction_faced : Direction = Direction.FACING_RIGHT
var can_shoot = true

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
	
	# Move angle slightly upwards to minimise collision with planet
	if input_dir > 0: # Going right
		input_vector = input_vector.rotated(deg_to_rad(-5))
		direction_faced = Direction.FACING_RIGHT
	elif input_dir < 0: # Going left
		input_vector = input_vector.rotated(deg_to_rad(5))
		direction_faced = Direction.FACING_LEFT
	
	# rotate to current rotation's axis
	velocity += input_vector.rotated(rotation)
	
	# Shoot any missles
	if can_shoot and Input.is_action_just_released("shoot-missle"):
		shoot_missle()
	
func shoot_missle():
	var missle = Missle.instantiate()
	get_parent().add_child(missle)
	missle.global_position = global_position
	var direction = Vector2.RIGHT
	direction = direction.rotated(deg_to_rad(-1 * missle.angle))
	direction = direction.rotated(rotation)
	missle.thrust_in_direction(direction)
	
	can_shoot = false
	$ShootTimer.start()


func _on_shoot_timer_timeout():
	can_shoot = true
