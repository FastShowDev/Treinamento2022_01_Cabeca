extends AnimatedSprite

var exploding: bool = false

onready var bomb_anim = $BombAnimation
onready var explosion_shape = $ExplosionArea/ExplosionShape

onready var explosion_sound = $ExplosionFX
onready var collect_sound = $CollectFX

func _ready():
	explosion_shape.disabled = true
	pass


func _physics_process(delta):
	bomb_anim.play("idle")
	
	
func explode():
	set_physics_process(false)
	self.scale.x = 2
	self.scale.y = 2
	bomb_anim.stop()
	bomb_anim.play("explode")
	yield(bomb_anim, "animation_finished")
	queue_free()
	

func _on_CollectArea_body_entered(body):
	if body.name == "Player" and not exploding:
		body.collect_bomb()
		collect_sound.play()
		self.visible = false
		yield(collect_sound, "finished")
		queue_free()
