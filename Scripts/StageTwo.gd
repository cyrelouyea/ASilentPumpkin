extends Node2D


signal end_stage
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lag_open_door = 100
var time_disappear = 100
var time_appear = 100
var is_ending = false
var is_open_door = false
var is_fully_opened = false
var is_starting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(0, 0, 0, 1.0)

func _process(delta):
	if is_starting:
		time_appear -= 100 * delta
		modulate += Color(0.1, 0.1, 0.1, 0.0) * delta * 10
		modulate.r = min(modulate.r, 1)
		modulate.g = min(modulate.g, 1)
		modulate.b = min(modulate.b, 1)
		if time_appear < 0:
			is_starting = false
	
	if is_open_door and !is_fully_opened:
		lag_open_door -= 100 * delta
		if lag_open_door < 0:
			$Before/Door.open()
			is_fully_opened = true
		
	if is_ending:
		time_disappear -= 100 * delta
		modulate *= Color(0.95, 0.95, 0.95, 1.0) 
		if time_disappear < 0:
			emit_signal("end_stage")


func _on_Mecanisme_activate():
	is_open_door = true


func _on_Door_leave():
	is_ending = true


