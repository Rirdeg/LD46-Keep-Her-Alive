extends RigidBody2D

export var hp : int = 1
export var mode_num : int = 0
export var chance_of_drop : float = 0.40

func _ready():
	randomize()
	mode = mode_num


func calculate_hp(attack):
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
	hp = hp - attack
	if hp <= 0 :
		destroyed()


func destroyed():
	# TODO Add random drop chance
	if $Timer.is_stopped():
		$AnimationPlayer.play("brokenpot")
		$Sprite.queue_free()
		$CollisionShape2D.queue_free()
		$Timer.start()
		
		var item_drop = randf()
		if item_drop < chance_of_drop:
			get_tree().call_group("levelmanager", "spawn_coin", position)
		
		


func _on_Timer_timeout():
	queue_free()
