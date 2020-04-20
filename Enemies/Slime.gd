extends "res://Enemies/Enemy.gd"

var direction : int
var jump_strength : int = 50

func _ready() -> void:
	$HPLabel.text = str(hp)
	randomize()


func _on_Slime_body_entered(body) -> void:
	if body.is_in_group("player"):
		do_damage()

func move() -> void:
	linear_velocity = Vector2(direction, jump_strength)
	


func _on_Timer_timeout():
	direction = randi() % 2
	if direction == 0:
		direction = 32
	else:
		direction = -32
	move()
