extends Camera3D

@export_group("Setup")
@export var rootNode: CharacterBody3D
@export var mainNode: Node3D
@export var pivotPoint: Node3D
var followPos

@export_group("Settings")
@export var sensitivity: float


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	followPos = rootNode.get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		mainNode.position = followPos.global_position
		if Input.is_action_just_pressed("esc"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event is InputEventMouseMotion:
		rootNode.rotation.y += deg_to_rad(event.relative.x) * -sensitivity
		mainNode.rotation.y = rootNode.rotation.y
		var xRotation = mainNode.rotation.x + deg_to_rad(event.relative.y) * -sensitivity
		xRotation = clamp(xRotation, deg_to_rad(-90), deg_to_rad(90))
		mainNode.rotation.x = xRotation
