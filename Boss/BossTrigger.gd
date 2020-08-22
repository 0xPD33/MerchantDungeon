extends Area2D

var boss_wall = preload("res://Boss/BossWall.tscn")

var triggered = false


func spawn_wall():
	var wall = boss_wall.instance()
	add_child(wall)
	wall.global_position.x = global_position.x + 32
	wall.global_position.y = global_position.y


func _on_BossTrigger_body_entered(body: Node):
	if body.is_in_group("Player") and !triggered:
		triggered = true
		call_deferred("spawn_wall")
		get_tree().call_group("Boss", "start_fight")
		get_tree().call_group("BossHeartDrop", "start_timer")
		call_deferred("set_monitoring", false)

