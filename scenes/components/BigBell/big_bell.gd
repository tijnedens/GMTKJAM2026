class_name kanonComponent
extends BaseComponent

@onready var big_bell_visualizer: BigBellVisualizer = $BigBellVisualizer
@onready var static_body_2d: StaticBody2D = $StaticBody2D


func _process(_delta):
	pass

func _on_hit():
	big_bell_visualizer.visualize_start()
