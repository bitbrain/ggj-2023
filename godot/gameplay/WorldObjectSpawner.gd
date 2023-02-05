class_name WorldObjectSpawner extends Node2D

const OFFSET = 200

@export var min_wait_time = 4
@export var max_wait_time = 6
@export var scene_to_spawn:PackedScene
@export var enabled = true

@onready var timer = $Timer
@onready var world_objects = get_tree().get_nodes_in_group("WorldObjects")[0]
@onready var spawn_points = $SpawnPoints.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_spawn_cloud)

func _spawn_cloud() -> void:
	timer.wait_time = randf_range(min_wait_time, max_wait_time)
	timer.start()
	
	if world_objects != null and enabled:
		var spawn_position = _get_random_spawn_point()
		var scene = scene_to_spawn.instantiate()
		scene.global_position = spawn_position
		world_objects.add_child(scene)

func _get_random_spawn_point() -> Vector2:
	var random_point = spawn_points[spawn_points.size() * randf()]
	return random_point.global_position
