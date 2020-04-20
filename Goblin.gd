extends "res://Enemies/Enemy.gd"

var motion : Vector2 = Vector2(0,0)
var speed : int = 10

func _ready():
	#set kinematic mode
	mode = 2


func _process(delta):
	if motion.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false


func _physics_process(delta):
	motion.y = 0
	linear_velocity = motion


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		do_damage()


func _on_MoveTimer_timeout():
	var direction = randf()
	if direction < 0.5 :
		$"Dagger Pivot".rotation_degrees = 0
		motion.x = -speed
	else:
		$"Dagger Pivot".rotation_degrees = 180
		motion.x = speed
		

func _on_AttackTimer_timeout():
	if not $AttackAnimPlayer.is_playing():
		$AttackAnimPlayer.play("Attack")
