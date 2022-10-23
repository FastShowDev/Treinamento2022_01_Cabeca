extends AnimatedSprite

var drop = preload("res://Models/Itens/Bomb.tscn")
var object_scene: PackedScene

var is_open: bool = false
var is_player_inside: bool = false

onready var interact_baloom = $InteractBaloom
onready var tween = $Tween

func _ready():
	self.playing = false
	self.frame = 0
	interact_baloom.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact_item") and is_player_inside and not is_open:
		is_open = true
		interact_baloom.hide()
		self.frame = 1
		drop_object()

func drop_object() -> void:
	#var object = drop.instance()
	var drop2 = drop.instance()
	#var object = object_scene.instance()
	#owner.get_node("Bombs").add_child(object)
	owner.get_node("YSort").add_child(drop2)
	tween.interpolate_property(drop2, "position", position + Vector2(20,0), position + Vector2(20, +10), 0.3, Tween.TRANS_QUAD,
								Tween.EASE_OUT)
	tween.start()
	
	yield(tween, "tween_completed")
	
	tween.interpolate_property(drop2, "position", position + Vector2(20,0), position + Vector2(20,+10), 0.3, Tween.TRANS_SINE,
								Tween.EASE_IN)
	
	tween.start()	
		
func _on_Area2D_body_entered(_player: KinematicBody2D) -> void:
	if _player is KinematicBody2D and not is_open:
		is_player_inside = true
		interact_baloom.show()

func _on_Area2D_body_exited(_player: KinematicBody2D) -> void:
	if _player is KinematicBody2D and not is_open:
		is_player_inside = false
		interact_baloom.hide()