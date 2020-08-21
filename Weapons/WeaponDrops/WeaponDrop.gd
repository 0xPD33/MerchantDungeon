extends Node2D

export (PackedScene) var linked_weapon

var player

var can_take = false


func _ready():
	player = get_tree().current_scene.get_node("YSort/Player")


func _input(event):
	if Input.is_action_just_pressed("interact") and can_take and player != null:
		take_weapon()


func take_weapon():
	player.call("equip_weapon", linked_weapon.instance())
	self.queue_free()


func _on_PickupRadius_body_entered(body: Node):
	if body.is_in_group("Player"):
		can_take = true


func _on_PickupRadius_body_exited(body: Node):
	if body.is_in_group("Player"):
		can_take = false

