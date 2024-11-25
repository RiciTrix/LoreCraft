extends Node3D
@export var whatToActivate: Array[Trap]
@export var disableAfterFirstActivation: bool

@onready var isActivated: bool = false

func activate():
	for trap in whatToActivate:
		if !trap.is_active():
			trap.activate()
	isActivated = !isActivated


func _on_area_3d_body_entered(body):
	if isActivated && disableAfterFirstActivation:
		return
	else:
		activate()
