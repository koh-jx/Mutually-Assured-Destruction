extends "res://scenes/entity/Projectiles/projectile.gd"

@export var thrust = Vector2(-300,-100)

func _ready():
	# TODO account for direction of shot by rotating initial_thrust
	linear_velocity = thrust
	
func _integrate_forces(state):
	super._integrate_forces(state)

func _on_body_entered(body):
	queue_free()

func _on_hitbox_body_entered(body):
	# TODO Damage entity
	queue_free()
