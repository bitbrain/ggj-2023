class_name SeedInputController extends Area2D

signal shoot(force:Vector2)

@export var debug := false
@export var maximum_length := 400.0
@export var strength := 0.35
@export var enabled := true

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
		
func _input(event: InputEvent) -> void:
	
	if not touch_down or not enabled:
		return
		
	if event.is_action_released("ui_touch"):
		touch_down = false
		shoot.emit(force * strength)
		queue_redraw()
	
	if event is InputEventMouseMotion:
		position_end = event.position
		#TODO fix clamping of force vector
		force = -(position_end - position_start)
		queue_redraw()

