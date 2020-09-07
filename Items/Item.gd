extends Node2D


func _on_PickupRadius_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.items.pickup_item(self)
		queue_free()

