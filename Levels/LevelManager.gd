extends Node2D

const COIN = preload("res://Coins/Coin.tscn")

func spawn_coin(spawn_position):
	var coin = COIN.instance()
	coin.position = spawn_position
	add_child(coin)
