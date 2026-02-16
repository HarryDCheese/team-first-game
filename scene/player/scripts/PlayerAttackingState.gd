extends State
class_name PlayerAttacking

@export var COMBO_MAX := 3
@export var COOLDOWN := 0.2 #time between each hit
@export var COMBO_TIMER := 50.0 #timer for reseting combo
var combo_timer
var combo_index := 0
var hit_timer
var countdown = false
var can_attack = true

func Enter():
	reset_combo()
	actor.hit_box.monitoring = true
	
func Update(delta):
	handle_input()
	handle_timer(delta)
	handle_cooldown(delta)
	handle_transition("Shooting")
	
func Exit():
	actor.hit_box.monitoring = false
	
func handle_input():
	if Input.is_action_just_pressed("primary_attack"):
		if not countdown:
			start_combo()
		else:
			continue_combo()

func start_combo():
	countdown = true
	combo_index += 1
	do_attack(combo_index)

func continue_combo():
	if combo_index == COMBO_MAX:
		reset_combo()
	combo_index += 1
	do_attack(combo_index)
	
func reset_combo():
	countdown = false
	combo_index = 0
	combo_timer = COMBO_TIMER
	
func handle_timer(t):
	if countdown:
		combo_timer -= t
		if combo_timer <= 0:
			reset_combo()
			
func handle_cooldown(t):
	if not can_attack:
		hit_timer -= t
		if hit_timer <= 0:
			can_attack = true
		
func handle_transition(new_state: String):
	if Input.is_action_pressed("shoot"):
		state_transition.emit(self, new_state)
	
		
#For testing
func do_attack(hit_index):
	can_attack = false
	hit_timer = COOLDOWN
	print("Attack hit: ", hit_index)
