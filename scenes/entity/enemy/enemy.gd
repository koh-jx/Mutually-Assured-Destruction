# Class representing the enemy, who derives input directions from probabilities
extends "res://scenes/entity/tank.gd"

@export var shoot_chance = 0.4
@export var change_rotation_chance = 0.01
@export var stop_moving_chance = 0.01
@export var change_direction_chance = 0.04

signal enemy_health_damaged
signal enemy_died

func _ready():
	super._ready()
	death_signal_name = "enemy_died"

func _physics_process(delta):
	random_update_velocity_input_dir()
	random_update_rotation_input_dir()
	super._physics_process(delta)
	random_check_and_shoot()

func random_update_velocity_input_dir():
	if velocity_input_dir == 0 and randf() < change_direction_chance:
		velocity_input_dir = 1 if randi() % 2 else -1
	else:
		if randf() <= change_direction_chance:
			velocity_input_dir *= -1
		elif randf() <= stop_moving_chance:
			velocity_input_dir = 0

func random_update_rotation_input_dir():
	if rotation_input_dir == 0 and randf() < change_rotation_chance:
		rotation_input_dir = 1 if randi() % 2 else -1
		
	else:
		if randf() <= change_rotation_chance:
			rotation_input_dir *= -1
		elif randf() <= stop_moving_chance:
			rotation_input_dir = 0

func random_check_and_shoot():
	if can_shoot and randf() <= shoot_chance:
		shoot_missle()

func _on_hurtbox_body_entered(body):
	emit_signal("enemy_health_damaged", body.damage)
	super._on_hurtbox_body_entered(body)
