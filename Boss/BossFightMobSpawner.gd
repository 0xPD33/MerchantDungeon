extends Area2D

export (Array, PackedScene) var possible_mob_spawns


func spawn_mob():
	randomize()
	var chosen_mob = possible_mob_spawns[randi() % possible_mob_spawns.size()]
	var mob = chosen_mob.instance()
	get_tree().current_scene.get_node("YSort/BossRoom").add_child(mob)
	mob.global_position = global_position


func start_timer():
	$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	spawn_mob()
	for timer in get_tree().get_nodes_in_group("MobSpawnTimer"):
		timer.randomize_time(10)

