extends KinematicBody2D

const ACCEL = 600
const SPEED = 100
const FRICTION = 500

enum {
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var speed = 4
var move_dir = Vector2.ZERO

var direction = Vector2.ZERO
#var sprite_dir = "right"

#var direction_map = {
#	Vector2(-1,0): "left",
#	Vector2(1,0): "right",
#	Vector2(0,1): "down",
#	Vector2(0,-1): "up",
#}

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
#		animation_player("run")
	else:
#		animation_player("idle")
		set_idle_anim_tree()
		$animTree.get("parameters/playback").travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

func attack_animation_finished():
	state = MOVE

#func sprite_dir_process():
#	var direction = direction_map.get(move_dir)
#	if direction != null:
#		sprite_dir = direction
#
#func animation_player(action):
#	$anim.play(str(action,sprite_dir))
