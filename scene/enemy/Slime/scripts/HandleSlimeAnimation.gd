extends HandleAnimation
class_name HandleSlimeAnimtaion

func play_moving(dir):
	name = "move_" + dir
	if animation.current_animation != name:
		animation.play(name)

func play_idle(dir):
	name = "idle_" + dir
	if animation.current_animation != name:
		animation.play(name)
	
func play_attack(dir):
	pass
	
func play_stun(dir):
	name = "stun_" + dir
	if animation.current_animation != name:
		animation.play(name)
