extends StaticBody2D

var planet1 = preload("res://assets/planets/planet_1.png")
var planet2 = preload("res://assets/planets/planet_2.png")
var planet3 = preload("res://assets/planets/planet_3.png")
var planet4 = preload("res://assets/planets/planet_4.png")
var planet5 = preload("res://assets/planets/planet_5.png")

var planet_list = [
	planet1, 
	planet2, 
	planet3, 
	planet4, 
	planet5
]

# Called when the node enters the scene tree for the first time.
func _ready():
	change_sprite()
	
func change_sprite():
	$PlanetSprite.texture = planet_list.pick_random()
