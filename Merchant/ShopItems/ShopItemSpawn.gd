extends Position2D

export (Array, PackedScene) var possible_shop_items

var has_appeared = false

onready var item_spawner = $ItemSpawner
onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer


func _ready():
	sprite.hide()


func spawn_shop_item():
	randomize()
	sprite.show()
	anim_player.play("appear")
	yield(anim_player, "animation_finished")
	has_appeared = true
	anim_player.play("flash")
	var shop_item = possible_shop_items[randi() % possible_shop_items.size()]
	item_spawner.spawn_item(shop_item, global_position)


func _on_shop_item_taken():
	yield(get_tree().create_timer(0.1), "timeout")
	anim_player.play("disappear")
	yield(anim_player, "animation_finished")
	sprite.hide()

