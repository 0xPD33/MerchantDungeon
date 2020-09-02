extends Position2D

export (Array, PackedScene) var possible_shop_items

onready var item_spawner = $ItemSpawner


func spawn_shop_item():
	randomize()
	
	#for i in range(get_tree().get_nodes_in_group("ShopItemSpawn").size()):
	
	var shop_item = possible_shop_items[randi() % possible_shop_items.size()]
	item_spawner.spawn_item(shop_item, global_position)

