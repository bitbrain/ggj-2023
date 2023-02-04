class_name Cloud extends Node2D

enum CloudType {
	WATER,
	HAZARD
}

@export var min_wait_time = 1
@export var max_wait_time = 2
@export var type:CloudType = CloudType.WATER

@onready var WaterDrop = preload("res://gameplay/water/WaterDrop.tscn")
@onready var HazardDrop = preload("res://gameplay/hazard/Hazard.tscn")
@onready var world_objects = get_tree().get_nodes_in_group("WorldObjects")[0]
@onready var spawn_points = $SpawnPoints.get_children()
@onready var sprite = $Sprite2D
@onready var timer = $Timer


func _ready() -> void:
	randomize()
	
	timer.timeout.connect(_spawn_drop)
	
	#FIXME dirty hack to make hazard cloud
	if type == CloudType.HAZARD:
		sprite.frame = 8
		
func _spawn_drop() -> void:
	timer.wait_time = randf_range(min_wait_time, max_wait_time)
	timer.start()
	drop()

func drop() -> void:
	if world_objects == null:
		print("Not spawning cloud! Unknown world_objects")
		return
		
	var spawn_position = _get_random_spawn_point()
	
	if type == CloudType.WATER:
		var water = WaterDrop.instantiate()
		water.global_position  = spawn_position
		world_objects.add_child(water)
		
	if type == CloudType.HAZARD:
		var hazard = HazardDrop.instantiate()
		hazard.global_position  = spawn_position
		world_objects.add_child(hazard)
		
func _get_random_spawn_point() -> Vector2:
	var random_point = spawn_points[spawn_points.size() * randf()]
	return random_point.global_position
