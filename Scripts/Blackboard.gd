extends Area2D

var entered = true
var alpha = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	if Input.is_action_pressed("ui_accept") and entered:
		$CollisionShape2D.set_deferred("disabled", true)
		alpha = 0
	
	$welcome/dontbelieveher.modulate.a = lerp($welcome/dontbelieveher.modulate.a, alpha, _delta)
	if $welcome/dontbelieveher.modulate.a < 0.001:
		set_process(false)

func _on_Blackboard_body_entered(body):
	$Pointer.show()
	entered = true
	
func _on_Blackboard_body_exited(body):
	$Pointer.hide()
	entered = false
	
	
