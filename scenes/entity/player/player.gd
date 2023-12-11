extends "res://scenes/entity/entity.gd"

var Missle = preload("res://scenes/Projectiles/missle.tscn")

enum Direction {FACING_LEFT, FACING_RIGHT}
var direction_faced : Direction = Direction.FACING_RIGHT
var can_shoot = true

# Player stats
var shoot_angle = 30.0
const SHOOT_ROTATION_SPEED = 200.0
var health = 100
var speed = 35000.0
var reload_speed = 0.5

func _ready():
	$Arrowhead.rotate(-1 * deg_to_rad(shoot_angle))
	super._ready()

func _physics_process(delta):
	reset_physics()
	handle_gravity_rotation()
	handle_input_velocity(delta)
	handle_gravity_velocity(delta)
	super._physics_process(delta)
	
	handle_arrowhead_rotation(delta)

func handle_input_velocity(delta):
	# Add input key directions
	var input_dir = Input.get_action_strength("ui_right") - \
					Input.get_action_strength("ui_left")
	var input_vector = speed * delta * input_dir * Vector2.RIGHT
	
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

func handle_arrowhead_rotation(delta):
	
		#return
	var input_dir = Input.get_action_strength("ui_up") - \
					Input.get_action_strength("ui_down")
	var change_in_angle = input_dir * delta * SHOOT_ROTATION_SPEED	
	if shoot_angle + change_in_angle >= 30 and shoot_angle + change_in_angle <= 150:
		shoot_angle += change_in_angle
		$Arrowhead.rotation -= deg_to_rad(change_in_angle)

func shoot_missle():
	var missle = Missle.instantiate()
	get_parent().add_child(missle)
	missle.global_position = global_position
	var direction = Vector2.RIGHT
	direction = direction.rotated(deg_to_rad(-1 * shoot_angle))
	direction = direction.rotated(rotation)
	missle.thrust_in_direction(direction)
	
	can_shoot = false
	$ShootTimer.start()

func _on_shoot_timer_timeout():
	can_shoot = true

func _on_hurtbox_body_entered(body):
	var damage = body.damage
	take_damage(damage)

func take_damage(damage):
	health -= damage
	print(damage, " damage taken, ", health, " health left")
	if health <= 0:
		lose()

func lose():
	queue_free()
