extends AudioStreamPlayer2D

const explosion = preload("res://assets/music/medium-explosion-40472.mp3")
const death     = preload("res://assets/music/explosion_01-6225.mp3")
const button    = preload("res://assets/music/button-124476.mp3")

func play_sfx(string: StringName, start_time = 0.0):
	match string:
		"explosion":
			set_stream(explosion)
			set_volume_db(-10.0)
		"death":
			set_stream(death)
			set_volume_db(-10.0)
		"button":
			set_stream(button)
			set_volume_db(-10.0)
		_:
			push_error("Sound effect not recognized:", string)
			return
	
	play(start_time)

func _on_finished():
	queue_free()
