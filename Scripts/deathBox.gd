extends Trap
class_name DeathBox
@export var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", onAreaEntered)


func onAreaEntered(body):
	if !enabled:
		return
		
	if body is PlayerController:
		print("dead")
		body.die()
		
func activate():
	enabled = !enabled
	print(enabled)
