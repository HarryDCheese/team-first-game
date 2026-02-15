extends State
class_name PlayerDashing

@export var DASH_SPEED := 400
@export var DASH_TIME := 0.15
@export var DASH_COOLDOWN := 0.4

var dash_timer
var cooldown_timer

func Enter():
	dash_timer = DASH_TIME
	cooldown_timer = DASH_COOLDOWN
	
func Update(delta):
	dash_timer -= delta
	cooldown_timer -= delta
	
	actor.handle_input()
	handle_dashing()
	handle_transition("Idle")

func handle_dashing():
	actor.velocity = actor.input_dir * DASH_SPEED
	actor.move_and_slide()

func handle_transition(new_state: String):
	if dash_timer <= 0:
		state_transition.emit(self, new_state)
