extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export var show_hit = true

export var invincible = false setget set_invincibility

signal registered_hit
signal invincibility_started
signal invincibility_ended

func show_hit_effect():
	if show_hit:
		var effect = HitEffect.instance()
		get_tree().current_scene.add_child(effect)
		effect.global_position = global_position
		
func set_invincibility(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func _on_hurtbox_area_entered(area):
	show_hit_effect()
	
	emit_signal("registered_hit", area)
	
	$Timer.start()
	
	set_deferred("monitoring", false)

func _on_Timer_timeout():
	self.invincible = false
	monitoring = true
