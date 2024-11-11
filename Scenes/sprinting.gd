extends State
@export var speed: float = 10
@export var acceleration: float = 2
@onready var body = $"../.."
@export var toggle: bool = true

func enter():
	$"../../AudioStreamPlayer3D".stream = load("res://SFX/concrete-footsteps-6752.mp3")
	$"../../AudioStreamPlayer3D".playing = true
	$"../../AudioStreamPlayer3D".pitch_scale = 2
	pass
	
func exit():
	$"../../AudioStreamPlayer3D".playing = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta):
	pass
	
func Physics_Update(delta):
	
	body.velocity.x += body.direction.x * speed * acceleration * delta
	body.velocity.z += body.direction.z * speed * acceleration * delta
	
	if Input.is_action_pressed("ui_accept"):
		Transitioned.emit(self, "Jumping")
	
	if Input.is_action_just_pressed("crouch"):
		Transitioned.emit(self, "Sliding")
		
	if !Input.is_action_pressed("sprint"):
		Transitioned.emit(self, "Walking")
	
	if body.direction:
		body.velocity.x = clampf(body.velocity.x, -speed * abs(body.direction.x), speed * abs(body.direction.x))
		body.velocity.z = clampf(body.velocity.z, -speed * abs(body.direction.z), speed * abs(body.direction.z))
	else:
		Transitioned.emit(self, "Idle")
