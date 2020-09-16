extends Area2D

var teleporter_pos
var teleporter_back_pos 
var origin_pos

var appeared = false
var teleported = false

onready var loop_anim = $LoopAnimation
onready var anim_player = $AnimationPlayer


func _ready():
	teleporter_pos = get_tree().current_scene.get_node("YSort/MerchantRoom/TeleportPosition").global_position
	teleporter_back_pos = get_tree().current_scene.get_node("YSort/MerchantRoom/TeleportBackPosition").global_position
	origin_pos = global_position


func teleport_player(player: Node, pos: Vector2):
	anim_player.play("teleport_anim")
	yield(anim_player, "animation_finished")
	if !teleported:
		create_teleport_back()
	player.global_position = pos


func create_teleport_back():
	var teleporter_instance = load("res://Merchant/MerchantTeleporter.tscn").instance()
	get_tree().current_scene.add_child(teleporter_instance)
	teleporter_instance.add_to_group("ReturnTeleporter")
	teleporter_instance.global_position = teleporter_back_pos


func _on_MerchantTeleporter_body_entered(body: Node):
	if body.is_in_group("Player") and appeared:
		if !is_in_group("ReturnTeleporter"):
			teleport_player(body, teleporter_pos)
		else:
			teleport_player(body, origin_pos)


func _on_VisibilityRange_body_entered(body: Node):
	if body.is_in_group("Player") and !appeared:
		anim_player.play("teleporter_appear")
		yield(anim_player, "animation_finished")
		appeared = true
		loop_anim.play("teleporter_loop_anim")

