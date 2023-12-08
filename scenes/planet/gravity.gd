extends Area2D

const Entity = preload("res://scenes/entity/entity.gd")
var GRAVITY = 9810
var body_list = []

func _on_body_entered(body):
	body_list.append(body)

func _on_body_exited(body):
	body_list.remove_at(body_list.find(body))
	
func _physics_process(delta):
	print(len(body_list))
	
	for body in body_list:
		var entity := body as Entity
		
		if not entity:
			return
			
		entity.velocity = Vector2()
		
		var pos_diff = global_position - entity.global_position
		pos_diff = Vector2(snapped(pos_diff.x, 100), snapped(pos_diff.y, 100))
		
		#var distance_between = global_position.distance_to(entity.global_position)
		var pull_force = pos_diff.normalized() * GRAVITY
		entity.velocity = pull_force * delta
	
		# TODO change rotation of parent of area object such that vector is pointing downwards



