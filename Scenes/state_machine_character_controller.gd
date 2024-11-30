extends CharacterBody3D
class_name PlayerController

@export var crouchFollowCamPos: Node3D
@export var standingFollowCamPos: Node3D
@export var mainCollider: CollisionShape3D
@export var crouchCollider: CollisionShape3D
@export var cam: PlayerCamera
@export var activeCheckpoint: Checkpoint
@export var acquiredKeys: Array

@onready var footsteps = $AudioStreamPlayer3D

var input_dir
var direction

@onready var c: bool = false

@onready var lerpCam : bool = false
var _rotationLerpAmount = 0

func _physics_process(delta):
	
	if lerpCam:
		cam.rotation_degrees.z = lerpf(cam.rotation_degrees.z, _rotationLerpAmount, 5 * delta)
		cam.rotation_degrees.x = lerpf(cam.rotation_degrees.x, _rotationLerpAmount / 2, 5 * delta)
	elif !lerpCam:
		cam.rotation_degrees.z = lerpf(cam.rotation_degrees.z, _rotationLerpAmount, 5 * delta)
		cam.rotation_degrees.x = lerpf(cam.rotation_degrees.x, _rotationLerpAmount, 5 * delta)
	
	input_dir = Input.get_vector("left", "right", "forward", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
	
func addKey(keyResource: KeyResource):
	acquiredKeys.append(keyResource)

func swapCamState(rotationLerpAmount, b):
	c = !c
	_rotationLerpAmount = rotationLerpAmount
	if c:
		cam.updateFollowPos(crouchFollowCamPos, b)
		mainCollider.disabled = true
		crouchCollider.disabled = false
		lerpCam = true
	elif !c:
		cam.updateFollowPos(standingFollowCamPos, b)
		mainCollider.disabled = false
		crouchCollider.disabled = true
		lerpCam = false

func die():
	$StateMachine.on_child_transitioned($StateMachine.currentState, "Idle")
	$StateMachine.enabled = false
