extends Trap
@export var length: float
@export var activeTime: float
@export var activeTimer: Timer
@export var speed: float

@onready var spikes = $"Spike Trap Base/Spike Trap Spikes2"

var originalPos
var tween
func activate():
	super.activate()
	activeTimer.wait_time = activeTime
	originalPos = spikes.position
	tween = create_tween()
	tween.tween_property(spikes, "position", Vector3(0, originalPos.y + length, 0), speed)
	tween.connect("finished", deactivate)

var tween2
func deactivate():
	print("done")
	activeTimer.start()
	tween.kill()
	await activeTimer.timeout
	tween = get_tree().create_tween()
	super.deactivate()
	print("done 2")
	tween.tween_property(spikes, "position", Vector3(0, originalPos.y, 0), speed)
	if trapType == Types.AlwaysOn:
		print(0)
		tween.connect("finished", reset)

func reset():
	tween.kill()
	activeTimer.start()
	await activeTimer.timeout
	activate()

func doTrapThings(delta):
	pass
