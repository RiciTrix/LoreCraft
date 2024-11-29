extends Trap
var stuff: Array[RigidBody3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is RigidBody3D:
			stuff.append(child)
			child.freeze = true


func activate():
	for c in stuff:
		c.freeze = false
		c.add_constant_force(Vector3(randi_range(-1, 1), randi_range(-1, 0), randi_range(-1, 1)) * 3)
	await get_tree().create_timer(3).timeout
	self.queue_free()
