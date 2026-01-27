extends State
class_name PlayerIdle

@export var animator: AnimatedSprite2D
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	handle_animation(player.last_dir)
	
func Update(_delta):
	if (Input.get_vector("left","right","up", "down")):
		state_transition.emit(self, "Moving")

func handle_animation(last_dir):
	animator.play("idle_" + last_dir)
