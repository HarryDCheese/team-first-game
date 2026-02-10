extends Node2D
@onready var Room = get_parent()
@onready var scalar = Room.RoomLength

const DirectionVector ={
	"up": Vector2(0,-1),
	"down": Vector2(0,1),
	"left": Vector2(-1,0),
	"right": Vector2(1,0)
}

func _ready():
	door_set_up()

func door_set_up() -> void:
	var rotation_factor = -1
	for dir in ["right","left"]:
		rotation_factor += 2
		var dir_door = get_node(dir)
		dir_door.position = scalar/2*DirectionVector[dir]
		dir_door.rotation= PI/2*rotation_factor
