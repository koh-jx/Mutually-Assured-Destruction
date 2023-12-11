extends "res://scenes/Projectiles/projectile.gd"

const magnitude = 450.0
const damage = 1

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
	$SmokeTrail.reparent_to_root()
	super.on_destroy()

func _on_invuln_timer_timeout():
	toggle_collision()
	
func toggle_collision():
	var shape = $CollisionShape2D
	shape.set_disabled(!shape.disabled)
