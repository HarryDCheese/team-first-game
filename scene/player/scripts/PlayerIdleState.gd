extends State
class_name PlayerIdle

@export var animator: AnimatedSprite2D
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Update(_delta):
	if (Input.get_vector("move_left","move_right","move_up", "move_down")):
		state_transition.emit(self, "Moving")
		
	handle_animation(player.last_dir)

func handle_animation(last_dir):
	animator.play("idle_" + last_dir)
