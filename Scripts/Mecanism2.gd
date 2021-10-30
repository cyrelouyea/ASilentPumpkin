extends AnimatedSprite

signal activate

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entered = false
export(String) var color
var nb_eyeballs = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	animation = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") and GlobalData.has_item("eyeball_" + color) and entered:
		GlobalData.remove_item("eyeball_" + color)
		$AudioStreamPlayer2D.play()
		nb_eyeballs += 1
		frame += 1
		
	if nb_eyeballs == 2:
		play()
		emit_signal("activate")
		$Pointer/CollisionShape2D.set_deferred("disabled", true)
		$Pointer/Pointer.hide()
		set_process(false)


func _on_Pointer_body_entered(body):
	$Pointer/Pointer.show()
	entered = true
	

func _on_Pointer_body_exited(body):
	$Pointer/Pointer.hide()
	entered = false
