extends Timer
@onready var isActivated: bool = false

func activate():
	var parent = get_parent()
	
	if parent is Trap:
		if !parent.is_active(): 
			parent.activate()
			parent.trapType = Trap.Types.AlwaysOn

func _ready():
	self.connect("timeout",activate)
