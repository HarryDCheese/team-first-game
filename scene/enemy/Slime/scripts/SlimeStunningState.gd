extends State

var timer
var animation_played

func Enter():
	timer = hurt_box.stun_time
	animation_played = false
	
func Update(delta):
	handle_timer(delta)
	handle_transition()
	handle_animation()
		
func Exit():
	hurt_box.is_stunned = false
	
func handle_transition():
	if timer <= 0:
		state_transition.emit(self, "Idle")

func handle_animation():
	if not animation_played:
		actor.animator.play_stun(actor.last_dir)
	animation_played = true

func handle_timer(t):
	timer -= t
