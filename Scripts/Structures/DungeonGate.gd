extends AnimatedSprite
class_name DungeonGate

var is_open: bool = false
var is_player_inside: bool = false

onready var interact_baloom = $StaticBody2D/InteractBaloom
onready var player = get_parent().get_parent().get_node("PlayerNode").get_node("Player")
onready var open_sound = $OpenFX
onready var transition_sound = $TransitionFX
onready var main = get_parent().get_parent()

var next_dungeon_path: String
var door_type: String


func load_gate() -> void:
	if is_open:
		self.frame = 1
	else:
		self.frame = 0
	interact_baloom.hide()
	#_save.character = player.get_actual_stats()
	is_player_inside = false
	self.playing = false

func open_gate() -> void:
	is_open = true
	self.frame = 1
	interact_baloom.hide()

func play_sound() -> void:
	open_sound.playing = true

func set_dungeon_data(path: String, dtype: String) -> void:
	next_dungeon_path = path
	self.door_type = dtype
	load_gate()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and is_player_inside and player.stats.keys > 0 and not is_open:
		player.use_key()
		is_open = true
		play_sound()
		interact_baloom.hide()
		self.frame = 1
	elif event.is_action_pressed("interact_item") and is_open and is_player_inside:
		transition_sound.playing = true
		main.loading_room = true
		main.door_type = self.door_type
		print("Indo para: " + next_dungeon_path)
		yield(transition_sound, "finished")
		get_tree().change_scene(next_dungeon_path)
		
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
