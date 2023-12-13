extends Control

@export var label_colour = Color();

@onready var health = 5
@onready var healthHearts = [
	$Heart1,
	$Heart2,
	$Heart3,
	$Heart4,
	$Heart5
]

func _ready():
	$Label.modulate = label_colour
	
func reset():
	health = 5
	for heart in healthHearts:
		heart.set_animation("default")

func damaged(damage):
	if health < 0:
		return
		
	# Play animations
	for i in range(damage):
		if health - damage < 0:
			continue
		var heart: AnimatedSprite2D = healthHearts[health - damage]
		heart.stop()
		heart.connect("finished", func(): _lose_heart(heart))
		heart.play("damaged")
	health -= damage

func _lose_heart(heart: AnimatedSprite2D):
	heart.set_animation("lost")
	heart.set_loop(true)
	heart.play()

