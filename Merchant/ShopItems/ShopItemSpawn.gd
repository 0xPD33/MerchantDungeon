extends Position2D

export (Array, PackedScene) var possible_shop_items

var has_appeared = false

onready var item_spawner = $ItemSpawner
onready var circle_sprite = $CircleSprite
onready var anim_player = $AnimationPlayer


func _ready():
	circle_sprite.hide()


func spawn_shop_item(price_multiplier):
	if !has_appeared:
		randomize()
		circle_sprite.show()
		anim_player.play("appear")
		yield(anim_player, "animation_finished")
		anim_player.play("flash")
		var shop_item = possible_shop_items[randi() % possible_shop_items.size()]
		item_spawner.spawn_shop_item(shop_item, global_position, price_multiplier)
		has_appeared = true


func _on_shop_item_taken():
	yield(get_tree().create_timer(0.1), "timeout")
	anim_player.play("disappear")
	yield(anim_player, "animation_finished")
	circle_sprite.hide()
	has_appeared = false

