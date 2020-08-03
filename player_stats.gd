extends "res://stats.gd"

signal stats

func _ready():
	emit_signal("stats")

func set_curr_health(value):
	.set_curr_health(value)
	emit_signal("stats")
