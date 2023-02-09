extends Area2D

signal seed_dead

@export var max_health := 3
@export var ground_control:GroundControl

@onready var insta_death_area = $InstaDeathArea
	
var current_health := max_health:
	set(v):
		current_health = v
		if current_health == 0:
			seed_dead.emit()

func _ready() -> void:
	area_entered.connect(_on_hazard_entered)
	insta_death_area.area_entered.connect(_insta_death)
	
func _on_hazard_entered(hazard:Area2D) -> void:
	if current_health > 0 and ground_control.is_touching_ground():
		current_health = current_health - 1
		hazard.get_parent().queue_free()
		
func _insta_death(hazard:Area2D) -> void:
	current_health = 0
		
func reset() -> void:
	current_health = max_health
