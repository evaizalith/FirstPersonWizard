extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var camera
var rotationHelper

var mouseSensitivity = 0.01

func _ready():
	camera = $"rotationHelper/Camera"
	rotationHelper = $"rotationHelper"
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var inputDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var moveDirection = Vector3(transform.basis * Vector3(inputDirection.x, 0, inputDirection.y)).normalized()
	var direction = Vector3()
	var camBasis = camera.get_global_transform()
	
	direction += camBasis.basis.z * moveDirection.z
	direction += camBasis.basis.x * moveDirection.x
	
	# Jumping and Gravity	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	else: 
		velocity.y -= gravity * delta
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotationHelper.rotate_y(-event.relative.x * mouseSensitivity)
		camera.rotate_x(-event.relative.y * mouseSensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -deg_to_rad(70), deg_to_rad(70))
		
