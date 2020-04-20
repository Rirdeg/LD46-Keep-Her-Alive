extends Node2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("player", "end_of_level")
