extends Node2D

@export var offset = 500
@export var camera:Camera2D

func _process(delta: float) -> void:
	global_position.x = camera.position.x + (float(camera.get_viewport_rect().size.x) / camera.zoom.x) / 2.0 + offset
