extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
onready var _light = $AnimatedSprite/Candle

const LIGHT_OFFSETS = {
	"right": Vector2(24, -4),
	"left": Vector2(-24, -4),
	"down": Vector2(0, 16),
	"up": Vector2(0, -48),
}
const WALK_SPEED = 65
const GRAVITY = 4.3

var first_walking = true
var cur_light_offset = LIGHT_OFFSETS["down"]
var velocity = Vector2(0, 0)

func _ready():
	pass

func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY
	velocity.x = 0
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -WALK_SPEED
		_animated_sprite.play("walk_left")
		if first_walking:
			_animated_sprite.frame = 1
			first_walking = false
		cur_light_offset = LIGHT_OFFSETS["left"]
	elif Input.is_action_pressed("ui_right"):
		velocity.x = WALK_SPEED
		_animated_sprite.play("walk_right")
		if first_walking:
			_animated_sprite.frame = 1
			first_walking = false
		cur_light_offset = LIGHT_OFFSETS["right"]
	elif Input.is_action_pressed("ui_down"):
		cur_light_offset = LIGHT_OFFSETS["down"]
		_animated_sprite.animation = "default"
		_animated_sprite.stop()
		_animated_sprite.frame = 0
	elif Input.is_action_pressed("ui_up"):
		cur_light_offset = LIGHT_OFFSETS["up"]
		_animated_sprite.animation = "default"
		_animated_sprite.stop()
		_animated_sprite.frame = 0
	else:
		_animated_sprite.stop()
		_animated_sprite.frame = 0
		first_walking = true
	
	_light.position = lerp(_light.position, cur_light_offset, delta * 10)
	velocity = move_and_slide(velocity, Vector2(0, -1))

