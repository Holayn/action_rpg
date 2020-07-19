extends "res://Player/person.gd"

enum {
	ROLL
}

var roll_dir = move_dir

func _process(delta):
	controls_process()
#	sprite_dir_process()
	match state:
		MOVE:
			movement_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
			
func movement_state(delta):
	if move_dir != Vector2.ZERO:
		roll_dir = move_dir
		
	.movement_state(delta)
	
	
func controls_process():
	move_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_dir = move_dir.normalized()
	
	if move_dir != Vector2.ZERO:
		direction = move_dir
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
		
	if Input.is_action_just_pressed("roll"):
		state = ROLL
		
func set_move_anim_tree():
	$animTree.set("parameters/idle/blend_position", move_dir)
	$animTree.set("parameters/run/blend_position", move_dir)
	$animTree.set("parameters/attack/blend_position", direction)
	$animTree.set("parameters/roll/blend_position", move_dir)

func set_idle_anim_tree():
	$animTree.set("parameters/attack/blend_position", direction)

func attack_state(delta):
	velocity = Vector2.ZERO
	$animTree.get("parameters/playback").travel("attack")
	
func roll_state(delta):
	velocity = move_and_slide(velocity)
	$animTree.get("parameters/playback").travel("roll")
	
func roll_finished():
	state = MOVE
