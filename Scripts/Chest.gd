extends AnimatedSprite

var is_open: bool = false
var is_player_inside: bool = false

onready var anim = $AnimetedSprite

func _ready():
	get_parent().get_node("Chest").playing = false
	get_parent().get_node("Chest").frame = 0

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and is_player_inside and not is_open:
		is_open = true
		get_parent().get_node("Chest").frame = 1


func _on_Area2D_player_entered(_player: KinematicBody2D) -> void:
	is_player_inside = true

func _on_Area2D_player_exited(_player: KinematicBody2D) -> void:
	is_player_inside = false
