extends CharacterBody2D
class_name CharacterBase

@export var animator: HandleAnimation
@export var last_dir: String
var dir: Vector2
const DIR_MAP = {
		"up":          Vector2.UP,
		"down":        Vector2.DOWN,
		"left":        Vector2.LEFT,
		"right":       Vector2.RIGHT,
		"up_left":     Vector2(-1, -1),
		"up_right":    Vector2(1, -1),
		"down_left":   Vector2(-1, 1),
		"down_right":  Vector2(1, 1)
	}

func _ready() -> void:
	$Health.died.connect(die)

func _process(_delta):
	dir = handle_direction()
	
func handle_direction():
	var dir = DIR_MAP.get(last_dir, Vector2.ZERO)
	return dir.normalized()

func die():
	return
