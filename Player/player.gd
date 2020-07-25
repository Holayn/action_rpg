extends "res://Player/person.gd"

var roll_dir = move_dir
var roll_speed = speed * 1.5

func _ready():
	state = Enums.MOVE

func _process(delta):
	controls_process()
#	sprite_dir_process()
	match state:
		Enums.MOVE:
			movement_state(delta)
		Enums.ROLL:
			roll_state(delta)
		Enums.ATTACK:
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
		state = Enums.ATTACK
		
	if Input.is_action_just_pressed("roll"):
		state = Enums.ROLL
		
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
	
func attack_animation_finished():
	state = Enums.MOVE
	
func roll_state(delta):
	velocity = move_and_slide(velocity.normalized() * (roll_speed))
	$animTree.get("parameters/playback").travel("roll")
	
func roll_finished():
	state = Enums.MOVE

func _on_hurtbox_registered_hit(area):
	if !$hurtbox.invincible:
		$stats.curr_health = $stats.curr_health - area.damage
		$hurtbox.invincible = true
	
func _on_stats_no_curr_health():
	queue_free()
