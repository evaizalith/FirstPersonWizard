extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = $"../../Player"
	
func _physics_process(delta):
	
	if player:
		velocity = global_position.direction_to(player.global_position)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
