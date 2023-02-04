class_name VaccuumCleaner extends Area2D

func _ready() -> void:
	area_exited.connect(func(area): area.get_parent().queue_free())
