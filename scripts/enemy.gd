extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = $"../../Player/CharacterBody3D"
	
func _process(delta):
	var distToPlayer = global_position.distance_to(player.transform.origin)
	
	if distToPlayer > 2.5:
		var newVelocity = global_position.direction_to(player.transform.origin)
		velocity.x = newVelocity.x
		velocity.z = newVelocity.z
	else:
		velocity = Vector3(0,velocity.y,0)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
