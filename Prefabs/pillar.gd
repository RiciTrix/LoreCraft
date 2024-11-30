extends Node3D
class_name Pillar

var tween
var isAnimating = false

enum PillarFace {
	Triangle,
	Diamond,
	Circle,
	Cross
}

@export var passwordFace: PillarFace = PillarFace.Triangle
@export var currentFace = 0

var facesOrder = [
	PillarFace.Triangle,
	PillarFace.Diamond,
	PillarFace.Circle,
	PillarFace.Cross
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func getCurrentFace():
	return facesOrder[currentFace]
	
func isCorrectFace():
	return getCurrentFace() == passwordFace

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onRotationEnd():
	tween.kill()
	isAnimating = false
	
func toggleUI(visible: bool):
	$CanvasLayer.visible = visible

func rotatePillar(numberOfRotations):
	isAnimating = true
	tween = get_tree().create_tween()
	tween.connect("finished", onRotationEnd)
	tween.tween_property($"Pillar Puzzle Block", "rotation", $"Pillar Puzzle Block".rotation + Vector3(0, numberOfRotations * PI/2, 0), 1)
	currentFace = (currentFace + numberOfRotations) % len(facesOrder)

func interact():
	
	if isAnimating:
		return
	
	var parent = get_parent()
	
	if parent is PillarGroup: 
		parent.onPillarInteracted(self)
	else:
		rotatePillar(1)
