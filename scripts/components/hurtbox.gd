extends Area2D
class_name HurtBox

@onready var health = get_parent().get_node_or_null("Health")
var is_stunned := false
var damage
var stun_time

func _ready():
	area_entered.connect(_on_area_entered)
	monitoring = true
	monitorable = false

func _on_area_entered(area: Area2D):
	if not area.has_method("get_damage"):
		return
	
	is_stunned = true
		
	damage = area.get_damage()
	stun_time = area.get_stun()
	
	if health:
		health.take_damage(damage)
		
