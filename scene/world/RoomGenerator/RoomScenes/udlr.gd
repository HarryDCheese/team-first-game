extends Sprite2D

class_name BaseRoom
enum DoorLocation { UP, DOWN, LEFT, RIGHT }

@export_flags("Up", "Down", "Left", "Right") var doors = 0
var grid_pos = Vector2i.ZERO

func has_door(dir: DoorLocation) -> bool:
	return (doors & (1 << dir)) != 0

func get_available_doors() -> Array[DoorLocation]:
	var result: Array[DoorLocation] = []
	for dir in DoorLocation.values():
		if has_door(dir):
			result.append(dir)
	return result
