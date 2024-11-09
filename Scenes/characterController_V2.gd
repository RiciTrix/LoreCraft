extends CharacterBody3D
class_name player_controller
@export_group("Speed")
@export var walk_speed: float
@export var sprint_speed: float
@export var acceleration: float

@export_group("Collision")
@export var crouch_collider: CollisionShape3D
@export var standing_collider: CollisionShape3D

@export_group("Camera")
@export var cam: PlayerCamera
@export var standing_followPos: Node3D
@export var crouch_followPos: Node3D

enum player_states{
	walking,
	sprinting,
	sliding,
	crouching
}

@onready var currentState: player_states = player_states.walking

func _physics_process(delta):
	
	var input_vector = Input.get_vector("left", "right", "forward", "down")
	var direction = (transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
	
	
	
	match currentState:
		player_states.walking:
			pass
		player_states.sprinting:
			pass
		player_states.sliding:
			pass
		player_states.crouching:
			pass
	

func change_state(state: player_states):
	currentState = state
