extends Node3D
@export var whatToActivate: Array[Trap]

func activate():
	for trap in whatToActivate:
		if !trap.is_active():
			trap.activate()


func _on_area_3d_body_entered(body):
	activate()
