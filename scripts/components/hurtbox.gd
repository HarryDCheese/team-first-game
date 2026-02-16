extends Area2D
class_name HurtBox

@onready var health = get_parent().get_node_or_null("Health")

func _ready():
	area_entered.connect(_on_area_entered)
	monitoring = true
	monitorable = false

func _on_area_entered(area: Area2D):
	if not area.has_method("get_damage"):
		return
		
	health.take_damage(area.get_damage())
