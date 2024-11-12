extends Node
class_name Trap

enum Types{
	Activated,
	AlwaysOn,
	Static
}

enum process_modes{
	Physics,
	Normal
}

@export var trapType: Types
@export var processType: process_modes
var activated: bool

func activate():
	activated = true
	pass
	
func deactivate():
	activated = false
	pass

func _ready():
	if trapType == Types.AlwaysOn:
		activate()

func doTrapThings(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !activated:
		return
	if processType == process_modes.Physics:
		return
	doTrapThings(delta)

func _physics_process(delta):
	if !activated:
		return
	if processType == process_modes.Normal:
		return
	doTrapThings(delta)
