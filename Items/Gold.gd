extends "res://Items/Item.gd"

var small_texture = preload("res://Tilesheets/images/colored_transparent_packed_215.png")
var big_texture = preload("res://Tilesheets/images/colored_transparent_packed_234.png")

var gold_amount = 1

onready var gold_sprite = $Sprite


func _ready():
	randomize()
	gold_amount = randi() % 3 + 1
	set_texture()


func set_texture():
	if gold_amount == 3:
		gold_sprite.texture = big_texture
	else:
		gold_sprite.texture = small_texture

