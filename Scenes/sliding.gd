extends State
@export var slideTime: float = 2
@onready var body = $"../.."
@export var slideSpeed: float = 2
@onready var timer = $Timer
@export var toggle: bool = false
@export var upwardRay: RayCast3D
var slideDir

func enter():
	timer.wait_time = slideTime
	timer.paused = false
	timer.start()
	slideDir = body.direction
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
	
	if body.get_floor_normal().dot(body.transform.basis.z) < 0:
		timer.paused = true
	elif body.get_floor_normal().dot(body.transform.basis.z) > 0.1:
		timer.stop()
	elif body.get_floor_normal().dot(body.transform.basis.z) == 0:
		timer.paused = false
	
	if Input.is_action_just_pressed("ui_accept"):
		Transitioned.emit(self, "Jumping")
		timer.paused = true
	
	if !Input.is_action_pressed("crouch") && !toggle:
		if upwardRay.is_colliding():
			Transitioned.emit(self, "Crouching")
		else:
			Transitioned.emit(self, "Walking")
	
	print(timer.time_left)
	body.velocity += slideDir * slideSpeed * delta
	body.velocity.y += body.get_gravity().y * delta
	if timer.is_stopped():
		Transitioned.emit(self, "crouching")
