extends HandleAnimation
class_name HandlePlayerAnimation

var is_attacking := false
var anim_name: String

func play_moving(dir):
	if is_attacking:
		return
	anim_name = "move_" + dir
	animation.play(anim_name)

func play_idle(dir):
	if is_attacking:
		return
	anim_name = "idle_" + dir
	animation.play(anim_name)
	
func play_attack(dir):
	is_attacking = true
	anim_name = "attack_" + dir
	
