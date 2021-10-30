extends Node2D

export(Array, Texture) var item_textures
export(Array, String) var map_name_to_texture

export(Array, PackedScene) var stages

var current_stage: Node
export var i: int

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GlobalData.connect("inventory_changed", self, "_on_Inventory_Change")
	current_stage = stages[i].instance()
	current_stage.connect("end_stage", self, "_on_end_stage")
	add_child(current_stage)
	
	if i != stages.size() - 1:
		Audio.volume_db = i * 6 + -30
		Audio.pitch_scale = i * 0.07 + 0.43
		Audio.play()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Inventory_Change(new_inventory):
	$CanvasLayer/Inventory/Item.texture = null
	for item in new_inventory:
		$CanvasLayer/Inventory/Item.texture = item_textures[map_name_to_texture.find(item)]

func _on_end_stage():
	current_stage.queue_free()
	i += 1
	current_stage = stages[i].instance()
	current_stage.connect("end_stage", self, "_on_end_stage")
	add_child(current_stage)
	
	if i != stages.size() - 1:
		Audio.volume_db = i * 6 + -30
		Audio.pitch_scale = i * 0.07 + 0.43
