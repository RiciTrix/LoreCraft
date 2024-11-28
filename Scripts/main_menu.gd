extends Node3D
var level = "res://Scenes/Oblisk Room.tscn"
var playSpace
var startLoad: bool = false
var anim: AnimationPlayer

func _ready():
	anim = $AnimationPlayer


func onPlayGame():
	ResourceLoader.load_threaded_request(level)
	$CanvasLayer/Control/Button.visible = false
	anim.play("moveCam")
	
func _process(delta):
	if !anim.is_playing():
		if ResourceLoader.load_threaded_get_status(level) == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			playSpace = ResourceLoader.load_threaded_get(level)
			var v = playSpace.instantiate()
			get_node("..").add_child(v)
			self.queue_free()		
