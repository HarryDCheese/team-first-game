extends Area2D
class_name HitBox

@export var damage: float
@export var knockback_force: float
@export var stun_time: float

signal damaged(damage: float)

func _ready():
	monitoring = false
	monitorable = false

func get_damage():
	return damage
	
func get_knockback():
	return knockback_force

func get_stun():
	return stun_time
