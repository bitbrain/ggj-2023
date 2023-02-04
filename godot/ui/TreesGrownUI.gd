extends Control

@export var gameplay_data:GameplayData

@onready var label = $Label

func _ready() -> void:
	gameplay_data.tree_grown.connect(_trees_grown)
	
func _trees_grown(total_trees_grown:int) -> void:
	if total_trees_grown == 1:
		label.text = str(total_trees_grown) + " " + tr("tree_grown")
	else:
		label.text = str(total_trees_grown) + " " + tr("trees_grown")
