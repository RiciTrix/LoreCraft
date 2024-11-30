extends Trap
@onready var num = 0
@onready var blade = $"Swinging Axe2"
@export var bladeSpeed = 1
@export var distance: Vector2

func doTrapThings(delta):
	num += delta
	var travel = distance.x * sin(num * bladeSpeed)
	blade.rotation.z = travel


func _on_area_3d_body_entered(body):
	if body is PlayerController:
		body.die()
