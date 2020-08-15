extends Area2D

var hit = false


func _on_Barrel_area_entered(_area: Area2D):
	if not hit:
		hit = true
		$AnimationPlayer.play("destroy")
		yield($AnimationPlayer, "animation_finished")
		spawn_item()
		queue_free()


func spawn_item():
	pass

