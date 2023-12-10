extends "res://scenes/Projectiles/projectile.gd"

@export var thrust = Vector2(-300,-100)

func _ready():
	# TODO account for direction of shot by rotating initial thrust
	# TODO modify initial thrust to just be a magnitude
	linear_velocity = thrust # Add gravity force
	
func _integrate_forces(state):
	super._integrate_forces(state)

func _on_body_entered(body):
	queue_free()

func _on_hitbox_body_entered(body):
	# TODO Damage entity
	queue_free()
