extends Area3D

@export var speed = 10
@export var attackDamage = 10 

var player
var launchAngle = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../../Player/CharacterBody3D"
	var rotationHelper =  $"../../Player/CharacterBody3D/rotationHelper"
	var playerCamera =  $"../../Player/CharacterBody3D/rotationHelper/Camera"
	#launchAngle += playerCamera.get_global_transform().basis.x
	#launchAngle += rotationHelper.get_global_transform().basis.y
	launchAngle = playerCamera.get_global_transform().basis.z * -1
	#launchAngle.normalized()
	global_position = player.transform.origin
	global_position.y += 1.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += launchAngle * speed * delta
	
func _on_body_entered(body):
	if body.is_in_group("damageable"):
		#body.damage(damage)
		body.damage(attackDamage)
		queue_free()
