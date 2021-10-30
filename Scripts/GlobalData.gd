extends Node

signal inventory_changed

var inventory = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func add_item(item: String):
	inventory.append(item)
	emit_signal("inventory_changed", inventory)
	
func remove_item(item: String):
	inventory.remove(inventory.find(item))
	emit_signal("inventory_changed", inventory)

func has_item(item: String):
	return inventory.find(item) != -1
