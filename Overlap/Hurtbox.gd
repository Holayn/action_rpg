extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export var show_hit = true

func _on_hurtbox_area_entered(area):
	if show_hit:
		var effect = HitEffect.instance()
		get_tree().current_scene.add_child(effect)
		effect.global_position = global_position
