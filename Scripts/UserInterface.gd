extends Control

onready var bomb_lb  = $BombIcon/BombsLabel
onready var heart_lb = $HeartIcon/HeartsLabel
onready var coin_lb = $CoinIcon/CoinsLabel
onready var player = $"%Player"

func _ready():
	if player != null:
		bomb_lb.text = player.bombs as String
		heart_lb.text = player.hearts as String
		coin_lb.text = player.coins as String
	
	
func set_heart_value(value: int):
	heart_lb.text = value as String

func set_coin_value(value: int):
	coin_lb.text = value as String
	
func set_bomb_value(value: int):
	bomb_lb.text = value as String