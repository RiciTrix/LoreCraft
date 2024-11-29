extends Camera3D
class_name PlayerCamera

@export_group("Setup")
@export var rootNode: CharacterBody3D
@export var mainNode: Node3D
@export var pivotPoint: Node3D
var followPos

@onready var ray = $RayCast3D

@export_group("Settings")
@export var sensitivity: float
var _enableLerp: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	followPos = rootNode.get_child(0)

func updateFollowPos(node : Node3D, enableLerp: bool):
	followPos = node
	_enableLerp = enableLerp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		mainNode.position.x = followPos.global_position.x
		mainNode.position.z = followPos.global_position.z
		
		if ray.is_colliding() and ray.get_collider().is_in_group('interactable'):
			
			if Input.is_action_just_pressed("interact"):
				
				var rayCollider = ray.get_collider()
				
				if rayCollider:
					var parent = rayCollider.get_parent()
					
					if parent.is_in_group("checkpoint") or parent.is_in_group("key"):
						parent.interact(rootNode)
					else:
						parent.interact()
		
		if _enableLerp:
			mainNode.position.y = lerp(mainNode.position.y, followPos.global_position.y, 15 * delta)
		else: 
			mainNode.position.y = followPos.global_position.y 
		if Input.is_action_just_pressed("esc"):
			if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _input(event):
	if event is InputEventMouseMotion:
		rootNode.rotation.y += deg_to_rad(event.relative.x) * -sensitivity
		mainNode.rotation.y = rootNode.rotation.y
		var xRotation = mainNode.rotation.x + deg_to_rad(event.relative.y) * -sensitivity
		xRotation = clamp(xRotation, deg_to_rad(-90), deg_to_rad(90))
		mainNode.rotation.x = xRotation
