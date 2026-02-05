extends Node
class_name HandleAnimation

@export var animation: AnimatedSprite2D

var is_attacking := false

func play_moving(dir):
	if is_attacking:
		return
	animation.play("move_" + dir)

func play_idle(dir):
	if is_attacking:
		return
	animation.play("idle_" + dir)
	
func play_attack(dir):
	is_attacking = true
	animation.play("attack_" + dir)
	
