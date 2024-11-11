extends State
@export var jump_velocity: float
@export var air_speed: float
@export var air_acceleration: float

@onready var body = $"../.."

@onready var jumpStarted: bool = false

func enter():
	jumpStarted = true
	$"../../AudioStreamPlayer3D".stream = load("res://SFX/jump-landing-30946.mp3")
	$"../../AudioStreamPlayer3D".playing = true
	$"../../AudioStreamPlayer3D".seek(0.6)
	$"../../AudioStreamPlayer3D".pitch_scale = 1

func exit():
	$"../../AudioStreamPlayer3D".playing = false
	if body.velocity.z > air_speed / 2.0:
		body.velocity.x = move_toward(body.velocity.x, 0, 2.5)
		body.velocity.z = move_toward(body.velocity.z, 0, 2.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta):
	pass
	
func Physics_Update(delta):
	if jumpStarted:
		body.velocity.y = jump_velocity
		body.swapCamState(0, false)
		body.swapCamState(0, false)
		jumpStarted = false
		
	else: 
		if body.is_on_floor():
			if Input.is_action_pressed("sprint"):
				if Input.is_action_pressed("crouch"):
					Transitioned.emit(self, "Sliding")
				else:
					Transitioned.emit(self, "Sprinting")
			else:
				Transitioned.emit(self, "idle")
		else:
			body.velocity += body.direction * air_acceleration * delta
			#body.velocity.x = clampf(body.velocity.x, -air_speed * abs(body.direction.x), air_speed * abs(body.direction.x))
			#body.velocity.z = clampf(body.velocity.z, -air_speed * abs(body.direction.z), air_speed * abs(body.direction.z))
	pass
