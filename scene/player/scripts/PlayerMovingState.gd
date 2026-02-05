extends State
class_name PlayerMoving

var input_dir
@export var move_speed:= 50
@onready var player: CharacterBody2D
@export var animator: HandleAnimation


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Update(_delta):
	get_input()
	handle_direction()
	handle_animation()
	handle_movement()
	
func handle_movement():
	player.velocity = input_dir * move_speed
	player.move_and_slide()
	
	if input_dir == Vector2.ZERO:
		handle_transition("Idle")
	
func handle_direction():
	if abs(input_dir.x) > abs(input_dir.y):
		player.last_dir = "side"
		animator.animation.flip_h = input_dir.x < 0
	else:
		if input_dir.y > 0:
			player.last_dir = "down"
		elif input_dir.y < 0:
			player.last_dir = "up"
		
func get_input():
	input_dir = Input.get_vector("move_left","move_right","move_up", "move_down")
	
func handle_transition(new_state: String):
	state_transition.emit(self, new_state)

func handle_animation():
	animator.play_moving(player.last_dir)
