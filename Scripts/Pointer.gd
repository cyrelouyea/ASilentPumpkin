extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var offset_pos = 0
var offset_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = round(-16 + 2 * cos(offset_pos * offset_speed))
	offset_pos += delta
