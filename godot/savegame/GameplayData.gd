class_name GameplayData extends Node

signal tree_grown(total_trees_grown:int)

var trees_grown = 0:
	set(v):
		trees_grown = v
		tree_grown.emit(trees_grown)
		
signal on_distance_travel(distance:int)

var distance_travelled = 0:
	set(v):
		distance_travelled = v
		on_distance_travel.emit(distance_travelled)
		
func save_data() -> Dictionary:
	return {
		"trees_grown": trees_grown,
		"distance_travelled": distance_travelled
	}
	
func load_data(data:Dictionary) -> void:
	trees_grown = data["trees_grown"]
	distance_travelled = data["distance_travelled"]
