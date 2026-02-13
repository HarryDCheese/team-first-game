extends Node2D
@onready var room = get_parent()
@onready var enemies = room.SpawnEnemies

func _ready() -> void:
	$Enemies.position = Vector2.ZERO
	spawn_enemies($Enemies.position)
	
func spawn_enemies(pos):
	
