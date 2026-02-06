extends State
class_name PlayerAttacking

var player: CharacterBody2D

#For testing input
var dash_speed:= 200.0

func dashing():
	player.velocity = player.dir * dash_speed
	player.move_and_slide()

#No more testing

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func Update(_delta):
	handle_attacking()
	handle_transition("Shooting")
	
func handle_attacking():
	if Input.is_action_just_pressed("primary_attack"):
		dashing() #For testing
		
func handle_transition(new_state: String):
	if Input.is_action_pressed("shoot"):
		state_transition.emit(self, new_state)
		
