extends Area2D

const Entity = preload("res://scenes/entity/entity.gd")
const Projectile = preload("res://scenes/Projectiles/projectile.gd")
var GRAVITY = 9810000
var body_list = []
var area_list = []

func _on_body_entered(body):
	body_list.append(body)

func _on_body_exited(body):
	body_list.remove_at(body_list.find(body))
	
func _on_area_entered(area):
	area_list.append(area)

func _on_area_exited(area):
	area_list.remove_at(area_list.find(area))

	
# Updates the pull force magnitude and direction in all Entities in the area.
func _physics_process(delta):	
	for body in body_list:
		var entity := body as Entity
		if entity:
			_affect_entity(entity)
	for area in area_list:
		var projectile := area.get_parent() as Projectile
		if projectile:
			_affect_projectile(projectile)
		
			
func calculate_pull_force(body):
	var pos_diff = global_position - body.global_position
	var dist = global_position.distance_to(body.global_position)
	return pos_diff.normalized() / dist * GRAVITY

func _affect_entity(entity):
	entity.gravity = calculate_pull_force(entity)

func _affect_projectile(projectile):
	projectile.gravity_force = calculate_pull_force(projectile)


