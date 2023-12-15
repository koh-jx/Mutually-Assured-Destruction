extends ColorRect

var SFXplayer = preload("res://scenes/UI/sfx_player.tscn")

var is_player_one = true

var w = InputEventKey.new()
var a = InputEventKey.new()
var s = InputEventKey.new()
var d = InputEventKey.new()
var f = InputEventKey.new()

var i = InputEventKey.new()
var j = InputEventKey.new()
var k = InputEventKey.new()
var l = InputEventKey.new()
var semicolon = InputEventKey.new()

func _ready():
	w.physical_keycode = KEY_W
	a.physical_keycode = KEY_A
	s.physical_keycode = KEY_S
	d.physical_keycode = KEY_D
	f.physical_keycode = KEY_F
	i.physical_keycode = KEY_I
	j.physical_keycode = KEY_J
	k.physical_keycode = KEY_K
	l.physical_keycode = KEY_L
	semicolon.physical_keycode = KEY_SEMICOLON

func _on_button_pressed():
	var sfx = SFXplayer.instantiate()
	sfx.play_sfx("button")
	get_parent().add_child(sfx)
	
	is_player_one = !is_player_one
	$player_1_keys.visible = is_player_one
	$player_2_keys.visible = !is_player_one
	
	$"Player2/player_1_keys".visible = !is_player_one
	$"Player2/player_2_keys".visible = is_player_one
	
	_reset_inputs()
	_add_player_one_inputs()
	_add_player_two_inputs()

func _add_player_one_inputs():
	InputMap.action_add_event("player_1_up", w if is_player_one else i)
	InputMap.action_add_event("player_1_left", a if is_player_one else j)
	InputMap.action_add_event("player_1_right", d if is_player_one else l)
	InputMap.action_add_event("player_1_down", s if is_player_one else k)
	InputMap.action_add_event("player_1_shoot", f if is_player_one else semicolon)

func _add_player_two_inputs():
	InputMap.action_add_event("player_2_up", w if !is_player_one else i)
	InputMap.action_add_event("player_2_left", a if !is_player_one else j)
	InputMap.action_add_event("player_2_right", d if !is_player_one else l)
	InputMap.action_add_event("player_2_down", s if !is_player_one else k)
	InputMap.action_add_event("player_2_shoot", f if !is_player_one else semicolon)

func _reset_inputs():
	InputMap.action_erase_events("player_1_up")
	InputMap.action_erase_events("player_1_left")
	InputMap.action_erase_events("player_1_right")
	InputMap.action_erase_events("player_1_down")
	InputMap.action_erase_events("player_1_shoot")
	InputMap.action_erase_events("player_2_up")
	InputMap.action_erase_events("player_2_left")
	InputMap.action_erase_events("player_2_right")
	InputMap.action_erase_events("player_2_down")
	InputMap.action_erase_events("player_2_shoot")
