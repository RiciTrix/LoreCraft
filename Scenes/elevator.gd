extends Trap
var tween

@export var distance: float
@export var direction: Vector3i
@export var duration: float
@export var enableReturn: bool

func activate():
	super.activate()
	tween = get_tree().create_tween()
	tween.tween_property(self, "position", self.position + (distance * direction), duration)
	tween.connect("finised", deactivate)
	
	
func deactivate():
	super.deactivate()
	if enableReturn:
		direction *= -1
	
func doTrapThings(delta):
	pass
