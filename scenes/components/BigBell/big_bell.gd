class_name kanonComponent
extends BaseComponent

@onready var big_bell_visualizer: BigBellVisualizer = $BigBellVisualizer


func _process(_delta):
	pass

func reset() -> void:
	big_bell_visualizer.reset()

func _on_hit():
	big_bell_visualizer.visualize_start()
	get_parent().stop_timer()
