extends Node

export var max_health = 1
onready var curr_health = max_health setget set_curr_health

signal no_curr_health

func set_curr_health(value):
	curr_health = value
	if curr_health <= 0:
		emit_signal("no_curr_health")
