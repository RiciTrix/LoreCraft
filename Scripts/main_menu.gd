extends Node3D
var level = "res://Scenes/Oblisk Room.tscn"
var playSpace
var startLoad: bool = false
var anim: AnimationPlayer

func _ready():
	anim = $AnimationPlayer
	$CanvasLayer/VBoxContainer/HSlider.value = AudioServer.get_bus_volume_db(0)


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


func _on_value_changed(value, index):
	if value == -6:
		AudioServer.set_bus_mute(index, true) 
	else:
		AudioServer.set_bus_mute(index, false) 
		
	print(str(value) + ", " + str(index))
	
	AudioServer.set_bus_volume_db(index, value)
