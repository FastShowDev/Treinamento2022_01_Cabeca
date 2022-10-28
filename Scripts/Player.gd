extends KinematicBody2D

#Stats + itens
var max_hearts: int = 6
var hearts: int = 2
var keys: int  = 0
var coins: int = 0
var bombs: int = 0

#Player physics
var speed = 175
var velocity = Vector2.ZERO

#Resources
var stats:= Character.new()
var _save:= SaveGameAsJSON.new()

#Components:
onready var animated_sprite = $AnimatedSprite
onready var animation = $AnimationPlayer
onready var collision = $AttackArea/CollisionShape2D
onready var timer = $DamageDelay
onready var ui = $"%UserInterface"
onready var bar = $"%DialogBar"

export var BOMB: PackedScene

#Permissions:
var can_attack: bool = false
var player_direction: Vector2 = Vector2(1,0)
var can_take_damage: bool = true

func _ready():
	animated_sprite.visible = true
	animated_sprite.modulate = Color(1,1,1,1)
	#ui.set_coin_value(coins)
	#ui.set_heart_value(hearts)
	#ui.set_bomb_value(bombs)
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
	else:
		animation.stop()
		if player_direction.x == 1:
			animated_sprite.play("idle_right")
		elif player_direction.x == -1:
			animated_sprite.play("idle_left")
		elif player_direction.y == 1:
			animated_sprite.play("idle_down")
		elif player_direction.y == -1:
			animated_sprite.play("idle_up")
			
			
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
		get_parent().add_child(bomb)
		get_parent().call_deferred("add_child", bomb)
		bomb.exploding = true
		bomb.scale.x = 1
		bomb.scale.y = 1
		bomb.position = global_position
		bomb.explode()


func update_key_score(key: int) -> void:
	pass


func collect_key() -> void:
	stats.keys += 1
	update_key_score(stats.keys)

#Player status functions:
func set_stats(new_stats: Character) -> void:
	set_physics_process(false)
	stats.global_position = new_stats.global_position
	self.global_position = new_stats.global_position
	stats.max_hearts = new_stats.max_hearts
	stats.hearts = new_stats.hearts
	stats.bombs = new_stats.bombs
	stats.keys = new_stats.keys
	stats.speed = new_stats.speed
	stats.coins = new_stats.coins
	set_physics_process(true)
	
func get_actual_stats() -> Character:
	stats.global_position = self.global_position
	return stats
	
func set_stats_to_default():
	global_position = Vector2(143,199)
	stats.bombs = 0
	stats.coins = 0
	stats.keys = 0
	stats.hearts = 1

func get_stats() -> Character:
	return stats

func kill():
	set_physics_process(false)
	animation.stop()
	#_save.character = stats
	
	#_save.write_savegame()
	
	#yield(_save, "save_completed")
	
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
		ui.set_heart_value(stats.hearts)
		if stats.hearts == 0:
			kill()
		can_take_damage = false
		timer.start()
		yield(timer, "timeout")
		can_take_damage = true

func _on_DamageArea_area_entered(area):
	if area.is_in_group("damage"):
		damage()
