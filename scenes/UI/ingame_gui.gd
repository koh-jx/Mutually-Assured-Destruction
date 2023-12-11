extends MarginContainer

@onready var playerhealth_node = $player_life
@onready var enemyhealth_node =  $enemy_life

func _ready():
	pass

func _on_player_health_damaged(damage):
	playerhealth_node.damaged(damage)


func _on_enemy_enemy_health_damaged(damage):
	enemyhealth_node.damaged(damage)
