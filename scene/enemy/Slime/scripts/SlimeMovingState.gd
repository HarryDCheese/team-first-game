extends State
class_name SlimeMoving

@export var MOVE_MIN := 0.7
@export var MOVE_MAX := 1.4
@export var MOVE_SPEED:= 20
var timer: float

func Enter():
	random_timer()
	
func Update(delta):
	handle_movement()
	handle_animation()
	handle_timer(delta)
	handle_transition()
	
func handle_movement():
	actor.velocity = actor.dir * MOVE_SPEED
	actor.move_and_slide()
	
func handle_animation():
	actor.animator.play_moving(actor.last_dir)

func handle_timer(t):
	timer -= t
	
func handle_transition():
	if timer <= 0:
		state_transition.emit(self, "Idle")
	if hurt_box.is_stunned == true:
		state_transition.emit(self, "Stunning")
	
func random_timer():
	timer = randf_range(MOVE_MIN, MOVE_MAX)
