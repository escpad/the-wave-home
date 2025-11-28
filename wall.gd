extends StaticBody2D

# You can use this later to add effects when the bubble hits
func _on_bubble_collided(body: Node):
	if body.name == "Bubble":
		# e.g. play sound, flash, etc.
		pass
