extends Node2D
@onready var Room = get_parent()
@onready var roomlength = Room.RoomLength
@onready var doorlength = Room.DoorLength

const DirectionVector ={
	"up": Vector2(0,-1),
	"down": Vector2(0,1),
	"left": Vector2(-1,0),
	"right": Vector2(1,0)
}

func _ready():
	wall_set_up()

func wall_set_up() -> void:
	size_set_up()
	pos_set_up()

func pos_set_up() -> void:
	var rotation_factor = -1
	for dir in ["up","right","down","left"]:
		rotation_factor += 1
		var dir_wall = get_node(dir)
		dir_wall.position = roomlength/2*DirectionVector[dir]
		dir_wall.rotation= PI/2*rotation_factor

func size_set_up() -> void:
	for dir in ["up","right","down","left"]:
		var width_door = doorlength
		var height = 6
		var width_wall = roomlength - height -2
		
		if (width_wall - width_door) <= 0:
			push_error("negative side-wall length")
		
		var dir_wall = get_node(dir)
		var wall_size = dir_wall.get_node("WallSprite").texture.get_size()
		dir_wall.get_node("WallSprite").scale.x = width_wall / wall_size.x
		dir_wall.get_node("WallSprite").scale.y = height / wall_size.y
		
		dir_wall.get_node("WallCollisionMiddle").shape.size.x = width_door
		dir_wall.get_node("WallCollisionLeft").shape.size.x = (width_wall - width_door)/2
		dir_wall.get_node("WallCollisionRight").shape.size.x = (width_wall - width_door)/2
		
		dir_wall.get_node("WallCollisionMiddle").shape.size.y = height 
		dir_wall.get_node("WallCollisionLeft").shape.size.y = height
		dir_wall.get_node("WallCollisionRight").shape.size.y = height
		
		dir_wall.get_node("WallCollisionLeft").position = (width_wall/2 - (width_wall - width_door)/4)*Vector2(-1,0)
		dir_wall.get_node("WallCollisionRight").position = (width_wall/2 - (width_wall - width_door)/4)*Vector2(1,0)
