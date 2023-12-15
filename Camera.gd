extends Camera2D

var location = 0.0
var startPlaying = false
var endPlaying = false

signal finishedPanning;

func _process(delta):
	if startPlaying:
		location += 2 * delta
		position.y = lerp(1030, 322, location)
		
		if location >= 1:
			location = 1
			position.y = 322
			startPlaying = false
			emit_signal("finishedPanning")
			
	if endPlaying:
		location -= 2 * delta
		position.y = lerp(1030, 322, location)
		
		if location <= 0:
			location = 0
			position.y = 1030
			endPlaying = false


func _on_main_menu_start_game():
	startPlaying = true

func _on_ingame_gui_return_to_menu():
	endPlaying = true
