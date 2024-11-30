extends GPUParticles3D
var area: Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_child(0)
	area.connect("body_entered", onHit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	area.monitoring = emitting
	
func onHit(body):
	if body is PlayerController:
		body.die()
