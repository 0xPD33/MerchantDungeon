extends Node2D

signal was_taken

export (PackedScene) var linked_item
export (String) var item_name
export (int) var item_cost

var merchant
var player

var price_multiplier = 1.0 setget set_price_multiplier

var can_interact = false
var taken = false

onready var item_panel = $Panel
onready var item_name_label = $Panel/VBoxContainer/ItemNameLabel
onready var gold_label = $Panel/VBoxContainer/HBoxContainer/GoldLabel

onready var item_spawner = $ItemSpawner
onready var anim_player = $AnimationPlayer


func set_price_multiplier(value):
	price_multiplier = value
	item_cost = round(item_cost * price_multiplier)


func _ready():
	setup()


func _input(_event):
	if Input.is_action_just_pressed("interact") and can_interact and !taken:
		if player.items.gold >= item_cost:
			taken = true
			item_spawner.spawn_item(linked_item, global_position)
			player.items.gold -= item_cost

			emit_signal("was_taken")
			queue_free()
		else:
			pass


func setup():
	for node in get_tree().get_nodes_in_group("ShopItemSpawn"):
		connect("was_taken", node, "_on_shop_item_taken")
	connect("was_taken", self, "_on_shop_item_taken")
	
	merchant = get_tree().current_scene.get_node("YSort/MerchantRoom/Merchant")
	connect("was_taken", merchant, "_on_shop_item_taken")
	
	player = get_tree().current_scene.get_node("YSort/Player")
	item_panel.hide()
	item_name_label.text = item_name
	gold_label.text = str(item_cost)
	anim_player.play("animate_shop_item")


func _on_shop_item_taken():
	for node in get_tree().get_nodes_in_group("ShopItem"):
		node.queue_free()


func _on_PickupRadius_body_entered(body: Node):
	can_interact = true
	item_panel.show()


func _on_PickupRadius_body_exited(body: Node):
	can_interact = false
	item_panel.hide()

