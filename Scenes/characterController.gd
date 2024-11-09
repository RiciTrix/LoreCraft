extends CharacterBody3D

@export var walkSpeed : float
@export var sprintSpeed : float
@export var acceleration : float
@export var main_collider: CollisionShape3D
@export var crouch_collider: CollisionShape3D
@export var cam : PlayerCamera


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
var slideDir

@onready var exitingSlide: bool = false
@onready var sprinting : bool = false
@onready var crouching: bool = false
@onready var sliding: bool = false
func stopSlide(resetVelocity: bool):
	main_collider.disabled = false
	crouch_collider.disabled = true
	cam.updateFollowPos($CameraFollow)
	sliding = false
	exitingSlide = true
	SPEED = walkSpeed
	if resetVelocity:
		velocity.x = move_toward(velocity.x, 0, acceleration)
		velocity.z = move_toward(velocity.z, 0, acceleration)
	await get_tree().create_timer(0.1, true, true, false).timeout
	exitingSlide = false

func _physics_process(delta):
	# Handle jump.
	
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if sliding && !exitingSlide:
			stopSlide(false)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if direction:
			velocity.x += (SPEED) * direction.x * acceleration * delta
			velocity.z += (SPEED) * direction.z * acceleration * delta
	
	if !sliding:	
		if Input.is_action_pressed("sprint") and is_on_floor() and not crouching:
			SPEED = sprintSpeed
			sprinting = true
		elif is_on_floor():
			SPEED = walkSpeed
			sprinting = false
		
		if Input.is_action_just_pressed("crouch") && is_on_floor():
			if sprinting:
				sliding = true
				slideDir = direction.z
			else:
				crouching = !crouching
				if crouching:
					main_collider.disabled = true
					crouch_collider.disabled = false
					cam.updateFollowPos($CameraFollowCrouch)
				else:
					main_collider.disabled = false
					crouch_collider.disabled = true
					cam.updateFollowPos($CameraFollow)
	
		if is_on_floor() and !exitingSlide:
			if direction:
				velocity.x += direction.x * acceleration
				velocity.z += direction.z * acceleration
			if direction.x == 0:
				velocity.x = move_toward(velocity.x, 0, acceleration * delta)
			if direction.z == 0:
				velocity.z = move_toward(velocity.z, 0, acceleration * delta)
	
	elif sliding:
		if Input.is_action_just_pressed("crouch"):
			if !exitingSlide:
				stopSlide(true)
		else: 
			main_collider.disabled = true
			crouch_collider.disabled = false
			cam.updateFollowPos($CameraFollowCrouch)
			SPEED = walkSpeed;
			velocity.z += (slideDir * SPEED * delta)
			await get_tree().create_timer(2, true, true, false).timeout
			if !exitingSlide and sliding:	
				stopSlide(true)

	if direction:
		velocity.x = clampf(velocity.x, -SPEED * abs(direction.x), SPEED * abs(direction.x))
		velocity.z = clampf(velocity.z, -SPEED * abs(direction.z), SPEED * abs(direction.z))
