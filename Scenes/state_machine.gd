extends Node

var currentState: State
var states: Dictionary = {}

@export var initial_state: State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
	
	if initial_state:
		initial_state.enter()
		currentState = initial_state

func _process(delta):
	if currentState:
		currentState.Update(delta)
		
func _physics_process(delta):
	if currentState:
		currentState.Physics_Update(delta)
		
func on_child_transitioned(state, new_state_name):
	if state != currentState:
		return
	
	var new_state: State = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
	
	if currentState:
		currentState.exit()
	
	print(new_state.name)
	new_state.enter()
	currentState = new_state
