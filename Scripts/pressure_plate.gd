extends Node3D
@export var whatToActivate: Array[Trap]
@export var disableAfterFirstActivation: bool
@export var canActivate: bool = true

@onready var isActivated: bool = false

func activate():
	
	if not canActivate:
		return
		
	for trap in whatToActivate:
		if !trap.is_active():
			trap.activate()
	isActivated = !isActivated


func _on_area_3d_body_entered(body):
	if isActivated && disableAfterFirstActivation:
		return
	else:
		if body is PlayerController:
			activate()
