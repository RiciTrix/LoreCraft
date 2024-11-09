extends State
class_name player_idle

@onready var body = $"../.."
@export var slow_speed: float = 10

func enter():
	pass
	
func exit():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Update(delta):
	pass
	
func Physics_Update(delta):
	
	if Input.is_action_pressed("ui_accept"):
		Transitioned.emit(self, "Jumping")
	
	if body.is_on_floor():
		body.velocity.x = move_toward(body.velocity.x, 0, slow_speed * delta)
		body.velocity.z = move_toward(body.velocity.z, 0, slow_speed * delta)
		
	if body.input_dir:
		Transitioned.emit(self, "Walking")
