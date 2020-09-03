extends Node


func spawn_shop_item(item, pos, price_mult):
	var item_instance = item.instance()
	item_instance.global_position = pos
	item_instance.set_price_multiplier(price_mult)
	get_tree().current_scene.get_node("YSort/Items").add_child(item_instance)

