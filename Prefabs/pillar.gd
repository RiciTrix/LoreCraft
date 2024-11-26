extends Node3D
class_name Pillar

enum PillarFace {
	Triangle,
	Diamond,
	Circle,
	Cross
}

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rotatePillar(numberOfRotations):
	rotation.y += numberOfRotations * PI / 2
	currentFace = (currentFace + numberOfRotations) % len(facesOrder)

func interact():
	
	var parent = get_parent()
	
	if parent is PillarGroup: 
		parent.onPillarInteracted(self)
	else:
		rotatePillar(1)
