extends Node2D

func _process(delta: float):
	rotation = owner.dir.angle() - PI/2
