extends Node2D

signal end_stage

var max_size = 5 # 5
var expected_order_1 = [45, 0, 270, 315, 90]
var expected_order_2 = [45, 90, 270, 180, 225]
var order = []
var order_1_found = false
var order_2_found = false
var lag_open_door = 100
var time_disappear = 100
var time_appear = 100
var is_ending = false
var is_open_door = false
var is_fully_opened = false
var is_starting = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Before/Eyeball.hide()
	$Before/Eyeball/Eyeball/CollisionShape2D.set_deferred("disabled", true)	
	$Before/Eyeball2.hide()
	$Before/Eyeball2/Eyeball/CollisionShape2D.set_deferred("disabled", true)
	modulate = Color(0, 0, 0, 1)	

func _process(delta):
	if order.size() == max_size:
		if expected_order_1 == order && !order_1_found:
			$Before/Sprite.animation = "after"
			$Before/Eyeball.show()
			$Before/Eyeball/Eyeball/CollisionShape2D.set_deferred("disabled", false)
			order_1_found = true
			$Before/Sprite/AudioStreamPlayer2D.play()
		elif expected_order_2 == order && !order_2_found:
			$Before/Eyeball2.show()
			$Before/Eyeball2/Eyeball/CollisionShape2D.set_deferred("disabled", false)
			order_2_found = true
			$Before/Sprite/AudioStreamPlayer2D.play()
			
	if order_1_found && order_2_found:
		$Before/Sprite.animation = "shutup"
		
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
		


func add_to_order(angle: int):
	order.append(angle)
	if order.size() > max_size:
		order.remove(0)


func _on_Area2D_activate(value: int):
	add_to_order(value)


func _on_Mecanisme_activate():
	is_open_door = true
	
func _on_Door_leave():
	is_ending = true
