extends CharacterBody3D

var input_dir
var direction

func _physics_process(delta):
	
	input_dir = Input.get_vector("left", "right", "forward", "down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if !is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
