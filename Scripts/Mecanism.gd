extends AnimatedSprite

signal activate

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entered = false
export(String) var color

# Called when the node enters the scene tree for the first time.
func _ready():
	animation = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") and GlobalData.has_item("eyeball_" + color) and entered:
		play()
		GlobalData.remove_item("eyeball_" + color)
		emit_signal("activate")
		$AudioStreamPlayer2D.play()
		$Pointer/CollisionShape2D.set_deferred("disabled", true)
		$Pointer/Pointer.hide()
		set_process(false)


func _on_Pointer_body_entered(body):
	$Pointer/Pointer.show()
	entered = true
	

func _on_Pointer_body_exited(body):
	$Pointer/Pointer.hide()
	entered = false
