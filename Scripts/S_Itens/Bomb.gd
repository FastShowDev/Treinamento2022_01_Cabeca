extends AnimatedSprite

var exploding: bool = false
onready var bomb_anim = $BombAnimation
onready var explosion = $ExplosionArea/ExplosionShape

func _ready():
	explosion.disabled = true
	pass


func _physics_process(delta):
	bomb_anim.play("idle")
	
	
func explode():
	set_physics_process(false)
	bomb_anim.stop()
	bomb_anim.play("explode")
	yield(bomb_anim, "animation_finished")
	queue_free()
	
	
func _on_Area2D_body_entered(body):
	if body.name == "Player" and not exploding:
		body.collect_bomb()
		queue_free()


func _on_BombAnimation_animation_finished(anim_name):
	#if(anim_name == "explode"):
		#queue_free()
	pass
	
