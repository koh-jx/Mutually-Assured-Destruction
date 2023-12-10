extends "res://scenes/Projectiles/projectile.gd"

const magnitude = 450.0
const angle = 30.0

func _ready():
	#thrust_towards(Vector2()) # Example to use if placed directly in world
	toggle_collision() # Prevent missle from harming shooter
	
func thrust_in_direction(direction: Vector2):
	linear_velocity = direction.normalized() * magnitude

func thrust_towards(target: Vector2):
	var direction = target - global_position
	linear_velocity = direction.normalized() * magnitude

func _integrate_forces(state):
	super._integrate_forces(state)

func _on_body_entered(body):
	queue_free()

func _on_hitbox_body_entered(body):
	# TODO Damage entity
	queue_free()

func _on_invuln_timer_timeout():
	toggle_collision()
	
func toggle_collision():
	var shape = $CollisionShape2D
	shape.set_disabled(!shape.disabled)
	var hitboxShape = $Hitbox/CollisionShape2D
	hitboxShape.set_disabled(!hitboxShape.disabled)
