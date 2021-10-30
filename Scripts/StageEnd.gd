extends Node2D

signal end_stage

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Script) var end_script

var is_starting = true
var time_appear = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(0, 0, 0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_starting:
		time_appear -= 100 * delta
		modulate += Color(0.1, 0.1, 0.1, 0.0) * delta * 10
		modulate.r = min(modulate.r, 1)
		modulate.g = min(modulate.g, 1)
		modulate.b = min(modulate.b, 1)
		if time_appear < 0:
			is_starting = false

func _on_Knife_body_entered(body):
	$Player.set_script(end_script)
	$Player.notification(NOTIFICATION_READY)
	$Player.connect("end_stage", self, "_on_end_stage")
	
func _on_end_stage():
	emit_signal("end_stage")


