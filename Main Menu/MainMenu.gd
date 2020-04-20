extends Control

func _ready():
	$Panel.visible = false

func _on_PlayButton_pressed():
	reset_game()


func _on_InstButton_pressed():
	$Panel.visible = true


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_Button_pressed():
	$Panel.visible = false


func reset_game():
	Global.reset_game()
	get_tree().change_scene("res://Levels/Home.tscn")
