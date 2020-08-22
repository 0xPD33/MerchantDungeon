extends Timer


func _ready():
	if get_parent().is_in_group("BossMobSpawn"):
		randomize_time(20)
	else:
		randomize_time(30)


func randomize_time(time):
	randomize()
	var random_time = rand_range(time, time * 1.5)
	wait_time = random_time

