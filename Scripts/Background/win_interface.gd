extends Control
class_name WinText

onready var tween: Tween = get_node("Tween")
var value: int
var mass: int = 20

var velocity: Vector2
var gravity: Vector2 = Vector2.UP

func _ready():
	randomize()
	#Inicial random impulse
	velocity = Vector2(
		rand_range(-10,10),
		-30
	)
	
	interpolate()

func interpolate() -> void:
	#Diminui a visibilidade
	var _interpolate_modulate = tween.interpolate_property(
		self,
		"modulate:a",
		1.0,
		0.0,
		0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT,
		4.0
	)
	#Invoca o label aumentando a escala
	var _interpolate_scale_up = tween.interpolate_property(
		self,
		"rect_scale",
		Vector2(0.0, 0.0),
		Vector2(1.0, 1.0),
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT
	)
	#Diminui a escala dele
	var _interpolate_scale_down = tween.interpolate_property(
		self,
		"rect_scale",
		Vector2(1.0, 1.0),
		Vector2(0.4, 0.4),
		1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT,
		3.5
	)
	
	var _start = tween.start()
	yield(tween, "tween_all_completed")
	queue_free()

func _process(delta):
	#Aplica o impulso inicial
	velocity += gravity * mass * delta
	rect_position += velocity * delta
