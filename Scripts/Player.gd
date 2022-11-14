extends KinematicBody2D

#Player physics
var speed = 175
var velocity = Vector2.ZERO

#Resources
var stats := Character.new()
var _save := SaveGameAsJSON.new()
var map := Map.new()

#Components:
onready var animated_sprite = $AnimatedSprite
onready var animation = $AnimationPlayer

onready var damage_sound = $Sounds/DamageFX
onready var hit_sound = $Sounds/HitFX
onready var walk_sound = $Sounds/WalkFX

onready var collision = $AttackArea/CollisionShape2D
onready var timer = $DamageDelay
onready var ui = $"%UserInterface"
onready var bar = $"%DialogBar"

var BOMB: PackedScene = preload("res://Models/Itens/Bomb.tscn")
const save_path: String = "C://Users//zlFas//Documents//Saves//player.json" 

#Permissions:
var can_attack: bool = false
var player_direction: Vector2 = Vector2(1,0)
var can_take_damage: bool = true
var can_play_sound: bool = false

func _ready():
	pass

func _process(delta: float) -> void:
	#print("Vida atual: " + hearts as String)
	pass


func _physics_process(delta: float) -> void:
	move()
	verify_direction()
	attack()
	animate()
	use_bomb()
	#print("Numero de bombas: " + bombs as String)
	
	
func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	velocity = direction_vector * stats.speed
	velocity = move_and_slide(velocity)


func verify_direction() -> void:
	if velocity.x > 0:
		player_direction = Vector2(1,0)
	elif velocity.x < 0:
		player_direction = Vector2(-1,0)
	elif velocity.y > 0:
		player_direction = Vector2(0,1)
	elif velocity.y < 0:
		player_direction = Vector2(0,-1)


func attack() -> void:
	if Input.is_action_just_pressed("attack") and not can_attack and not bar.is_opened:
		can_attack = true


func animate() -> void:
	if can_attack:
		set_physics_process(false)
		hit_sound.play()
		if player_direction.x == 1:
			animation.play("attack_right")
		if player_direction.x == -1:
			animation.play("attack_left")
		if player_direction.y == 1:
			animation.play("attack_down")
		if player_direction.y == -1:
			animation.play("attack_up")
		yield(animation, "animation_finished")
		set_physics_process(true)
		can_attack = false
	elif velocity != Vector2.ZERO:
		if velocity.x > 0:
			animation.play("move_right")
		elif velocity.x < 0:
			animation.play("move_left")
		elif velocity.y > 0:
			animation.play("move_down")
		elif velocity.y < 0:
			animation.play("move_up")
		play_walk_sound()
	else:
		animation.stop()
		walk_sound.stop()
		if player_direction.x == 1:
			animated_sprite.play("idle_right")
		elif player_direction.x == -1:
			animated_sprite.play("idle_left")
		elif player_direction.y == 1:
			animated_sprite.play("idle_down")
		elif player_direction.y == -1:
			animated_sprite.play("idle_up")
		can_play_sound = true

func play_walk_sound() -> void:
	if can_play_sound:
		walk_sound.playing = true
		can_play_sound = false

	
func increase_max_heart() -> void:
	stats.max_hearts += 1


func collect_heart() -> void:
	if stats.hearts >= stats.max_hearts:
		return
	else:
		stats.hearts += 1
		ui.set_heart_value(stats.hearts)
		
		
func collect_coin() -> void:
	stats.coins += 1
	ui.set_coin_value(stats.coins)


#Bomb functions:
func collect_bomb() -> void:
	print("Coletei!")
	stats.bombs += 1
	ui.set_bomb_value(stats.bombs)
	
	
func use_bomb() -> void:
	if Input.is_action_just_pressed("use_item") and stats.bombs > 0:
		print("Usando bomba!")
		stats.bombs -= 1
		ui.set_bomb_value(stats.bombs)
		var bomb = BOMB.instance()
		owner.get_node("Instances").add_child(bomb)
		bomb.exploding = true
		bomb.position = global_position
		bomb.explode()


func collect_key() -> void:
	stats.keys += 1
	ui.set_key_value(stats.keys)
	
func use_key() -> void:
	stats.keys -= 1
	ui.set_key_value(stats.keys)

#Player status functions:
func load_stats(data: Dictionary) -> void:
	set_physics_process(false)
	stats.global_position = Vector2(data.x, data.y)
	self.global_position = stats.global_position
	stats.max_hearts = data.max_hearts
	stats.hearts = data.hearts
	stats.coins = data.coins
	stats.bombs = data.bombs
	stats.keys = data.keys
	stats.speed = data.speed
	set_physics_process(true)

func get_actual_stats() -> Character:
	stats.global_position = self.global_position
	return stats
	
func set_stats_to_default():
	global_position = Vector2(143,199)
	stats.bombs = 10
	stats.coins = 10
	stats.keys = 10
	stats.hearts = 10

func get_stats() -> Character:
	return stats

func kill():
	set_physics_process(false)
	animation.stop()	
	if player_direction.x == 1:
		animation.play("die_right")
	elif player_direction.x == -1:
		animation.play("die_left")
	elif player_direction.y == 1:
		animation.play("die_down")
	elif player_direction.y == -1:
		animation.play("die_up")
		
	yield(animation, "animation_finished")
	set_stats_to_default()
	get_tree().reload_current_scene()
	
func damage() -> void:
	if can_take_damage:
		stats.hearts -= 1
		damage_sound.playing = true
		damage_sound.play()
		ui.set_heart_value(stats.hearts)
		if stats.hearts <= 0:
			kill()
		can_take_damage = false
		timer.start()
		yield(timer, "timeout")
		can_take_damage = true


func _on_DamageArea_area_entered(area):
	if area.is_in_group("damage"):
		damage()


func _on_WalkFX_finished():
	can_play_sound = true
