extends KinematicBody2D

signal end_stage

onready var _animated_sprite = $AnimatedSprite
onready var _light = $AnimatedSprite/Candle

const LIGHT_OFFSETS = {
	"right": Vector2(24, -4),
	"left": Vector2(-24, -4),
	"down": Vector2(0, 16),
	"up": Vector2(0, -48),
}
const WALK_SPEED = 50
const GRAVITY = 4.3

var first_walking = true
var cur_light_offset = LIGHT_OFFSETS["down"]
var velocity = Vector2(0, 0)
var counter = 0
var part = 0


func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY
	velocity.x = 0
	
	if part == 0:
		if counter < 200:
			_animated_sprite.animation = "walk_right"
			_animated_sprite.stop()
			_animated_sprite.frame = 0
		elif counter < 500:
			_animated_sprite.animation = "walk_knife"
			_animated_sprite.stop()
			first_walking = true
			$"../Before/Knife".hide()
		else:
			velocity.x = WALK_SPEED*0.6
			if first_walking:
				_animated_sprite.play()
				_animated_sprite.frame = 1
				first_walking = false
			cur_light_offset = LIGHT_OFFSETS["right"]
			Audio.volume_db += 0.35 * delta
	elif part == 1:
		if counter < 200:
			_animated_sprite.animation = "walk_knife"
			_animated_sprite.stop()
			_animated_sprite.frame = 0
		elif counter < 500:
			_animated_sprite.animation = "raise_knife"
			_animated_sprite.stop()
		else:
			Audio.stop()
			get_parent().get_node("Before/Vessel/AudioStreamPlayer2D").play()
			get_parent().modulate = Color.black
			part = 2
			counter = 0
	elif part == 2:
		if counter > 200:
			emit_signal("end_stage")
	
	counter += 100 * delta
	_light.position = lerp(_light.position, cur_light_offset, delta * 10)
	velocity = move_and_slide(velocity, Vector2(0, -1))



func _on_Vessel_body_entered(body):
	part = 1
	counter = 0
