extends Node3D
class_name Key

@export var keyResource: KeyResource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh = keyResource.mesh
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interact(player):
	player.addKey(self.keyResource)
	print(keyResource.name + ' key acquired!')
	queue_free()
