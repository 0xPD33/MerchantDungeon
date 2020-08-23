extends Area2D

export (Array, PackedScene) var possible_mob_spawns

var max_mobs = 4
var mob_count = 0


func spawn_mob():
	if mob_count < max_mobs:
		randomize()
		var chosen_mob = possible_mob_spawns[randi() % possible_mob_spawns.size()]
		var mob = chosen_mob.instance()
		get_tree().current_scene.get_node("YSort/BossRoom").add_child(mob)
		mob.global_position = global_position
		mob_count += 1


func start_timer():
	$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	spawn_mob()
	for timer in get_tree().get_nodes_in_group("MobSpawnTimer"):
		timer.randomize_time(10)

