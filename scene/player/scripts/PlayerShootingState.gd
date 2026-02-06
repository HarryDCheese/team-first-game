extends State
class_name PlayerShooting

@export var gun: Marker2D
var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update(_delta):
	handle_shooting()
	handle_transition("Attacking")

func handle_shooting():
	if Input.is_action_pressed("shoot"):
		gun.shoot(player.dir)
	
func handle_transition(new_state: String):
	if Input.is_action_pressed("primary_attack"):
		state_transition.emit(self, new_state)
