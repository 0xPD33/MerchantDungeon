extends Node2D

signal was_taken

export (PackedScene) var linked_item
export (String) var item_name
export (int) var item_cost

var player
var player_gold

var can_interact = false
var taken = false

onready var item_panel = $Panel
onready var item_name_label = $Panel/VBoxContainer/ItemNameLabel
onready var gold_label = $Panel/VBoxContainer/HBoxContainer/GoldLabel

onready var item_spawner = $ItemSpawner


func _ready():
	setup()


func _input(_event):
	if Input.is_action_just_pressed("interact") and can_interact and !taken:
		taken = true
		if player_gold >= item_cost:
			item_spawner.spawn_item(linked_item, global_position)
			player_gold -= item_cost
			get_tree().call_group("HUD", "set_gold", player_gold)
			emit_signal("was_taken")
			queue_free()


func setup():
	for node in get_tree().get_nodes_in_group("ShopItemSpawn"):
		connect("was_taken", node, "_on_shop_item_taken")
	connect("was_taken", self, "_on_shop_item_taken")
	item_panel.hide()
	player = get_tree().current_scene.get_node("YSort/Player")
	player_gold = player.items.gold
	item_name_label.text = item_name
	gold_label.text = str(item_cost)


func _on_shop_item_taken():
	for node in get_tree().get_nodes_in_group("ShopItem"):
		node.queue_free()


func _on_PickupRadius_body_entered(body: Node):
	can_interact = true
	item_panel.show()


func _on_PickupRadius_body_exited(body):
	can_interact = false
	item_panel.hide()

