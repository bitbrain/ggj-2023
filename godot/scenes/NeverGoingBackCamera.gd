extends Camera2D

@export var gameplay_data:GameplayData

var shake_amount = 0.0
var tween

func _process(delta: float) -> void:
	var left_side_of_camera = global_position.x - (float(get_viewport_rect().size.x) / zoom.x) / 2.0
	if limit_left < left_side_of_camera:
		limit_left = round(left_side_of_camera)
		gameplay_data.distance_travelled = limit_left
	
	set_offset(Vector2( \
			randf_range(-1.0, 1.0) * shake_amount * delta, \
			randf_range(-1.0, 1.0) * shake_amount * delta \
	))

func shake(intensity:float, duration:float) -> void:
	if tween != null:
		tween.stop()
	shake_amount = intensity
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "shake_amount", 0.0, duration)
