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


func _on_hurtbox_registered_hit(area):
	$stats.curr_health = $stats.curr_health - area.damage
	knockback_vector = area.direction_vector * 250

#func _on_hurtbox_area_entered(area):
#	$stats.curr_health = $stats.curr_health - area.damage
#	knockback_vector = area.direction_vector * 130

func _on_stats_no_curr_health():
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.position = position
	queue_free()

func chase_state(delta):
	var to_player = Vector2.ZERO
	if $PlayerDetection.player:
		to_player = ($PlayerDetection.player.global_position - global_position).normalized() * speed
	else:
		state = Enums.IDLE
		
	$AnimatedSprite.flip_h = to_player.x < 0
	
	velocity = velocity.move_toward(to_player, ACCEL * delta)
	velocity = move_and_slide(velocity)
	
	$AnimatedSprite.speed_scale = 2

func idle_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	
	$AnimatedSprite.speed_scale = 1
	
	if $PlayerDetection.can_detect_player():
		state = Enums.CHASE
