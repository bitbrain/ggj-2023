extends Node2D

const OFFSET = 200

@export var min_wait_time = 2
@export var max_wait_time = 4
@export var hazard_chance = 0.1
@export var camera:Camera2D

@onready var CloudScene = preload("res://gameplay/cloud/Cloud.tscn")
@onready var timer = $Timer
@onready var world_objects = get_tree().get_nodes_in_group("WorldObjects")[0]
@onready var spawn_points = $SpawnPoints.get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_spawn_cloud)

func _spawn_cloud() -> void:
	timer.wait_time = randf_range(min_wait_time, max_wait_time)
	timer.start()
	
	if world_objects != null:
		var spawn_position = _get_random_spawn_point()
		var cloud = CloudScene.instantiate()
		cloud.global_position = spawn_position
		if randf() <= hazard_chance:
			cloud.type = Cloud.CloudType.HAZARD
		world_objects.add_child(cloud)

func _get_random_spawn_point() -> Vector2:
	var random_point = spawn_points[spawn_points.size() * randf()]
	return random_point.global_position

func _process(delta: float) -> void:
	global_position.x = camera.position.x + (float(camera.get_viewport_rect().size.x) / camera.zoom.x) / 2.0 + OFFSET
