extends Trap
@onready var blade = $Sawblade2
@export var bladeSpeed = 10
@export var spinSpeed = 30
var num = 0
@export var distance: Vector2
@export var delay: float

func activate():
	await get_tree().create_timer(delay).timeout
	super.activate()
	

func doTrapThings(delta):
	num += delta
	blade.rotate_z(delta * spinSpeed)
	var travel = distance.x * sin(num * bladeSpeed)
	blade.position.x = travel

func _on_blade_entered(body):
	if	body is PlayerController:
		body.die()
