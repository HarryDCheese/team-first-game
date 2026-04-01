extends State
class_name SlimeIdle

@export var IDLE_MIN := 1.0
@export var IDLE_MAX := 4.0
var timer: float

func Enter():
	random_timer()
		
func Update(delta):
	handle_animation()
	handle_timer(delta)
	handle_transition()
	
func Exit():
	random_direction()
	
func handle_animation():
	actor.animator.play_idle(actor.last_dir)
	
func handle_timer(t):
	timer -= t
	
func handle_transition():
	if timer <= 0:
		state_transition.emit(self, "Moving")
	if hurt_box.is_stunned == true:
		state_transition.emit(self, "Stunning")
		
func random_timer():
	timer = randf_range(IDLE_MIN, IDLE_MAX)
	
func random_direction():
	actor.last_dir = ["up", "down", "right", "left"].pick_random()

	
