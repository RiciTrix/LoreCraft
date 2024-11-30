extends Trap

enum spinModes{
	None,
	Constant,
	Intervals
}

enum directionChange{
	none,
	x,
	z,
	X_to_Z,
}

enum swapMode{
	None,
	OnInterval,
	Timed
}

@onready var spinArea = $"Flame Thrower Pillar2/Flame Thrower"

@export_group("Spin Settings")
@export var spinMode: spinModes
@export var spinSpeed: float
@export var spinInterval: float
@export var timeBetweenIntervals: float

@export_category("Thrower Polarity Swap")
@export var mode: swapMode
@export var swapPolarity: directionChange

@export_category("Active Throwers")
@export var positiveX: bool
@export var negativeX: bool
@export var positiveZ: bool
@export var negativeZ: bool


@onready var posXT = $"Flame Thrower Pillar2/Flame Thrower/Cylinder/GPUParticles3D"
@onready var negXT = $"Flame Thrower Pillar2/Flame Thrower/Cylinder/GPUParticles3D2"
@onready var posZT = $"Flame Thrower Pillar2/Flame Thrower/Cylinder/GPUParticles3D4"
@onready var negZT = $"Flame Thrower Pillar2/Flame Thrower/Cylinder/GPUParticles3D3"


func activate():
	super.activate()
	if spinMode == spinModes.Intervals:
		$Timer.wait_time = timeBetweenIntervals
		$Timer.connect("timeout", rotateInterval)
		resetTimer()

	$AudioStreamPlayer3D.play()
	posXT.emitting = positiveX
	negXT.emitting = negativeX
	posZT.emitting = positiveZ
	negZT.emitting = negativeZ
	
func deactivate():
	super.deactivate()
	
var tween
var originalRotation

func rotateInterval():
	tween = get_tree().create_tween()
	tween.tween_property(spinArea, "rotation", originalRotation + Vector3.UP * deg_to_rad(spinInterval), spinSpeed)
	tween.connect("finished", resetTimer)
	if mode == swapMode.OnInterval:
		doPolaritySwap()

func doPolaritySwap():
	match swapPolarity:
		directionChange.x:
			if posXT.emitting:
				posXT.emitting = false
				negXT.emitting = true
			elif negXT.emitting:
				posXT.emitting = true
				negXT.emitting = false

		directionChange.z:
			if posZT.emitting:
				posZT.emitting = false
				negZT.emitting = true
			elif negZT.emitting:
				posZT.emitting = true
				negZT.emitting = false

		directionChange.X_to_Z:
			if posZT.emitting || negZT.emitting:
				if negZT.emitting:
					negXT.emitting = true
					negZT.emitting = false
				if posZT.emitting:
					posXT.emitting = true
					posZT.emitting= false
			elif posXT.emitting || negXT.emitting:
				if posXT.emitting:
					posXT.emitting = false
					posZT.emitting = true
				if negXT.emitting:
					negXT.emitting = false
					negZT.emitting = true

func resetTimer():
	$Timer.start()
	if tween:
		tween.kill()
	originalRotation = spinArea.rotation
	
func doTrapThings(delta):
	match spinMode:
		spinModes.Constant:
			spinArea.rotation.y += spinSpeed * delta
