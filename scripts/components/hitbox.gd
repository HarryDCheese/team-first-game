extends Area2D
class_name HitBox

@export var damage: float
signal damaged(damage: float)

func get_damage():
	return damage
