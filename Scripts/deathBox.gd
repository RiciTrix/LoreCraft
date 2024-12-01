extends Trap
class_name DeathBox
@export var enabled = true
var body1

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", onAreaEntered)


func onAreaEntered(body):
	
	if body is PlayerController:
		body1 = body
	
	if !enabled:
		return
		
	if body is PlayerController:
		print("dead")
		body.die()
		
func activate():
	enabled = !enabled
	if body1:
		body1.die()
	print(enabled)
