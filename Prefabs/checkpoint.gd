extends Node3D
class_name Checkpoint
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggleUI(b : bool):
	$CanvasLayer.visible = b

func interact(player: PlayerController):
	if player.activeCheckpoint == self:
		return
	
	if player.activeCheckpoint:
		player.activeCheckpoint.deactivate(player)
	
	player.activeCheckpoint = self
	self.anim.play("activate")
	$AudioStreamPlayer3D.play(4.53)

func deactivate(node):
	node.activeCheckpoint.anim.play_backwards("activate")
