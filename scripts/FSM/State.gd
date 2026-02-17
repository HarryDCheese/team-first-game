extends Node
class_name State

#NOTE This is the State base-class, all our specific states inherits this logic

signal state_transition
@export var actor: CharacterBase
@export var hurt_box: HurtBox
@export var hit_box: HitBox

func Enter():
	pass

func Exit():
	pass

func Update(_delta):
	pass
