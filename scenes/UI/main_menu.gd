extends Control

var SFXplayer = preload("res://scenes/UI/sfx_player.tscn")
signal start_game
signal start_local_multiplayer

func _on_texture_button_pressed():
	if $"../Camera".location != 0:
		return
	
	var sfx = SFXplayer.instantiate()
	sfx.play_sfx("button", 0.3)
	get_parent().add_child(sfx)
	
	$"../Planet".change_sprite()
	emit_signal("start_game")
	await $"../Camera".finishedPanning
	$"../ingame_gui".start_game()


func _on_ingame_gui_update_high_score(streak: int):
	var curr_score = int($HighScoreLabel/hi_score.text)
	$HighScoreLabel/hi_score.text = str(max(curr_score, streak))


func _on_multiplayer_button_pressed():
	if $"../Camera".location != 0:
		return
	
	var sfx = SFXplayer.instantiate()
	sfx.play_sfx("button", 0.3)
	get_parent().add_child(sfx)
	
	$"../Planet".change_sprite()
	emit_signal("start_game")
	await $"../Camera".finishedPanning
	$"../ingame_gui".start_multiplayer_game()
