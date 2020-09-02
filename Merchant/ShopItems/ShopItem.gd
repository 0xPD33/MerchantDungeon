extends Node2D

export (PackedScene) var linked_item
export (String) var item_name
export (int) var item_cost

var player
var merchant

var can_interact = false
var taken = false

onready var item_panel = $Panel
onready var item_name_label = $Panel/VBoxContainer/ItemNameLabel
onready var gold_label = $Panel/VBoxContainer/HBoxContainer/GoldLabel

onready var item_spawner = $ItemSpawner


func _ready():
	item_panel.hide()
	setup()


func _input(_event):
	if Input.is_action_just_pressed("interact") and can_interact and !taken:
		taken = true
		item_spawner.spawn_item(linked_item, global_position)


func setup():
	merchant = get_tree().current_scene.get_node("YSort/MerchantRoom/Merchant")
	player = get_tree().current_scene.get_node("YSort/Player")
	item_name_label.text = item_name
	gold_label.text = str(item_cost)


func _on_PickupRadius_body_entered(body: Node):
	can_interact = true

