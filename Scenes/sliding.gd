extends State
@export var slideTime: float = 2
@onready var body = $"../.."
@export var slideSpeed = 2
@onready var timer = $Timer
var slideDir

func enter():
	timer.paused = false
	timer.start()
	slideDir = body.direction.z
	body.swapCamState(20, true)
	$"../../AudioStreamPlayer3D".stream = load("res://SFX/sliding-sound-103631.mp3")
	$"../../AudioStreamPlayer3D".playing = true
	$"../../AudioStreamPlayer3D".pitch_scale = 1
	pass
	
func exit():
	body.swapCamState(0, true)
	$"../../AudioStreamPlayer3D".playing = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta):
	pass
	
func Physics_Update(delta):
	
	if body.get_floor_normal().dot(body.transform.basis.z) < -0.5:
		timer.paused = true
	elif body.get_floor_normal().dot(body.transform.basis.z) > 0.5:
		timer.stop()
	elif body.get_floor_normal().dot(body.transform.basis.z) == 0:
		timer.paused = false
	
	if Input.is_action_just_pressed("ui_accept"):
		Transitioned.emit(self, "Jumping")
		timer.paused = true
	
	print(timer.time_left)
	body.velocity.z += slideDir * slideSpeed * delta
	body.velocity.y = body.get_gravity().y
	if timer.is_stopped():
		Transitioned.emit(self, "crouching")
