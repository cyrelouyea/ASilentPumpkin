extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entered = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") and entered:
		$AnimatedSprite.animation = "collected"
		GlobalData.add_item("eyeball_blue")
		$Eyeball/CollisionShape2D.set_deferred("disabled", true)
		$AudioStreamPlayer2D2.play()
		$Eyeball/Pointer.hide()
		set_process(false)


func _on_Eyeballs_body_entered(body):
	$CollisionShape2D.set_deferred("disabled", true)
	$AudioStreamPlayer2D.play()
	$AnimatedSprite.play()

func _on_Eyeball_body_entered(body):
	$Eyeball/Pointer.show()
	entered = true
	

func _on_Eyeball_body_exited(body):
	$Eyeball/Pointer.hide()
	entered = false
