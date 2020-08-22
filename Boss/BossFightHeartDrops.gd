extends Area2D

var drop = preload("res://Items/Heart.tscn")


func drop_heart():
	var heart = drop.instance()
	add_child(heart)
	heart.global_position = global_position


func start_timer():
	$DropTimer.start()


func _on_DropTimer_timeout():
	drop_heart()
	for timer in get_tree().get_nodes_in_group("HeartDropTimer"):
		timer.randomize_time(30)

