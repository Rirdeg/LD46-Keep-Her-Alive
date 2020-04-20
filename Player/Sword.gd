extends Node2D

func _ready():
	$Sprite.scale.y = Global.sword

func _on_Area2D_body_entered(body):
	body.calculate_hp(Global.attack_damage)
