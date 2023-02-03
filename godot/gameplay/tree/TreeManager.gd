class_name TreeManager extends Node2D

signal new_seed_ready(position:Vector2)

@onready var ForestTree = preload("res://gameplay/tree/ForestTree.tscn")
@onready var tree_container = $TreeContainer

func plant_tree_from_seed(seed:Seed) -> void:
	if seed.is_touching_ground():
		_plant_tree_at_position(seed.global_position)
		seed.queue_free()
	else:
		seed.on_touch_ground.connect(_on_touch_ground.bind(seed))
		
func _on_touch_ground(seed:Seed) -> void:
	_plant_tree_at_position(seed.global_position)
	seed.queue_free()
		
func _plant_tree_at_position(position:Vector2) -> void:
	var tree = ForestTree.instantiate()
	tree_container.add_child(tree)
	tree.global_position = position
	new_seed_ready.emit(tree.get_seed_spawn_position())
