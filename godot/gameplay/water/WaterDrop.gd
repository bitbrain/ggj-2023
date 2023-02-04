extends RigidBody2D

@export var expires = true

@onready var area = $Area2D

func _ready() -> void:
	area.area_entered.connect(func(area): queue_free())
	if expires:
		$ExpiryTimer.timeout.connect(queue_free)
		$ExpiryTimer.start()

