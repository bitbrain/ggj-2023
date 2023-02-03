# Reports on touching grounds
class_name GroundControl extends Area2D

var touching_ground = false

func is_touching_ground() -> bool:
	return touching_ground

func _on_body_entered(body: Node2D) -> void:
	touching_ground = true

func _on_body_exited(body: Node2D) -> void:
	touching_ground = false
