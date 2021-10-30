extends Area2D

signal activate

export(int) var value

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var entered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.animation = "off"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and entered:
		$Button.animation = "on"
		$Pointer/CollisionShape2D.set_deferred("disabled", true)
		$Pointer/Pointer.hide()
		$AudioStreamPlayer2D.play()
		emit_signal("activate")
	

func reset_switch():
	set_process(true)
	$Button.animation = "off"
	$Pointer/CollisionShape2D.set_deferred("disabled", false)

func _on_Pointer_body_entered(body):
	$Pointer/Pointer.show()
	entered = true
	

func _on_Pointer_body_exited(body):
	$Pointer/Pointer.hide()
	entered = false
