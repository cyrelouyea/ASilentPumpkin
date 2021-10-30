extends Node2D

signal end_stage

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2.modulate = Color(0, 0, 0, 1)
	$Sprite3.modulate = Color(0, 0, 0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if counter < 200:
		pass
	elif counter < 500:
		$Sprite2.modulate += Color(0.1, 0.1, 0.1, 0.0) * delta * 10
	elif counter < 800:
		$Sprite2.modulate -= Color(0.1, 0.1, 0.1, 0.0) * delta * 10
	elif counter < 1100:
		$Sprite3.modulate += Color(0.1, 0.1, 0.1, 0.0) * delta * 10
	elif counter < 1400:
		$Sprite3.modulate -= Color(0.1, 0.1, 0.1, 0.0) * delta * 10
	else:
		get_tree().quit()
		
	counter += delta * 100
