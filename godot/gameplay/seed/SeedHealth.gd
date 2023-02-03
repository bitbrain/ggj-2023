extends Area2D

signal seed_dead

@export var max_health := 3
	
var current_health := max_health:
	set(v):
		current_health = v
		if current_health == 0:
			seed_dead.emit()

func _ready() -> void:
	area_entered.connect(_on_hazard_entered)
	
func _on_hazard_entered(hazard:Area2D) -> void:
	if current_health > 0:
		current_health = current_health - 1
		hazard.queue_free()
