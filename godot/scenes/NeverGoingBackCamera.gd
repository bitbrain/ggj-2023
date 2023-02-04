extends Camera2D

func _process(delta: float) -> void:
	var left_side_of_camera = global_position.x - (float(get_viewport_rect().size.x) / zoom.x) / 2.0
	if limit_left < left_side_of_camera:
		limit_left = left_side_of_camera
