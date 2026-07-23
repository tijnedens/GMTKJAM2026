class_name BigBellVisualizer
extends ComponentVisualizer

@onready var animation_tree: AnimationTree = %AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = (
	animation_tree.get("parameters/playback")
)

func visualize_start(_gear_speed: float = 0) -> void:
	state_machine.travel("klengel")

func visualize_jam() -> void:
	push_warning("Tried to visualize jam, but BigBell cannot jam.")

func reset() -> void:
	state_machine.travel("RESET")
