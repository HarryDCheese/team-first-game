extends State
class_name PlayerMoving

var input_dir
@export var move_speed:= 50
@onready var player: CharacterBody2D
@export var animator: AnimatedSprite2D


func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Update(_delta):
	get_input()
	handle_movement()
	handle_animation(player.last_dir)
	
func handle_movement():
	player.velocity = input_dir * move_speed
	player.move_and_slide()
	
	if input_dir == Vector2.ZERO:
		handle_transition("Idle")
	
func handle_animation(last_dir):
	if abs(input_dir.x) > abs(input_dir.y):
		last_dir = "side"
		animator.flip_h = input_dir.x < 0
	else:
		if input_dir.y > 0:
			last_dir = "down"
		elif input_dir.y < 0:
			last_dir = "up"
		
	animator.play(last_dir)
		
func get_input():
	input_dir = Input.get_vector("left","right","up", "down")
	
func handle_transition(new_state: String):
	state_transition.emit(self, new_state)
