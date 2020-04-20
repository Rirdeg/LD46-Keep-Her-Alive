extends "res://Enemies/Enemy.gd"

#Don't place on raised platforms

var motion : Vector2 = Vector2(0,0)
var speed : int = 10

func _ready():
	#Set kinematic body mode
	mode = 2
	randomize()
	
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		do_damage()


func _process(delta):
	if motion.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
		



func _physics_process(delta):
	motion.y = 0
	linear_velocity = motion



func _on_Timer_timeout():
	if not $AttackAnimPlayer.is_playing() and $Sprite.flip_h:
		$AttackAnimPlayer.play("AttackRight")
	elif not $AttackAnimPlayer.is_playing():
		$AttackAnimPlayer.play("AttackLeft")


func _on_MoveTimer_timeout():
	var direction = randf()
	if direction < 0.5 :
		$"Hammer Pivot".rotation_degrees = 15.6
		motion.x = -speed
	else:
		$"Hammer Pivot".rotation_degrees = 138
		motion.x = speed
		
