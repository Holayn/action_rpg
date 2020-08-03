extends Control

var hearts = []
var curr_health = 1
var max_health = 1

var HeartFull = preload("res://UI/heartuifull.tscn")
var HeartEmpty = preload("res://UI/heartuiempty.tscn")

func _on_player_stats(stats):
	print(str(stats.curr_health))
	curr_health = stats.curr_health
	max_health = stats.max_health
	update_health_ui()
	
func update_health_ui():
	var missing_health = max_health - curr_health
	for i in hearts:
		i.queue_free()
	hearts = []
	for i in range(curr_health):
		var heartFull = HeartFull.instance()
		var offset = heartFull.texture.get_width() * i
		heartFull.rect_position.x = rect_position.x + offset
		add_child(heartFull)
		hearts.append(heartFull)
	for i in range(curr_health, max_health):
		var heartEmpty = HeartEmpty.instance()
		var offset = heartEmpty.texture.get_width() * i
		heartEmpty.rect_position.x = rect_position.x + offset
		add_child(heartEmpty)
		hearts.append(heartEmpty)
