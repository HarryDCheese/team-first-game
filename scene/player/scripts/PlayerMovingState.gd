extends State
class_name PlayerMoving

@export var MOVE_SPEED := 50

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
	var dir_key = Vector2(sign(actor.input_dir.x), sign(actor.input_dir.y))
	
	var directions = {
		Vector2(1, 0): "right",
		Vector2(-1, 0): "left",
		Vector2(0, 1): "down",
		Vector2(0, -1): "up",
		Vector2(1, 1): "down_right",
		Vector2(-1, 1): "down_left",
		Vector2(1, -1): "up_right",
		Vector2(-1, -1): "up_left"
	}
	
	if directions.has(dir_key):
		actor.last_dir = directions[dir_key]
	
func handle_transition(new_state: String):
	if actor.input_dir == Vector2.ZERO:
		state_transition.emit(self, new_state)

func handle_animation():
	actor.animator.play_moving(actor.last_dir)
