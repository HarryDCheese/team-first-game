extends Node2D

enum DoorLocation {UP, DOWN, LEFT, RIGHT}

@export var rooms: Array[PackedScene]

const ROOM_LENGTH = 32

var current_room: BaseRoom
var placed_rooms := {}
var current_grid_pos = Vector2i.ZERO
var last_chosen_door
var max_room = 10
var room_count = 0

var dir_offsets = {
	DoorLocation.UP: Vector2i(0, -1),
	DoorLocation.DOWN: Vector2i(0, 1),
	DoorLocation.LEFT: Vector2i(-1, 0),
	DoorLocation.RIGHT: Vector2i(1, 0),
}

var opposite = {
	DoorLocation.UP: DoorLocation.DOWN,
	DoorLocation.DOWN: DoorLocation.UP,
	DoorLocation.LEFT: DoorLocation.RIGHT,
	DoorLocation.RIGHT: DoorLocation.LEFT,
}

func _ready():
	spawn_start_room()

func spawn_start_room():
	current_room = rooms.pick_random().instantiate()
	current_room.position = Vector2.ZERO
	add_child(current_room)
	placed_rooms[Vector2i(0,0)] = current_room
	current_grid_pos = Vector2i.ZERO
	room_count = 1
	
	generate_next()

func generate_next():
	if room_count >= max_room:
		return
	# STEP 3: get exits
	var doors = current_room.get_available_doors()
	var available_doors = doors.duplicate()
	# STEP 4: pick random exit
	if last_chosen_door != null:
		available_doors.erase(opposite[last_chosen_door])
	var chosen_exit = available_doors.pick_random()
	if chosen_exit == null:
		print("No exits available")
		return
	# STEP 5: find compatible room
	var candidates = get_rooms_with_exit(opposite[chosen_exit])
	
	var chosen_scene = candidates.pick_random()
	
	# STEP 6: place room
	var grid_pos = current_grid_pos + dir_offsets[chosen_exit]
	
	if placed_rooms.has(grid_pos):
		return
	
	var new_room = chosen_scene.instantiate()
	new_room.position = grid_pos * ROOM_LENGTH
	add_child(new_room)
	placed_rooms[grid_pos] = new_room
	
	current_room = new_room
	current_grid_pos = grid_pos
	last_chosen_door = chosen_exit
	# repeat
	room_count += 1
	generate_next()

func get_rooms_with_exit(dir: DoorLocation) -> Array[PackedScene]:
	var result: Array[PackedScene] = []
	
	for scene in rooms:
		var temp = scene.instantiate()
		if temp.has_door(dir):
			result.append(scene)
		temp.queue_free()
	
	return result
