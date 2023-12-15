# Class representing the player, who derives input directions from controls
extends "res://scenes/entity/tank.gd"

signal health_damaged
signal player_died

var right_input = "player_1_right"
var left_input  = "player_1_left"
var up_input    = "player_1_up"
var down_input  = "player_1_down"
var shoot_input = "player_1_shoot"

func _ready():
	super._ready()
	death_signal_name = "player_died"

func _physics_process(delta):
	velocity_input_dir = Input.get_action_strength(right_input) - \
					Input.get_action_strength(left_input)
	rotation_input_dir = Input.get_action_strength(up_input) - \
					Input.get_action_strength(down_input)
	super._physics_process(delta)
	# Shoot any missles
	if can_shoot and Input.is_action_just_released(shoot_input):
		shoot_missle()

func _on_hurtbox_body_entered(body):
	emit_signal("health_damaged", body.damage)
	super._on_hurtbox_body_entered(body)

func toggle_player(player_num : int):
	assert(player_num == 1 or player_num == 2)
	var string = str(player_num)
	right_input = "player_" + string + "_right"
	left_input = "player_" + string + "_left"
	up_input = "player_" + string + "_up"
	down_input = "player_" + string + "_down"
	shoot_input = "player_" + string + "_shoot"

	if player_num == 2:
		$AnimatedSprite2D.modulate = Color(1, 0, 0)
