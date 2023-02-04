extends RigidBody2D

@export var expires = true

func _ready() -> void:
	if expires:
		$ExpiryTimer.timeout.connect(queue_free)
		$ExpiryTimer.start()

