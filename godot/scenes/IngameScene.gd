extends Node2D

@onready var fade_overlay := %FadeOverlay
@onready var pause_overlay := %PauseOverlay
@onready var game_over_overlay := %GameOverOverlay
@onready var seed_controller := %SeedInputController
@onready var tree_manager := %TreeManager
@onready var seed := %Seed
@onready var ground := %Ground
@onready var camera := %Camera2D

func _ready() -> void:
	camera.make_current()
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)
	
	# connect signals
	seed_controller.shoot.connect(seed.apply_impulse)
	seed.seed_dead.connect(_game_over)
	seed.seed_ready_to_tree.connect(tree_manager.plant_tree_from_seed)

	# screenshake!
	tree_manager.tree_growing.connect(func(): camera.shake(50, 3.5))
	
	MusicManager.play([])
	
func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_inner_focus()
		pause_overlay.visible = true
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())
	
func _game_over() -> void:
	game_over_overlay.visible = true
	get_tree().paused = true
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		camera.shake(150.0, 3.0)
