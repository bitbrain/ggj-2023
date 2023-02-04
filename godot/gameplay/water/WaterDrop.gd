extends RigidBody2D

@export var expires = true

@onready var area = $Area2D
@onready var ground_control:GroundControl = $GroundControl
@onready var sprite := $Sprite2D

func _ready() -> void:
	area.area_entered.connect(func(area): queue_free())
	if expires:
		$ExpiryTimer.timeout.connect(queue_free)
		$ExpiryTimer.start()
	
	# trigger splash animation on touch ground
	ground_control.on_touch_ground.connect(func(): sprite.play("default"))

