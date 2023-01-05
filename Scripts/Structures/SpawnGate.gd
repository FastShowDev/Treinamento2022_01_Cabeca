extends AnimatedSprite

onready var main = get_parent().get_parent()
const door_type: String = "SpawnGate"
var is_open: bool = false
var is_player_inside: bool = false

onready var anim = $AnimetedSprite

func _ready():
	is_player_inside = false
	self.playing = false
	self.frame = 0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and is_player_inside and not is_open:
		is_open = true
		self.frame = 1
	elif event.is_action_pressed("interact_item") and is_open and is_player_inside:
		if(main.loading_room):
			return
		
		print("Entrando na dungeon!!!")
		main.loading_room = true
		main.door_type  = self.door_type;
		get_tree().change_scene("res://Scenes/DungeonRooms/DungeonRoom0.tscn")
		
func _on_Area2D_body_entered(body) -> void:
	if body.name == "Player":
		is_player_inside = true

func _on_Area2D_body_exited(body) -> void:
	if body.name == "Player":
		is_player_inside = false
