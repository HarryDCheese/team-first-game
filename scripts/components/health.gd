extends Node
class_name Health

@export var MAX_HP: float
@export var immortality := false
@onready var hp := MAX_HP

signal damaged(amount)
signal died
 
func take_damage(amount: float):
	if hp <= 0:
		return
	
	hp -= amount
	damaged.emit(amount)
	
	if hp <= 0:
		hp = 0
		died.emit()
	

func heal(amount: float):
	hp = clamp(hp + amount, 0, MAX_HP)
