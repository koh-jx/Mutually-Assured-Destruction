extends Area2D

const Entity = preload("res://scenes/entity/entity.gd")
var GRAVITY = 9810000
var body_list = []

func _on_body_entered(body):
	body_list.append(body)

func _on_body_exited(body):
	body_list.remove_at(body_list.find(body))
	
# Updates the pull force magnitude and direction in all Entities in the area.
func _physics_process(delta):	
	for body in body_list:
		var entity := body as Entity
		if not entity:
			return
		
		var pos_diff = global_position - entity.global_position
		var dist = global_position.distance_to(entity.global_position)
		#pos_diff = Vector2(snapped(pos_diff.x, 0), snapped(pos_diff.y, 0))
		var pull_force = pos_diff.normalized() / dist * GRAVITY
		
		entity.gravity = pull_force
	
		# TODO change rotation of parent of area object such that vector is pointing downwards
		# Same with velocity, should keep a variable inside Entity that handles this
		# Should I do this entire rotation thing in gravity or entity?



