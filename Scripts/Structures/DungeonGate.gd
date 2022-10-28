extends AnimatedSprite

var is_open: bool = false
var is_player_inside: bool = false

onready var interact_baloom = $StaticBody2D/InteractBaloom
onready var player = $"%Player"

#var _player := Character.new()
var _save := SaveGameAsJSON.new()

var dungeon_room_path: String = "res://Scenes/DungeonRooms/DungeonRoom0.tscn"

func _ready():
	interact_baloom.hide()
	_save.character = player.get_actual_stats()
	is_player_inside = false
	self.playing = false
	self.frame = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and is_player_inside and player.stats.keys > 0 and not is_open:
		player.stats.keys -= 1
		is_open = true
		interact_baloom.hide()
		self.frame = 1
	elif event.is_action_pressed("interact_item") and is_open:
		_save.character = player.get_actual_stats()
		_save.write_savegame()
		get_tree().change_scene(dungeon_room_path)
		
func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player" and not is_open:
		is_player_inside = true
		interact_baloom.show()

func _on_Area2D_body_exited(body) -> void:
	if body.name == "Player" and not is_open:
		is_player_inside = false
		interact_baloom.hide()
