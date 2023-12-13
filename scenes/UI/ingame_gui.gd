extends MarginContainer

@onready var playerhealth_node = $player_life
@onready var enemyhealth_node =  $enemy_life

var Player = preload("res://scenes/entity/player/player.tscn")
var Enemy = preload("res://scenes/entity/enemy/enemy.tscn")
signal return_to_menu

var curr_player
var curr_enemy

func _ready():
	pass

func _on_player_health_damaged(damage):
	playerhealth_node.damaged(damage)

func _on_enemy_enemy_health_damaged(damage):
	enemyhealth_node.damaged(damage)

func _reset_health(player, enemy):
	player.health_damaged.connect(_on_player_health_damaged)
	enemy.enemy_health_damaged.connect(_on_enemy_enemy_health_damaged)
	player.player_died.connect(end_game)
	enemy.enemy_died.connect(end_game)
	playerhealth_node.reset()
	enemyhealth_node.reset()

func _spawn_player():
	var player = Player.instantiate()
	get_parent().add_child(player)
	player.global_position = Vector2(100, 100)
	return player

func _spawn_enemy(location: Vector2):
	var enemy = Enemy.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = location
	return enemy

func start_game():
	curr_player = _spawn_player()
	curr_enemy  = _spawn_enemy(Vector2(1149, 640))
	_reset_health(curr_player, curr_enemy)
	
func end_game():
	print("END GAME")
	$return_timer.start()
	
func _on_return_timer_timeout():
	emit_signal("return_to_menu")
	$destruct_timer.start()
	
func _on_destruct_timer_timeout():
	if curr_enemy and is_instance_valid(curr_enemy):
		curr_enemy.queue_free()
	if curr_player and is_instance_valid(curr_player):
		curr_player.queue_free()


