extends RigidBody2D

var gravity_force = Vector2()

# Handle effect of gravity on RigidBody
func _integrate_forces(state):
	var delta = state.get_step()
	state.apply_force(gravity_force * delta)

func _handle_rotation(state):
	# TODO
	pass

# EXAMPLE
# ------------
#var thrust = Vector2(0, -250)
#var torque = 20000
#
#func _integrate_forces(state):
	#if Input.is_action_pressed("ui_up"):
		#state.apply_force(thrust.rotated(rotation))
	#else:
		#state.apply_force(Vector2())
	#var rotation_direction = 0
	#if Input.is_action_pressed("ui_right"):
		#rotation_direction += 1
	#if Input.is_action_pressed("ui_left"):
		#rotation_direction -= 1
	#state.apply_torque(rotation_direction * torque)
