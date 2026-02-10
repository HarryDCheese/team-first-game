extends Node2D

const room_size = 40
@export var RoomTemplate: Array[RoomData]

const DirectionVector ={
	"up": Vector2(0,-1),
	"down": Vector2(0,1),
	"left": Vector2(-1,0),
	"right": Vector2(1,0)
}

@export var MaxRooms := 10
var dungeon := {}
var frontier := []

func _ready() :
	generate_dungeon()

func generate_dungeon():
	dungeon.clear()
	frontier.clear()
	
	var start_pos := Vector2.ZERO
	dungeon[start_pos] = get_room_by_type("normal")
	frontier.append(start_pos)
	
	while frontier.size() > 0 and dungeon.size() <= MaxRooms:
		var current = frontier.pop_front()
		expand_room(current)
	
	spawn_rooms()

func expand_room(pos):
	var room_data = dungeon[pos]
	for dir in room_data.doors:
		if randi()%2 <1:
			continue
		if dungeon.size()> MaxRooms:
			return
		
		var next_pos = pos + DirectionVector[dir]
		if dungeon.has(next_pos):
			continue
		
		var neighbor_counter = 0
		for r in ["up","down","left","right"]:
			var neighbor_pos = next_pos + DirectionVector[r]
			if dungeon.has(neighbor_pos):
				neighbor_counter +=1
		
		if neighbor_counter>= 2:
			continue
		dungeon[next_pos] = PickRoom(dir)
		frontier.append(next_pos)

func spawn_rooms():
	for pos in dungeon.keys():
		var room_data = dungeon[pos]
		var room = room_data.scene.instantiate()
		
		room.position = pos*room_size
		add_child(room)
		dungeon[pos]={
			"data": room_data,
			"instance": room
		}
	enable_doors()

func enable_doors():
	for pos in dungeon.keys():
		var room_info = dungeon[pos]
		var room_instance = room_info["instance"]
		
		for dir in ["up", "down", "left", "right"]:
			if not room_instance.has_node("Doors/" + dir):
				continue
			var next_pos = pos + DirectionVector[dir]
			var door_node = room_instance.get_node("Doors/" + dir)
		
			if dungeon.has(next_pos):
				var next_room_data = dungeon[next_pos]["data"]
				door_node.visible = opposite(dir) in next_room_data.doors
			else:
				door_node.visible = false

func opposite(dir):
	return {
		"up": "down",
		"down": "up",
		"left": "right",
		"right": "left"
	}[dir]

func PickRoom(dir):
	var room_selection= []
	for i in RoomTemplate:
		if opposite(dir) in i.doors:
			room_selection.append(i)
	
	if room_selection.is_empty():
		push_error("no dir found for " + dir)
		return RoomTemplate[0]
		
	return weight_based_selector(room_selection)

func weight_based_selector(selection_list):
	var total_weight=0
	
	for i in selection_list:
		total_weight += i.weight
	
	var roll = randi() % total_weight
	var weight_in_run=0
	
	for i in selection_list:
		weight_in_run += i.weight
		if roll < weight_in_run:
			return i
	return selection_list[0]

func get_room_by_type(type):
	for i in RoomTemplate:
		if i.type==type:
			return i
	return null
