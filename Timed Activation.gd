extends Timer
@onready var isActivated: bool = false

func activate():
	var parent = get_parent()
	
	if parent is Trap: 
		parent.activate()
		parent.trapType = Trap.Types.AlwaysOn

func _ready():
	self.connect("timeout",activate)
