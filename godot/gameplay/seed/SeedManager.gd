extends Node

@export var input_controller:SeedInputController
@export var seed:Seed
@export var tree_manager:TreeManager

func _ready() -> void:
	tree_manager.consume_seed.connect(_consume_seed)
	tree_manager.new_seed_ready.connect(_spawn_new_seed)

func _consume_seed(seed:Seed) -> void:
	seed.visible = false
	input_controller.enabled = false

func _spawn_new_seed(position:Vector2) -> void:
	seed.reset()
	seed.global_position = position
	seed.visible = true
	input_controller.enabled = true
