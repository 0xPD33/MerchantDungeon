extends Node


func spawn_item(item, pos):
	var item_instance = item.instance()
	item_instance.global_position = pos
	get_tree().current_scene.get_node("YSort/Items").add_child(item_instance)

