extends Node2D

onready var health_bar = $CanvasLayer/StatBars/VBoxContainer/HBoxContainer/HealthProgress
onready var warmth_bar = $CanvasLayer/StatBars/VBoxContainer/HBoxContainer2/WarmthProgress
onready var hunger_bar = $CanvasLayer/StatBars/VBoxContainer/HBoxContainer3/HungerProgress

var day1 = "I cant go no further today"
var day2 = "Its not getting any better"
var day3 = "This is really keeping me down"
var day4 = "This trip is not what I expected"
var day5 = "I hope i'm over the worst of it'"

func _ready():
	health_bar.value = Global.health
	warmth_bar.value = Global.warmth
	hunger_bar.value = Global.hunger
	change_text()
	



func change_text():
	if Global.level == 1:
		$CanvasLayer/ColorRect/RichTextLabel.text = day1
	if Global.level == 2:
		$CanvasLayer/ColorRect/RichTextLabel.text = day2
	if Global.level == 3:
		$CanvasLayer/ColorRect/RichTextLabel.text = day3
	if Global.level == 4:
		$CanvasLayer/ColorRect/RichTextLabel.text = day4
	if Global.level == 5:
		$CanvasLayer/ColorRect/RichTextLabel.text = day5


func _on_Button_pressed():
	get_tree().change_scene("res://Levels/Level" + str(Global.level) + ".tscn")
