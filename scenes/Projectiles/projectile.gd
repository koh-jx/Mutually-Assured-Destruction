extends RigidBody2D

var Explosion = preload("res://scenes/Projectiles/explosion.tscn")
var gravity_force = Vector2()

# Handle effect of gravity on RigidBody
func _integrate_forces(state):
	var delta = state.get_step()
	state.apply_force(gravity_force * delta)
	_handle_gravity_rotation(state)

func _handle_gravity_rotation(state: PhysicsDirectBodyState2D):
	rotation = get_linear_velocity().angle() - deg_to_rad(90)

func on_destroy():
	var explosion = Explosion.instantiate()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	queue_free()
