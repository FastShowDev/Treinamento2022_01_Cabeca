extends AnimatedSprite

var is_open: bool = false
var is_player_inside: bool = false

onready var interact_baloom = $StaticBody2D/InteractBaloom
onready var player = $"%Player"
onready var open_sound = $OpenFX
onready var transition_sound = $TransitionFX

#var _player := Character.new()
var _save := SaveGameAsJSON.new()

var dungeon_room_path: String = "res://Scenes/DungeonRooms/DungeonRoom0.tscn"

func _ready():
	interact_baloom.hide()
	_save.character = player.get_actual_stats()
	is_player_inside = false
	self.playing = false
	self.frame = 0

func open_gate() -> void:
	is_open = true
	self.frame = 1
	interact_baloom.hide()

func play_sound() -> void:
	open_sound.playing = true

func set_dungeon_path(path: String) -> void:
	dungeon_room_path = path

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and is_player_inside and player.stats.keys > 0 and not is_open:
		player.use_key()
		is_open = true
		play_sound()
		interact_baloom.hide()
		self.frame = 1
	elif event.is_action_pressed("interact_item") and is_open and is_player_inside:
		transition_sound.playing = true
		yield(transition_sound, "finished")
		_save.character = player.get_actual_stats()
		_save.write_savegame()
		get_tree().change_scene(dungeon_room_path)
		
func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		is_player_inside = true
		if not is_open:
			interact_baloom.show()

func _on_Area2D_body_exited(body) -> void:
	if body.name == "Player":
		is_player_inside = false
		if not is_open:
			interact_baloom.hide()


func _on_OpenFX_finished():
	open_sound.playing = false
