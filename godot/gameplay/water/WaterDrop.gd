extends RigidBody2D

@export var expires = false

@onready var area = $Area2D
@onready var ground_control:GroundControl = $GroundControl
@onready var sprite := $Sprite2D
@onready var hit_ground_sound: AudioStreamPlayer2D = $HitGroundSound

func _ready() -> void:
	area.area_entered.connect(func(area): queue_free())
	if expires:
		$ExpiryTimer.timeout.connect(queue_free)
		$ExpiryTimer.start()
	
	# trigger splash animation on touch ground
	ground_control.on_touch_ground.connect(func(): sprite.play("default"))
	ground_control.on_touch_ground.connect(func(): hit_ground_sound.play())
