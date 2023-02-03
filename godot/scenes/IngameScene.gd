extends Node2D

@onready var fade_overlay := %FadeOverlay
@onready var pause_overlay := %PauseOverlay
@onready var seed_controller := %SeedController
@onready var seed := %Seed
@onready var camera := %Camera2D

func _ready() -> void:
	camera.make_current()
	fade_overlay.visible = true
	
	if SaveGame.has_save():
		SaveGame.load_game(get_tree())
	
	pause_overlay.game_exited.connect(_save_game)
	
	# connect signals
	seed_controller.shoot.connect(seed.apply_impulse)
	seed.seed_dead.connect(func(): print("SEED DEAD!"))
	seed.seed_ready_to_tree.connect(func(): print("SEED READY TO TREE!"))

func _input(event) -> void:
	if event.is_action_pressed("pause") and not pause_overlay.visible:
		get_viewport().set_input_as_handled()
		get_tree().paused = true
		pause_overlay.grab_focus()
		pause_overlay.visible = true
		
func _save_game() -> void:
	SaveGame.save_game(get_tree())
