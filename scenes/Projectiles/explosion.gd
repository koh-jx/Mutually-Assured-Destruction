extends AnimatedSprite2D

var SFXplayer = preload("res://scenes/UI/sfx_player.tscn")

func _ready():
	var sfx = SFXplayer.instantiate()
	sfx.play_sfx("explosion")
	get_parent().add_child(sfx)
	

func _on_timer_timeout():
	queue_free()
