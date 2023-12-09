extends CharacterBody2D

# Set a gravity variable to work with Gravity scene
var gravity = Vector2()

func _ready():
	set_floor_max_angle(deg_to_rad(360))

func _physics_process(delta):
	if not is_on_floor():
		velocity = gravity * delta
	print(move_and_slide())

# Handle velocity from gravity
func handle_gravity_velocity(delta):
	velocity += gravity * delta

# Handle rotation to gravity
func handle_gravity_rotation():
	var target_rotation = gravity.angle() - deg_to_rad(90)
	rotation += target_rotation

func reset_physics():
	velocity = Vector2()
	rotation = 0
