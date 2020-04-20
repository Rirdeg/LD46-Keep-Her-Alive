extends Node2D

#button variables
onready var med_button = $CanvasLayer/Control/VBoxContainer/HBoxContainer/ColorRect/CenterContainer/HBoxContainer/BuyMedicine
onready var bla_button = $CanvasLayer/Control/VBoxContainer/HBoxContainer/ColorRect2/CenterContainer2/HBoxContainer/BuyBlankets
onready var food_button = $CanvasLayer/Control/VBoxContainer/HBoxContainer/ColorRect3/CenterContainer3/HBoxContainer/BuyFood

onready var hp_upg = $CanvasLayer/Control/VBoxContainer/HBoxContainer2/ColorRect/CenterContainer4/HBoxContainer/HPUpg
onready var atk_upg = $CanvasLayer/Control/VBoxContainer/HBoxContainer2/ColorRect2/CenterContainer5/HBoxContainer/ATKUpg
onready var swd_upg = $CanvasLayer/Control/VBoxContainer/HBoxContainer2/ColorRect3/CenterContainer6/HBoxContainer/SWDUpg


func _ready():
	Global.calculate_stats()
	update_coin_total()
	update_button_status()


func update_coin_total():
	$CanvasLayer/Control/CoinTotal.text = str(Global.gold)


func update_button_status():
	med_button.text = str(Global.medicine_cost) +"g"
	bla_button.text = str(Global.blanket_cost) +"g"
	food_button.text = str(Global.food_cost) +"g"
	
	hp_upg.text = str(Global.hp_upg_cost) +"g"
	atk_upg.text = str(Global.atk_upg_cost) +"g"
	swd_upg.text = str(Global.swd_upg_cost) +"g"
	
	#Home buttons disabled
	if Global.gold < Global.medicine_cost:
		med_button.disabled = true
	elif Global.gold >= Global.medicine_cost:
		med_button.disabled = false
	if Global.gold < Global.blanket_cost:
		bla_button.disabled = true
	elif Global.gold >= Global.blanket_cost:
		bla_button.disabled = false
	if Global.gold < Global.food_cost:
		food_button.disabled = true
	elif Global.gold >= Global.food_cost:
		food_button.disabled = false
	
	#Player upgrade Buttons disabled
	if Global.gold < Global.hp_upg_cost:
		hp_upg.disabled = true
	elif Global.gold >= Global.hp_upg_cost:
		hp_upg.disabled = false
	if Global.gold < Global.atk_upg_cost:
		atk_upg.disabled = true
	elif Global.gold >= Global.atk_upg_cost:
		atk_upg.disabled = false
	if Global.gold < Global.swd_upg_cost:
		swd_upg.disabled = true
	elif Global.gold >= Global.swd_upg_cost:
		swd_upg.disabled = false
	

func _on_BuyMedicine_pressed():
	Global.use_medicine()
	update_coin_total()
	update_button_status()


func _on_BuyBlankets_pressed():
	Global.use_blankets()
	update_coin_total()
	update_button_status()


func _on_BuyFood_pressed():
	Global.use_food()
	update_coin_total()
	update_button_status()


func _on_DoneButton_pressed():
	Global.level = Global.level + 1
	print(Global.level)
	Global.check_game_over()
	Global.load_home_scene()



func _on_HPUpg_pressed():
	Global.hp_upgrade()
	update_coin_total()
	update_button_status()
	


func _on_ATKUpg_pressed():
	Global.atk_upgrade()
	update_coin_total()
	update_button_status()
	


func _on_SWDUpg_pressed():
	Global.swd_upgrade()
	update_coin_total()
	update_button_status()
