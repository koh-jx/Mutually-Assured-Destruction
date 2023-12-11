# Class representing the player, who derives input directions from controls
extends "res://scenes/entity/tank.gd"

signal health_damaged
signal player_died

func _physics_process(delta):
	velocity_input_dir = Input.get_action_strength("ui_right") - \
					Input.get_action_strength("ui_left")
	rotation_input_dir = Input.get_action_strength("ui_up") - \
					Input.get_action_strength("ui_down")
	super._physics_process(delta)
	# Shoot any missles
	if can_shoot and Input.is_action_just_released("shoot-missle"):
		shoot_missle()

func _on_hurtbox_body_entered(body):
	emit_signal("health_damaged", body.damage)
	super._on_hurtbox_body_entered(body)
