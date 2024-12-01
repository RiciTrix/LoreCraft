extends PillarGroup

var mainMenu = "res://Scenes/main_menu.tscn"
var playSpace

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ResourceLoader.load_threaded_get_status(mainMenu) == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		playSpace = ResourceLoader.load_threaded_get(mainMenu)
		var v = playSpace.instantiate()
		get_node("/root").add_child(v)
		get_parent().get_parent().queue_free()

func onPillarInteracted(pillar: Pillar, player):
	super.onPillarInteracted(pillar, player)
	
	pillar.rotatePillar(1)
			
	if isPasswordCorrect():
		ResourceLoader.load_threaded_request(mainMenu)
		player.die()
		print('Victory!')
