extends StaticBody2D

signal leave

func _ready():
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.animation = 'open'


func open():
	$AnimatedSprite.animation = 'open'
	$AnimatedSprite.play()
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$AudioStreamPlayer2D.play()


func _on_Area2D_body_entered(body):
	$AnimatedSprite.animation = 'cry'
	$AnimatedSprite.play()
	$Area2D/CollisionShape2D.set_deferred("disabled", true)


func _on_Area2D2_body_entered(body):
	emit_signal("leave")
