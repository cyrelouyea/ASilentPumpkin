extends Node2D

signal end_stage

var expected_order = [1, 2, 3, 4, 5]
var order = []
var lag_result = 100
var lag_open_door = 100
var is_open_door = false
var time_disappear = 100
var time_appear = 100
var is_ending = false
var is_fully_opened = false
var is_starting = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Before/Eyeball.hide()
	$Before/Eyeball/Eyeball/CollisionShape2D.set_deferred("disabled", true)
	modulate = Color(0, 0, 0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if order.size() == 5:
		lag_result -= 100 * delta
	
	if lag_result < 0:
		if order == expected_order:
			$Before/Alpaca.queue_free()
			$Before/Eyeball.show()
			$Before/Eyeball/Eyeball/CollisionShape2D.set_deferred("disabled", false)
			$AudioStreamPlayer2D.play()
		else:
			$Before/Portrait_1/Button_1.reset_switch()
			$Before/Portrait_2/Button_2.reset_switch()
			$Before/Portrait_3/Button_3.reset_switch()
			$Before/Portrait_4/Button_4.reset_switch()
			$Before/Portrait_5/Button_5.reset_switch()
			# play KO sound
		order.clear()
		lag_result = 100
		
	if is_open_door and !is_fully_opened:
		lag_open_door -= 100 * delta
		if lag_open_door < 0:
			$Before/Door.open()
			is_fully_opened = true
			
	if is_starting:
		time_appear -= 100 * delta
		modulate += Color(0.1, 0.1, 0.1, 0.0) * delta * 10
		modulate.r = min(modulate.r, 1)
		modulate.g = min(modulate.g, 1)
		modulate.b = min(modulate.b, 1)
		if time_appear < 0:
			is_starting = false
			
	if is_ending:
		time_disappear -= 100 * delta
		modulate *= Color(0.95, 0.95, 0.95, 1.0) 
		if time_disappear < 0:
			emit_signal("end_stage")



func _on_Button_1_activate():
	order.append(1)


func _on_Button_2_activate():
	order.append(2)


func _on_Button_3_activate():
	order.append(3)


func _on_Button_4_activate():
	order.append(4)


func _on_Button_5_activate():
	order.append(5)


func _on_Alpaca_body_entered(body):
	$Before/Portrait_1.play()
	$Before/Portrait_2.play()
	$Before/Portrait_3.play()
	$Before/Portrait_4.play()
	$Before/Portrait_5.play()
	$Before/Alpaca.disconnect("body_entered", self, "_on_Alpaca_body_entered")
	
func _on_Mecanisme_activate():
	is_open_door = true
	
func _on_Door_leave():
	is_ending = true
