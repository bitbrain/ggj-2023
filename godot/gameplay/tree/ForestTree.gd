extends Node2D

@onready var seed_spawn_position = $SeedSpawnPosition

func get_seed_spawn_position() -> Vector2:
	return seed_spawn_position.global_position
