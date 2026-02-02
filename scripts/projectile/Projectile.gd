extends Area2D
class_name Projectile

var direction: Vector2
var speed: float

func setup(dir: Vector2, spd: float):
	direction = dir.normalized()
	speed = spd
	
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	
