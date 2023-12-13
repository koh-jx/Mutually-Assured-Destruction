extends Control

var SFXplayer = preload("res://scenes/UI/sfx_player.tscn")
signal start_game

func _on_texture_button_pressed():
	var sfx = SFXplayer.instantiate()
	sfx.play_sfx("button", 0.3)
	get_parent().add_child(sfx)
	
	$"../Planet".change_sprite()
	emit_signal("start_game")
