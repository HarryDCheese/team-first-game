extends State
class_name PlayerAttacking

@export var COMBO_MAX := 3
@export var COOLDOWN := 0.2 #time between each hit
@export var COMBO_TIMER := 50.0 #timer for reseting combo
@export var ATTACKING_TIMER := 0.8 #for placeholder
var attacking_timer #for placeholder
var combo_timer
var combo_index := 0
var hit_timer
var countdown = false
var can_attack = true

func Enter():
	reset_combo()
	hit_box.monitorable = true
	attacking_timer = ATTACKING_TIMER
	
func Update(delta):
	handle_input()
	handle_animation()
	handle_timer(delta)
	handle_cooldown(delta)
	handle_transition()
	attacking_timer -= delta
	
func Exit():
	hit_box.monitorable = false
	
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
		
func handle_transition():
	if Input.is_action_pressed("shoot") or attacking_timer <= 0:
		state_transition.emit(self, "Shooting")

func handle_animation():
	actor.animator.play_attack(actor.last_dir)
	

#For testing
func do_attack(hit_index):
	can_attack = false
	hit_timer = COOLDOWN
	print("Attack hit: ", hit_index)
