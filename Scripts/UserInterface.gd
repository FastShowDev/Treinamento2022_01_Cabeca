extends Control

onready var bomb_lb = $BombsLabel
onready var heart_lb = $HeartsLabel
onready var coin_lb = $CoinsLabel

func _ready():
	pass

func set_heart_value(value: int):
	heart_lb.text = value as String

func set_coin_value(value: int):
	coin_lb.text = value as String
	
func set_bomb_value(value: int):
	bomb_lb.text = value as String
