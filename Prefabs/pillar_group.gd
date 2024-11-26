extends Node3D
class_name PillarGroup

var pillars = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var children = get_children()
	
	for node in children:
		if node is Pillar:
			pillars.append(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onPillarInteracted(pillar: Pillar):
	pillar.rotatePillar(2)
	
	for otherPillar in pillars:
		if not otherPillar == pillar:
			otherPillar.rotatePillar(1)
