extends MarginContainer

@onready var playerhealth_node = $player_life
@onready var enemyhealth_node =  $enemy_life

var Player = preload("res://scenes/entity/player/player.tscn")
var Enemy = preload("res://scenes/entity/enemy/enemy.tscn")
signal return_to_menu
signal update_high_score
signal self_destruct

const ENEMY_SPAWN_DISTANCE = 500.0
const ENEMY_DIFFICULTY_MULTIPLIER = 2
var streak = 0
enum GameState {ONGOING, STOPPED}
var curr_gamestate: GameState = GameState.STOPPED

func _ready():
	pass

func _on_player_health_damaged(damage):
	playerhealth_node.damaged(damage)

func _on_enemy_enemy_health_damaged(damage):
	enemyhealth_node.damaged(damage)

func _reset_player_health(player, playerNum: int):
	assert(playerNum == 1 or playerNum == 2)
	if playerNum == 1:
		player.health_damaged.connect(_on_player_health_damaged)
		player.player_died.connect(end_game)
		playerhealth_node.reset()
	elif playerNum == 2:
		player.health_damaged.connect(_on_enemy_enemy_health_damaged)
		player.player_died.connect(end_game)
		enemyhealth_node.reset()

func _reset_enemy_health(enemy):
	enemy.enemy_health_damaged.connect(_on_enemy_enemy_health_damaged)
	enemy.enemy_died.connect(continue_game)
	enemyhealth_node.reset()

func _spawn_player(location):
	var player = Player.instantiate()
	get_parent().add_child(player)
	player.global_position = location
	self_destruct.connect(player.queue_free)
	return player

func _spawn_enemy(location: Vector2):
	if curr_gamestate != GameState.ONGOING:
		return
	var enemy = Enemy.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = location
	self_destruct.connect(enemy.queue_free)
	return enemy

func _spawn_next_enemy():
	if curr_gamestate != GameState.ONGOING:
		return
	var planet_center = $"../Planet".global_position
	var spawn_vector = Vector2(ENEMY_SPAWN_DISTANCE, 0)
	spawn_vector = spawn_vector.rotated(randf_range(0, 359))
	return _spawn_enemy(planet_center + spawn_vector)
	
func _set_score(new_score: int):
	var high_score_label = $high_score/score
	high_score_label.set_text(str(new_score))

func start_game():
	curr_gamestate = GameState.ONGOING
	
	streak = 0
	_set_score(streak)
	$high_score.visible = true
	
	var curr_player = _spawn_player(Vector2(100, 100))
	var curr_enemy  = _spawn_enemy(Vector2(1149, 640))
	_reset_player_health(curr_player, 1)
	_reset_enemy_health(curr_enemy)

func start_multiplayer_game():
	curr_gamestate = GameState.ONGOING
	$high_score.visible = false
	
	var player_1 = _spawn_player(Vector2(100, 100))
	player_1.toggle_player(1)
	_reset_player_health(player_1, 1)
	
	var player_2 = _spawn_player(Vector2(1040, 646))
	player_2.toggle_player(2)
	_reset_player_health(player_2, 2)

func continue_game():
	if curr_gamestate != GameState.ONGOING:
		return
		
	streak += 1
	_set_score(streak)
	$AnimationPlayer.play("increment_score")
	$enemy_spawn_timer.start()
	
	
func end_game():
	curr_gamestate = GameState.STOPPED
	$return_timer.start()
	emit_signal("update_high_score", streak)
	
func _on_return_timer_timeout():
	emit_signal("return_to_menu")
	$destruct_timer.start()
	
func _on_destruct_timer_timeout():
	emit_signal("self_destruct")

func _on_enemy_spawn_timer_timeout():
	var enemy = _spawn_next_enemy()
	_reset_enemy_health(enemy)
