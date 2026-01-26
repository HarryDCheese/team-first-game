extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var speed := 50
var input_dir
var last_dir = "down"


func _physics_process(delta: float) -> void:
	get_input()
	handle_movement()
	handle_animation()
	move_and_slide()
	
func handle_animation():
	if abs(input_dir.x) > abs(input_dir.y):
		last_dir = "side"
		animated_sprite_2d.flip_h = input_dir.x < 0
	else:
		if input_dir.y > 0:
			last_dir = "down"
		elif input_dir.y < 0:
			last_dir = "up"
		
	if input_dir == Vector2.ZERO:
		animated_sprite_2d.play("idle_" + last_dir)
	elif animated_sprite_2d.animation != last_dir:
		animated_sprite_2d.play(last_dir)
		
func get_input():
	input_dir = Input.get_vector("left","right","up", "down")
	
func handle_movement():
	velocity = input_dir * speed

	
