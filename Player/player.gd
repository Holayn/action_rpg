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

func _physics_process(delta):
	movement_process(delta)
#	sprite_dir_process()

func movement_process(delta):
	move_dir = Vector2(0,0)
	move_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if move_dir != Vector2(0,0):
		velocity = velocity.move_toward(move_dir * SPEED, ACCEL * delta)
		animation_player("run")
	else:
		animation_player("idle")
		velocity = velocity.move_toward(Vector2(0,0), FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
func sprite_dir_process():
	match move_dir:
		Vector2(-1,0):
			sprite_dir = "left"
		Vector2(1,0):
			sprite_dir = "right"
		Vector2(0,1):
			sprite_dir = "down"
		Vector2(0,-1):
			sprite_dir = "up"


func animation_player(action):
	var direction
	if move_dir == Vector2(0,0):
		direction = sprite_dir
	else: 
		direction = direction_map.get(move_dir)
		sprite_dir = direction
	$anim.play(str(action,direction))
