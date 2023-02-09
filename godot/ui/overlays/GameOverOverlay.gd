extends Control

var changed = false

func _input(event: InputEvent) -> void:
	if not changed and visible and not event is InputEventMouseMotion:
		changed = true
		SaveGame.delete_save()
		get_tree().paused = false
		MusicManager.play([])
		get_tree().change_scene_to_file("res://scenes/MainMenuScene.tscn")
