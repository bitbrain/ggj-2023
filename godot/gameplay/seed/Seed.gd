class_name Seed extends RigidBody2D

signal seed_dead
signal seed_ready_to_tree(seed:Seed)
signal on_touch_ground
signal on_leave_ground

@onready var health := $SeedHealth
@onready var growth := $SeedGrowth
@onready var ground_control := $GroundControl

var reset_force = false

func _ready() -> void:
	# forward health signals
	health.seed_dead.connect(func(): seed_dead.emit())
	growth.seed_ready_to_tree.connect(func(): seed_ready_to_tree.emit(self))
	ground_control.on_touch_ground.connect(func(): on_touch_ground.emit())
	ground_control.on_leave_ground.connect(func(): on_leave_ground.emit())

func is_touching_ground() -> bool:
	return ground_control.is_touching_ground()

func reset() -> void:
	health.reset()
	growth.reset()
	reset_force = true
	
func _integrate_forces(state):
	if reset_force:
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0.0
		reset_force = false
	
