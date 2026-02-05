extends State
class_name PlayerIdle

@export var animator: HandleAnimation
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Update(_delta):
	if (Input.get_vector("move_left","move_right","move_up", "move_down")):
		handle_transition("Moving")
	
	handle_animation()

func handle_transition(new_state: String):
	state_transition.emit(self, new_state)
	
func handle_animation():
	animator.play_idle(player.last_dir)
