extends KinematicBody2D

const ACCEL = 600
const SPEED = 100
const FRICTION = 500

var velocity = Vector2(0,0)
var speed = 4

var move_dir = Vector2(0,0)
var sprite_dir = "right"

var direction_map = {
	Vector2(-1,0): "left",
	Vector2(1,0): "right",
	Vector2(0,1): "down",
	Vector2(0,-1): "up",
}

func movement_process(delta):
	var animState = $animTree.get("parameters/playback")
	if move_dir != Vector2(0,0):
		$animTree.set("parameters/idle/blend_position", move_dir)
		$animTree.set("parameters/run/blend_position", move_dir)
		animState.travel("run")
		velocity = velocity.move_toward(move_dir * SPEED, ACCEL * delta)
#		animation_player("run")
	else:
#		animation_player("idle")
		animState.travel("idle")
		velocity = velocity.move_toward(Vector2(0,0), FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
func sprite_dir_process():
	var direction = direction_map.get(move_dir)
	if direction != null:
		sprite_dir = direction

func animation_player(action):
	$anim.play(str(action,sprite_dir))
