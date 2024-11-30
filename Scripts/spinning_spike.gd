extends Trap
@export var spin_speed: float

@export var spin_direction: Vector3i

@onready var spike = $"Spinning Spike"

func doTrapThings(delta):
	spike.rotation += spin_speed * delta * spin_direction


func _on_area_3d_body_entered(body):
	if body is PlayerController:
		body.die()
