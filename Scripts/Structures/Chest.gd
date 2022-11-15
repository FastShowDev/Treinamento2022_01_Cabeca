extends AnimatedSprite

var drop_path: Array = ["res://Models/Itens/Heart.tscn", 
						"res://Models/Itens/Bomb.tscn",
						"res://Models/Itens/Key.tscn",
						"res://Models/Itens/Coin.tscn"
						 ]
var drop_list: Array #[heart, bomb, key, coin]
var object = preload("res://Models/Itens/Bomb.tscn")
var object2 = preload("res://Models/Itens/Key.tscn")
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
	var i: int  = 0
	for ammount in drop_list:
		while ammount > 0:
			var drop: PackedScene = load(drop_path[i])
			var object = drop.instance()
			owner.get_node("Drops").add_child(object)
			var pos = randi() % 200 - 100
			play_drop_animation(object, position, pos)
			ammount -= 1
		i += 1
#	#var object = drop.instance()
#	var drop1 = object.instance()
#	var drop2 = object2.instance()
#	#var object = object_scene.instance()
#	#owner.get_node("Bombs").add_child(object)
#	owner.get_node("Drops").add_child(drop1)
#	owner.get_node("Drops").add_child(drop2)
#	play_drop_animation(drop1, position, 10)
#	play_drop_animation(drop2, position, 50)	


func play_drop_animation(drop, position: Vector2, offset: float) -> void:
	tween.interpolate_property(drop, "position", position + Vector2(20,0), position + Vector2(offset, 0), 0.3, Tween.TRANS_QUAD,
								Tween.EASE_OUT)
	tween.start()
	
	
func _on_Area2D_body_entered(_player: KinematicBody2D) -> void:
	if _player.name == "Player" and not is_open:
		is_player_inside = true
		interact_baloom.show()

func _on_Area2D_body_exited(_player: KinematicBody2D) -> void:
	if _player.name == "Player" and not is_open:
		is_player_inside = false
		interact_baloom.hide()
