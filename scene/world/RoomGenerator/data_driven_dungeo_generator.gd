extends Node2D

const room_size = 32
const RoomTemplate =[
	{
		"type": "normal",
		"scene": preload("res://scene/world/RoomGenerator/RoomScenes/normal_room.tscn"),
		"doors": ["up","down","left","right"],
		"weight": 1
	},
	{
		"type": "special",
		"scene": preload("res://scene/world/RoomGenerator/RoomScenes/special_room.tscn"),
		"doors": ["left","right"],
		"weight": 4
	}
]
const DirectionVector ={
	"up": Vector2(0,-1),
	"down": Vector2(0,1),
	"left": Vector2(-1,0),
	"right": Vector2(1,0)
}
var PositionGrid := {}

@export var MaxRooms := 15
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
	
	while frontier.size() > 0 and dungeon.size() < MaxRooms:
		var current = frontier.pop_front()
		expand_room(current)
	
	spawn_rooms()

func expand_room(pos):
	var room_data = dungeon[pos]
	
	for dir in room_data.doors:
		if randf() < 0.5:
			continue
		
		var next_pos = pos + DirectionVector[dir]
		
		if dungeon.has(next_pos):
			continue
		
		var new_room = PickRoom(pos)
		
		dungeon[next_pos] = new_room
		frontier.append(next_pos)

func PickRoom(pos):
	var room_data = dungeon[pos]
	var room_selection= []
	for i in RoomTemplate:
		for r in i.doors:
			if opposite(r) in room_data.doors:
				room_selection.append(i)
	return weight_based_selector(room_selection).duplicate(true)

func spawn_rooms():
	for pos in dungeon.keys():
		var room_data = dungeon[pos]
		var room = room_data["scene"].instantiate()
		
		room.position = pos*room_size
		add_child(room)
		room_data["instance"]= room
	finalize_rooms()

func finalize_rooms():
	for pos in dungeon.keys():
		var room = dungeon[pos].instance
		
		for dir in ["up", "down", "left", "right"]:
			if not room.has_node(dir):
				continue
			var neighbor_pos = pos + DirectionVector[dir]
			var door_node = room.get_node(dir)
			
			door_node.visible = dungeon.has(neighbor_pos)

func opposite(dir):
	return {
		"up": "down",
		"down": "up",
		"left": "right",
		"right": "left"
	}[dir]

func weight_based_selector(selection_list):
	var total_weight=0
	
	for i in selection_list:
		total_weight += i.weight
	
	var roll = randi()%total_weight
	var weight_in_run=0
	
	for i in selection_list:
		weight_in_run += i.weight
		if roll < weight_in_run:
			return i
	return selection_list[0]

func get_room_by_type(type):
	for i in RoomTemplate:
		if i.type==type:
			return i.duplicate(true)
	return null
