extends KinematicBody2D

const ACCEL = 600
const SPEED = 100
const FRICTION = 500

var state = Enums.MOVE
var velocity = Vector2.ZERO
var speed = 4
var move_dir = Vector2.ZERO

var direction = Vector2.ZERO

func _ready():
	if $animTree:
		$animTree.active = true
	
func set_move_anim_tree():
	pass
	
func set_idle_anim_tree():
	pass

func movement_state(delta):
	if move_dir != Vector2(0,0):
		set_move_anim_tree()
		$animTree.get("parameters/playback").travel("run")
		velocity = velocity.move_toward(move_dir * SPEED, ACCEL * delta)
	else:
		set_idle_anim_tree()
		$animTree.get("parameters/playback").travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

func attack_animation_finished():
	state = Enums.MOVE
