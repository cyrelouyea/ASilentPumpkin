extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Alpaca_body_entered(body):
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play()
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D2.play()
