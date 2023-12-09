extends CharacterBody2D

# Set a gravity variable to work with Gravity scene
var gravity = Vector2()

func _physics_process(delta):
	move_and_slide()
	
# Handle velocity from gravity
func handle_gravity_velocity(delta):
	velocity += gravity * delta

# Handle rotation to gravity	
func handle_gravity_rotation():
	var target_rotation = gravity.angle() - deg_to_rad(90) # Offset by 90 degrees to align with bottom side
	rotation += target_rotation

	##### Method 2: use of acos + dot product
	#var down_vec = Vector2.DOWN
	#var new_down_vec = gravity.normalized()
	#var rot_angle = acos(down_vec.dot(new_down_vec))
	#var sign = 1 if down_vec.cross(new_down_vec) > 0 else -1
	#rotation = sign * rot_angle

func reset_physics():
	velocity = Vector2()
	rotation = 0
