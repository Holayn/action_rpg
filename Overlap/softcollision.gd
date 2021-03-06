extends Area2D

var overlapping_areas = Array()

func _process(delta):
	overlapping_areas = get_overlapping_areas()

func is_colliding():
	return overlapping_areas.size() > 0
	
func get_push_vector()-> Vector2:
	if is_colliding():
		return (overlapping_areas[0].global_position).direction_to(global_position)
	else:
		return Vector2.ZERO
		
