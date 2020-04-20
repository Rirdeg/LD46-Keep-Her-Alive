extends Node

var level = 1
var market_increase = 15

#player stats
const starting_damage = 2
var attack_damage = 2
var starting_hp = 5
var player_hp = 5
var starting_swd = 1
var sword = 1
var gold = 0

#Home upgrades
var medicine_strength = 30
var medicine_cost = 15
var blanket_strength = 30
var blanket_cost = 15
var food_strength = 30
var food_cost = 15

#Player Upgrades
var hp_upg_cost = 10
var atk_upg_cost = 10
var swd_upg_cost = 10


#girl stats
var decay = 35
var health = 100
var warmth = 100
var hunger = 100

func use_medicine():
	if gold >= medicine_cost:
		gold = gold - medicine_cost
		medicine_cost = medicine_cost + market_increase
		if health < 100:
			health = clamp(health + medicine_strength, 0, 100)
	print(health)


func use_blankets():
	if gold >= blanket_cost:
		gold = gold - blanket_cost
		blanket_cost = blanket_cost + market_increase
		if warmth < 100:
			warmth = clamp(warmth + blanket_strength, 0, 100)
	print(warmth)


func use_food():
	if gold >= food_cost:
		gold = gold - food_cost
		food_cost = food_cost + market_increase
		if hunger < 100:
			hunger = clamp(hunger + food_strength, 0, 100)
	print(hunger)


func calculate_stats():
	health = health - decay
	warmth = warmth - decay
	hunger = hunger - decay


func check_game_over():
	if health <= 0 or warmth <= 0 or hunger <= 0:
		game_over()
	


func game_over():
	get_tree().change_scene("res://Main Menu/GameOver.tscn")


func reset_game():
	level = 1
	attack_damage = 3
	medicine_cost = 15
	blanket_cost = 15
	food_cost = 15
	hp_upg_cost = 10
	atk_upg_cost = 10
	swd_upg_cost = 10
	health = 100
	warmth = 100
	hunger = 100
	gold = 0
	player_hp = starting_hp
	attack_damage = starting_damage
	sword = starting_swd


func hp_upgrade():
	player_hp = player_hp + 1
	hp_upg_cost = hp_upg_cost + 10

func atk_upgrade():
	attack_damage = attack_damage + 1
	atk_upg_cost = atk_upg_cost + 10

func swd_upgrade():
	sword = sword + 0.1
	swd_upg_cost = swd_upg_cost + 10


func load_home_scene():
	if level > 5:
		get_tree().change_scene("res://Main Menu/GameWon.tscn")
	else:
		get_tree().change_scene("res://Levels/Home.tscn")
