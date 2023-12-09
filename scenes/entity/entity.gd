extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = Vector2()

func _physics_process(delta):
	velocity = gravity * delta
	move_and_slide()
