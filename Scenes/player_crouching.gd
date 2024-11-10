extends State

@export var speed: float = 10
@export var acceleration: float = 2
@onready var body = $"../.."
@onready var r: bool = false

func enter():
	body.swapCamState(0, true)
	r = true
	
func exit():
	r = false
	body.swapCamState(0, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta):
	pass
	
func Physics_Update(delta):
	
	body.velocity.x += body.direction.x * speed * acceleration * delta
	body.velocity.z += body.direction.z * speed * acceleration * delta
	
	if Input.is_action_pressed("ui_accept"):
		Transitioned.emit(self, "Jumping")
		
	if Input.is_action_just_pressed("crouch"):
		if r:
			Transitioned.emit(self, "Idle")

	
	if body.direction:
		body.velocity.x = clampf(body.velocity.x, -speed * abs(body.direction.x), speed * abs(body.direction.x))
		body.velocity.z = clampf(body.velocity.z, -speed * abs(body.direction.z), speed * abs(body.direction.z))
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, 6 * delta)
		body.velocity.z = move_toward(body.velocity.z, 0, 6 * delta)
