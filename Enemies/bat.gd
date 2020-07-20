extends "res://Player/person.gd"

var EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
var knockback_vector = Vector2.ZERO

func _physics_process(delta):
	knockback_vector = knockback_vector.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback_vector = move_and_slide(knockback_vector)

func _on_hurtbox_area_entered(area):
	$stats.curr_health = $stats.curr_health - area.damage
	knockback_vector = area.direction_vector * 130

func _on_stats_no_curr_health():
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.position = position
	queue_free()
