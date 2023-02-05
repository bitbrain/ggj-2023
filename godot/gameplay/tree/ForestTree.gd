class_name ForestTree extends Node2D

signal tree_growing
signal tree_fully_grown

@export var nature_fade_in_time = 1.0

@onready var seed_spawn_position = $SeedSpawnPosition
@onready var nature_audio = $AudioStreamPlayer2D
@onready var sprite = $Sprite2D

func _ready() -> void:
	randomize()
	
	sprite.animation_finished.connect(func():tree_fully_grown.emit())
	
	nature_audio.seek(randf() * nature_audio.stream.get_length())
		
	var tween = create_tween()\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(nature_audio, "volume_db", 0.0, nature_fade_in_time)

func get_seed_spawn_position() -> Vector2:
	return seed_spawn_position.global_position

func _on_grow_timer_timeout() -> void:
	tree_growing.emit()
