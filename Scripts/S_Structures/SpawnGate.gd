extends AnimatedSprite

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
		print("Entrando na dungeon!!!")
		pass
		
func _on_Area2D_body_entered(_player: KinematicBody2D) -> void:
	if _player is KinematicBody2D:
		is_player_inside = true

func _on_Area2D_body_exited(_player: KinematicBody2D) -> void:
	if _player is KinematicBody2D:
		is_player_inside = false
