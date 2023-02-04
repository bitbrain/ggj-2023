class_name TreeManager extends Node2D

signal new_seed_ready(position:Vector2)
signal consume_seed(seed:Seed)

@export var gameplay_data:GameplayData

@onready var ForestTreeScene = preload("res://gameplay/tree/ForestTree.tscn")
@onready var tree_container = $TreeContainer

func plant_tree_from_seed(seed:Seed) -> void:
	if seed.is_touching_ground():
		consume_seed.emit(seed)
		_plant_tree_at_position(seed.global_position)
	else:
		seed.on_touch_ground.connect(_on_touch_ground.bind(seed))
		
func _on_touch_ground(seed:Seed) -> void:
	if seed.on_touch_ground.is_connected(_on_touch_ground.bind(seed)):
		seed.on_touch_ground.disconnect(_on_touch_ground.bind(seed))
	consume_seed.emit(seed)
	_plant_tree_at_position(seed.global_position)
		
func _plant_tree_at_position(position:Vector2) -> void:
	var tree = ForestTreeScene.instantiate()
	tree_container.call_deferred("add_child", tree)
	tree.global_position = position
	tree.ready.connect(_tree_grown_successfully.bind(tree))
	
func _tree_grown_successfully(tree:ForestTree) -> void:
	new_seed_ready.emit(tree.get_seed_spawn_position())
	gameplay_data.trees_grown = gameplay_data.trees_grown + 1
	
