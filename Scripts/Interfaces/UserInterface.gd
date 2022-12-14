extends Control

onready var bomb_lb  = $Icons/BombIcon/BombsLabel
onready var heart_lb = $Icons/HeartIcon/HeartsLabel
onready var coin_lb = $Icons/CoinIcon/CoinsLabel
onready var key_lb = $Icons/KeyIcon/KeysLabel
onready var player = $"%Player"

#var stats: Character setget set_stats

func _ready():
	if player != null:
		bomb_lb.text = player.stats.bombs as String
		heart_lb.text = player.stats.hearts as String
		coin_lb.text = player.stats.coins as String
		key_lb.text = player.stats.keys as String
	
func set_heart_value(value: int):
	heart_lb.text = value as String

func set_coin_value(value: int):
	coin_lb.text = value as String
	
func set_bomb_value(value: int):
	bomb_lb.text = value as String

func set_key_value(value: int):
	key_lb.text = value as String

func set_values(new_character: Character) -> void:
	heart_lb.text = new_character.hearts as String
	bomb_lb.text = new_character.bombs as String
	coin_lb.text = new_character.coins as String
	key_lb.text = new_character.keys as String
