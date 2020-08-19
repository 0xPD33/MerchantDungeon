extends StaticBody2D

export (PackedScene) var linked_item_drop

const EXPLOSION = preload("res://Effects/Explosion1.tscn")

var hit = false
var explosion_done = false

onready var item_spawner = $ItemSpawner


func explode():
	var instance = EXPLOSION.instance()
	instance.global_position = position
	get_tree().current_scene.add_child(instance)
	yield(instance.get_node("AnimationPlayer"), "animation_finished")
	instance.queue_free()
	explosion_done = true
	spawn_item()
	queue_free()


func spawn_item():
	if linked_item_drop != null:
		item_spawner.spawn_item(linked_item_drop, global_position)


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox"):
		if not hit:
			hit = true
			$AnimationPlayer.play("destroy")
			yield($AnimationPlayer, "animation_finished")
			for node in get_children():
				if node is Sprite:
					node.hide()
			explode()

