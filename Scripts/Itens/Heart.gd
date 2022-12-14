extends AnimatedSprite

onready var animation_player = $HeartAnimationPlayer
onready var sound = $CollectFX

var path: String = "res://Models/Itens/Heart.tscn"

func _ready():
	pass
	
func _physics_process(delta):
	animation_player.play("idle")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.collect_heart()
		sound.playing = true
		self.visible = false
		yield(sound, "finished")
		queue_free()
