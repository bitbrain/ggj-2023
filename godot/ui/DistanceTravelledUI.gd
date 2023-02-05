extends Control

@export var gameplay_data:GameplayData

@onready var label = $Label

func _ready() -> void:
	gameplay_data.on_distance_travel.connect(_distance_travelled)
	
func _distance_travelled(distance:int) -> void:
	label.text = str(max(distance, 0) / 100.0) + "m"
