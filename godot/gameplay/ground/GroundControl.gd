# Reports on touching grounds
class_name GroundControl extends Area2D

signal on_touch_ground

var touching_ground = false

func is_touching_ground() -> bool:
	return touching_ground

func _on_body_entered(body: Node2D) -> void:
	touching_ground = true
	on_touch_ground.emit()

func _on_body_exited(body: Node2D) -> void:
	touching_ground = false
