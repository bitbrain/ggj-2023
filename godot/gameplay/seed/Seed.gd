class_name Seed extends RigidBody2D

func shoot_me(force:Vector2) -> void:
	apply_impulse(force)
