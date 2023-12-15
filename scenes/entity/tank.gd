# Tank "interface" to handle common player functions (movement, weapons)
# directions from inputs and weapon usage are done in child classes
extends "res://scenes/entity/entity.gd"

var Missle = preload("res://scenes/Projectiles/missle.tscn")
var Explosion = preload("res://scenes/Projectiles/explosion.tscn")
var SFXplayer = preload("res://scenes/UI/sfx_player.tscn")

# Default stats
var shoot_angle = 30.0
const SHOOT_ROTATION_SPEED = 200.0
const MIN_SHOOT_ANGLE = 30.0
const MAX_SHOOT_ANGLE = 150.0
var health = 5
var speed = 25000.0
var reload_speed = 0.5

# Variables
enum Direction {FACING_LEFT, FACING_RIGHT}
var direction_faced : Direction = Direction.FACING_RIGHT
var can_shoot: bool = true
var velocity_input_dir: float = 0
var rotation_input_dir: float = 0

# For child classes
var death_signal_name: StringName

func _ready():
	$Arrowhead.rotate(-1 * deg_to_rad(shoot_angle))
	$ShootTimer.set_wait_time(reload_speed)
	super._ready()

# Update velocity_input_dir and rot_input_dir 
# in child._physics_process or otherwise
func _physics_process(delta):
	reset_physics()
	handle_gravity_rotation()
	handle_input_velocity(delta, velocity_input_dir)
	handle_arrowhead_rotation(delta, rotation_input_dir)
	handle_gravity_velocity(delta)
	super._physics_process(delta)

func handle_input_velocity(delta, input_dir: float):
	# Add input key directions
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

func handle_arrowhead_rotation(delta, input_dir: float):
	var change_in_angle = input_dir * delta * SHOOT_ROTATION_SPEED	
	if shoot_angle + change_in_angle >= MIN_SHOOT_ANGLE and \
			shoot_angle + change_in_angle <= MAX_SHOOT_ANGLE:
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
	var sfx = SFXplayer.instantiate()
	sfx.play_sfx("death", 0.0)
	get_parent().add_child(sfx)
	
	var explosion = Explosion.instantiate()
	get_parent().add_child(explosion)
	explosion.set_animation("mushroom_cloud")
	explosion.global_position = global_position
	explosion.global_rotation = global_rotation
	explosion.global_scale = Vector2(2, 2)
	
	emit_signal(death_signal_name)
	queue_free()
