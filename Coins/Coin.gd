extends Sprite

var value : int = 5



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$AudioStreamPlayer2D.play()
		Global.gold += value
		get_tree().call_group("player", "update_coin_amount")
		$Area2D.queue_free()
		texture = null
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
