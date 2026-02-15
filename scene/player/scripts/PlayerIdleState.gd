extends State
class_name PlayerIdle

func Enter():
	return 
		
func Update(_delta):	
	handle_transition("Moving")	
	handle_animation()

func handle_transition(new_state: String):
	if (Input.get_vector("move_left","move_right","move_up", "move_down")):
		state_transition.emit(self, new_state)
	
func handle_animation():
	actor.animator.play_idle(actor.last_dir)
