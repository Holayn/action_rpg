extends "res://Player/person.gd"

var knockback_vector = Vector2.ZERO

func _physics_process(delta):
	knockback_vector = knockback_vector.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback_vector = move_and_slide(knockback_vector)

func _on_hurtbox_area_entered(area):
	print(area.direction_vector)
	knockback_vector = area.direction_vector * 130
