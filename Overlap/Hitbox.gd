extends "res://Overlap/TheHitbox.gd"

var direction_vector = Vector2.ZERO

func _onPositionUpdated():
	direction_vector = Vector2(cos(get_parent().rotation), sin(get_parent().rotation))
