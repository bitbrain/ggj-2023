extends Node

@export var input_controller:SeedInputController
@export var seed:Seed
@export var tree_manager:TreeManager

func _ready() -> void:
	tree_manager.consume_seed.connect(_consume_seed)
	tree_manager.new_seed_ready.connect(_spawn_new_seed)
	seed.on_touch_ground.connect(_on_seed_touch_ground)
	seed.on_leave_ground.connect(_on_seed_leave_ground)
	
func _on_seed_touch_ground() -> void:
	input_controller.enabled = true
	
func _on_seed_leave_ground() -> void:
	input_controller.enabled = false

func _consume_seed(seed:Seed) -> void:
	seed.visible = false
	input_controller.enabled = false

func _spawn_new_seed(position:Vector2) -> void:
	seed.visible = false
	seed.reset()
	seed.global_position = position
	seed.visible = true
	input_controller.enabled = true
