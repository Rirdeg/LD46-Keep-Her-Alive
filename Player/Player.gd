extends KinematicBody2D
#PLAYER CONTROLLER
const UP : Vector2 = Vector2(0,-1)

#player vars
var max_hitpoints : int = Global.player_hp
var hit_points : int = 0
var invunerable : bool = false

#movement vars
var motion : Vector2 = Vector2(0,0)
var move_speed : int = 4500
var jump_strength : int = 100
var gravity : int = 5

onready var sword = $Sword

func _ready():
	hit_points = max_hitpoints
	
	$CanvasLayer/UI/HPBar.max_value = hit_points
	$CanvasLayer/UI/HPBar.value = hit_points
	update_hp_label()
	update_coin_amount()


func _process(_delta):
	handle_sword()


func _physics_process(delta):
	handle_movement(delta)
	handle_jump()
	apply_gravity()
	motion = move_and_slide(motion,UP)


func handle_movement(delta) -> void:
	if Input.get_action_strength("move_left") and not Input.get_action_strength("move_right"):
		motion.x = -move_speed * delta
	elif Input.get_action_strength("move_right") and not Input.get_action_strength("move_left"):
		motion.x = move_speed * delta
	else:
		motion.x = 0
	if motion.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.playing = true
	elif motion.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.playing = true
	else:
		$AnimatedSprite.playing = false


func handle_jump() -> void:
	if Input.get_action_strength("jump") and is_on_floor():
		motion.y -= jump_strength


func apply_gravity() -> void:
	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += gravity


func handle_sword() -> void:
	sword.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("attack") and not $Sword/AnimationPlayer.is_playing(): 
		$Sword/AnimationPlayer.play("attack")
		$Sword/AudioStreamPlayer2D.play()


func take_damage(damage, enemy_position) -> void:
	if not invunerable:
		#Knockback
		var knockback : Vector2 = position - enemy_position.normalized()
		knockback = -knockback 
		motion = motion + knockback
		#adjust hp
		invunerable = true
		$InvunerableTimer.start()
		hit_points = hit_points - damage
		update_hp_label()
		
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("damage")
			$AudioStreamPlayer2D.play()
	
	
	if hit_points <= 0:
		game_over()


func update_hp_label():
	$CanvasLayer/UI/HPBar.value = hit_points
	$CanvasLayer/UI/HPLabel.text = str(hit_points) + "/" + str(max_hitpoints)


func update_coin_amount():
	$CanvasLayer/UI/HBoxContainer/CoinAmount.text = str(Global.gold)


func game_over():
	if Global.gold > 10:
		Global.gold = Global.gold - 10
	else:
		Global.gold = 0
	$DeathTimer.start()
	$CanvasLayer/Popup.show()
	get_tree().paused = true
	


func _on_InvunerableTimer_timeout():
	invunerable = false


func end_of_level():
	get_tree().change_scene("res://Shop/Shop.tscn")


func _on_DeathTimer_timeout():
	get_tree().paused = false
	$CanvasLayer/Popup.hide()
	get_tree().reload_current_scene()
