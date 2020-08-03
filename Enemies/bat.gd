extends "res://Player/person.gd"

var EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
var knockback_vector = Vector2.ZERO

func _ready():
	state = Enums.CHASE
	speed = speed * 1/2

func _physics_process(delta):
	knockback_vector = knockback_vector.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback_vector = move_and_slide(knockback_vector)
	
	match state:
		Enums.CHASE:
			chase_state(delta)
		Enums.IDLE:
			idle_state(delta)
		Enums.WANDER:
			wander_state(delta)
	
	velocity += $softcollision.get_push_vector() * delta * 600
	
	velocity = move_and_slide(velocity)
	
	if $PlayerDetection.can_detect_player():
		state = Enums.CHASE

func _on_hurtbox_registered_hit(area):
	$stats.curr_health = $stats.curr_health - area.damage
	knockback_vector = area.direction_vector * 250
	$hurtbox.invincible = true

func _on_stats_no_curr_health():
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.position = position
	queue_free()

func chase_state(delta):
	var to_player = Vector2.ZERO
	if $PlayerDetection.player:
		to_player = global_position.direction_to($PlayerDetection.player.global_position)
	else:
		state = Enums.IDLE
	
	$AnimatedSprite.flip_h = to_player.x < 0
	
	velocity = velocity.move_toward(to_player * speed, ACCEL * delta)
	
	$AnimatedSprite.speed_scale = 2

func idle_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	$AnimatedSprite.speed_scale = 1
	
func state_change():
	if $wanderController.is_wandering:
		pass
	if state == Enums.IDLE || state == Enums.WANDER:
		state = _pick_random_state([Enums.IDLE, Enums.WANDER])

func wander_state(delta):
	if $wanderController.can_wander():
		print("wandering")
		$wanderController.start_wander(rand_range(1, 3))
		
		var direction = global_position.direction_to($wanderController.target_position)
		velocity = velocity.move_toward(direction * speed, ACCEL * delta)
		
func _pick_random_state(states):
	states.shuffle()
	return states.pop_front()

func _on_stateChangeTimer_timeout():
	print("state change timer timeout")
	state_change()


func _on_hurtbox_invincibility_started():
	print("foo")
	$blinkPlayer.play("On")

func _on_hurtbox_invincibility_ended():
	$blinkPlayer.play("Off")
