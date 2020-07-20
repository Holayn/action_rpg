extends AnimatedSprite

func _ready():
	# connecting signal manually
	connect("animation_finished", self, "_on_animation_finished")
	play("default")

func _on_animation_finished():
	queue_free()
	pass # Replace with function body.
