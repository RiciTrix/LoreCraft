extends CharacterBody3D

@export var walkSpeed : float
@export var sprintSpeed : float
@export var acceleration : float

var SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var sprinting : bool = false


func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("sprint") and is_on_floor():
		SPEED = sprintSpeed
		sprinting = true
	elif is_on_floor():
		SPEED = walkSpeed
		sprinting = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x += SPEED * direction.x * acceleration
			velocity.z += SPEED * direction.z * acceleration
		if direction.x == 0:
			velocity.x = move_toward(velocity.x, 0, acceleration)
		if direction.z == 0:
			velocity.z = move_toward(velocity.z, 0, acceleration)
			
	elif not is_on_floor():
		velocity += get_gravity() * delta
		if direction:
			velocity.x += (SPEED / 2) * direction.x
			velocity.z += (SPEED / 2) * direction.z
	
	if direction:
		velocity.x = clampf(velocity.x, -SPEED * abs(direction.x), SPEED * abs(direction.x))
		velocity.z = clampf(velocity.z, -SPEED * abs(direction.z), SPEED * abs(direction.z))
	print(velocity)
	
	move_and_slide()
