extends Node
class_name State

#NOTE This is the State base-class, all our specific states inherits this logic

signal state_transition

func Enter():
	pass

func Exit():
	pass

func Update(_delta):
	pass
	
