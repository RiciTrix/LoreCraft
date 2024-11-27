extends PillarGroup

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onPillarInteracted(pillar: Pillar):
	super.onPillarInteracted(pillar)
	
	pillar.rotatePillar(2)
	
	for otherPillar in pillars:
		if not otherPillar == pillar:
			otherPillar.rotatePillar(1)
			
	if isPasswordCorrect():
		$"../Pressure Plate".canActivate = true
	else:
		$"../Pressure Plate".canActivate = false
