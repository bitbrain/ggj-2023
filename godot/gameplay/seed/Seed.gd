class_name Seed extends RigidBody2D

signal seed_dead
signal seed_ready_to_tree

@onready var health := $SeedHealth
@onready var growth := $SeedGrowth

func _ready() -> void:
	# forward health signals
	health.seed_dead.connect(func(): seed_dead.emit())
	growth.seed_ready_to_tree.connect(func(): seed_ready_to_tree.emit())
