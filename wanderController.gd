extends Node2D


export(int) var wander_range = 32

onready var original_position = global_position
onready var target_position = global_position

var is_wandering = false

func update_target_position():
	var target_vector = Vector2(rand_range(-wander_range,wander_range), rand_range(-wander_range,wander_range))
	target_position = original_position + target_vector
	
func can_wander():
	return !is_wandering
	
func start_wander(duration):
	update_target_position()
	is_wandering = true
	$Timer.start(duration)

func _on_Timer_timeout():
	is_wandering = false
