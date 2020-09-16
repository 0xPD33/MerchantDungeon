extends StaticBody2D

signal barrel_destroyed

export (PackedScene) var unique_drop

const EXPLOSION = preload("res://Effects/Explosion1.tscn")

var player

var hit = false
var explosion_done = false

onready var drops = $Drops


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")
	add_to_group("Barrel")


func explode():
	var instance = EXPLOSION.instance()
	instance.global_position = position
	get_tree().current_scene.add_child(instance)
	yield(instance.get_node("AnimationPlayer"), "animation_finished")
	instance.queue_free()
	explosion_done = true
	if unique_drop != null:
		drops.drop_unique_item()
	else:
		drops.drop_item()
	emit_signal("barrel_destroyed")
	queue_free()


func _on_Hurtbox_area_entered(area: Area2D):
	if area.is_in_group("Hitbox") or area.is_in_group("Projectile"):
		if not hit:
			hit = true
			if area.is_in_group("Projectile"):
				area.impact(global_position)
				area.queue_free()
			$AnimationPlayer.play("destroy")
			yield($AnimationPlayer, "animation_finished")
			for node in get_children():
				if node is Sprite:
					node.hide()
			explode()

