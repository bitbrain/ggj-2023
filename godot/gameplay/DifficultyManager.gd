class_name DifficultyManager extends Node

@export var gameplay_data:GameplayData
@export var lava_spawner:WorldObjectSpawner
@export var cloud_spawner:WorldObjectSpawner

func _ready() -> void:
	gameplay_data.tree_grown.connect(_tree_grown)
	
func _tree_grown(number_of_trees:int) -> void:
	var play_tracks = min(_remap_range(number_of_trees, 0, 6, 0, 2) + 1, 4)
	var total_tracks:Array[int] = []
	for i in range(0, play_tracks):
		total_tracks.append(i)
	MusicManager.play(total_tracks)
	

func _remap_range(input:int, minInput:int, maxInput:int, minOutput:int, maxOutput:int):
	return int(float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput)	
