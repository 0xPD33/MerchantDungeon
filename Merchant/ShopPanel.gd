extends Panel

var player

var item1
var item2
var item3

var available_items = []

var item_selected

onready var item_list = $VBoxContainer/ItemList


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")
	close_shop()
	load_individual_items()
	load_item_list()


func _input(_event):
	if Input.is_action_just_pressed("ui_down"):
		select_next_item()
	if Input.is_action_just_pressed("ui_up"):
		select_previous_item()
	if Input.is_action_just_released("interact"):
		if item_selected:
			buy_item(item_selected)
	if Input.is_action_just_pressed("interact_secondary"):
		close_shop()


func select_next_item():
	if item_list.is_selected(0):
		item_list.select(1)
		_on_ItemList_item_selected(1)
	elif item_list.is_selected(1):
		item_list.select(2)
		_on_ItemList_item_selected(2)
	elif item_list.is_selected(2):
		item_list.select(0)
		_on_ItemList_item_selected(0)


func select_previous_item():
	if item_list.is_selected(2):
		item_list.select(1)
		_on_ItemList_item_selected(1)
	elif item_list.is_selected(1):
		item_list.select(0)
		_on_ItemList_item_selected(0)
	elif item_list.is_selected(0):
		item_list.select(2)
		_on_ItemList_item_selected(2)


func open_shop():
	show()
	yield(get_tree().create_timer(0.3), "timeout")
	set_process_input(true)
	item_list.grab_focus()
	if !item_list.is_anything_selected():
		item_list.select(0)


func close_shop():
	hide()
	set_process_input(false)


func load_individual_items():
	item1 = preload("res://Merchant/ShopItems/IronSwordShopItem.tscn").instance()
	available_items.append(item1)
	item2 = preload("res://Merchant/ShopItems/IronDaggerShopItem.tscn").instance()
	available_items.append(item2)
	item3 = preload("res://Merchant/ShopItems/HealthPotionShopItem.tscn").instance()
	available_items.append(item3)


func load_item_list():
	var id = 0
	for item in available_items:
		var item_sprite = item.get_node("Sprite")
		item_list.add_item(item.item_name + " - " + str(item.item_cost) + " Gold", item_sprite.texture)
		item_list.set_item_icon_region(id, item_sprite.region_rect)
		item_list.set_item_icon_modulate(id, item_sprite.self_modulate)
		id += 1


func buy_item(item):
	if player.items.gold >= item.item_cost:
		get_parent().item_spawner.spawn_item(item.linked_item, get_parent().get_node("ItemSpawnPosition").global_position)
		player.items.gold -= item.item_cost
		get_tree().call_group("HUD", "set_gold", player.items.gold)


func _on_ItemList_item_selected(index: int):
	if item_list.is_selected(0):
		item_selected = available_items[0]
	elif item_list.is_selected(1):
		item_selected = available_items[1]
	elif item_list.is_selected(2):
		item_selected = available_items[2]

