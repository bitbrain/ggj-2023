class_name SeedInputController extends Area2D

signal shoot(force:Vector2)

@export var debug := false
@export var maximum_length := 200.0
@export var strength := 0.45
@export var enabled := true

@onready var seed_pull_sound = $SeedPull
@onready var seed_throw_sound = $SeedThrow

var position_start := Vector2()
var position_end := Vector2()
var force := Vector2()
var touch_down := false

func _ready() -> void:
	input_event.connect(_on_input_event)

func _draw() -> void:
	if not debug or not touch_down:
		return

	draw_line(position_start - global_position,
		(position_end - global_position),
		Color.BLUE,
		1)
		
	draw_line(position_start - global_position,
		(position_start - global_position + force),
		Color.RED,
		2)
		
func _on_input_event(_viewport, event, _shape_idx) -> void:
	
	if not enabled:
		return
	
	if event.is_action_pressed("ui_touch"):
		touch_down = true
		position_start = event.position
		queue_redraw()
		# TODO manipulate sound by pull velocity (requires timer?)
		seed_pull_sound.play()
		
func _input(event: InputEvent) -> void:
	
	if not touch_down or not enabled:
		return
		
	if event.is_action_released("ui_touch"):
		touch_down = false
		shoot.emit(force * strength)
		queue_redraw()
		# TODO manipulate sound by force
		seed_throw_sound.play()
	
	if event is InputEventMouseMotion:
		position_end = event.position
		force = -(position_end - position_start).limit_length(maximum_length)
		queue_redraw()

