extends Node
class_name FiniteStateMachine

#NOTE This is a generic finite_state_machine, it handles all states, changes to this code will affect

var states: Dictionary = {}
var current_state: State
@export var initial_state: State

func _ready() -> void:
	for child in get_children():
		states[child.name.to_lower()] = child
		child.state_transition.connect(change_state)
		
	if initial_state:
		initial_state.Enter()
		current_state = initial_state 
	
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
	
func change_state(source_state: State, new_state_name: String):
	if source_state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	current_state = new_state
		
