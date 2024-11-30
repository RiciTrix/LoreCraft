extends Node3D

@export var FirstSlotKey: KeyResource:
	set(v):
		FirstSlotKey = v
		$ObliskKeySlot.requiredKey = v

@export var SecondSlotKey: KeyResource:
	set(v):
		SecondSlotKey = v
		$ObliskKeySlot2.requiredKey = v
		
@export var ThirdSlotKey: KeyResource:
	set(v):
		ThirdSlotKey = v
		$ObliskKeySlot3.requiredKey = v

@export var FourthSlotKey: KeyResource:
	set(v):
		FourthSlotKey = v
		$ObliskKeySlot4.requiredKey = v

@export var WhatToActivateFirstSlot: Array[Trap]:
	set(v):
		WhatToActivateFirstSlot = v
		$ObliskKeySlot.whatToActivate = v

@export var WhatToActivateSecondSlot: Array[Trap]:
	set(v):
		WhatToActivateSecondSlot = v
		$ObliskKeySlot2.whatToActivate = v
		
@export var WhatToActivateThirdSlot: Array[Trap]:
	set(v):
		WhatToActivateThirdSlot = v
		$ObliskKeySlot3.whatToActivate = v
		
@export var WhatToActivateFourthSlot: Array[Trap]:
	set(v):
		WhatToActivateFourthSlot = v
		$ObliskKeySlot4.whatToActivate = v

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Oblisk Gem2/AnimationPlayer".play("Spin")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
