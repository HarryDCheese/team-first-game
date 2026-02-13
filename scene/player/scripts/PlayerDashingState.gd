extends State
class_name PlayerDashing

@export var DASH_SPEED := 400
@export var DASH_TIME := 0.15
@export var DASH_COOLDOWN := 0.4

var dash_timer
var cooldown_timer

var input_dir
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	dash_timer = DASH_TIME
	cooldown_timer = DASH_COOLDOWN
	
func Update(delta):
	dash_timer -= delta
	cooldown_timer -= delta
	
	handle_input()
	handle_dashing()
	handle_transition("Idle")

func handle_dashing():
	player.velocity = input_dir * DASH_SPEED
	player.move_and_slide()

func handle_input():
	input_dir = Input.get_vector("move_left","move_right","move_up", "move_down")

func handle_transition(new_state: String):
	if dash_timer <= 0:
		state_transition.emit(self, new_state)
