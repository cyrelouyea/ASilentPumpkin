extends Light2D


export var initial_rad: float
export var offset_rad: float
export var speed_rad: float
var sc_offset = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = Vector2(
		initial_rad + offset_rad * cos(sc_offset * speed_rad),
		initial_rad + offset_rad * cos(sc_offset * speed_rad)
	)
	sc_offset += delta
