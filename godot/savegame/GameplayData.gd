class_name GameplayData extends Node

signal tree_grown(total_trees_grown:int)

var trees_grown = 0:
	set(v):
		trees_grown = v
		tree_grown.emit(trees_grown)
		
func save_data() -> Dictionary:
	return {
		"trees_grown": trees_grown
	}
	
func load_data(data:Dictionary) -> void:
	trees_grown = data["trees_grown"]
