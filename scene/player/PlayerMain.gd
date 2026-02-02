extends CharacterBody2D
class_name PlayerMain

@onready var fsm: FiniteStateMachine = $FSM
@onready var gun: Marker2D = $Gunpoint

@export var animator: AnimatedSprite2D
@export var last_dir: String

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		gun.shoot(get_shoot_direction())

	
func get_shoot_direction() -> Vector2:
	match last_dir:
		"up": return Vector2.UP
		"down": return Vector2.DOWN
		"side":
			return Vector2.LEFT if animator.flip_h else Vector2.RIGHT
	return Vector2.UP
	
