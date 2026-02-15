extends CharacterBase
class_name PlayerMain

var input_dir
	
func handle_input():
	input_dir = Input.get_vector("move_left","move_right","move_up", "move_down")
