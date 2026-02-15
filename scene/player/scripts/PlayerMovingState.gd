extends State
class_name PlayerMoving

@export var MOVE_SPEED:= 50

func Enter():
	return
		
func Update(_delta):
	actor.handle_input()
	handle_direction()
	handle_animation()
	handle_movement()
	handle_transition("Idle")

func handle_movement():
	actor.velocity = actor.input_dir * MOVE_SPEED
	actor.move_and_slide()
	
func handle_direction():
	if abs(actor.input_dir.x) > abs(actor.input_dir.y):
		actor.last_dir = "side"
		actor.animator.animation.flip_h = actor.input_dir.x < 0
	else:
		if actor.input_dir.y > 0:
			actor.last_dir = "down"
		elif actor.input_dir.y < 0:
			actor.last_dir = "up"
	
func handle_transition(new_state: String):
	if actor.input_dir == Vector2.ZERO:
		state_transition.emit(self, new_state)

func handle_animation():
	actor.animator.play_moving(actor.last_dir)
