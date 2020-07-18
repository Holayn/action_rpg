extends "res://Player/person.gd"

func _process(delta):
	controls_process()
	sprite_dir_process()
	match state:
		MOVE:
			movement_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
	
func controls_process():
	move_dir = Vector2(0,0)
	move_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_dir = move_dir.normalized()
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func attack_state(delta):
	velocity = Vector2.ZERO
	$animTree.get("parameters/playback").travel("attack")
	
