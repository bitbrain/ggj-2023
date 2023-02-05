extends Node2D

@onready var fade_overlay := %FadeOverlay
@onready var pause_overlay := %PauseOverlay
@onready var seed_controller := %SeedInputController
@onready var tree_manager := %TreeManager
@onready var seed := %Seed
@onready var ground := %Ground
@onready var camera := %Camera2D

var game_over = false

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

	MusicManager.play([])
	
func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_focus()
		pause_overlay.visible = true
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())
	
func _game_over() -> void:
	if not game_over:
		game_over = true
		get_tree().change_scene_to_file("res://scenes/GameOverScene.tscn")
