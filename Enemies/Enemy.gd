extends RigidBody2D

export var hp : int = 5
export var damage : int = 2
export var chance_of_coin_drop : float = 0.0

var invunerable : bool = false

func _ready():
	$HPLabel.text = str(hp)

func calculate_hp(attack) -> void:
	if not invunerable:
		#Knockback
		linear_velocity.y -= 30
		
		$AnimationPlayer.play("damage")
		var invunerable_timer = Timer.new()
		invunerable_timer.one_shot = true
		invunerable_timer.connect("timeout",self,"_on_timer_timeout")
		add_child(invunerable_timer)
		invunerable_timer.start(1)
		invunerable = true
		hp = hp - attack
		$HPLabel.text = str(hp)
		if hp <= 0 :
			var item_drop = randf()
			if item_drop < chance_of_coin_drop:
				get_tree().call_group("levelmanager", "spawn_coin", position)
			kill()

func kill():
	#Also add money drop or other drops later
	queue_free()

func do_damage():
	get_tree().call_group("player", "take_damage", damage, position)


func _on_timer_timeout():
	invunerable = false
