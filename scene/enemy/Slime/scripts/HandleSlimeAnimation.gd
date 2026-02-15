extends HandleAnimation
class_name HandleSlimeAnimtaion

@onready var real_animation = animation.get_child(0)

func play_moving(dir):
	name = "move_" + dir
	if real_animation.current_animation != name:
		real_animation.play(name)

func play_idle(dir):
	name = "idle_" + dir
	if real_animation.current_animation != name:
		real_animation.play(name)
	
func play_attack(dir):
	pass
