extends State
class_name PlayerMoving

@export var MOVE_SPEED:= 50

var input_dir
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Update(_delta):
	handle_input()
	handle_direction()
	handle_animation()
	handle_movement()
	handle_transition("Idle")

func handle_movement():
	player.velocity = input_dir * MOVE_SPEED
	player.move_and_slide()
	
func handle_direction():
	if abs(input_dir.x) > abs(input_dir.y):
		player.last_dir = "side"
		player.animator.animation.flip_h = input_dir.x < 0
	else:
		if input_dir.y > 0:
			player.last_dir = "down"
		elif input_dir.y < 0:
			player.last_dir = "up"
		
func handle_input():
	input_dir = Input.get_vector("move_left","move_right","move_up", "move_down")
	
func handle_transition(new_state: String):
	if input_dir == Vector2.ZERO:
		state_transition.emit(self, new_state)

func handle_animation():
	player.animator.play_moving(player.last_dir)
