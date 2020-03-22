extends "res://Player/person.gd"

func _physics_process(delta):
	controls_process()
	movement_process(delta)
	sprite_dir_process()
	
func controls_process():
	move_dir = Vector2(0,0)
	move_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_dir = move_dir.normalized()
