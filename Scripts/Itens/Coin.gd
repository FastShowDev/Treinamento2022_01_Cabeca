extends AnimatedSprite

onready var anim = $CoinAnimationPlayer
onready var sound = $CollectFX

var path: String = "res://Models/Itens/Coin.tscn"

func _ready():
	pass
	
func _physics_process(delta):
	anim.play("idle")

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.collect_coin()
		sound.playing = true
		self.visible = false
		yield(sound, "finished")
		queue_free()
