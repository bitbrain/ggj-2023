class_name ForestTree extends Node2D

@export var nature_fade_in_time = 1.0

@onready var seed_spawn_position = $SeedSpawnPosition
@onready var nature_audio = $AudioStreamPlayer2D

func _ready() -> void:
	randomize()
	
	nature_audio.seek(randf() * nature_audio.stream.get_length())
		
	var tween = create_tween()\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(nature_audio, "volume_db", 0.0, nature_fade_in_time)

func get_seed_spawn_position() -> Vector2:
	return seed_spawn_position.global_position
