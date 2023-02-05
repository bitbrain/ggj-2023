extends Button

@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var hover_sound: AudioStreamPlayer = $HoverSound

func _on_mouse_entered() -> void:
	hover_sound.play()


func _on_pressed() -> void:
	click_sound.play()
