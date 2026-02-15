extends State
class_name PlayerShooting

@export var gun: Marker2D

func Enter():
	return 
	
func Update(_delta):
	handle_shooting()
	handle_transition("Attacking")

func handle_shooting():
	if Input.is_action_pressed("shoot"):
		gun.shoot(actor.dir)
	
func handle_transition(new_state: String):
	if Input.is_action_pressed("primary_attack"):
		state_transition.emit(self, new_state)
