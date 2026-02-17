extends CharacterBody2D
class_name CharacterBase

@export var animator: HandleAnimation
@export var last_dir: String
var dir: Vector2

func _ready() -> void:
	$Health.died.connect(die)

func _process(_delta):
	dir = handle_direction()
	
func handle_direction():
	match last_dir:
		"up": return Vector2.UP
		"down": return Vector2.DOWN
		"side":
			return Vector2.RIGHT if animator.animation.flip_h else Vector2.LEFT
	return Vector2.UP

func die():
	return
