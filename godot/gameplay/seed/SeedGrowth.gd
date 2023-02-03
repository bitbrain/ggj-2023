extends Area2D

signal seed_ready_to_tree

@export var required_water_to_tree := 3

var current_water := 0:
	set(v):
		current_water = v
		if current_water == required_water_to_tree:
			seed_ready_to_tree.emit()
			
func _ready() -> void:
	area_entered.connect(_on_water_entered)
	
func _on_water_entered(water:Area2D) -> void:
	if current_water < required_water_to_tree:
		current_water = current_water + 1
		water.queue_free()
