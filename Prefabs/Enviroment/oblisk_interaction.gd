extends Node3D
class_name ObliskInteraction

@export var requiredKey: KeyResource:
	set(v):
		requiredKey = v
		$MeshInstance3D.mesh = v.mesh
		
@export var whatToActivate: Array[Trap] = []
		
var unlocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if unlocked:
		$MeshInstance3D.visible = true
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact(player: PlayerController):
	
	if unlocked:
		return
		
	if player.hasKey(requiredKey):
		unlocked = true
		$MeshInstance3D.visible = true
		
		for trap in whatToActivate:
			if !trap.is_active():
				trap.activate()

func toggleUI(visible: bool):
	
	if unlocked:
		$"../CanvasLayer".visible = false
		return
	
	$"../CanvasLayer".visible = visible
