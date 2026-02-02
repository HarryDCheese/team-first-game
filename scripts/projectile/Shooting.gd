extends Marker2D

@export var projectile_scene: PackedScene
@export var bullet_speed := 300
@export var cooldown := 0.2

var can_shoot := true

func shoot(dir: Vector2):
	if not can_shoot:
		return
	can_shoot = false
	
	var bullet = projectile_scene.instantiate()
	bullet.global_position = global_position
	bullet.setup(dir, bullet_speed)
	get_tree().current_scene.add_child(bullet)
	
	await get_tree().create_timer(cooldown).timeout
	can_shoot = true
