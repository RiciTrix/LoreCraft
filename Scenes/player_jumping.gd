extends State
@export var jump_velocity: float
@export var air_speed: float
@export var air_acceleration: float

@onready var body = $"../.."

@onready var jumpStarted: bool = false

func enter():
	jumpStarted = true

func exit():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta):
	pass
	
func Physics_Update(delta):
	if jumpStarted:
		body.velocity.y = jump_velocity
		jumpStarted = false
	else: 
		if body.is_on_floor():
			Transitioned.emit(self, "idle")
		else:
			body.velocity += body.direction * air_speed * air_acceleration * delta
			if body.direction:
				body.velocity.x = clampf(body.velocity.x, -air_speed * abs(body.direction.x), air_speed * abs(body.direction.x))
				body.velocity.z = clampf(body.velocity.z, -air_speed * abs(body.direction.z), air_speed * abs(body.direction.z))
	pass
